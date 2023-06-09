Use master
Go

Create Database ChainRestaurant
    on( Name='res_data', FileName='C:\Users\hamed\Documents\SQL Server Management Studio\res_data.mdf', Size=5 )
log on( Name='res_log', FileName='C:\Users\hamed\Documents\SQL Server Management Studio\res_log.ldf' )
Go

Alter Database ChainRestaurant Collate Persian_100_CI_AI
GO
Use ChainRestaurant


create table Restaurant
(
	rId int Primary key,
	rName nvarchar(20) not null,                
	rMail char(30) null,                
	rWebsite char(30) null,
	rDetails char(100) null,
	rAddress nvarchar(100) not null,
	rPhone char(15) not null
 )

create table Ingredient
(
	inId int Primary Key,
	inName nvarchar(30) not null,		
	inAmount int not null,            
	inPrice int not null,             
	inDetails nvarchar(100) null,
	inBuyer nvarchar(30) not null		-- better to be foreign key from employee
)

create table Menu
(
	mId int Primary key,
	mName nvarchar(30) not null,
	mDetails nvarchar(100) null,
	rId int not null,
	foreign key (rId) references Restaurant
)

create table Food
(
	fId int Primary key,
	fName nvarchar(30) not null,
	fPrice int not null,
	fDetails nvarchar(100) null
)

create table [Table]
(
	tNo int Primary Key,                   
	tCapasity nvarchar(30) not null,            
	rId int not null,                      
	Foreign Key (rId) References Restaurant On Update Cascade
)

create table [Order]
(
	oId int Primary key,
	ordererName nvarchar(30) not null,
	oDate date not null,
	oTime time not null,
	oStatus nvarchar(30) not null,
	oType nvarchar(30) not null,
	rId int not null,
	tNo int not null,
	foreign key (rId) references Restaurant,
	foreign key (tNo) references [Table]
)

create table Evaluation	
(
	eId int primary key,  
	eMail char(30) null,
	eScore int not null,   
	eComment char(200) null,
	eEvaluatorName char(70) null,
	rId int not null,                      
	Foreign Key (rId) References Restaurant On Update Cascade
)

CREATE TABLE Employee (
	eId INT PRIMARY KEY not null,
	eFirstName NVARCHAR(50) not null,
	eLastName NVARCHAR(50) not null,
	ePosition NVARCHAR(50) not null,
	eHireDate DATE not null,
	eSalary DECIMAL(10,2) not null,
	rId INT not null,
	FOREIGN KEY (rId) REFERENCES Restaurant On Update Cascade
)


CREATE TABLE Reservation (
	reId INT PRIMARY KEY,
	reCustomerName NVARCHAR(50) NOT NULL,
	reCustomerEmail NVARCHAR(50) NOT NULL,
	reCustomerPhone NVARCHAR(15) NOT NULL,
	reDate DATE NOT NULL,
	reTime TIME NOT NULL,
	rePartySize INT NOT NULL,
	tNo INT NOT NULL,
	FOREIGN KEY (tNo) REFERENCES [Table],
	rId INT NOT NULL,
	FOREIGN KEY (rId) REFERENCES [Restaurant]
)

create table Store
(
  stId int primary key,                  
  rId int not null,
  inId int not null,     
  Foreign Key (rId) References Restaurant On Update Cascade,
  Foreign Key (inId) References Ingredient On Update Cascade
)

CREATE TABLE Contain (
  cId INT PRIMARY KEY,
  fId INT NOT NULL,
  FOREIGN KEY (fId) REFERENCES Food (fId) On Update Cascade,
  oId INT NOT NULL,
  FOREIGN KEY (oId) REFERENCES [Order] (oId) On Update Cascade,
  cAmount INT NOT NULL
)






-- Insert records into Restaurant table
INSERT INTO Restaurant (rId, rName, rMail, rWebsite, rDetails, rAddress, rPhone)
VALUES (1, 'Restaurant 1', 'restaurant1@mail.com', 'www.restaurant1.com', 'Details 1', 'Address 1', '1234567890'),
       (2, 'Restaurant 2', 'restaurant2@mail.com', 'www.restaurant2.com', 'Details 2', 'Address 2', '2345678901'),
       (3, 'Restaurant 3', 'restaurant3@mail.com', 'www.restaurant3.com', 'Details 3', 'Address 3', '3456789012'),
       (4, 'Restaurant 4', 'restaurant4@mail.com', 'www.restaurant4.com', 'Details 4', 'Address 4', '4567890123'),
       (5, 'Restaurant 5', 'restaurant5@mail.com', 'www.restaurant5.com', 'Details 5', 'Address 5', '5678901234'),
       (6, 'Restaurant 6', 'restaurant6@mail.com', 'www.restaurant6.com', 'Details 6', 'Address 6', '6789012345'),
       (7, 'Restaurant 7', 'restaurant7@mail.com', 'www.restaurant7.com', 'Details 7', 'Address 7', '7890123456'),
       (8, 'Restaurant 8', 'restaurant8@mail.com', 'www.restaurant8.com', 'Details 8', 'Address 8', '8901234567'),
       (9, 'Restaurant 9', 'restaurant9@mail.com', 'www.restaurant9.com', 'Details 9', 'Address 9', '9012345678'),
       (10, 'Restaurant 10', 'restaurant10@mail.com', 'www.restaurant10.com', 'Details 10', 'Address 10', '0123456789');

