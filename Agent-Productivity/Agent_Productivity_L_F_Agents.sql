-- Agent Information 
selectlistagentidmls as "Agent ID", 
primaryagentcompanyid as "Company ID", 
max(listingofficename) as"Example Office", 
max(listingofficemlsid) as "Office ID", max(state) as "State", max(listagentname) as "Agent Name", 
-- Manipulate Company and Time Range
SUM(CASE WHEN solddate between ('2016-01-01'::date - interval '12 months') and'2016-01-01'::date THEN 1 ELSE 0 END) as "Listing range 1", -- 1 year prior to the date
SUM(CASE WHEN solddate between '2016-01-01'::date and ('2016-01-01'::date + interval '12 months') THEN 1 ELSE 0 END) as "Listing range 2", -- 1 year from the date
coalesce(max(s.sell1),0) "Buying range 1", 
coalesce(max(s.sell2),0) "Buying range 2"
FROM wrd.listing l

left join (	select sellingagentmlsid,
		SUM(CASE WHEN solddate between ('2016-01-01'::date - interval '12 months') and'2016-01-01'::date THEN 1 ELSE 0 END) as sell1, -- 1 year prior to the date
		SUM(CASE WHEN solddate between '2016-01-01'::date and ('2016-01-01'::date + interval '12 months') THEN 1 ELSE 0 END) as sell2  -- 1 year from the date
		from wrd.listing ls join wrd.user us on ls.sellingagentmlsid = us.mlsagentandls.mlsid = us.mlsid-- join with user table to extract company ids
		where listingstatusid in (23,24) -- Closed Listings Only
		and solddate is not null
		and propertytypeid != 6 -- Exclude Rentals
		and sourcetableid = 3 -- Extract only from MLS data
		and ls.mlsid not in (174) -- Exclude TDX, since it shows duplicate listings with TRD
		and us.companyid in (13,257,262,289,337,374,459,759,820,861,1046,1222)  -- Long & Foster companies
		group by sellingagentmlsid) s on l.listagentidmls = s.sellingagentmlsid
		
join wrd.user u on l.listagentidmls = u.mlsagent and l.mlsid = u.mlsid-- join with user table to extract active agents

WHERE primaryagentcompanyid in (13,257,262,289,337,374,459,759,820,861,1046,1222) -- Long & Foster companies
and listingstatusid in (23,24) --Closed Listings Only
and solddate is not null
andpropertytypeid != 6 -- Exclude Rentals
andsourcetableid = 3 -- Extract only from MLS data
and l.mlsid not in (174) -- Exclude TDX, since it shows duplicate listings with TRD
and u.active = true-- active agents
GROUP BY listagentidmls, primaryagentcompanyid
ORDER BY listagentidmls
