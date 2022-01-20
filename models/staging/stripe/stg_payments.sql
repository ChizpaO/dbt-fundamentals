SELECT  id AS payment_id,
        orderid AS order_id,
        paymentmethod AS payment_method,
        status,
        --amount is in cents, convert it to dollars
        amount/100 AS amount,
        created
            
FROM {{source('stripe','payment')}}