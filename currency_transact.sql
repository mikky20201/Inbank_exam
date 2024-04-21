WITH currency_exchange as 
(SELECT p.user_id_sender,
	p.transaction_date,					
	case when cr.exchange_rate_to_eur is null then p.amount * 1
	else p.amount * cr.exchange_rate_to_eur  
	end as total_amount,
	p.currency					   
FROM PAYMENTS p
LEFT OUTER JOIN CURRENCY_RATES cr ON p.currency = cr.currency_id and p.transaction_date =  cr.exchange_date) 

select 
sum(ce.total_amount) as AMOUNT_EUR
,ce.transaction_date as transaction_date
from currency_exchange ce
INNER JOIN currencies c   ON ce.currency = c.currency_id
LEFT OUTER JOIN blacklist b ON ce.user_id_sender = b.user_id
WHERE c.end_date is NULL AND b.blacklist_code IS NULL
group by ce.transaction_date