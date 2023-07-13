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