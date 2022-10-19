--3. Страница «Сотрудники» (employees_page)
-- Выбрать записи работников (включить колонки имени, фамилии, телефона, региона) в которых регион неизвестен
SELECT first_name, last_name, home_phone, region
FROM employees
WHERE region IS NULL;
-- Выбрать такие страны в которых "зарегистированы" одновременно заказчики и поставщики, но при этом в них не "зарегистрированы" работники
SELECT DISTINCT cus.country
FROM orders
LEFT JOIN order_details AS od ON od.order_id = orders.order_id
LEFT JOIN products AS pr ON pr.product_id = od.product_id
LEFT JOIN suppliers AS sup ON sup.id = pr.id_suppliers
LEFT JOIN customers AS cus ON cus.customer_id = orders.customer_id
LEFT JOIN employees AS emp ON emp.employee_id = orders.employee_id
WHERE cus.country = sup.country AND cus.country <> emp.country;