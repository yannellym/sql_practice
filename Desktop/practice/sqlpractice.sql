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