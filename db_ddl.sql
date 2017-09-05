CREATE DATABASE db_dsp_2016 -- създаване на нова база

GO
USE db_dsp_2016 -- използване на новата база

-- Създаване на таблицата Suppliers (Доставчици):

CREATE TABLE Suppliers(
id_suppliers char(10) primary key, -- първичен ключ, БУЛСТАТ, 10 символа
name nvarchar(50), -- име на доставчик, 50 символа
city nvarchar(50), -- име на града, 50 символа
adress nvarchar(50), -- адрес на доставчик, 50 символа
telephone nvarchar(20), -- телефонен номер, 20 символа
email nvarchar(50) -- електронна поща, 50 символа
)

-- Създаване на таблицата Products (Продукти):

CREATE TABLE Products(
id_products int primary key identity, -- първичен ключ, нараства автоматично с единица
name nvarchar(20), -- име на продукт
products_weight decimal(6,3), -- тегло на един продукт съхранен в склада; (Пример: Колко е общото тегло на краставиците в склада ?)
quantity int, -- количество от дадения продукт, съхранявано в склада
price money -- цена на единица продукт; (Пример: Колко струва един домат ?)
)

-- Създаване на таблицата Delivery (Доставки):

CREATE TABLE Delivery(
id_delivery int primary key identity, -- първичен ключ, номер на доставка, нараства автоматично с единица
id_suppliers char(10) references Suppliers(id_suppliers), /*Задаваме id_suppliers от таблица Suppliers за външен ключ*/
date_of_delivery date, -- дата на доставка
price money, -- цена на цялата доставка
invoice nvarchar(5) -- отговаря на това дали има получена фактура
)

-- Създаване на таблицата Delivery_products (Доставки_Продукти):

CREATE TABLE Delivery_products(
id_delivery_products int primary key identity, -- първичен ключ, нараства автоматично с единица
id_delivery int references Delivery(id_delivery), /*Задаваме id_delivery от таблица Delivery за външен ключ*/
id_products int references Products(id_products), /*Задаваме id_products от таблица Products за външен ключ*/
)

-- Създаване на таблицата Meals (Ястия):

CREATE TABLE Meals(
id_meals int primary key identity, -- Първичен ключ, номер на ястие от списъка с предлагани ястия
group_meals nvarchar(20), -- Група ястие, до 20 символа
name nvarchar(30), -- Име ястие, до 30 символа
price money, -- цена на 1 бр. от дадено ястие
quantity int -- общ брой от произведеното ястие за деня
) 

-- Създаване на таблицата Making (Приготвяне):

CREATE TABLE Making(
id_making int primary key identity, -- пореден номер на приготвено ястие 
id_products int references Products(id_products), /*Задаваме id_products от таблица
Products_meals за външен ключ и е връзка към таблица Products*/
id_meals int references Meals(id_meals), /*Задаваме id_meals от таблица
Products_meals за външен ключ и е връзка към таблица Meals*/
date_of_prepare date -- Дата на приготвяне на ястие
)

-- Създаване на таблицата Clients (Клиенти):

CREATE TABLE Clients(
EGN_clients char(10) primary key, -- Първичен ключ
first_name nvarchar(20), -- Име на клиент, до 20 символа
last_name nvarchar(20), -- Фамилия на клиент, до 20 символа
city nvarchar(50), -- Град на клиент, до 50 символа
adress nvarchar(50), -- Адрес на клиент, до 50 символа
years tinyint -- Години на клиент
)

-- Създаване на таблицата Positions (Позиции):

CREATE TABLE Positions(
id_positions int primary key identity, -- Пореден номер на длъжност, първичен ключ
name nvarchar(30), -- Име на длъжност
position_description nvarchar(50) -- Описание на длъжност
)

-- Създаване на таблицата Employees (Служители):

CREATE TABLE Employees(
EGN_employees char(10) primary key, -- Първичен ключ, показва ЕГН на служител
id_positions int references Positions(id_positions), /*Задаваме id_positions от таблица
Positions за външен ключ*/
first_name nvarchar(20), -- Име на служител, до 50 символа
last_name nvarchar(20), -- Фамилия на служител, до 50 символа
city nvarchar(50), -- Град на служителя, до 50 символа
adress nvarchar(50), -- Адрес на служителя, до 50 символа
email nvarchar(50), -- Електронна поща на служител
years tinyint, -- Години на служител
telephone nvarchar(20) -- Телефон на служител
)


-- Създаване на таблицата Queries (Ястия):

