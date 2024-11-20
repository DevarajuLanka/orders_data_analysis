        

		select * from orders_data

		--To get top 10 
		select top 10* from orders_data

		--TO see oldest entered data first
		select * from orders_data
		order by order_date , profit 

		select *,round(sales/profit,2) as ratio from orders_data
		
		--To filter the data 
		select * from orders_data
		where region = 'south'

		select * from orders_data 
		where quantity > 3 
		order by quantity 

		select * from orders_data
		where order_date = '2019-04-30'

		select * from orders_data
		where (region = 'central' or category = 'technology') and quantity > 3 

		update orders_data set city = null where order_id in ('CA-2020-152156','US-2019-118983') 

		--OPERATORS  
		select * from orders_data 
		where quantity > = 3 and quantity < = 5 

		 select * from orders_data 
	     where quantity between 3 and  5 

		 select * from orders_data 
		where quantity in ( 3,5)

		select * from orders_data 
		where quantity = 3 or quantity = 5 
		order by quantity 

		--NOT operator 
		select * from orders_data 
		where quantity not in (3,5) 

		-- PATTERN MATCHING 
		--write a query to know whose name is starts with A 
           
		   select * from orders_data 
		   where customer_name like 'A%'

		   select * from orders_data
		   where customer_name like '_[ae]%n'

		   --AGGRAGATE FUNCTIONS 

		   select * from orders_data order by sales ;

		   -- to get max & min sales 
		   select max(sales) as max_sales from orders_data 
		   select min(sales) as min_sales from orders_data 
		   
		   -- To get average sales 
		   select avg(sales) as avg_sales,avg(profit) as avg_profit from orders_data

		   --Another way to get average sales 
		   select round (sum(sales )/ count(*),2) as avg_sales 
		   from orders_data

		   -- To get no.of records // count(*) and count(constant numbers) both are same. like, count(1) or count(100 or 500) or count(abc).
		   select count(*) as no_of_records,count (order_id) as no_of_order_ids,count(city) as no_of_city_count from orders_data

		   --To get distinct values 
		   select count (distinct region) as dist_region, count ( distinct city ) as no_of_dist_city from orders_data 
		   select distinct category,region from orders_data 

		   -- Getting null values 
		   select * from orders_data 
		   where city is null 

		   --Getting no null values 
		   select * from orders_data 
		   where city is not null 

		   --Summerizing group sales 
		   select category , sum (sales) as category_Sales 
		   from orders_data 
		   group by category 

		   select category,city, sum(sales) as cat_city_sales
		   from orders_data 
		   group by category,city 

		   select city,sum(sales) as sum_sales  from orders_data
		   group by city 
		   having city = 'Madison'

		   select category, region, sum(sales) as sum_Sales, sum(profit) as category_profit from orders_data 
		   group by category , region 

		   --Filtering data group wise 
           select city,sum(sales) as city_sales
		   from orders_data 
		   group by city 
		   having sum(sales)> 200 
		    
		   --Region wise city sales where sum of sales is greater than 500 
		   select city, sum(sales) as city_sales 
		   from orders_data
		   where region = 'central'
		   group by city 
		   having sum(sales) > 500 

		   --JOINS + Aggregated Functions 
		   select * from orders_data
		   inner join returns_data on orders_data.order_id = returns_data.order_id 

		   --To find sum of return values
		   select sum(sales) as return_sum from orders_data
		   inner join returns_Data on orders_data.order_id = returns_data.order_id 

		   --To find category wise retuns value 
		   select category,sum(sales) as cat_wise_sum from orders_data
		   inner join returns_Data on orders_Data.order_id = returns_Data.order_id
		   group by category 

		   --To find category wise return values with different reasons 
		   --Inner join - Combining records of two different tables 
		   select category,return_reason,sum(sales) as cat_wise_sum from orders_data
		   inner join returns_data on orders_data.order_id = returns_data.order_id 
		   where  return_reason = 'bad quality'
		   group by category,return_reason 

		   select * from orders_data 
		   inner join returns_data 
		   on 
		   orders_data.order_id = returns_data.order_id 
		   where return_reason = 'wrong items' and city = 'troy' 
		   
		   --Left join = All the values of the left table and matching records of the right table 

		   select * from orders_Data o
		   left join returns_data r
		   on 
		   o.order_id = r.order_id 

		   --To get the records which is not returned
		   
		   select * from orders_Data o
		   left join returns_data r
		   on 
		   o.order_id = r.order_id 
		   where return_reason is null

		   --Region/Reson wise sum value
		   select r.return_reason, sum (sales) as return_sales 
		   from orders_data o
		   left join returns_data r
		   on 
		   o.order_id = r.order_id 
		   group by return_reason 
		   
		    select region,r.return_reason, sum (sales) as return_sales 
		   from orders_data o
		   left join returns_data r
		   on 
		   o.order_id = r.order_id 
		   group by region,return_reason 
		   having region = 'south'
		   
		   --Case statement
		   select *,
		   case when return_reason = 'wrong item ' then 'wrong items ' else return_reason end as new_return_reason
		   from returns_data 

		   --Categorized profits
		   select *,
		   case when profit < 0 then 'loss'
		   when profit > 0 and profit < 50 then ' low profit'
		   when profit < 100 then 'high profit'
		   else 'very high profit'
		   end as new_profit_bucket 
		   from orders_data 

		   --Date & String functions
		   select*
		   , len(customer_name ) as cust_name 
		   , left(order_id,2) as left_value
		   , right(order_id,6) as right_value
		   , SUBSTRING(order_id,4,4) as year_value
		   , replace (customer_name,'j','e') as replace_name
		   from orders_data 

		   --Date functions
		   select DATEPART ( year,order_date) as order_year,DATEPART ( month,order_date ) as order_moth 
		   from orders_data 

		    select DATEPART ( year,order_date) as order_year,DATEPART ( month,order_date ) as order_moth,
			sum (sales ) as year_month_sales 
		   from orders_data 
		   group by DATEPART ( year,order_date),DATEPART ( month,order_date )

		   select order_id,order_date,
		   DATENAME(MONTH,order_date) as order_month_name,
		   DATENAME(weekday,order_date) as order_week_name
		   from orders_data

		   select order_id,order_date,ship_date,
		   DATEDIFF ( DAY,order_date,ship_date) as lead_day,
		   DATEDIFF ( week,order_date,ship_date) as lead_week,
		   DATEDIFF ( month,order_date,ship_date) as lead_month,
		   DATEADD  (day,5,ship_date) as day_5
		   from orders_data