-- Insert records into Ingredient table
INSERT INTO Ingredient (inId, inName, inAmount, inPrice, inDetails, inBuyer)
VALUES (1, 'Ingredient 1', 10, 5, 'Details 1', 'Buyer 1'),
       (2, 'Ingredient 2', 20, 10, 'Details 2', 'Buyer 2'),
       (3, 'Ingredient 3', 30, 15, 'Details 3', 'Buyer 3'),
       (4, 'Ingredient 4', 40, 20, 'Details 4', 'Buyer 4'),
       (5, 'Ingredient 5', 50, 25, 'Details 5', 'Buyer 5'),
       (6, 'Ingredient 6', 60, 30, 'Details 6', 'Buyer 6'),
       (7, 'Ingredient 7', 70, 35, 'Details 7', 'Buyer 7'),
       (8, 'Ingredient 8', 80, 40, 'Details 8', 'Buyer 8'),
       (9, 'Ingredient 9', 90, 45, 'Details 9', 'Buyer 9'),
       (10, 'Ingredient 10', 100, 50, 'Details 10', 'Buyer 10');

-- Insert records into Menu table
INSERT INTO Menu (mId, mName, mDetails, rId)
VALUES (1, 'Menu 1', 'Menu details 1', 1),
       (2, 'Menu 2', 'Menu details 2', 2),
       (3, 'Menu 3', 'Menu details 3', 3),
       (4, 'Menu 4', 'Menu details 4', 4),
       (5, 'Menu 5', 'Menu details 5', 5),
       (6, 'Menu 6', 'Menu details 6', 6),
       (7, 'Menu 7', 'Menu details 7', 7),
       (8, 'Menu 8', 'Menu details 8', 8),
       (9, 'Menu 9', 'Menu details 9', 9),
       (10, 'Menu 10', 'Menu details 10', 10);

-- Insert records into Food table
INSERT INTO Food (fId, fName, fPrice, fDetails)
VALUES (1, 'Food 1', 10, 'Food details 1'),
       (2, 'Food 2', 20, 'Food details 2'),
       (3, 'Food 3', 30, 'Food details 3'),
       (4, 'Food 4', 40, 'Food details 4'),
       (5, 'Food 5', 50, 'Food details 5'),
       (6, 'Food 6', 60, 'Food details 6'),
       (7, 'Food 7', 70, 'Food details 7'),
       (8, 'Food 8', 80, 'Food details 8'),
       (9, 'Food 9', 90, 'Food details 9'),
       (10, 'Food 10', 100, 'Food details 10');

-- Insert records into [Table] table
INSERT INTO [Table] (tNo, tCapasity, rId)
VALUES (1, 'Table 1 Capacity', 1),
       (2, 'Table 2 Capacity', 2),
       (3, 'Table 3 Capacity', 3),
       (4, 'Table 4 Capacity', 4),
       (5, 'Table 5 Capacity', 5),
       (6, 'Table 6 Capacity', 6),
       (7, 'Table 7 Capacity', 7),
       (8, 'Table 8 Capacity', 8),
       (9, 'Table 9 Capacity', 9),
       (10, 'Table 10 Capacity', 10);


-- Insert records into [Order] table
INSERT INTO [Order] (oId, ordererName, oDate, oTime, oStatus, oType, rId, tNo)
VALUES (1, 'Orderer 1', '2023-06-01', '12:00:00', 'Status 1', 'Type 1', 1, 1),
       (2, 'Orderer 2', '2023-06-02', '13:00:00', 'Status 2', 'Type 2', 2, 2),
       (3, 'Orderer 3', '2023-06-03', '14:00:00', 'Status 3', 'Type 3', 3, 3),
       (4, 'Orderer 4', '2023-06-04', '15:00:00', 'Status 4', 'Type 4', 4, 4),
       (5, 'Orderer 5', '2023-06-05', '16:00:00', 'Status 5', 'Type 5', 5, 5),
       (6, 'Orderer 6', '2023-06-06', '17:00:00', 'Status 6', 'Type 6', 6, 6),
       (7, 'Orderer 7', '2023-06-07', '18:00:00', 'Status 7', 'Type 7', 7, 7),
       (8, 'Orderer 8', '2023-06-08', '19:00:00', 'Status 8', 'Type 8', 8, 8),
       (9, 'Orderer 9', '2023-06-09', '20:00:00', 'Status 9', 'Type 9', 9, 9),
       (10, 'Orderer 10', '2023-06-10', '21:00:00', 'Status 10', 'Type 10', 10, 10);

