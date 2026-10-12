with customers AS (
    SELECT
        id as customer_id,
        first_name,
        last-name
    FROM `dbt-demo`.jaffle_shop.customers
),

order as (
    SELECT
        id as order_id,
        user_id as customer_id,
        order_date,
        status
    FROM `dbt-demo`.jaffle_shop.customers
),

customer_orders as (
    SELECT  
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most-recent_order_date,
        count(order_id) as number_of_orders
    FROM orders
    group by 1

final as (
    SELECT
        customers.customers_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_orderr_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as num_of_orders
    FROM customers
    left join customer_orders using (customer_id)
)