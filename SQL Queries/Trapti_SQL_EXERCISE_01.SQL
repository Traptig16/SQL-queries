
Simple Queries

1.SELECT count (*) FROM cd.bookings;
SELECT count (*) FROM cd.members;
SELECT count (*) FROM cd.members;

2. SELECT * FROM cd.bookings
ORDER BY starttime DESC;

3. SELECT DISTINCT name FROM cd.facilities;

4.SELECT facid, name,membercost,guestcost, initialoutlay, monthlymaintenance
ORDER BY membercost DESC
LIMIT 3;

5.SELECT facid, name,membercost,guestcost, initialoutlay, monthlymaintenance
FROM cd.facilities
ORDER BY monthlymaintenance ASC
LIMIT 1;
 
6. SELECT * FROM cd.members
WHERE surname IN (
    SELECT surname
    FROM cd.members
    GROUP BY surname
    HAVING COUNT(*) > 1
);
  6.select surname from cd.members
group by surname
having count(*)>1;


7. select city , string_agg(firstname,',')
from
(
	select
	m.firstname,m.address,'Boston' as city 
	from 
	cd.members m where address like '%Boston%'
)as a
group by city;

8. SELECT * FROM cd.members
WHERE surname LIKE 'Sm%' OR surname LIKE 'Tr%' OR surname LIKE '%ll' OR surname LIKE '%ew'
ORDER BY surname, firstname;

Join Queries
1.  SELECT m.firstname, m.surname
FROM cd.members m
JOIN cd.bookings b ON m.memid = b.memid
JOIN cd.facilities f ON b.facid = f.facid;

2.SELECT name from cd.facilities f 
join cd.bookings b on f.facid= b.facid;

3. SELECT cd.members.firstname
FROM cd.members
LEFT JOIN cd.bookings ON cd.members.memid = cd.bookings.memid
WHERE cd.bookings.memid IS NULL;

4. SELECT cd.facilities.name
FROM cd.facilities
LEFT JOIN cd.bookings ON cd.facilities.facid = cd.bookings.facid
WHERE cd.bookings.memid IS NULL;

5. SELECT *
FROM bookings b
LEFT JOIN members m ON b.memid = m.memid
LEFT JOIN facilities f ON b.facid = f.facid
WHERE m.memberid IS NULL OR f.facid IS NULL;

Aggregate Queries

1. select f.name,sum(b.slots)AS total_slots
from cd.bookings b
join cd.facilities f on b.facid=f.facid
group by f.name;


2.SELECT m.memid,f.name,sum(b.slots) AS total_slots
FROM cd.bookings b 
join cd.members m on b.memid=m.memid
join  cd.facilities f on b.facid=f.facid
GROUP BY m.memid,f.name
order by total_slots desc;



3. select m.firstname,m.surname,sum(b.slots) AS total_slots
from cd.members m
join cd.bookings b on m.memid=b.memid
join cd.facilities f on f.facid=b.facid
group by m.firstname, m.surname
order by total_slots desc
limit 3;

 
4. SELECT f.name, SUM(b.slots) AS total_slots
FROM bookings b
JOIN facilities f ON b.facid = f.facid
GROUP BY f.name
ORDER BY total_slots DESC;

5. Select f.name,sum(b.slots*(f.membercost+f.guestcost)) as total_earning
from cd.bookings b 
join cd.facilities f on b.facid=f.facid
group by f.name 
order by total_earning desc
limit 3;

6. SELECT m.memid,m.firstname,m.surname,count(b.slots) AS total_slots
FROM cd.bookings b 
join cd.members m on b.memid=m.memid
GROUP BY m.memid
order by total_slots desc
limit 3;

7. SELECT m.memid,m.firstname,m.surname,count(*) AS usage_count
FROM cd.members m 
join cd.bookings b on b.memid=m.memid
join cd.facilities f on f.facid = b.facid
where f.name like '%Tennis'
GROUP BY m.memid
order by usage_count desc;