-- Insert records into Evaluation table
INSERT INTO Evaluation (eId, eMail, eScore, eComment, eEvaluatorName, rId)
VALUES (1, 'evaluation1@mail.com', 5, 'Comment 1', 'Evaluator 1', 1),
       (2, 'evaluation2@mail.com', 4, 'Comment 2', 'Evaluator 2', 2),
       (3, 'evaluation3@mail.com', 3, 'Comment 3', 'Evaluator 3', 3),
       (4, 'evaluation4@mail.com', 2, 'Comment 4', 'Evaluator 4', 4),
       (5, 'evaluation5@mail.com', 1, 'Comment 5', 'Evaluator 5', 5),
       (6, 'evaluation6@mail.com', 5, 'Comment 6', 'Evaluator 6', 6),
       (7, 'evaluation7@mail.com', 4, 'Comment 7', 'Evaluator 7', 7),
       (8, 'evaluation8@mail.com', 3, 'Comment 8', 'Evaluator 8', 8),
       (9, 'evaluation9@mail.com', 2, 'Comment 9', 'Evaluator 9', 9),
       (10, 'evaluation10@mail.com', 1, 'Comment 10', 'Evaluator 10', 10);

-- Insert records into Employee table
INSERT INTO Employee (eId, eFirstName, eLastName, ePosition, eHireDate, eSalary, rId)
VALUES (1, 'Employee 1', 'Lastname 1', 'Position 1', '2022-01-01', 1000.00, 1),
       (2, 'Employee 2', 'Lastname 2', 'Position 2', '2022-02-01', 2000.00, 2),
       (3, 'Employee 3', 'Lastname 3', 'Position 3', '2022-03-01', 3000.00, 3),
       (4, 'Employee 4', 'Lastname 4', 'Position 4', '2022-04-01', 4000.00, 4),
       (5, 'Employee 5', 'Lastname 5', 'Position 5', '2022-05-01', 5000.00, 5),
       (6, 'Employee 6', 'Lastname 6', 'Position 6', '2022-06-01', 6000.00, 6),
       (7, 'Employee 7', 'Lastname 7', 'Position 7', '2022-07-01', 7000.00, 7),
       (8, 'Employee 8', 'Lastname 8', 'Position 8', '2022-08-01', 8000.00, 8),
       (9, 'Employee 9', 'Lastname 9', 'Position 9', '2022-09-01', 9000.00, 9),
       (10, 'Employee 10', 'Lastname 10', 'Position 10', '2022-10-01', 10000.00, 10);

-- Insert records into Reservation table
INSERT INTO Reservation (reId, reCustomerName, reCustomerEmail, reCustomerPhone, reDate, reTime, rePartySize, tNo, rId)
VALUES (1, 'Customer 1', 'customer1@mail.com', '1234567890', '2023-06-01', '12:00:00', 5, 1, 1),
       (2, 'Customer 2', 'customer2@mail.com', '2345678901', '2023-06-02', '13:00:00', 4, 2, 2),
       (3, 'Customer 3', 'customer3@mail.com', '3456789012', '2023-06-03', '14:00:00', 3, 3, 3),
       (4, 'Customer 4', 'customer4@mail.com', '4567890123', '2023-06-04', '15:00:00', 2, 4, 4),
       (5, 'Customer 5', 'customer5@mail.com', '5678901234', '2023-06-05', '16:00:00', 1, 5, 5),
       (6, 'Customer 6', 'customer6@mail.com', '6789012345', '2023-06-06', '17:00:00', 5, 6, 6),
       (7, 'Customer 7', 'customer7@mail.com', '7890123456', '2023-06-07', '18:00:00', 4, 7, 7),
       (8, 'Customer 8', 'customer8@mail.com', '8901234567', '2023-06-08', '19:00:00', 3, 8, 8),
       (9, 'Customer 9', 'customer9@mail.com', '9012345678', '2023-06-09', '20:00:00', 2, 9, 9),
       (10, 'Customer 10', 'customer10@mail.com', '0123456789', '2023-06-10', '21:00:00', 1, 10, 10);

-- Insert records into Store table
INSERT INTO Store (stId, rId, inId)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3),
       (4, 4, 4),
       (5, 5, 5),
       (6, 6, 6),
       (7, 7, 7),
       (8, 8, 8),
       (9, 9, 9),
       (10, 10, 10);

-- Insert records into Contain table
INSERT INTO Contain (cId, fId, oId, cAmount)
VALUES (1, 1, 1, 2),
       (2, 2, 2, 3),
       (3, 3, 3, 4),
       (4, 4, 4, 5),
       (5, 5, 5, 6),
       (6, 6, 6, 7),
       (7, 7, 7, 8),
       (8, 8, 8, 9),
       (9, 9, 9, 10),
       (10, 10, 10, 1);

Go