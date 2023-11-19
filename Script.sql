--membuat tipe data enum untuk role users :
create type users_role as enum ('admin', 'staff', 'customer');

drop database coffee_shop_basic_implementation

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





--memasukan data products :
insert into "products"("name", "description", "base_price", "image", "discount", "is_recommended") values 
('Espresso', 'Strong and concentrated coffee shot', 25000, 'espresso.jpg', 2000, true),
('Latte', 'A smooth and creamy coffee with steamed milk', 35000, 'latte.jpg', 3000, true),
('Cappuccino', 'Equal parts espresso, steamed milk, and frothed milk', 30000, 'cappuccino.jpg', 3000, true),
('Mocha', 'Espresso with chocolate and steamed milk', 40000, 'mocha.jpg', 5000, true),
('Cold Brew', 'Cold steeped coffee for a refreshing experience', 30000, 'cold_brew.jpg', 2000, true),
('Chai Latte', 'Spiced tea with steamed milk', 30000, 'chai_latte.jpg', 3000, null),
('Hot Chocolate', 'Rich and creamy chocolate drink', 35000, 'hot_chocolate.jpg', 3000, null),
('Iced Tea', 'Cool and refreshing iced tea', 25000, 'iced_tea.jpg', 2000, null),
('Fruit Smoothie', 'Blend of fresh fruits for a healthy treat', 45000, 'fruit_smoothie.jpg', 6000, null),
('Lemonade', 'Classic lemonade with a twist', 20000, 'lemonade.jpg', 2000, null),
('Croissant', 'Buttery and flaky pastry', 15000, 'croissant.jpg', 1000, null),
('Avocado Toast', 'Sliced avocado on toasted bread', 25000, 'avocado_toast.jpg', 2000, null),
('Bagel with Cream Cheese', 'Classic bagel with creamy cheese spread', 18000, 'bagel_cream_cheese.jpg', 3000, null),
('Vegetarian Wrap', 'Fresh veggies wrapped in a tortilla', 30000, 'vegetarian_wrap.jpg', 2000, null),
('Chicken Panini', 'Grilled chicken sandwich with melted cheese', 35000, 'chicken_panini.jpg', 3000, null),
('Extra Shot of Espresso', 'Add an extra kick to your coffee', 5000, 'extra_espresso.jpg', null, null),
('Vanilla Syrup', 'Sweet vanilla flavor for your drink', 3000, 'vanilla_syrup.jpg', null, true),
('Whipped Cream', 'Creamy topping for your favorite beverage', 2000, 'whipped_cream.jpg', null, true),
('Almond Milk', 'Dairy-free alternative for a nutty taste', 4000, 'almond_milk.jpg', null, null),
('Caramel Drizzle', 'Sweet caramel swirl for a delightful treat', 2500, 'caramel_drizzle.jpg', null, null);






--memasukan data product_size :
insert into "product_size"("size", "additional_price") values 
('small', null),
('medium', 3000),
('large', 5000)





--memasukan data product_variant :
insert into "product_variant"("name", "additional_price") values 
('cold', null),
('hot', null),
('spicy', 4000),
('savory', 3000),
('extra_sweet', 2000),
('unsweetened', null)





--memasukan data tags :
insert into "tags"("name") values 
('flashsale')





--update table product_tags, menambahkan not null ke column product_id dan tag_id:
alter table "product_tags" alter column "product_id" set not null;
alter table "product_tags" alter column "tag_id" set not null;


--memasukan data ke table relasi many to many "product_tag" :
insert into "product_tags"("tag_id", "product_id") values 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5)





--update table product_tags, menambahkan not null ke column product_id dan user_id:
alter table "product_ratings" alter column "product_id" set not null;
alter table "product_ratings" alter column "user_id" set not null;



