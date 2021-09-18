--IF WANT TO CALCULATE THE SALES RATIOS ACCORDING TO THE DAYS OF THE WEEK
ALTER TABLE SALES
ADD
DAYOFWEEK_ as (datename(dw,Date)) 

/*IT IS DESIRED TO MAKE A CAMPAIGN SPECIAL FOR THE CITY AND DAYS,
BY LEARNING WHAT DAY THE MOST SALES ARE MADE IN EACH CITY.
SQL QUERY ON HOW MUCH SALES CITIES MADE BY DAYS OF THE WEEK. */

SELECT 
DISTINCT City,
(SELECT SUM(TOTAL) FROM SALES WHERE City =S.City AND DAYOFWEEK_='Monday') AS Monday,
(SELECT SUM(TOTAL) FROM SALES WHERE City =S.City AND DAYOFWEEK_='Tuesday') AS Tuesday,
(SELECT SUM(TOTAL) FROM SALES WHERE City =S.City AND DAYOFWEEK_='Wednesday') AS Wednesday,
(SELECT SUM(TOTAL) FROM SALES WHERE City =S.City AND DAYOFWEEK_='Thursday') AS Thursday,
(SELECT SUM(TOTAL) FROM SALES WHERE City =S.City AND DAYOFWEEK_='Friday') AS Friday,
(SELECT SUM(TOTAL) FROM SALES WHERE City =S.City AND DAYOFWEEK_='Saturday') AS Saturday,
(SELECT SUM(TOTAL) FROM SALES WHERE City =S.City AND DAYOFWEEK_='Sunday') AS Sunday

FROM SALES S
ORDER BY 1

-- SQL QUERY BRINGING THE 3 BEST SELLING CATEGORIES OF EACH CITY.

SELECT S.City, S1.[Product line] line, SUM(S1.TOTALSALE) AS TotalSale
FROM SALES S
CROSS APPLY (SELECT TOP 3 [Product line], SUM(Total) AS TOTALSALE FROM SALES WHERE City = S.City GROUP BY [Product line] ORDER BY 2 DESC) S1

GROUP BY S.City, S1.[Product line]
ORDER BY S.City, SUM(S1.TOTALSALE) DESC


---------------------------------------------
--SQL QUERY RETURNING TOTAL SALES BY GENDER ON DAYS OF WEEK WITH THE LEAST SALES.


SELECT S.City, S1.DAYOFWEEK_,Gender, SUM(S1.TOTALSALE) AS TotalSale
FROM SALES S
CROSS APPLY (SELECT TOP 1 DAYOFWEEK_, SUM(Total) AS TOTALSALE FROM SALES WHERE City = S.City GROUP BY DAYOFWEEK_ ORDER BY 2 ASC) S1

GROUP BY S.City, S1.DAYOFWEEK_, Gender
ORDER BY S.City, SUM(S1.TOTALSALE) DESC