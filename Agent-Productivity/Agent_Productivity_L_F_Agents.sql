-- Agent Information 
select primaryagentuserid,
       max(l.mlsid) as "MLS ID",
       max(listagentidmls) as "Agent ID",
       max(u.firstname) as "Agent First Name", 
       max(u.lastname) as "Agent Last Name", 
       substring(min(g.created_at)::text,1,10) as "Goal Date",
       substring((min(g.created_at)+interval '1month')::text,1,7) as "Goal Month",
-- Manipulate Company and Time Range
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-01' THEN 1 ELSE 0 END) as "2015-01 Sell",
	   SUM(CASE WHEN substring(solddate::text,1,7) = '2015-02' THEN 1 ELSE 0 END) as "2015-02 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-03' THEN 1 ELSE 0 END) as "2015-03 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-04' THEN 1 ELSE 0 END) as "2015-04 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-05' THEN 1 ELSE 0 END) as "2015-05 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-06' THEN 1 ELSE 0 END) as "2015-06 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-07' THEN 1 ELSE 0 END) as "2015-07 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-08' THEN 1 ELSE 0 END) as "2015-08 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-09' THEN 1 ELSE 0 END) as "2015-09 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-10' THEN 1 ELSE 0 END) as "2015-10 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-11' THEN 1 ELSE 0 END) as "2015-11 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-12' THEN 1 ELSE 0 END) as "2015-12 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-01' THEN 1 ELSE 0 END) as "2016-01 Sell",
	   SUM(CASE WHEN substring(solddate::text,1,7) = '2016-02' THEN 1 ELSE 0 END) as "2016-02 Sell",
	   SUM(CASE WHEN substring(solddate::text,1,7) = '2016-03' THEN 1 ELSE 0 END) as "2016-03 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-04' THEN 1 ELSE 0 END) as "2016-04 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-05' THEN 1 ELSE 0 END) as "2016-05 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-06' THEN 1 ELSE 0 END) as "2016-06 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-07' THEN 1 ELSE 0 END) as "2016-07 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-08' THEN 1 ELSE 0 END) as "2016-08 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-09' THEN 1 ELSE 0 END) as "2016-09 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-10' THEN 1 ELSE 0 END) as "2016-10 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-11' THEN 1 ELSE 0 END) as "2016-11 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-12' THEN 1 ELSE 0 END) as "2016-12 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-01' THEN 1 ELSE 0 END) as "2017-01 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-02' THEN 1 ELSE 0 END) as "2017-02 Sell",
	   SUM(CASE WHEN substring(solddate::text,1,7) = '2017-03' THEN 1 ELSE 0 END) as "2017-03 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-04' THEN 1 ELSE 0 END) as "2017-04 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-05' THEN 1 ELSE 0 END) as "2017-05 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-06' THEN 1 ELSE 0 END) as "2017-06 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-07' THEN 1 ELSE 0 END) as "2017-07 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-08' THEN 1 ELSE 0 END) as "2017-08 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-09' THEN 1 ELSE 0 END) as "2017-09 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-10' THEN 1 ELSE 0 END) as "2017-10 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-11' THEN 1 ELSE 0 END) as "2017-11 Sell",
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-12' THEN 1 ELSE 0 END) as "2017-12 Sell",
	   coalesce(max(s.sell201501),0) "2015-01 Buy", 
	   coalesce(max(s.sell201502),0) "2015-02 Buy",
       coalesce(max(s.sell201503),0) "2015-03 Buy",
       coalesce(max(s.sell201504),0) "2015-04 Buy",
       coalesce(max(s.sell201505),0) "2015-05 Buy",
       coalesce(max(s.sell201506),0) "2015-06 Buy",
       coalesce(max(s.sell201507),0) "2015-07 Buy",
       coalesce(max(s.sell201508),0) "2015-08 Buy",
       coalesce(max(s.sell201509),0) "2015-09 Buy",
       coalesce(max(s.sell201510),0) "2015-10 Buy",
       coalesce(max(s.sell201511),0) "2015-11 Buy",
       coalesce(max(s.sell201512),0) "2015-12 Buy",
       coalesce(max(s.sell201601),0) "2016-01 Buy",
       coalesce(max(s.sell201602),0) "2016-02 Buy",
       coalesce(max(s.sell201603),0) "2016-03 Buy",
       coalesce(max(s.sell201604),0) "2016-04 Buy",
       coalesce(max(s.sell201605),0) "2016-05 Buy",
       coalesce(max(s.sell201606),0) "2016-06 Buy",
       coalesce(max(s.sell201607),0) "2016-07 Buy",
       coalesce(max(s.sell201608),0) "2016-08 Buy",
       coalesce(max(s.sell201609),0) "2016-09 Buy",
       coalesce(max(s.sell201610),0) "2016-10 Buy",
       coalesce(max(s.sell201611),0) "2016-11 Buy",
       coalesce(max(s.sell201612),0) "2016-12 Buy",
       coalesce(max(s.sell201701),0) "2017-01 Buy",
       coalesce(max(s.sell201702),0) "2017-02 Buy",
       coalesce(max(s.sell201703),0) "2017-03 Buy",
       coalesce(max(s.sell201704),0) "2017-04 Buy",
       coalesce(max(s.sell201705),0) "2017-05 Buy", 
	   coalesce(max(s.sell201706),0) "2017-06 Buy",
       coalesce(max(s.sell201707),0) "2017-07 Buy",
       coalesce(max(s.sell201708),0) "2017-08 Buy",
       coalesce(max(s.sell201709),0) "2017-09 Buy",
       coalesce(max(s.sell201710),0) "2017-10 Buy",
       coalesce(max(s.sell201711),0) "2017-11 Buy",
       coalesce(max(s.sell201712),0) "2017-12 Buy"

        FROM wrd.listing l
  
  full join (	select primarysellingagentuserid,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-01' THEN 1 ELSE 0 END) as sell201501,
	   SUM(CASE WHEN substring(solddate::text,1,7) = '2015-02' THEN 1 ELSE 0 END) as sell201502,
	   SUM(CASE WHEN substring(solddate::text,1,7) = '2015-03' THEN 1 ELSE 0 END) as sell201503,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-04' THEN 1 ELSE 0 END) as sell201504,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-05' THEN 1 ELSE 0 END) as sell201505,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-06' THEN 1 ELSE 0 END) as sell201506,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-07' THEN 1 ELSE 0 END) as sell201507,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-08' THEN 1 ELSE 0 END) as sell201508,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-09' THEN 1 ELSE 0 END) as sell201509,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-10' THEN 1 ELSE 0 END) as sell201510,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-11' THEN 1 ELSE 0 END) as sell201511,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2015-12' THEN 1 ELSE 0 END) as sell201512,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-01' THEN 1 ELSE 0 END) as sell201601,
	   SUM(CASE WHEN substring(solddate::text,1,7) = '2016-02' THEN 1 ELSE 0 END) as sell201602,
	   SUM(CASE WHEN substring(solddate::text,1,7) = '2016-03' THEN 1 ELSE 0 END) as sell201603,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-04' THEN 1 ELSE 0 END) as sell201604,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-05' THEN 1 ELSE 0 END) as sell201605,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-06' THEN 1 ELSE 0 END) as sell201606,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-07' THEN 1 ELSE 0 END) as sell201607,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-08' THEN 1 ELSE 0 END) as sell201608,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-09' THEN 1 ELSE 0 END) as sell201609,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-10' THEN 1 ELSE 0 END) as sell201610,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-11' THEN 1 ELSE 0 END) as sell201611,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2016-12' THEN 1 ELSE 0 END) as sell201612,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-01' THEN 1 ELSE 0 END) as sell201701,
	   SUM(CASE WHEN substring(solddate::text,1,7) = '2017-02' THEN 1 ELSE 0 END) as sell201702,
	   SUM(CASE WHEN substring(solddate::text,1,7) = '2017-03' THEN 1 ELSE 0 END) as sell201703,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-04' THEN 1 ELSE 0 END) as sell201704,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-05' THEN 1 ELSE 0 END) as sell201705,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-06' THEN 1 ELSE 0 END) as sell201706,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-07' THEN 1 ELSE 0 END) as sell201707,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-08' THEN 1 ELSE 0 END) as sell201708,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-09' THEN 1 ELSE 0 END) as sell201709,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-10' THEN 1 ELSE 0 END) as sell201710,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-11' THEN 1 ELSE 0 END) as sell201711,
       SUM(CASE WHEN substring(solddate::text,1,7) = '2017-12' THEN 1 ELSE 0 END) as sell201712
		  from wrd.listing ls join wrd.user us on ls.primarysellingagentuserid = us.userid -- join with user table to extract company ids
		 where listingstatusid in (23,24) -- Closed Listings Only
		   and solddate is not null 
		   and propertytypeid != 6 -- Exclude Rentals
		   and sourcetableid = 3 -- Extract only from MLS data
		   and ls.mlsid not in (174) -- Exclude TDX, since it shows duplicate listings with TRD
           and us.active = true -- active agents
		   and us.companyid in (13)  -- Long & Foster companies
		  group by primarysellingagentuserid) s on l.primaryagentuserid = s.primarysellingagentuserid
		  
  join wrd.user u on l.primaryagentuserid = u.userid -- join with user table to extract agent information
  left join crm.agents a on a.uuid = u.uuid::text 
  left join crm.gci_goals g on g.agent_id = a.id
  
 WHERE u.companyid in (13) -- Long & Foster companies
   and listingstatusid in (23,24) --Closed Listings Only
   and solddate is not null 
   and propertytypeid != 6 -- Exclude Rentals
   and sourcetableid = 3 -- Extract only from MLS data
   and l.mlsid not in (174) -- Exclude TDX, since it shows duplicate listings with TRD
   and substring(solddate::text,1,7) >= '2015-01'
   and u.active = true -- active agents
   and g.created_at is null
   and l.primaryagentuserid not in ('1495563')
   

 GROUP BY primaryagentuserid-- per Agent
 ORDER BY primaryagentuserid

