## Approach

A summary of the approach was to;

Download a set of public data (Covid data from: https://ourworldindata.org/covid-deaths)
Learn how to install and deploy a MySQL database to my local machine
Write a script in SQL to import and clean the data
Explore the data using queries
Visualising the data; connecting from SQL Server to PowerBI
The below will detail some of the stages and share some of the notes I took as part of the project.

## Data Import
This was proving troubling but after investigation determined the issue was Excel would save .csv as ASCII when my SQL analysis tool was expecting UTF-8. Saving the csv in Excel in UTF-8 remedied problems.

## Data Cleaning
This was the most time consuming part of the project. Data was missing for continent, the import had created several EMPTY values which I discovered was different to NULL and then had to replace. The date format was wrong and in text so converted this to proper format and from DD/MM/YYYY to YYY-MM-DD.

## Repo Structure
Clean files for starting afresh with the data after getting things wrong, will generate tables.
Query1 is for the data exploration, QueriesPart2 is for getting the data for the visualisation.
Temp files were for holding temporary queries to help troubleshoot and explore other items.

## Running with new data
If you wish to run a version of this yourself you can, download the data from the our world in data link above, bring the data into your SQL database, run the cleanup script, use queries in QueriesPart2 (make minor adjustments based on your data, using comments as a guide). You'll now have tables that can be used in PowerBI for the visualisation.

## Conclusion
The project was an enjoyable push, ended up spending more time on learning to do database admin installing MySQL that intended. Gained valuable experience cleaning the data up and finding best ways to write and run SQL queries. There is probably a lot more to get into with this and data visualisation in general.