CREATE TABLE Queries(
id_queries int primary key identity, -- Първичен ключ, пореден номер на заявка
EGN_employees char(10) references Employees(EGN_employees), -- ЕГН на служител, взето от таблицата Employees
EGN_clients char(10) references Clients(EGN_clients), -- ЕГН на клиент, взето от таблицата Clients
id_ordereddishes int,
date_of_transport date, -- Дата на изготвяне на заявка
destination nvarchar(30),
kilometer int,
query_description nvarchar(50) -- Описание на заявка
)

-- Създаване на таблицата Ordered_dishes (Поръчани ястия):

CREATE TABLE Ordered_dishes(
id_ordereddishes int primary key identity, -- Уникален номер на поръчаните ястия
id_meals int references Meals(id_meals), /*Задаваме id_meals от таблица
Meals за външен ключ*/
id_queries int references Queries(id_queries) /*Задаваме id_queries от таблица
Queries за външен ключ*/
)

-- Добавяне на ограничение FOREIGN KEY за таблицата Queries
ALTER TABLE Queries
ADD CONSTRAINT Ordered_dishes_FK FOREIGN KEY (id_ordereddishes)
REFERENCES Ordered_dishes (id_ordereddishes);


-- INSERT INTO - Вмъкване на данни в таблица
-- VALUES - Стойности за полетата

-- Добавяне на данни в таблицата Suppliers (Доставчици):
INSERT INTO Suppliers (id_suppliers, name, city, adress, telephone, email)
VALUES('5363420901', 'Лотус', 'Варна', 'Шипка 2', '0879203920', 'lotus@abv.bg'), 
('5363423411', 'Еделвайс', 'Каварна', 'Нов живот 3', '0889234520', 'edelvais@abv.bg'), 
('4346342341', 'Роял', 'Варна', 'Ангел Кънчев 10', '0887920901', 'royal1@gmail.com'),
('4326708921', 'Гергана - Деница', 'Каварна', 'Черни връх', '0898710794', 'gerganadenica@gmail.com'),
('4492038640', 'ЗлатенКлас', 'Балчик', 'Черно море 34', '0889019891', 'zlatenklas@yahoo.com'),
('4024900194', 'Био', 'Каварна', 'Братя Шкорпил 33', '0872019047', 'bio2004@abv.bg'),
('3792032610', 'Николай2003', 'Девня', '', '', 'niki2003@mail.bg'),
('3235832900', 'Царевец', 'Варна', 'Слънчев бряг 21', '0887204910', ''),
('3238992960', 'Асония', 'Балчик', 'Гео Милев 22', '0872008693', 'asonia@abv.bg'),
('8964907852', 'SeaFoods', 'Варна', 'Иван Вазов 29', '0892034820', 'seafoods@mail.bg'),
('8098643905', 'Yummy', 'Варна',  'Преслав 12', '0884039048', 'yummyfoods@gmail.com'),
('5930289028', 'HealthyFoods', 'Варна',  'Македония 73' , '0894890451', 'healthyfoods@gmail.com')

INSERT INTO Suppliers(id_suppliers, name)
VALUES('1029408902', 'Paradise'),
('1945049056', 'Сладкарница Лондон'),
('4920497893', 'Българска ябълка')

INSERT INTO Suppliers(id_suppliers, name, city, adress, telephone)
VALUES('1529490787', 'Нико2004', 'Шабла', 'Равно поле 41', '0887340458'),
('4954560934', 'Дуков', 'Каварна', '','')

-- Добавяне на данни в таблицата Products (Продукти):
INSERT INTO Products(name,products_weight, quantity, price)
VALUES('Кисело мляко', 0.400, 30, 0.85),
('Моркови', 1, 25, 0.55),
('Захар', 1, 25, 1.50),
('Леща', 1, 40, 2.50),
('Мандарини', 1, 20, 2.20),
('Ориз', 1, 30, 2.69),
('Домати', 1, 40, 2.20),
('Хляб', 0.650, 50, 0.90),
('Брашно', 1, 30, 1.40)

-- Добавяне на данни в таблицата Delivery (Доставки):
INSERT INTO Delivery(date_of_delivery, price)
VALUES('12-04-2016', 300)
INSERT INTO Delivery(id_suppliers,date_of_delivery, price, invoice)
VALUES ('5930289028','12-04-2016', 35, 'да'),
('3792032610','2016-04-15', 200, 'да'),
('4024900194','2016-04-18', 60, 'да'),
('4346342341','2016-04-19', 60, 'не'),
('3235832900','2016-03-07', '', 'не'),
('8098643905','2016-01-08', '', 'не'),
('1945049056','2016-03-05', 50, 'да')

-- Добавяне на данни в таблицата Delivery_products (Доставки_Продукти):
INSERT INTO Delivery_products(id_delivery, id_products)
VALUES(1, 2),
(3,1),
(2,1),
(2,4),
(4,5),
(3,1),
(4,2),
(2,7),
(4,1),
(5,5)