--memasukan data "product_ratings" :
insert into "product_ratings"("product_id", "rate", "review_message", "user_id") values
(6, 5, 'Delicious chai latte. So comforting!', 7),
(7, 4, 'Hot chocolate was rich and satisfying.', 12),
(8, 5, 'Refreshing iced tea. Just what I needed.', 34),
(9, 4, 'Fruit smoothie was a tasty treat.', 14),
(10, 5, 'Lemonade had the perfect tanginess.', 48),
(11, 5, 'Croissant was flaky and delicious.', 19),
(12, 4, 'Avocado toast was a healthy choice.', 27),
(13, 5, 'Bagel with cream cheese was perfect.', 5),
(14, 4, 'Vegetarian wrap was fresh and filling.', 43),
(15, 5, 'Chicken panini had a great combination of flavors.', 21),
(16, 5, 'Extra shot of espresso gave a nice kick!', 6),
(17, 4, 'Vanilla syrup added a sweet touch.', 29),
(18, 5, 'Whipped cream made the drink extra indulgent.', 15),
(19, 4, 'Almond milk was a tasty alternative.', 37),
(20, 5, 'Caramel drizzle was the perfect finishing touch.', 9),
(1, 5, 'Loved the coffee! Great service too.', 21),
(5, 4, 'Good coffee, nice atmosphere.', 42),
(9, 5, 'The fruit smoothie was refreshing and healthy.', 36),
(13, 4, 'Bagel with cream cheese was a quick and tasty breakfast.', 17),
(17, 5, 'Vanilla syrup made my drink extra special.', 50),
(2, 4, 'Nice espresso, will be back for more.', 31),
(6, 5, 'Chai latte was a perfect pick-me-up.', 2),
(10, 4, 'Iced tea was a great choice for a hot day.', 47),
(14, 5, 'Vegetarian wrap was delicious and satisfying.', 13),
(18, 4, 'Whipped cream on my drink was a delightful surprise.', 24),
(3, 5, 'Perfectly brewed coffee, just the way I like it.', 46),
(7, 4, 'Hot chocolate warmed me up on a cold day.', 38),
(11, 5, 'Croissant was flaky and buttery. Yum!', 23),
(15, 4, 'Chicken panini had a nice combination of flavors.', 4),
(19, 5, 'Almond milk is a great alternative for my coffee.', 16),
(4, 4, 'Nice balance of flavors in the mocha.', 30),
(8, 5, 'Iced tea was refreshing, just what I needed.', 11),
(12, 4, 'Avocado toast was a healthy and tasty choice.', 44),
(16, 5, 'Extra shot of espresso gave my coffee a boost!', 35),
(20, 4, 'Caramel drizzle added a sweet touch to my drink.', 26),
(1, 5, 'Great coffee! Really enjoyed the flavor.', 3),
(2, 4, 'Good quality, nice aroma.', 10),
(3, 5, 'Perfectly brewed. Loved it!', 25),
(4, 4, 'Nice balance of flavors.', 18),
(5, 5, 'Amazing coffee, will come back for more.', 8);





--memasukan data categories :
insert into "categories"("name") values 
('favorite_product'),
('coffee'),
('non_coffee'),
('foods'),
('add_on')





--memasukan data ke table relasi many to many product category :
insert into "product_categories"("category_id", "product_id") values 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 7),
(1, 8),
(1, 17),
(1, 18),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(3, 6),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(4, 11),
(4, 12),
(4, 13),
(4, 14),
(4, 15),
(5, 16),
(5, 17),
(5, 18),
(5, 19),
(5, 20)





--update table products, mengubah column is_recommended menjadi false jika bukan rekomendasi :
update "products" set "is_recommended" = false where id between 6 and 16 or id = 19;




--update table promo, ganti nama column :
alter table "promo" rename column "minimun_amount" to "minimum_amount";


