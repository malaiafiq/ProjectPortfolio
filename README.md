## Approach

A summary of the approach was to;

Download a set of public data (Covid data from: https://ourworldindata.org/covid-deaths)
Learn how to install and deploy a MySQL database to my local machine
Write a script in SQL to import and clean the data
Explore the data using queries
Visualising the data; connecting from SQL Server to PowerBI

## Data Import
This was proving troubling but after investigation determined the issue was Excel would save .csv as ASCII when my SQL analysis tool was expecting UTF-8. Saving the csv in Excel in UTF-8 remedied problems.

## Data Cleaning
This was the most time consuming part of the project. Data was missing for continent, the import had created several EMPTY values which I discovered was different to NULL and then had to replace.

## Repo Structure
Clean files for starting fresh with the data after getting things wrong, will generate tables.
COVID-SQLQuery2.sql is for the data exploration, viz_query.sql is for getting the data for the visualisation.

## Conclusion
The project was an enjoyable push, ended up spending more time on learning to do database admin installing MySQL that intended. Gained valuable experience cleaning the data up and finding best ways to write and run SQL queries. There is probably a lot more to get into with this and data visualisation in general.

