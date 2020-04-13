--IMCOMPLETE


CREATE FUNCTION monthly_sales_expenditures (select_month NUMERIC(2,0), select_year NUMERIC(2,0))
	RETURN TABLE(
		monthly_sales 				NUMERIC(9,2),
		monthly_expenditures	NUMERIC(9,2))
RETURN TABLE
	SELECT ISBN, quantity, price, commisson
	 (FROM book NATURAL JOIN cart NATURAL JOIN 
		(SELECT C_ID FROM order
		 WHERE month = monthly_sales_expenditures.select_month AND year = monthly_sales_expenditures.select_year) AS monthly_order) AS monthly_cart
	