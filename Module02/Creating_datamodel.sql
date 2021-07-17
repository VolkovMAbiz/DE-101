DROP TABLE customer_dim cascade;
DROP TABLE order_date_calendar cascade;
DROP TABLE orders_body_dim cascade;
DROP TABLE orders_headers_facts cascade;
DROP TABLE ship_date_calendar cascade;
DROP TABLE regional_manager_dim cascade;
DROP TABLE products_dim cascade;


CREATE TABLE customer_dim
(
 customer_id       varchar(50) NOT NULL,
 birthdate         date NOT NULL,
 age               integer NOT NULL,
 email             varchar(150) NOT NULL,
 phone             varchar(20) NOT NULL,
 registration_date date NOT NULL,
 segment           varchar(50) NOT NULL,
 CONSTRAINT PK_customer_dim PRIMARY KEY ( customer_id )
);

CREATE TABLE products_dim
(
 product_id   varchar(50) NOT NULL,
 category     varchar(50) NOT NULL,
 sub_category varchar(50) NOT NULL,
 product_name varchar(150) NOT NULL,
 CONSTRAINT PK_products_dim PRIMARY KEY ( product_id )
);

CREATE TABLE regional_manager_dim
(
 region  varchar(50) NOT NULL,
 manager varchar(50) NOT NULL,
 CONSTRAINT PK_region_manager_dim PRIMARY KEY ( region )
);

CREATE TABLE ship_date_calendar
(
 ship_date      date NOT NULL,
 year           integer NOT NULL,
 quarter        varchar(2) NOT NULL,
 month          varchar(15) NOT NULL,
 month_num      varchar(2) NOT NULL,
 year_month     varchar(19) NOT NULL,
 year_month_num varchar(7) NOT NULL,
 week           integer NOT NULL,
 week_day       integer NOT NULL,
 CONSTRAINT PK_calendar_clone PRIMARY KEY ( ship_date )
);

CREATE TABLE order_date_calendar
(
 order_date     date NOT NULL,
 year           integer NOT NULL,
 quarter        varchar(2) NOT NULL,
 month          varchar(15) NOT NULL,
 month_num      varchar(2) NOT NULL,
 year_month     varchar(19) NOT NULL,
 year_month_num varchar(7) NOT NULL,
 week           integer NOT NULL,
 week_day       integer NOT NULL,
 CONSTRAINT PK_calendar PRIMARY KEY ( order_date )
);

CREATE TABLE orders_body_dim
(
 row_id     serial NOT NULL,
 product_id varchar(50) NOT NULL,
 quantity   integer NOT NULL,
 price      numeric(10,2) NOT NULL,
 sales      numeric(10,2) NOT NULL,
 profit     numeric(10,2) NOT NULL,
 discount   numeric(10,2) NOT NULL,
 order_id   varchar(50) NOT NULL,
 CONSTRAINT PK_table_4 PRIMARY KEY ( row_id ),
 CONSTRAINT FK_117 FOREIGN KEY ( product_id ) REFERENCES products_dim ( product_id )
);


CREATE INDEX fkIdx_118 ON orders_body_dim
(
 product_id
);

CREATE INDEX fkIdx_85 ON orders_body_dim
(
 order_id
);

CREATE TABLE orders_headers_facts
(
 order_id        varchar(50) NOT NULL,
 order_date      date NOT NULL,
 ship_date       date NOT NULL,
 ship_mode       varchar(50) NOT NULL,
 customer_id     varchar(50) NOT NULL,
 country         varchar(50) NOT NULL,
 region          varchar(50) NOT NULL,
 city            varchar(100) NOT NULL,
 "state"           varchar(100) NOT NULL,
 "postal code"     varchar(20) NOT NULL,
 total_sales     numeric(10,2) NOT NULL,
 total_profit    numeric(10,2) NOT NULL,
 total_discount  numeric(10,2) NOT NULL,
 returned_status varchar(3) NOT NULL,
 CONSTRAINT PK_orders_headers_facts PRIMARY KEY ( order_id ),
 CONSTRAINT FK_99 FOREIGN KEY ( customer_id ) REFERENCES customer_dim ( customer_id ),
 CONSTRAINT FK_114 FOREIGN KEY ( region ) REFERENCES regional_manager_dim ( region ),
 CONSTRAINT FK_133 FOREIGN KEY ( order_date ) REFERENCES order_date_calendar ( order_date ),
 CONSTRAINT FK_141 FOREIGN KEY ( ship_date ) REFERENCES ship_date_calendar ( ship_date )
);

CREATE INDEX fkIdx_100 ON orders_headers_facts
(
 customer_id
);

CREATE INDEX fkIdx_115 ON orders_headers_facts
(
 region
);

CREATE INDEX fkIdx_134 ON orders_headers_facts
(
 order_date
);

CREATE INDEX fkIdx_142 ON orders_headers_facts
(
 ship_date
);


ALTER TABLE orders_body_dim ADD FOREIGN KEY (order_id) REFERENCES orders_headers_facts (order_id);
