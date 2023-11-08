--membuat tipe data enum untuk role users :
create type users_role as enum ('admin', 'staff', 'customer');

--membuat table users :
create table "users"(
	"id" serial primary key,
	"full_name" varchar(100)not null,
	"email" varchar(255)not null unique,
	"password" varchar(25)not null,
	"address" text not null,
	"picture" text,
	"phone_number" varchar(20)not null unique,
	"role" users_role not null,
	"created_at" timestamp default now(),
	"updated_at" timestamp
);





--membuat table products :
create table "products"(
	"id" serial primary key,
	"name" varchar(50) not null,
	"description" text,
	"base_price" numeric(12, 2) default 10000,
	"image" text,
	"discount" numeric(12, 2),
	"is_recommended" boolean,
	"created_at" timestamp default now(),
	"updated_at" timestamp
);





--membuat tipe data enum untuk size product :
create type "size" as enum ('small', 'medium', 'large');


--membuat table product size :
create table "product_size"(
	"id" serial primary key,
	"size" size not null,
	"additional_price" numeric(12,2),
	"created_at" timestamp default now(),
	"updated_at" timestamp
);





--membuat table product variant :
create table "product_variant"(
	"id" serial primary key,
	"name" varchar(50) not null,
	"additional_price" numeric(12, 2),
	"created_at" timestamp default now(),
	"updated_at" timestamp
);





--membuat table tags :
create table "tags"(
	"id" serial primary key,
	"name" varchar(50) not null,
	"created_at" timestamp default now(),
	"updated_at" timestamp
);





--membuat table relasi many to many products dan tags :
create table "product_tags"(
	"id" serial primary key,
	"product_id" int references "products" ("id"),
	"tag_id" int references "tags" ("id"),
	"created_at" timestamp default now(),
	"updated_at" timestamp
);





--membuat table product ratings dengan relasi many to one dengan products dan users:
create table "product_ratings"(
	"id" serial primary key,
	"product_id" int references "products" ("id"),
	"rate" int not null,
	"review_message" text,
	"user_id" int references "users" ("id"),
	"created_at" timestamp default now(),
	"updated_at" timestamp
);




--membuat table categories :
create table "categories"(
	"id" serial primary key,
	"name" varchar(50) not null,
	"created_at" timestamp default now(),
	"updated_at" timestamp
);





--membuat table relasi many to many products dan  categories :
create table "product_categories"(
	"id" serial primary key,
	"product_id" int references "products" ("id"),
	"category_id" int references "categories" ("id"),
	"created_at" timestamp default now(),
	"updated_at" timestamp
);




--membuat table promo :
create table "promo"(
	"id" serial primary key,
	"name" varchar(50)not null,
	"code" varchar(25)not null,
	"description" text,
	"percentage" float not null,
	"is_expired" boolean,
	"maximum_promo" numeric(12, 2)not null,
	"minimun_amount" numeric (12, 2)not null,
	"created_at" timestamp default now(),
	"updated_at" timestamp
)





--membuat tipe data enum untuk status order:
create type status_order as enum ('on-progress', 'delivered', 'canceled', 'ready-to-pick')


--membuat table orders :
create table "orders"(
	"id" serial primary key,
	"user_id" int references "users" ("id") not null,
	"order_number" int not null,
	"promo_id" int references "promo" ("id"),
	"total" numeric(12, 2)not null,
	"tax_amount" numeric(12, 2)not null,
	"status" status_order not null,
	"delivery_address" text not null,
	"full_name" varchar(50),
	"email" varchar(100),
	"created_at" timestamp default now(),
	"updated_at" timestamp
)





--membuat table order detail :
create table "order_detail"(
	"id" serial primary key,
	"product_id" int references "products" ("id")not null,
	"product_size_id" int references "product_size" ("id")not null,
	"product_variant_id" int references "product_variant" ("id")not null,
	"quantity" int not null,
	"order_id" int references "orders" ("id")not null,
	"created_at" timestamp default now(),
	"updated_at" timestamp
)





--membuat table message :
create table "message" (
	"id" serial primary key,
	"recipient_id" int references "users" ("id") not null,
	"sender_id" int references "users" ("id") not null,
	"text" text not null,
	"created_at" timestamp default now(),
	"updated_at" timestamp
)





