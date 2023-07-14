'''
ORDER BY:

Write a query to return the 10 earliest orders in the orders table. 
Include the id, occurred_at, and total_amt_usd.Write a query to return 
the top 5 orders in terms of largest total_amt_usd. Include the id, 
account_id, and total_amt_usd.Write a query to return the lowest 20 orders
 in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.

 * hen you provide a list of columns in an ORDER BY command, the sorting occurs using the 
 leftmost column in your list first, then the next column from the left, and so on. 
'''

SELECT id, occurred_at, total_amt_usd
FROM orders
LIMIT 10;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd ASC
LIMIT 20;

''' 
ORDER BY 2:

Write a query that displays the order ID, account ID, and total dollar amount for
all the orders, sorted first by the account ID (in ascending order), and then by 
the total dollar amount (in descending order).

Now write a query that again displays order ID, account ID, and total dollar amount 
for each order, but this time sorted first by total dollar amount (in descending order)
, and then by account ID (in ascending order).

'''

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;

'''
WHERE:
Pulls the first 5 rows and all columns from the orders table that have a dollar amount 
of gloss_amt_usd greater than or equal to 1000.

Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less
 than 500.
'''

SELECT * 
FROM orders
WHERE gloss_amt_usd >= 100
LIMIT 5;

SELECT *
FROM orders 
WHERE total_amt_usd < 500
LIMIT 10;

'''
WHERE with Non-numeric Data

Filter the accounts table to include the company name, website, and the primary point of contact 
(primary_poc) just for the Exxon Mobil company in the accounts table.
'''
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

'''
ARITHMETIC OPERATORS:

*This derived column, and its alias, are generally only temporary, existing just for the duration
of your query. The next time you run a query and access this table, the new column will not be there.

Using the orders table:

Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard 
paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.


Write a query that finds the percentage of revenue that comes from poster paper for each order. You will 
need to use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also.
'''

SELECT id, account_id, (standard_amt_usd/standard_qty) AS unit_price
FROM orders
LIMIT 10;


SELECT id, account_id,poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;


'''
LIKE:
Use the accounts table to find

All the companies whose names start with 'C'.

All companies whose names contain the string 'one' somewhere in the name.

All companies whose names end with 's'.

'''

SELECT *
FROM accounts
WHERE name LIKE 'C%';

SELECT *
FROM accounts
WHERE name LIKE '%one%';

SELECT *
FROM accounts
WHERE name LIKE '%S';

'''
IN:
The IN operator is useful for working with both numeric and text columns. This operator allows you to use an =, but for more than one item of that particular column. We can check one, two or many column 
values for which we want to pull data, but all within the same query. 

Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.
'''

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN('Walmart', 'Target', 'Nordstrom');

SELECT * 
FROM web_events
WHERE channel IN('organic', 'adwords');



'''
NOT:
The NOT operator is an extremely useful operator for working with the previous two operators we introduced: IN and LIKE. By specifying NOT LIKE or NOT IN, we can grab all of the rows that do not meet a particular criteria.

Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.

Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.
Use the accounts table to find:

All the companies whose names do not start with 'C'.

All companies whose names do not contain the string 'one' somewhere in the name.

All companies whose names do not end with 's'.
'''
SELECT name, primary_poc, sales_rep_id 
FROM accounts
WHERE name NOT IN('Walmart', 'Target', 'Nordstrom');

SELECT * 
FROM web_events
WHERE channel NOT IN('organic', 'adwords');

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%';

SELECT * 
FROM accounts
WHERE NAME NOT LIKE '%one%';

SELECT * 
FROM accounts
WHERE name NOT LIKE '%S'; 


'''
BETWEEN:
Sometimes we can make a cleaner statement using BETWEEN than we can using AND. Particularly this is true when we are using the same column for different parts of our AND statement. In the previous video, we probably should have used BETWEEN.

Instead of writing :

WHERE column >= 6 AND column <= 10
we can instead write, equivalently:

WHERE column BETWEEN 6 AND 10
Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.

Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.

When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? Figure out the answer to this important question by writing a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29. Then look at your output to see if the BETWEEN operator included the begin and end values or not.

Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest.
** The BETWEEN operator in SQL is inclusive; that is, the endpoint values are included.
'''
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;


SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

-- While BETWEEN is generally inclusive of endpoints, it assumes the time is at 00:00:00 (i.e. midnight) for dates. This is the reason why we set the right-side endpoint of the period at '2017-01-01'.


'''
OR:
Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.
Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.
Find all the company names that start with a "C" or "W", and the primary contact contains "ana" or "Ana", but it doesn"t contain 'eana'.
'''

SELECT id
FROM orders
WHERE (gloss_qty > 4000 OR poster_qty > 4000);

SELECT *
FROM orders
WHERE (standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000));
                             
SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
    AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
    AND primary_poc NOT LIKE '%eana%');
                                            

-- JOINS
'''
We use ON clause to specify a JOIN condition which is a logical statement to combine the table in FROM and JOIN statements.

Try pulling all the data from the accounts table, and all the data from the orders table.

Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
'''
SELECT * 
FROM accounts
JOIN orders
ON orders.account_id = accounts.id;

SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON accounts.id = orders.id;


'''
PRIMARY KEYS:
A primary key is a unique column in a particular table
It is common that the primary key is the first column in our tables in most databases.

Foreign Key (FK)
A foreign key is a column in one table that is a primary key in a different table

ERD Diagrams
The crows foot shows that the FK can actually appear in many rows in the sales_reps table.
While the single line is telling us that the PK shows that id appears only once per row in this table.

In the ON, we will ALWAYs have the PK equal to the FK:
'''
SELECT *
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id

'''
ALIAS:
When we JOIN tables together, it is nice to give each table an alias. Frequently an alias is just 
the first letter of the table name.

Select t1.column1 aliasname, t2.column2 aliasname2
FROM tablename AS t1
JOIN tablename2 AS t2
'''

-- Provide a table for all the for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

--Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
SELECT r.name region, a.name account, 
           o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;



'''
LEFT JOIN:

will include all of the results from the right table that match AND the results from the left table
that did not match.

Full outer join. This will return the inner join result set, as well as any unmatched rows from either of the two tables being joined.

'''
-- Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY a.name;

--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;

--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;

-- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price.
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;


--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first.
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first.
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

--What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.
SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';

--Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;

