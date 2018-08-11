-- The most recent percentage of MLS's lower than 5% missing rate 
SELECT (count(l1.mlsid)::float/(
    select count(mlsid) from 
    (SELECT DISTINCT l.mlsid FROM rpt.missing_image_log l
	where l.mlsid in (select mlsid from wrd.mls where listingdata_available = true)) total)-- total MLS count
    *100.0)::numeric(10,2)::text || '%'
FROM rpt.missing_image_log l1 
where l1.mlsid in (select mlsid from wrd.mls where listingdata_available = true)
and l1.created = ( -- most recent log for each MLS
    select max(l2.created) from rpt.missing_image_log l2
	where l1.mlsid = l2.mlsid.
	group by l2.mlsid)
and missingrate <= 5

-- The most recent missing image log
SELECT l1.mlsid, (missingrate::numeric(10,2))::text || '%' as missingraterounded, *
FROM rpt.missing_image_log l1
where l1.mlsid in (select mlsid from wrd.mls where listingdata_available = true)
and l1.created = ( -- most recent log for each MLS
    select max(l2.created) from rpt.missing_image_log l2
	where l1.mlsid = l2.mlsid
	group by l2.mlsid)
and l1.mlsid not in ('216','217','218','219','246','245','247','248','249','222','223','224','235','233','231','232','230',
 '225','228','229','227','226','237','243','220','221','234','238','239','240','241','242','244','236')
order by l1.missingrate desc

-- Overall Missing Image counts and percentages for each date
SELECT l1.created::date as "Log date",
	count(l1.mlsid) as "Total MLS Count",
	SUM(CASE WHEN l1.missingrate <= 5 THEN 1 ELSE 0 END) as "<5% Count",
    SUM(CASE WHEN l1.missingrate <= 2 THEN 1 ELSE 0 END) as "<2% Count",
    ((SUM(CASE WHEN l1.missingrate <= 5 THEN 1 ELSE 0 END) / count(l1.mlsid)::float * 100)::numeric(10,2))::text || '%' as "<5% Percentage",
    ((SUM(CASE WHEN l1.missingrate <= 2 THEN 1 ELSE 0 END) / count(l1.mlsid)::float * 100)::numeric(10,2))::text || '%' as "<2% Percentage"
FROM rpt.missing_image_log l1 
where l1.mlsid in (select mlsid from wrd.mls where listingdata_available = true)
and l1.created = -- because some MLS has multiple logs on the same date
	(select max(l2.created) from rpt.missing_image_log l2
     where l1.mlsid = l2.mlsid and l1.created::date = l2.created::date
     group by l2.created::date, l2.mlsid)
and NOT l1.created::date = '2016-08-25' -- not relevant on this date
group by l1.created::date
order by l1.created::date


