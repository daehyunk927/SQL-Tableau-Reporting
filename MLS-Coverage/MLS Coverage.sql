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


