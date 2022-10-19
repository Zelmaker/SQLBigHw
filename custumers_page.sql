--1. Страница «Заказчики» (customers_page)

--Посчитать количество заказчиков
SELECT COUNT(customer_id) FROM customers;

--Выбрать все уникальные сочетания городов и стран, в которых "зарегестрированы" заказчики
SELECT country, city FROM customers
GROUP BY country, city;

--Найти заказчиков и обслуживающих их заказы сотрудников, таких, что и заказчики и сотрудники из города London, а доставка идёт компанией Speedy Express. Вывести компанию заказчика и ФИО сотрудника.
SELECT cus.company_name, emp.last_name, emp.first_name
FROM orders
LEFT JOIN customers as cus ON cus.customer_id = orders.customer_id
LEFT JOIN employees as emp ON emp.employee_id = orders.employee_id
LEFT JOIN shippers ON shippers.shipper_id = orders.ship_via
WHERE cus.city = 'London' AND emp.city = 'London' AND shippers.company_name = 'Speedy Express';

--Найти заказчиков, не сделавших ни одного заказа. Вывести имя заказчика и order_id.--Количество заказчиков
SELECT company_name, orders.order_id
FROM customers
LEFT JOIN orders ON orders.customer_id = customers.customer_id
WHERE orders.order_id IS NULL;