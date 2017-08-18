/*
 Final Assignment
 Benjamin Haimowitz
 */
 
DROP TABLE IF EXISTS EnergyCategories;
DROP TABLE IF EXISTS EnergyTypes;
DROP TABLE IF EXISTS Buildings;
DROP TABLE IF EXISTS BuildingEnergy;

CREATE TABLE EnergyCategories
(
cat_id int NOT NULL,
category varchar(50) NOT NULL
);

INSERT INTO EnergyCategories (cat_id, category) VALUES (1, 'Fossil');
INSERT INTO EnergyCategories (cat_id, category) VALUES (2, 'Renewable');

# Select * From EnergyCategories;

CREATE TABLE EnergyTypes
(
type_id int NOT NULL,
Etype varchar(30) NOT NULL,
cat_id int NOT NULL
);

INSERT INTO EnergyTypes (type_id, etype, cat_id) VALUES (1, 'Electricity', 1);
INSERT INTO EnergyTypes (type_id, etype, cat_id) VALUES (2, 'Gas', 1);
INSERT INTO EnergyTypes (type_id, etype, cat_id) VALUES (3, 'Steam', 1);
INSERT INTO EnergyTypes (type_id, etype, cat_id) VALUES (4, 'Fuel Oil', 1);
INSERT INTO EnergyTypes (type_id, etype, cat_id) VALUES (5, 'Solar', 2);
INSERT INTO EnergyTypes (type_id, etype, cat_id) VALUES (6, 'Wind', 2);

# Select * From EnergyTypes;

Select
EnergyCategories.category AS `Category`,
EnergyTypes.etype AS `Type`
from EnergyCategories

left join EnergyTypes
on EnergyCategories.cat_id = EnergyTypes.cat_id
order by `Type`;


CREATE TABLE Buildings
(
building_id int NOT NULL,
building varchar(50) NOT NULL
);

INSERT INTO Buildings (building_id, building) VALUES (1, 'Empire State Building');
INSERT INTO Buildings (building_id, building) VALUES (2, 'Chrysler Building');
INSERT INTO Buildings (building_id, building) VALUES (3, 'Borough of Manhattan Community College');

Select * From Buildings;

CREATE TABLE BuildingEnergy
(
buildingenergy_id int NOT NULL auto_increment PRIMARY KEY,
building_id int NULL,
type_id int NULL
);

INSERT INTO BuildingEnergy (building_id, type_id) VALUES (1, 1);
INSERT INTO BuildingEnergy (building_id, type_id) VALUES (1, 2);
INSERT INTO BuildingEnergy (building_id, type_id) VALUES (1, 3);
INSERT INTO BuildingEnergy (building_id, type_id) VALUES (2, 1);
INSERT INTO BuildingEnergy (building_id, type_id) VALUES (2, 3);
INSERT INTO BuildingEnergy (building_id, type_id) VALUES (3, 1);
INSERT INTO BuildingEnergy (building_id, type_id) VALUES (3, 3);
INSERT INTO BuildingEnergy (building_id, type_id) VALUES (3, 5);

Select
buildings.building AS `Building`,
EnergyTypes.etype AS `Energy Type`
from buildings

left join BuildingEnergy
on buildings.building_id = BuildingEnergy.building_id

left join EnergyTypes
on BuildingEnergy.type_id = EnergyTypes.type_id
order by `Building`;

#6 Adding info to various databases
INSERT INTO Buildings (building_id, building) VALUES (4, 'Bronx Lion House');
INSERT INTO Buildings (building_id, building) VALUES (5, 'Brooklyn Childrens Museum');
INSERT INTO EnergyTypes (type_id, etype, cat_id) VALUES (7, 'Geothermal', 2);
INSERT INTO BuildingEnergy (building_id, type_id) VALUES (4, 7);
INSERT INTO BuildingEnergy (building_id, type_id) VALUES (5, 1);
INSERT INTO BuildingEnergy (building_id, type_id) VALUES (5, 7);

#7
Select 
buildings.building AS `Building`,
EnergyTypes.etype AS `Energy Type`,
EnergyCategories.category AS `Category`
from buildings

left join BuildingEnergy
on buildings.building_id = BuildingEnergy.building_id

left join EnergyTypes
on BuildingEnergy.type_id = EnergyTypes.type_id

left join EnergyCategories
on EnergyCategories.cat_id = EnergyTypes.cat_id
where category = 'Renewable'

order by `Building`;

#8
Select
EnergyTypes.etype AS `Type`,
Count(EnergyTypes.etype) AS `Count`
FROM EnergyTypes
right join BuildingEnergy
on BuildingEnergy.type_id = EnergyTypes.type_id

left join Buildings
on BuildingEnergy.building_id = Buildings.building_id

Group by `Type`
Order By `Count` DESC;
