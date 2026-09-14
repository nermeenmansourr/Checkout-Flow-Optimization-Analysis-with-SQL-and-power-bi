Select
 user_id,
 action_date,
 action_name,
 error_message,
 device
from checkout_actions
 where 
 action_date between '2022-07-01' and '2023-01-31' and action_name like'%checkout%'
group by user_id
order by action_date 
