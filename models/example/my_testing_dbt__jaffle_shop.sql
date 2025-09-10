with
    customers as (
        select id as customer_id, name as customer_name from jaffle_shop.customers
    ),
    orders as (
        select
            id as order_id,
            customer as customer_id,
            ordered_at,
            store_id,
            subtotal,
            tax_paid,
            order_total
        from jaffle_shop.orders
    ),
    items as (select id, order_id, sku from jaffle_shop.items),
    products as (select * from jaffle_shop.products),
    stores as (select * from jaffle_shop.stores),
    supplies as (select * from jaffle_shop.supplies)

select
    a.customer_id,
    a.customer_name,
    sum(order_total) total_order,
    count(sku) as total_sku,
    count(distinct sku) as total_distinct_sku
from customers a
left join orders b on a.customer_id = b.customer_id
left join items c on b.order_id = c.order_id
group by 1, 2
having total_order > 0
order by total_order desc