--memasukan data users :
insert into "users"("full_name", "email", "password", "address", "picture", "phone_number", "role") values
('John Doe', 'john.doe@example.com', 'password123', '123 Main St, Anytown', 'path/to/john.jpg', '123-456-7890', 'admin'),
('Jane Smith', 'jane.smith@example.com', 'p@$$w0rd', '456 Elm St, Othertown', 'path/to/jane.jpg', '987-654-3210', 'staff'),
('Alice Johnson', 'alice.johnson@example.com', 'securePass', '789 Oak St, Anotherplace', 'path/to/alice.jpg', '555-555-5555', 'staff'),
('Bob Brown', 'bob.brown@example.com', 'bobpass', '987 Willow St, Somecity', 'path/to/bob.jpg', '111-222-3333', 'staff'),
('Eva Wilson', 'eva.wilson@example.com', 'evapassword', '456 Pine St, Differentville', 'path/to/eva.jpg', '333-444-5555', 'staff'),
('Michael Lee', 'michael.lee@example.com', 'mike123', '654 Birch St, Elsewhere', 'path/to/michael.jpg', '222-888-9999', 'staff'),
('Sara Martinez', 'sara.martinez@example.com', 'saraPass', '321 Cedar St, Newtown', 'path/to/sara.jpg', '777-777-7777', 'customer'),
('David Davis', 'david.davis@example.com', 'daviddav', '987 Spruce St, Nextdoor', 'path/to/david.jpg', '666-999-8888', 'customer'),
('Olivia Taylor', 'olivia@example.com', 'olivia123', '123 Redwood St, Nearby', 'path/to/olivia.jpg', '123-123-0000', 'customer'),
('William Wilson', 'william.wilson@example.com', 'will123', '123 Cherry St, Nearby', 'path/to/william.jpg', '777-000-1111', 'customer'),
('Sophia Adams', 'sophia.adams@example.com', 'sophiaa', '123 Poplar St, Nearby', 'path/to/sophia.jpg', '555-111-7777', 'customer'),
('James Turner', 'james.turner@example.com', 'jamesturn', '123 Maple St, Nearby', 'path/to/james.jpg', '333-777-5555', 'customer'),
('Emma Miller', 'emma.miller@example.com', 'emmapass', '123 Aspen St, Nearby', 'path/to/emma.jpg', '888-555-9999', 'customer'),
('Liam Martin', 'liam.martin@example.com', 'liampass', '123 Elm St, Nearby', 'path/to/liam.jpg', '666-444-1111', 'customer'),
('Ava Clark', 'ava.clark@example.com', 'ava123', '123 Oak St, Nearby', 'path/to/ava.jpg', '111-999-7777', 'customer'),
('Benjamin Young', 'benjamin.young@example.com', 'benjamin123', '123 Birch St, Nearby', 'path/to/benjamin.jpg', '222-333-6666', 'customer'),
('Mia Harris', 'mia.harris@example.com', 'miaPass', '123 Cedar St, Nearby', 'path/to/mia.jpg', '777-666-5555', 'customer'),
('Lucas Hall', 'lucas.hall@example.com', 'lucas123', '123 Spruce St, Nearby', 'path/to/lucas.jpg', '555-222-1111', 'customer'),
('Charlotte Scott', 'charlotte.scott@example.com', 'charlottepass', '123 Pine St, Nearby', 'path/to/charlotte.jpg', '999-777-3333', 'customer'),
('Henry Adams', 'henry.adams@example.com', 'henry123', '123 Redwood St, Nearby', 'path/to/henry.jpg', '123-000-8888', 'customer'),
('Laura White', 'laura.white@example.com', 'laurapass', '567 Willow St, Othercity', 'path/to/laura.jpg', '555-333-2222', 'customer'),
('Andrew King', 'andrew.king@example.com', 'kingpass', '123 Cedar St, Anotherplace', 'path/to/andrew.jpg', '555-666-4444', 'customer'),
('Grace Baker', 'grace.baker@example.com', 'grace123', '789 Elm St, Differenttown', 'path/to/grace.jpg', '777-222-6666', 'customer'),
('Daniel Young', 'daniel.young@example.com', 'danielpass', '456 Birch St, Elsewhere', 'path/to/daniel.jpg', '333-111-8888', 'customer'),
('Lily Lewis', 'lily.lewis@example.com', 'lilypass', '654 Oak St, Differentcity', 'path/to/lily.jpg', '999-444-7777', 'customer'),
('Jackson Smith', 'jackson.smith@example.com', 'jackson123', '123 Pine St, Otherplace', 'path/to/jackson.jpg', '111-888-5555', 'customer'),
('Sophie Johnson', 'sophie.johnson@example.com', 'sophiepass', '987 Cedar St, Anothercity', 'path/to/sophie.jpg', '222-333-7777', 'customer'),
('Noah Davis', 'noah.davis@example.com', 'noah123', '321 Spruce St, Someplace', 'path/to/noah.jpg', '444-555-8888', 'customer'),
('Oliver Miller', 'oliver.miller@example.com', 'oliverpass', '456 Redwood St, Othertown', 'path/to/oliver.jpg', '555-555-9999', 'customer'),
('Charlotte Martin', 'charlotte.martin@example.com', 'charlotte123', '654 Elm St, Differentplace', 'path/to/charlotte.jpg', '777-999-1111', 'customer'),
('Amelia Hall', 'amelia.hall@example.com', 'ameliapass', '123 Oak St, Anothercity', 'path/to/amelia.jpg', '888-444-3333', 'customer'),
('Theodore Turner', 'theodore.turner@example.com', 'theodorepass', '321 Willow St, Elsewhere', 'path/to/theodore.jpg', '333-666-8888', 'customer'),
('Emma Clark', 'emma.clark@example.com', 'emma123', '654 Redwood St, Otherplace', 'path/to/emma.jpg', '777-111-2222', 'customer'),
('Aiden Scott', 'aiden.scott@example.com', 'aiden123', '456 Maple St, Somecity', 'path/to/aiden.jpg', '555-111-6666', 'customer'),
('Aria Green', 'aria.green@example.com', 'ariapass', '123 Cedar St, Othertown', 'path/to/aria.jpg', '111-777-4444', 'customer'),
('Ethan White', 'ethan.white@example.com', 'ethanpass', '789 Pine St, Differentville', 'path/to/ethan.jpg', '222-999-6666', 'customer'),
('Olivia Taylor', 'olivia.taylor@example.com', 'oliviapass', '123 Maple St, Differentcity', 'path/to/olivia.jpg', '555-777-3330', 'customer'),
('Jack Moore', 'jack.moore@example.com', 'jackpass', '987 Redwood St, Othercity', 'path/to/jack.jpg', '111-444-8888', 'customer'),
('Avery Hill', 'avery.hill@example.com', 'avery123', '321 Spruce St, Anotherplace', 'path/to/avery.jpg', '999-111-5555', 'customer'),
('Mia Adams', 'mia.adams@example.com', 'miapass', '654 Oak St, Elsewhere', 'path/to/mia.jpg', '777-444-3333', 'customer'),
('William Lee', 'william.lee@example.com', 'williampass', '123 Cedar St, Differentcity', 'path/to/william.jpg', '555-222-6666', 'customer'),
('Liam Johnson', 'liam.johnson@example.com', 'liampass', '789 Maple St, Differentplace', 'path/to/liam.jpg', '555-111-2222', 'customer'),
('Sophia Brown', 'sophia.brown@example.com', 'sophiapass', '123 Redwood St, Othercity', 'path/to/sophia.jpg', '222-666-8888', 'customer'),
('Henry Martin', 'henry.martin@example.com', 'henrypass', '654 Birch St, Othertown', 'path/to/henry.jpg', '999-888-1111', 'customer'),
('Emily Green', 'emily.green@example.com', 'emilypass', '321 Cedar St, Otherplace', 'path/to/emily.jpg', '111-555-6666', 'customer'),
('James Clark', 'james.clark@example.com', 'jamespass', '987 Spruce St, Anothercity', 'path/to/james.jpg', '555-777-3333', 'customer'),
('Ava Lewis', 'ava.lewis@example.com', 'avapass', '456 Elm St, Differentcity', 'path/to/ava.jpg', '777-444-9999', 'customer'),
('Oliver Young', 'oliver.young@example.com', 'oliverpass', '123 Poplar St, Differentville', 'path/to/oliver.jpg', '666-111-2222', 'customer'),
('Emma Turner', 'emma.turner@example.com', 'emmapass', '789 Willow St, Elsewhere', 'path/to/emma.jpg', '444-999-5555', 'customer'),
('William Moore', 'william.moore@example.com', 'williampass', '654 Oak St, Othertown', 'path/to/william.jpg', '999-222-8888', 'customer');





select * from "users";

select * from "products";

select * from "product_size";

select * from "product_variant";

select * from "tags";

select * from "product_tags";

select * from "product_ratings";

select * from "categories"

select * from "product_categories"

select * from "promo"

select * from "orders"

select * from "order_detail"

select * from "message"
