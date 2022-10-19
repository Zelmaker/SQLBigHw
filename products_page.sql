--4. Страница «Товары» (products_page)
-- Найти активные (см. поле discontinued) продукты из категории Beverages и Seafood, которых в продаже менее 20 единиц. Вывести наименование продуктов, кол-во единиц в продаже, имя контакта поставщика и его телефонный номер.
SELECT product_name, units_in_stock, s.contact_name, s.phone
FROM products
LEFT JOIN suppliers s ON s.id = products.id_suppliers
LEFT JOIN categories ON categories.category_id = products.category_id
WHERE category_name IN ('Beverages', 'Seafood') AND units_in_stock > 20;