-- Добавяне на данни в таблицата Meals (Ястия):
INSERT INTO Meals(group_meals, name, price, quantity)
VALUES('Салата', 'Шопска', 3, 70 ),
('Супа', 'Пилешка', 2, 50 ),
('Супа', 'Леща', 2, 50),
('Супа', 'Месо', 3, 45),
('Супа', 'Топчета', 2.20, 40),
('Супа', 'Таратор', 1.50, 30),
('Десерт', 'Ашуре', 2, 30),
('Десерт', 'Бисквитена торта', 2.20, 39),
('Основно ястие', 'Руло Стефани', 2.60, 40),
('Основно ястие', 'Пиле с ориз', 2.20, 40),
('Основно ястие', 'Боб яхния', 2.40, 50),
('Основно ястие', 'Зеле с домати', 2.80, 40),
('Основно ястие', 'Тас-кебап', 3, 40),
('Основно ястие', 'Зелен боб яхния', 2.50, 50),
('Десерт', 'Кисело мляко', 1, 50),
('Десерт', 'Каварма', 0.60, 62)

-- Добавяне на данни в таблицата Clients (Клиенти):
INSERT INTO Clients(EGN_clients, first_name, last_name, city, adress, years)
VALUES('3402017983', 'Иван', 'Стоянов', 'Шабла', 'Марица 29', 82),
('3503126943', 'Петър', 'Иванов', 'Шабла', 'Искър 15', 81),
('4003129943', 'Калоян', 'Иванов', 'Шабла', 'Равно поле 10', 76),
('4212126983', 'Димитър', 'Желязков', 'Шабла', 'Искър 15', 74),
('3903126993', 'Йорданка', 'Тенева', 'Шабла', 'Нефтяник 5', 77)

-- Добавяне на данни в таблицата Positions (Длъжности):
INSERT INTO Positions(name, position_description)
VALUES ('Главен готвач', 'Отговаря за приготвянето на храната'),
('Счетоводител', 'Съставя и поддържа документацията'),
('Хигиенист', 'Грижи се за чистота на помещенията')

INSERT INTO Positions(name)
VALUES ('Шофьор')

-- Добавяне на данни в таблицата Employees (Служители):
INSERT INTO Employees(EGN_employees, id_positions, first_name, last_name, city, adress, email, years, telephone)
VALUES ('8203291293', 1, 'Надежда', 'Николова'	, 'Шабла', 'Равно поле 45', 'nadejda82@abv.bg', 34, '0889203020'),
('7303190093', 2, 'Искра', 'Пенчева'	, 'Шабла', 'Хан Кубрат 3', 'iskra.pencheva@mail.bg', 43, '0883204019'),
('8012039013', 3, 'Силвия', 'Христова'	, 'Шабла', 'Хаджи Димитър 12', 'silviq.hristova@mail.bg', 35, '0887404281'),
('6302173374', 3, 'Елена', 'Йорданова'	, 'Шабла', 'Стефан Караджа 10', 'elenaiordanova@gmail.com', 53, '0876204094'),
('7905108082', 1, 'Христо', 'Янев', 'Шабла', 'Ропотамо 30', 'hristo1979@yahoo.com', 37, '0885923045'),
('6705194502', 4, 'Ивайло', 'Звездев', 'Каварна', 'Чиракман 20', 'ivailo67@mail.bg', 48, '0889089962'),
('7704204301', 4, 'Калоян', 'Петров', 'Каварна', 'Братя Шкорпил 10', 'kalo77@mail.bg', 48, '0890639104')

-- Добавяне на данни в таблицата Making (Приготвяне):
INSERT INTO Making(id_products, id_meals, date_of_prepare)
VALUES (1, 3, '2016-03-12'),
(2, 2, '2016-02-20'),
(3, 3, '2016-04-15'),
(5, 1, '2016-03-16'),
(8, 5, '2016-03-12')

-- Добавяне на данни в таблицата Orders_dishes (Поръчани ястия):
INSERT INTO Ordered_dishes(id_meals)
VALUES (1),
(1),
(2),
(3),
(4)

-- Добавяне на данни в таблицата Queries (Заявки):
INSERT INTO Queries(EGN_employees, EGN_clients, date_of_transport, destination, kilometer, query_description)
VALUES ('8203291293', '3503126943', '2016-04-30', 'Шабла', 3, ''),
('6302173374', '3903126993', '2016-04-27', 'Шабла', 3, 'Поръчана е супа леща!'),
('8012039013', '3903126993', '2016-04-28', 'Ваклино', 13, ''),
('8012039013', '3903126993', '2016-04-28', 'Крапец', 14, ''),
('6302173374', '3503126943', '2016-04-30', 'Горун', 5, 'Поръчана е супа месо!')


