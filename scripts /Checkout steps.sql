with total_carts_created as
(select
*
from
checkout_carts),
total_checkout_attempts as
(select
tc.user_id,
a.action_name,
a.action_date
from checkout_carts as tc
left join 
checkout_actions as a on a.user_id = tc.user_id
where a.action_name like '%completepayment.click%'
and 
a.action_date between '2022-07-01' and '2023-01-31'
group by tc.user_id),
total_successful_attempts as
(select
a.user_id,
a.action_name,
a.action_date
from total_checkout_attempts as a
where
a.action_name like '%succes%'
group by a.user_id),
count_total_carts as
(select
action_date,
count(*) as count_total_carts
from
total_carts_created
group by action_date),
count_total_checkout_attempts as
(select
action_date,
count(*) as count_total_checkout_attempts
from 
total_checkout_attempts
group by action_date),
count_successful_checkout_attempts as
(select
action_date,
count(*) as count_successful_checkout_attempts
from
total_successful_attempts
group by action_date)

select
c.action_date,
c.count_total_carts,
ifnull(a.count_total_checkout_attempts,0) as count_total_checkout_attempts,
ifnull(s.count_successful_checkout_attempts,0) as count_successful_checkout_attempts
from
count_total_carts c
left join
count_total_checkout_attempts a on a.action_date = c.action_date
left join
count_successful_checkout_attempts s on s.action_date = a.action_date
where c.action_date between '2022-07-01' and '2023-01-31'
order by c.action_date