--memasukan data promo :
insert into "promo"("name", "code", "description", "percentage", "is_expired", "maximum_promo", "minimum_amount") values 
('Super Deal', 'SD123', 'Special discount for coffee lovers', 0.2, false, 50000, 100000),
('Morning Bliss', 'MB456', 'Start your day with a 15% off', 0.15, false, 70000, 120000),
('Coffee Craze', 'CC789', 'Exclusive promo for coffee enthusiasts', 0.1, false, 80000, 150000),
('Weekend Brew', 'WB101', 'Weekend special: 25% discount on coffee', 0.25, false, 60000, 90000),
('Caffeine Boost', 'CB202', 'Get a boost with 18% off on your order', 0.18, false, 55000, 95000),
('Java Delight', 'JD303', 'Delightful promo for Java coffee fans', 0.12, false, 75000, 130000),
('Espresso Extravaganza', 'EE404', 'Experience an espresso extravaganza with 30% off', 0.3, false, 70000, 110000),
('Latte Love', 'LL505', 'Show your love for lattes with a 22% discount', 0.22, false, 65000, 100000),
('Double Shot', 'DS606', 'Double the joy with a 20% discount on your double shot', 0.2, false, 60000, 80000),
('Mocha Madness', 'MM707', 'Indulge in mocha madness with 28% off', 0.28, false, 55000, 120000);




--update table orders, mengubah tipe data column order_number dari int menjadi varchar dan menghapus :
alter table "orders" alter column "order_number" type varchar(25)





--update table order_detail, ubah nama table:
alter table "order_detail" rename to "order_details"


--"chicken-and-egg problem" atau "masalah ayam dan telur" antara column total di table order dan column order_id di order_details :
-- dimana perlu membuat entitas tertentu sebelum entitas lainnya, tetapi entitas pertama memerlukan informasi dari entitas kedua, dan sebaliknya

--update table orders, menghapus not null di total dan di delivery address, set default column tax_amount dan status, menambah unique column order_number:
alter table "orders" alter column "total" drop not null;
alter table "orders" alter column "delivery_address" drop not null;
alter table "orders" alter column "tax_amount" set default 1000;
alter table "orders" alter column "status" set default 'on-progress';
alter table "orders" add constraint unique_order_number unique ("order_number")





--update table product_size, set nilai 0 untuk additional_price null :
update "product_size" set "additional_price" = 0 where id = 1;





--update table product_varian, set nilai 0 untuk additional_price null :
update "product_variant" set "additional_price" = 0 where id in (1, 2, 6);





--update table products, set nilai 0 untuk discount null :
update "products" set "discount" = 0 where id between 16 and 20;






--orders berisi 5 baris data tapi di proses satu satu dengan transaction:

--start transaction 
--
--memasukan data orders :
--insert into "orders"("user_id", "order_number") values 
--(30, '#80459-80459');
--
--
--
--
--
--memasukan delivery_address = bisa dimasukan custom atau sesuai dengan address dari user :
--	jika custom address :
--	update "orders" set "delivery_address" = '123 Elm St, Nearby' where id = 1
--	
--	jika menggunakan address user :
--	update "orders" set "delivery_address" = (
--		select "u"."address"
--		from "orders" "o"
--		join "users" "u" on ("u"."id" = "o"."user_id")
--		where "o"."id" = 8
--	)
--	where id = 8
--	
--
--
--
--
--memasukan full_name = bisa dimasukan custom atau sesuai dengan full_name dari user :
--	jika custom address :
--	update "orders" set "full_name" = 'lily lewis' where id = 1
--	
--	jika menggunakan full_name user :
--	update "orders" set "full_name" = (
--		select "u"."full_name"
--		from "orders" "o"
--		join "users" "u" on ("u"."id" = "o"."user_id")
--		where "o"."id" = 8
--	)
--	where id = 8
--		
--
--
--
--
--memasukan email = bisa dimasukan custom atau sesuai dengan email dari user :
--	jika custom email :
--	update "orders" set "email" = 'email@example.com' where id = 1
--	
--	jika menggunakan email user :
--	update "orders" set "email" = (
--		select "u"."email"
--		from "orders" "o"
--		join "users" "u" on ("u"."id" = "o"."user_id")
--		where "o"."id" = 8
--	)
--	where id = 8
--
--
--
--
--
--memasukan data order_details :
--insert into "order_details"("product_id", "product_size_id", "product_variant_id", "quantity", "order_id") values
--(2, 3, 2, 2, 8)
--
--
--
--hitung total orders :
--update "orders" set "total" = (
--	select 	(("p"."base_price" - "p"."discount") * "od"."quantity") + "ps"."additional_price" + "pv"."additional_price" + "o"."tax_amount"
--			from "order_details" 	"od"
--			join "products" 		"p" 	on ("p"."id"  = "od"."product_id")
--			join "product_size" 	"ps" 	on ("ps"."id" = "od"."product_size_id")
--			join "product_variant"	"pv"	on ("pv"."id" = "od". "product_variant_id")
--			join "orders"			"o"		on ("o". "id" = "od". "order_id")
--	where "od"."order_id" = 8
--)
--where id = 8;
--			
--
--
--
--
--jika apakai pakai promo :
--update "orders" set "promo_id" = 7
--where id = 7;
--
--
--
--
--
--
--hitung total di kurangi potongan harga, jika pakai promo:
--update "orders" set "total" = (
--	select "o"."total" - ("o"."total" * "p"."percentage")
--	from "orders" "o"
--	join "promo"  "p" on ("p"."id" = "o"."promo_id")
--	where "o"."id" = 8
--)
--where id = 8
--
--
--commit





--memasukan data "mesage" :
insert into "message"("recipient_id", "sender_id", "text") values 
(2, 7, 'Hello, I would like to order a coffee.'),
(3, 10, 'What is the special coffee of the day?'),
(4, 15, 'I enjoy black coffee, do you have anything new?'),
(5, 22, 'Is there a special promotion for loyal customers?'),
(6, 30, 'I would like to make a reservation for two at 6:00 PM.'),
(2, 12, 'Thank you for the friendly service yesterday.'),
(3, 18, 'Is there a special menu for vegetarians?'),
(4, 25, 'How can I become a loyalty member?'),
(5, 32, 'What is the price for an espresso?'),
(6, 40, 'Can I order a chocolate cake to take away?'),
(2, 14, 'When do you open and close on Sundays?'),
(3, 20, 'I want to give positive feedback for the excellent service.'),
(4, 28, 'Is there a discount for large orders?'),
(5, 35, 'Can I order a hot coffee without sugar?'),
(6, 44, 'Thank you so much! I really love your coffee.');





--inner join = menampilkan data promo dan orders yang berelasi:
select "p"."name" as promo, "o"."id" as "order_id"
from "orders" "o"
join "promo" "p" on ("p"."id" = "o"."promo_id")


--left join = menampilkan semua data orders walaupun tidak berelasi dengan promo :
select "p"."name" as promo, "o"."id" as "order_id"
from "orders" "o"
left join "promo" "p" on ("p"."id" = "o"."promo_id")


--left join = menampilkan semua data promo walaupun tidak berelasi dengan orders :
select "p"."name" as promo, "o"."id" as "order_id"
from "orders" "o"
right join "promo" "p" on ("p"."id" = "o"."promo_id")


--full outer join = menampilkan semua data dari table promo dan orders yang berelasi maupun yang tidak berelasi :
select "p"."name" as promo, "o"."id" as "order_id"
from "orders" "o"
full outer join "promo" "p" on ("p"."id" = "o"."promo_id")





--aggregate function = menampilkan banyak produk, harga tertinggi, harga terendah dan rata-rata dari tiap category produk:
select "c"."name" as "category",
		count("p"."id") as "total products",
		min("p"."base_price") as "lowest price",
		max("p"."base_price") as "highest price",
		round(avg("p"."base_price"), 0) as "average price"
		from "categories" "c"
		join "product_categories" "pc" on ("pc"."category_id" = "c"."id")
		join "products" "p" on ("p"."id" = "pc"."product_id")
		group by "c"."name"
		
		
		
		
		
