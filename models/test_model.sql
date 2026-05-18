select * from {{ ref('customers') }}
where last_name like 'A%'