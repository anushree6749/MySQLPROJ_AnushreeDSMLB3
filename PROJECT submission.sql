#You are going to build a project based on Library Management System. It keeps
# track all information about books in the library, their cost, status and total number of books available in the library. 
create database library;
use library;
create table branch ( branch_id int primary key,manager_id int ,branch_address varchar (30),contact_no int);
insert into branch values ( 0413,6749, "Ernakulam", 999999);
insert into branch values ( 0565,6748, "Eruveli", 999998);
insert into branch values ( 0651,6747, "Ekm Mktroad", 999997);
insert into branch values ( 0343,6746, "Kakkanad", 999996);
insert into branch values ( 0075,6745, "Trivandrum", 999995);

create table employee(emp_id int primary key,emp_name varchar (30),position varchar (30),salary int);
insert into employee values(6749,"anu","officer",35000);
insert into employee values(6748,"manu","officer",35000);
insert into employee values(6747,"tanu","officer",55000);
insert into employee values(6746,"nanu","Manager",60000);
insert into employee values(6745,"Auri","clerk",20000);

create table customer(customer_id int primary key,customer_name varchar (30),customer_address varchar (30),reg_date date);
insert into customer values (9999,"xxx","Vennalla","2022-04-01");
insert into customer values (9998,"yyy","pala","2021-04-05"); 
insert into customer values (9997,"zzz","tvm","2020-06-01"); 
insert into customer values (9996,"ppp","Vennalla","2022-04-01"); 
insert into customer values (9995,"mmm","ekm","2019-08-01"); 
select * from customer;

CREATE TABLE Boookss (
  ISBN VARCHAR(30) PRIMARY KEY,
  Book_title VARCHAR(30),
  Category VARCHAR(30),
  Rental_Price DECIMAL(10, 2),
  Status ENUM('yes', 'no'),
  Author VARCHAR(30),
  Publisher VARCHAR(30)
);
INSERT INTO Boookss VALUES('ISB001', 'BA', 'Fiction', 10.00, 'yes', 'John Smith', 'ABC Publishing');
INSERT INTO Boookss VALUES('ISB002', 'BC', 'Mystery', 20.00, 'yes', 'Sarah Johnson', 'XYZ Books');
INSERT INTO Boookss VALUES('ISB003', 'BD', 'History', 15.00, 'no', 'Michael Brown', 'DEF Publishers');
INSERT INTO Boookss VALUES('ISB004', 'BE', 'Fiction', 109.00, 'yes', 'Emily Davis', 'GHI Press');
INSERT INTO Boookss VALUES('ISB005', 'Book E', 'Science Fiction', 11.00, 'yes', 'Emily Johnson', 'JKL Publishing');
SELECT * FROM BOOOKSS;

CREATE TABLE IssueStatusss (
  Issue_Id INT PRIMARY KEY,
  Issued_cust INT,
  Issued_book_name VARCHAR(255),
  Issue_date DATE,
  Isbn_book VARCHAR(255),
  FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES BOOOkss(ISBN));

INSERT INTO IssueStatusss (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(1, 9999, 'Book A', '2023-06-05', 'ISB001'),
(2, 9998, 'Book B', '2023-06-10', 'ISB002'),
(3, 9997, 'Book C', '2023-06-12', 'ISB003'),
(4, 9996, 'Book D', '2023-06-15', 'ISB004'),
(5, 9995, 'Book D', '2023-06-15', 'ISB005');
SELECT * FROM IssueStatusss;

CREATE TABLE ReturnStatusss(
  Return_Id INT PRIMARY KEY,
  Return_cust INT,
  Return_book_name VARCHAR(30),
  Return_date DATE,
  Isbn_book2 VARCHAR(30),
    FOREIGN KEY (Isbn_book2) REFERENCES Boookss(ISBN));
INSERT INTO ReturnStatusss (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(1, 9999, 'Book A', '2023-06-18', 'ISB001'),
(2, 9998, 'Book B', '2023-06-20', 'ISB002'),
(3, 9997, 'Book C', '2023-06-21', 'ISB003'),
(4, 9996, 'Book E', '2023-06-18', 'ISB004'),
(5, 9995, 'Book F', '2023-06-20', 'ISB005');
SELECT * FROM ReturnStatusss;

#Retrieve the book title, category, and rental price of all available books. 
SELECT Book_title, Category, Rental_Price
FROM Boookss
WHERE Status = 'yes';

#Retrieve the book titles and the corresponding customers who have issued those books.
SELECT b.Book_title, c.Customer_name
FROM Boookss
JOIN IssueStatusss i ON b.ISBN = i.Isbn_book
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

#Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Count
FROM Boookss
GROUP BY Category;

#Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position FROM Employee WHERE Salary > 50000;

#Display the branch numbers and the total count of employees in each branch.
SELECT b.Branch_id, COUNT(*) AS Total_Employees
FROM Branch b
JOIN Employee e ON b.Manager_Id = e.Emp_Id
GROUP BY b.Branch_id;

#List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01'AND Customer_Id NOT IN (
    SELECT Issued_cust     FROM IssueStatus );
    
#Display the names of customers who have issued books in the month of June 2023.
SELECT c.Customer_name FROM Customer c JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE MONTH(i.Issue_date) = 6 AND YEAR(i.Issue_date) = 2023;

#Retrieve book_title from the book table containing history.
SELECT Book_title
FROM Books
WHERE Category = 'History';

#Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT b.Branch_id, COUNT(*) AS Total_Employees
FROM Branch b
JOIN Employee e ON b.Manager_Id = e.Emp_Id
GROUP BY b.Branch_id
HAVING COUNT(*) > 5;












 