--revisi-3 :

--menambah column "price_cut" di table "orders" :
alter table "orders" add column "price_cut" numeric (12, 2);






--tambah column "subtotal" di table "order_details" :
alter table "order_details" add column "subtotal" numeric(12, 2);





--tambah column "final_total" di table "orders" :
alter table "orders" add column "final_total" numeric(12, 2);





--tugas :
--customer 1 =  1 order 1 barang
--customer 2 =  3 order 1 barang tiap order
--customer 3 =  5 order 5 barang tiap order
		



--satu order satu transaction :

start transaction

--memasukan data orders :
insert into "orders"("user_id", "order_number", "promo_id", "delivery_address", "full_name", "email") values 
--(35, '#91590-31590', 9, (select "address" from "users" where "id" = 19), (select "full_name" from "users" where "id" = 19), (select "email" from "users" where "id" = 19))
--(26, '#75801-75801', 10, (select "address" from "users" where "id" = 26), (select "full_name" from "users" where "id" = 26), (select "email" from "users" where "id" = 26)),
--(26, '#65801-65801', 1, (select "address" from "users" where "id" = 26), (select "full_name" from "users" where "id" = 26), (select "email" from "users" where "id" = 26)),
--(26, '#55801-45801', 4, (select "address" from "users" where "id" = 26), (select "full_name" from "users" where "id" = 26), (select "email" from "users" where "id" = 26))
--(36, '#92642-92642', 2, (select "address" from "users" where "id" = 36), (select "full_name" from "users" where "id" = 36), (select "email" from "users" where "id" = 36))
--(36, '#82642-82642', 3, (select "address" from "users" where "id" = 36), (select "full_name" from "users" where "id" = 36), (select "email" from "users" where "id" = 36))
--(36, '#72642-72642', 6, (select "address" from "users" where "id" = 36), (select "full_name" from "users" where "id" = 36), (select "email" from "users" where "id" = 36))
--(36, '#62642-62642', 7, (select "address" from "users" where "id" = 36), (select "full_name" from "users" where "id" = 36), (select "email" from "users" where "id" = 36))
(36, '#52642-52642', 8, (select "address" from "users" where "id" = 36), (select "full_name" from "users" where "id" = 36), (select "email" from "users" where "id" = 36))





--memasukan data order_details :
insert into "order_details"( "order_id", "product_id", "product_variant_id", "product_size_id", "quantity") values
--(13, 7, 5, 3, 2)
--(19, 6, 5, 3, 2),
--(20, 7, 5, 3, 2),
--(21, 8, 5, 3, 2)
--(23, 1, 5, 3, 2),
--(23, 2, 5, 3, 2),
--(23, 3, 5, 3, 2),
--(23, 4, 5, 3, 2),
--(23, 5, 5, 3, 2)
--(24, 11, 4, 2, 2),
--(24, 12, 4, 2, 2),
--(24, 13, 4, 2, 2),
--(24, 14, 4, 2, 2),
--(24, 15, 4, 2, 2)
--(25, 6, 5, 2, 2),
--(25, 7, 5, 2, 2),
--(25, 8, 5, 2, 2),
--(25, 9, 5, 2, 2),
--(25, 10, 5, 2, 2)
--(26, 1, 1, 2, 2),
--(26, 16, 1, 2, 2),
--(26, 2, 1, 2, 2),
--(26, 18, 1, 2, 2),
--(26, 17, 1, 2, 2)
(28, 1, 5, 3, 2),
(28, 6, 5, 3, 2),
(28, 2, 5, 3, 2),
(28, 8, 5, 3, 2),
(28, 5, 5, 3, 2)




