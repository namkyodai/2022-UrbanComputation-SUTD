Hallo All,

Hope you enjoyed week 2 lecture ^_^ :smile: :smile: :smile:. if not, then my apology :sweat_smile:.

As discussed, our class will have 2 groups :ok_woman: :ok_man: and the expectation is that members of the groups shall meet and work together and help each other so all members are able to perform the same operation.

This week assignment will be pretty simple :innocent:, that is to practice some basic SQL syntax so you can understand the importance of relational database management system (RDBMS) and later be able to communicate with other groups (e.g. IT, business, marketing) when chances arrive :wink:.


# GROUP members
| Group 1 | Group 2 |
|---------|---------|
| Xiaoyan | Yiming  |
| Sean    | Shannon |
| Rachel  | Rohinee |
| Zwelynn | Alba    |
| Angela  | Liting  |


# Requirements for both two groups

## Dataset
- Dataset for group 1 is **dump-sghousingprice-202203250215.sql**
- Dataset for group 2 is **dump-propertylistings-202203250237.sql**

you can file these two sql dataset saved under [2022-UrbanComputation-SUTD/notes/sg-houseprice/sql](https://github.com/namkyodai/2022-UrbanComputation-SUTD/tree/main/notes/sg-houseprice/sql)


## Exercise 1 - SQL Practicing
- Step 1 - Creating and Loading data
  - Using dbeaver to create a new database name --> choose whatever you like
  - Import the database by executing script (sql)

- Step 2 - Practicing some useful SQL functions

Go to [https://www.w3schools.com/SQl/](https://www.w3schools.com/SQl/) and you can see a list of SQL on the left panel, if you click on them, there will be example, which is similar to what we learnt in the class

Your job is to trying to understand the data a little bit by using SQL. Please choose examples by discussing with your group members, you can create many examples as you like so at least during the next class, you can spend about 10 minutes for presentation.

There is no limitation of SQL you will use, however, you can try first with the followings
  - SELECT
  - SELECT Distinct
  - Where
  - And, or, not
  - Order by
  - Insert into
  - Update
  - Delete
  - Min and Max
  - Count, Avg, Sum --> please use these functions to understand a bit inside of the data
  - Group by

## Exercise 2 - Playing some funs with PostgreSQL and QGIS

- Step 1 - Go to the internet and ask prof. Google ^_^ for any possible spatial database (there are tons of them). Database can be from anywhere in the world. Choose 2 database of shapefile extension (remember shapefile goes with 4 files always), one database of polygon type (e.g. administrative, district, commute, natural resource boundary) and another database of line type (e.g. road network, river, pipeline)

- Step 2 - Using QGIS to import these 2 shapefiles into PostgreSQL (note that you need to create PostGIS extensions --> see the video)

- Step 3 - Using dbeaver to create SQL syntax that compute AREA of targeted polygon fields for the polygon Database

- Step 4 - Using dbeaver to create SQL syntax that compute LENGTH of targeted objects for the line Database

- Step 5 - (Optional) - Create a connection to PostgreSQL databases from R environment and copy these SQL that you create in step 3 and 4 and run them in R.

- Step 6 (Optional) - Anyone of you if wish to learn more about [PostGIS](https://postgis.net/), visit its website and

## Important notes
- If you have any issue, pls go to and post issue [https://github.com/namkyodai/2022-UrbanComputation-SUTD/issues](https://github.com/namkyodai/2022-UrbanComputation-SUTD/issues) so I or other members of the class can address timely and all of us can see the solutions
- You can also upload your solutions under issue

Cheers

Nam
