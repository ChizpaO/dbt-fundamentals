WITH customers as (
    SELECT *
    FROM {{ref('stg_customers')}}
),

orders AS (
    SELECT *
    FROM {{ref('fct_orders')}}
),


customer_orders as (
      SELECT
          customer_id,
          min(order_date) as first_order_date,
          max(order_date) as most_recent_order_date,
          count(order_id) as number_of_orders,
          sum(amount) as lifetime_value
      FROM orders
      GROUP BY 1

),

final AS (

      SELECT
          customers.customer_id,
          customers.first_name,
          customers.last_name,
          customer_orders.first_order_date,
          customer_orders.most_recent_order_date,
          Coalesce(customer_orders.number_of_orders, 0) AS number_of_orders,
          customer_orders.lifetime_value
      FROM customers
      LEFT JOIN customer_orders USING (customer_id)    
)

SELECT *
FROM final