select sas.getmls('NJM')

SELECT '||Created Date|', 'Total Count|', 'Image Count|', 'Missing Count|', 'Missing Rate||'
UNION ALL
SELECT mlsid, abbreviation, '| '||created::date::text, totalcount::text, imagecount::text, missingcount::text, missingrate::numeric(10,2)::text||' %|' as missingrate
FROM rpt.missing_image_log
WHERE abbreviation = 'CHM'
and NOT created::date = '2016-08-25'
and created::date > '2017-08-01'
/*and created::date in ('2016-10-14','2016-10-28','2016-11-11','2016-11-25','2016-12-09','2016-12-16','2016-12-30','2017-01-13','2017-01-27','2017-02-10',
                     '2017-02-24','2017-03-10','2017-03-24','2017-04-05','2017-04-19','2017-05-05','2017-05-19','2017-06-05','2017-06-19','2017-07-05','2017-07-19',
                     '2017-08-05','2017-08-19','2017-09-05','2017-09-19','2017-10-05','2017-10-19',CURRENT_DATE)*/
order by mlsid, created::date

group by extract(year from created),extract(month from created)
ORDER BY extract(year from created),extract(month from created)


select * from wrd.mls order by mlsid

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

-- The most recent log
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

-- The most recent log to JIRA
SELECT '||mlsid|', 'Missing Rate|', 'Abbreviation|', 'Total Count|', 'Image Count|', 'Missing Count|', 'Created||'
UNION ALL
(SELECT '| ' || l1.mlsid::text,
         (l1.missingrate::numeric(10,2))::text || '%',
 		 l1.abbreviation,
 		 l1.totalcount::text,
 		 l1.imagecount::text,
 		 l1.missingcount::text,
 		 l1.created::date::text || '|'
FROM rpt.missing_image_log l1
where l1.mlsid in (select mlsid from wrd.mls where listingdata_available = true)
and l1.created = ( -- most recent log for each MLS
    select max(l2.created) from rpt.missing_image_log l2
	where l1.mlsid = l2.mlsid
	group by l2.mlsid)
and l1.mlsid not in ('216','217','218','219','246','245','247','248','249','222','223','224','235','233','231','232','230',
 '225','228','229','227','226','237','243','220','221','234','238','239','240','241','242','244','236')
order by l1.missingrate desc)
 
-- Overall count for each date (can calculate percentage of <5% over time)
SELECT l1.created::date, count(l1.mlsid)
FROM rpt.missing_image_log l1
where l1.mlsid in (select mlsid from wrd.mls where listingdata_available = true)
and l1.created = -- because some MLS has multiple logs on the same date
	(select max(l2.created) from rpt.missing_image_log l2
     where l1.mlsid = l2.mlsid and l1.created::date = l2.created::date
     group by l2.created::date, l2.mlsid)
 and l1.missingrate <= 2 -- with this, <5% count and w/o this, total count
group by l1.created::date
order by l1.created::date

-- Overall counts and percentages for each date
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

-- Overall counts and percentages for each date for JIRA
SELECT '||Log Date|', 'Total MLS Count|', '<5% Count|', '<2% Count|', '<5% Percentage|', '<2% Percentage||'
UNION ALL
(SELECT '| ' || l1.created::date::text,
	count(l1.mlsid)::text,
	SUM(CASE WHEN l1.missingrate <= 5 THEN 1 ELSE 0 END)::text,
    SUM(CASE WHEN l1.missingrate <= 2 THEN 1 ELSE 0 END)::text,
    ((SUM(CASE WHEN l1.missingrate <= 5 THEN 1 ELSE 0 END) / count(l1.mlsid)::float * 100)::numeric(10,2))::text || '%',
    ((SUM(CASE WHEN l1.missingrate <= 2 THEN 1 ELSE 0 END) / count(l1.mlsid)::float * 100)::numeric(10,2))::text || '%|' 
FROM rpt.missing_image_log l1 
where l1.mlsid in (select mlsid from wrd.mls where listingdata_available = true)
and l1.created = -- because some MLS has multiple logs on the same date
	(select max(l2.created) from rpt.missing_image_log l2
     where l1.mlsid = l2.mlsid and l1.created::date = l2.created::date
     group by l2.created::date, l2.mlsid)
and l1.mlsid not in ('216','217','218','219','246','245','247','248','249','222','223','224','235','233','231','232','230',
 '225','228','229','227','226','237','243','220','221','234','238','239','240','241','242','244','236') -- Crey Leike
and NOT l1.created::date = '2016-08-25' -- not relevant on this date
group by l1.created::date
order by l1.created::date)

-- Crey Leike
('216','217','218','219','246','245','247','248','249','222','223','224','235','233','231','232','230',
 '225','228','229','227','226','237','243','220','221','234','238','239','240','241','242','244','236')
