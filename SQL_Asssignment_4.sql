This assignment is about writing SQL statement that can be used to retrieve information
from a given relational database. Your SQL statement needs to satisfy all standard SQL
grammar.
The Long Haul Database belongs to a company name Long Haul, which operates a number of
passenger vans. Vans are distinguished by registration code, and characterized by the number of
passenger seats. The company keep track of the cabin type of its vans. Cabin type differ in their
air conditioning capabilities. At present, there are only two types: those with air-conditioning and
those without it (yes/no). Each van is assigned a quality rank (which is equal to the number of
break-down within the last year.)
Long Haul operates various lines among the neighboring towns. All lines are express and
passenger vans never stop on a line. Each line is assign a unique number, and characterized by its
origin and destination towns. Additionally, the management keeps track of the length of distance
covered by each line (in miles).
Information is stored about drivers. For each drivers, the management needs to know ssn, first
and last names, and date of birth. If available, driver contact phone numbers are stored.
The management keeps a departure plan of lines, which schedules the departure and arrival times
of each line on each date. Carefully predicting the passenger interest, the scheduling clerk dispatches
one or more vans to each individual scheduled line. For each dispatched van, the dispatcher records
which driver has been assigned to it. Once this assignment is made, the ticket booth is free to book
tickets for each dispatched van. Each sold seat is recorded, so that no van should be booked above
its capacity.
The database is created by the following SQL statements:
create table van(
registr char(6),
seats number,
cabin char(1),
rank number,
primary key(registr)
);

create table driver(
ssn char(10),
firstname varchar(16),
lastname varchar(36),
birthdate date,
primary key(ssn)
);
create table phonebook(

1

person char(10),
phonenum varchar(16),
primary key(person, phonenum),
foreign key (person) references driver
);
create table line(
linenum number,
origin varchar(20),
destination varchar(20),
distance number,
primary key (linenum)
);
create table plan(
depcode char(12),
nline number,
depart date,
arrive date,
primary key (depcode),
foreign key (nline) references line
);
create table dispatch(
vehicle char(6),
depcode char(12),
soldseats number,
driverid char(10),
primary key (vehicle, depcode),
foreign key (driverid) references driver,
foreign key (depcode) references plan,
foreign key (vehicle) references van
);
Write SQL statements for the queries specified below:
1. Find registration codes for all vans that do not have air conditioning.
2. Find names (first and last) of all drivers who have been assigned to drive a van without air
conditioning.
3. Find names (first and last) of all drivers who have not been assigned to drive a van without
air conditioning on a line that covers a distance longer than 15 miles.
4. Find registration codes of those vans that are scheduled to depart today, but the number of
sold seats has reached their seat capacity ( we do not know what date is today).

2

5. Find the origin and destination of those van lines on which at least one dispatched van has
had all its seats sold.
6. find the largest distance and the average distance covered by the lines that depart today ( we
do not know what date is today).
7. Find the total number of passenger seats sold (altogether) in all the vans that have been
dispatched to lines that cover a distance longer than 50 miles.

Brandy's solutions
1
SELECT registr
From van
Where cabin=’N’;
2
SELCET firstname, lastname
From diver, van, dispatch
Where ssn =driverid and
registr=vehicle
Cabin=’N’;    
3 
SELCET firstname, lastname
From diver
Where ssn not in (
SELECT ssn 
From diver, van, dispatch, line, plan
Where ssn=driverid and                      
registr=vehicle and                              
linenum=nline   and                             
plan.decode=dispatch.depcode and  plan - dispatch
cabin=’N’ and
distance > 15);

4
SELECT registr
From van, plan, dispatch
Where plan.decode=dispatch.depcode and 
registr=vehicle and                                                     
depart= date() and
soldseats>=seats ;                                                                      
5
SELECT origin, destination
From van, line, dispatch,plan                       
Where plan.decode=dispatch.depcode and 
registr=vehicle and                                                  
depart= date() and
seats> soldseats;     soldseats>=seats;  
6
SELECT max(distance), avg(distance)
From line, plan
Where linenum=nline and 
Depart=date();
7
SELECT sum(soldseats)
From van, dispatch, line, plan
Where registr=vehicle and                           
linenum=nline   and                                        
plan.decode=dispatch.depcode and           
distance>50;