--menghitung data subtotal :
update "order_details" set "subtotal" = (
	select (("p"."base_price" - "p"."discount") * "od"."quantity") + "ps"."additional_price" + "pv"."additional_price"
	from "order_details" "od"
	join "products" "p" on ("p"."id" = "od"."product_id")
	join "product_size" "ps" on ("ps"."id" = "od"."product_size_id")
	join "product_variant" "pv" on ("pv"."id" = "od"."product_variant_id")
	where "od"."id" = 50
)
where "id" = 50




--menghitung total :
update "orders" set "total" = (select sum("subtotal") from "order_details" where "order_id" = 28) + (select "tax_amount" from "orders" where "id" = 28)
where "id" = 28





--menghitung price_cut, jika pakai pakai promo:
update "orders" set "price_cut" = (
	select "o"."total" * "pro"."percentage"
	from "orders" "o"
	join "promo" "pro" on ("pro"."id" = "o"."promo_id")
	where "o"."id" = 28
)
where "id" = 28




--menghitung final_total :
update "orders" set "final_total" = (select "total" from "orders" where "id" = 28) - (select "price_cut" from "orders" where "id" = 28)
where "id" = 28


rollback

commit





--aggregation function :
select "u"."id" as "user_id", 
		count("o"."id") as "total order"
		from "orders" "o"
		join "users" "u" on ("u"."id" = "o"."user_id")
		group by "u"."id"
		having "u"."id" in (35, 26, 36)





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

select * from "orders" order by "id"

select * from "order_details" order by "id"

select * from "message"





--revisi-4 :

--create table :
create table "example"(
	"id" serial primary key,
	"created_at" timestamp default now(),
	"updated_at" timestamp
);




--alter table :
alter table "example" rename to "example_table";





--drop table :
drop table "example_table";





--insert :
insert into "products"("name", "base_price", "image", "discount", "is_recommended") values 
('black coffee', 15000, 'black_coffee.jpg', 2000, true),
('white coffee', 15000, 'white_coffee.jpg', 1000, true);

insert into "categories"("name") values ('others')





--alter table :
alter table "products" add column "availibility" varchar(50);

alter table "products" rename column "availibility" to "availibility_product";

alter table "products" drop column "availibility_product";





--update record :
update "products" set "availibility_product" = 'made to order' where "id" = 23;





--query :
select * from "products" where "name" = 'Espresso';

select * from "products" where "name" like 'Espresso';

select * from "products" where "name" ilike 'espresso';

select
	"p"."name" as "product",
	"p"."base_price",
	"c"."name" as "category"
from "products" "p"
join "product_categories" "pc" on ("pc"."product_id" = "p"."id")
join "categories" "c" on ("c"."id" = "pc"."category_id")
where "p"."base_price" < 40000 and "c"."name" = 'coffee';

select "name", "description", "base_price" from "products"
where "name" ilike '%black%';

select "name", "description", "base_price" from "products"
where "name" ilike 'c%';

select "name", "description", "base_price" from "products"
where "name" ilike '%o';

select "name", "description", "base_price" from "products"
where "name" ilike '__t%';

select "name", "description", "base_price" from "products"
where "description" is null;

select "name", "description", "base_price" from "products"
where "description" is not null;

select "name", "description", "base_price" from "products"
where "base_price" between 1000 and 5000;

select
	"p"."name" as "product",
	"p"."base_price",
	"c"."name" as "category"
from "products" "p"
join "product_categories" "pc" on ("pc"."product_id" = "p"."id")
join "categories" "c" on ("c"."id" = "pc"."category_id")
where "c"."name" in ('coffee', 'add_on');

select
	"p"."name" as "product",
	"p"."base_price",
	"c"."name" as "category"
from "products" "p"
join "product_categories" "pc" on ("pc"."product_id" = "p"."id")
join "categories" "c" on ("c"."id" = "pc"."category_id")
where "c"."name" not in ('coffee', 'favorite_product');

select "name", "description", "base_price" from "products"
where "base_price" <= 50000 order by "base_price" asc limit 5 offset 0;

