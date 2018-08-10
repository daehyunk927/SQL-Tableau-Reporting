-- zipcode 
select state, city, zipcode, l.mlsid, UPPER(m.short_name_display), m.abbreviation, count(*) as ct from wrd.listing l
join wrd.mls m on l.mlsid = m.mlsid
join sas.statelookup s on l.state = s.abbreviation and s.countryabbreviation not in ('MX')
where m.listingdata_available = true
group by state, city, zipcode, l.mlsid, m.short_name_display, m.abbreviation
having count(*) > 100
order by state, city, zipcode, ct desc, l.mlsid, m.short_name_display

-- cities 
select state, city, l.mlsid, UPPER(m.short_name_display), m.abbreviation, count(*) as ct from wrd.listing l
join wrd.mls m on l.mlsid = m.mlsid
join sas.statelookup s on l.state = s.abbreviation and s.countryabbreviation not in ('MX')
where m.listingdata_available = true
group by state, city, l.mlsid, m.short_name_display, m.abbreviation
having count(*) > 500
order by state, city, ct desc, l.mlsid, m.short_name_display

-- states
select state, s.name, l.mlsid, UPPER(m.short_name_display), m.abbreviation, count(*) as ct from wrd.listing l
join wrd.mls m on l.mlsid = m.mlsid
join sas.statelookup s on l.state = s.abbreviation and s.countryabbreviation not in ('MX')
where m.listingdata_available = true
--and l.state ~ '[A-Za-z][A-Za-z]'
group by state, s.name, l.mlsid, m.short_name_display, m.abbreviation --, s.name
having count(*) > 500
order by state, ct desc, l.mlsid, m.short_name_display


select name, name_display, UPPER(short_name_display), * from wrd.mls limit 10
select * from wrd.listing limit 10
select abbreviation, count(*) from sas.statelookup group by abbreviation order by abbreviation
select * from sas.statelookup where abbreviation in ('CA','HI','NL')

SELECT short_name_display, * from wrd.mls where abbreviation in ('CAA')

--
select count(*) from wrd.listing
WHERE propertytypeid != 6 -- Exclude Rentals
   and sourcetableid = 3 -- Extract only from MLS data
   and mlsid not in (174) -- Exclude TDX, since it shows duplicate listings with TRD
   and datelisted > '2016-12-31' and datelisted < '2018-01-01'

select count(*) from wrd.listing
WHERE propertytypeid != 6 -- Exclude Rentals
   and propertytypeid != 3 -- Exclude Lands
   and sourcetableid = 3 -- Extract only from MLS data
   and mlsid not in (174) -- Exclude TDX, since it shows duplicate listings with TRD
   and solddate > '2016-12-31' and solddate < '2018-01-01'
   and listingstatusid in (23,24) --Closed Listings Only
   and solddate is not null 
