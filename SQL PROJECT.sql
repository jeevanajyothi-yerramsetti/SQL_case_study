create database project;
show databases;
use project;
show tables;
#______________1kpi___________________________________________________#
SELECT
  CASE 
    WHEN DAYOFWEEK(o.order_purchase_timestamp) IN (1, 7) THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type,
  round(sum(p.payment_value),2) AS total_payment
FROM
  orders as o
JOIN
  payments as p ON o.order_id = p.order_id
GROUP BY day_type;
#_________________________4kpi_______________________#
select round(avg(a.price))average_price,round(avg(b.payment_value))average_payment,d.customer_city
from order_items as a 
join payments as b
on a.order_id=b.order_id
join orders as c on a.order_id=c.order_id
join customers as d on c.customer_id=d.customer_id
group by d.customer_city having customer_city="sao paulo";
#__________________________2kpi_________________________#
#credit card and review score 5
select count(a.order_id)No_of_orders
from orders as a join reviews as b 
on a.order_id=b.order_id
join payments as c
on a.order_id=c.order_id
where payment_type="credit_card"
and review_score=5;

#______________________5KPI___________________________#
select *,datediff(order_delivered_customer_date,order_purchase_timestamp)avgdays from orders;
select a.review_score,round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)))shippingdays 
from reviews as a join orders as b
on a.order_id=b.order_id
group by review_score
order by review_score asc;
#____________________3kpi_____________________________# a.product_category_name,,b.product_id
select round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)))shipdays
from products as a join order_items as b
on a.product_id=b.product_id
join orders as c 
on b.order_id=c.order_id
group by product_category_name
having product_category_name="pet_shop";