select "name", "description", "base_price" from "products"
where "base_price" <= 50000 order by "base_price" desc limit 5 offset 5;


select distinct "c"."name" as "category"
from "products" "p"
join "product_categories" "pc" on ("pc"."product_id" = "p"."id")
join "categories" "c" on ("c"."id" = "pc"."category_id");

select "name", "base_price"/1000 as "price_in_k" from "products";

select lower("name"), length("name"), upper("description") from "products";

select id, extract(year from created_at) as "year", extract(month from created_at) as "month" from "products" limit 5;

select "name",
	case
		when "description" is null then 'tidak ada deskripsi'
		else "description"
	end as "description_product"
from "products";

select "name", "base_price",
	case
		when "base_price" <= 20000 then 'Cheap'
		when "base_price" <= 30000 then 'Standar'
		else 'Expensive'
	end as "price_category"
from "products";

select "c"."name" as "category", count("p"."id"), max("p"."base_price"), min("p"."base_price")
from "products" "p"
join "product_categories" "pc" on ("pc"."product_id" = "p"."id")
join "categories" "c" on ("c"."id" = "pc"."category_id")
group by "c"."name";

--union = jika data full_name ada di kedua table maka hanya akan di tampilkan satu kali
select "full_name" from "users" union select "full_name" from "orders";
--union all = jika data full_name ada di kedua table maka akan di tampilkan dua kali atau sebanyak yang ada
select "full_name" from "users" union all select "full_name" from "orders";
--intersect = hanya menampilkan data yang ada di kedua table
select "full_name" from "users" intersect select "full_name" from "orders";
--except = tidak menampilkan data yang berada di kedua table atau tidak menampilkan hasil intersect
select "full_name" from "users" except select "full_name" from "orders";





--delete record :
delete from "products" where "id" = 23;





--inner join = hanya menampilkan data yang berelasi :
select "p"."name", "c"."name" as "category"
from "products" "p"
join "product_categories" "pc" on ("pc"."product_id" = "p"."id")
join "categories" "c" on ("c"."id" = "pc"."category_id")

--left join = menampilkan semua data dari table kiri walaupun tidak berelasi :
select "p"."name", "c"."name" as "category"
from "products" "p"
left join "product_categories" "pc" on ("pc"."product_id" = "p"."id")
left join "categories" "c" on ("c"."id" = "pc"."category_id")

--right join = menampilkan semua data dari table kanan walaupun tidak berelasi :
select "p"."name", "c"."name" as "category"
from "products" "p"
right join "product_categories" "pc" on ("pc"."product_id" = "p"."id")
right join "categories" "c" on ("c"."id" = "pc"."category_id")

--full outer join = menampilkan semua data dari kedua table yang berelasi maupun yang tidak berelasi :
select "p"."name", "c"."name" as "category"
from "products" "p"
full outer join "product_categories" "pc" on ("pc"."product_id" = "p"."id")
full outer join "categories" "c" on ("c"."id" = "pc"."category_id")



--revisi - 5
alter table "products" add constraint "unique_name" unique("name")

alter table "products" alter column "base_price" set not null

alter table "product_variant" add constraint "unique_product_variant" unique("name")

alter table "tags" add constraint "unique_product_tag" unique("name")

alter table "categories" add constraint "unique_categories" unique("name")

alter table "promo" add constraint "unique_name_promo" unique("name")

alter table "promo" add constraint "unique_code_promo" unique("code")

alter table "orders" alter column "delivery_address" set not null

alter table "product_categories" alter column "product_id" set not null

alter table "product_categories" alter column "category_id" set not null

alter table "product_size" add constraint "unique_size_name" unique("size")

alter table "product_size" alter column "additional_price" set default 0

alter table "product_variant" alter column "additional_price" set default 0

alter table "product_variant" add constraint "unique_variant_name" unique("name")

alter table "product_variant" rename to "variant"

alter table "promo" alter column "is_expired" set default false

alter table "products" alter column "discount" set default 0