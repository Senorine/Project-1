use pageview_db;

--Template Query for creating table to store page view data for each hour of January 20, 2021
create table table_name (
	domain_code string,
	page_title string,
	count_views int,
	total_response_size int)
	
	row format delimited fields terminated by ' ';

--Query for loading page view adat into a table
LOAD DATA LOCAL INPATH '/home/fsenorine/mypages/pageviews-20210103-230000' INTO TABLE table_name;


--Query for finding the top ten highest page views per hour for January 20, 2021
select page_title , count_views as total from table_name 
where domain_code like "en%" 
and page_title Not like "Main_Page" and page_title Not like "Special:Search" 
and page_title not like "-"
group by page_title order by  count_views desc limit 10;