   select s.sweepprocessname, m.abbreviation, count(*)
   from wrd.listing l
   join wrd.mls m ON m.mlsid = l.mlsid
   join sas.sweepjob s ON s.mlsabbrev = m.abbreviation
   where l.lastmodifiedmls::date >= (now()::date - interval '8 days') 
   and l.lastmodifiedmls::date < now()::date
   group by s.sweepprocessname, m.abbreviation
   order by s.sweepprocessname, m.abbreviation
   
   -- How many listings per mls?
   SELECT s.sweepprocessname, s.mlsabbrev, count(l.*) 
   from sas.sweepjob s 
   join wrd.listing l on sas.getmls(s.mlsabbrev) = l.mlsid 
   where AGE(l.lastmodifiedmls) < '1 week'
   --and sweepprocessname = 'ETLSWEEP-01' 
   group by s.sweepprocessname, s.mlsabbrev order by sweepprocessname, count(l.*)
   
   
   select * from wrd.listing where mlsid = 278 and lastmodifiedmls::date > (now()::date - interval '7 days') 
   order by lastmodifiedmls::date
   limit 100