use pageview_db;


--Table for storing all pageview data for January 20, 2021
create table total_pageviews (
	domain_code string,
	page_title string,
	count_views int,
	total_response_size int)
	
	row format delimited fields terminated by ' ';
	
LOAD DATA LOCAL INPATH '/home/fsenorine/pageviews-20210120-230000' INTO TABLE total_pageViews;


--Query for finding the most viewd wikipedia page for January 20,2021
select page_title, sum(count_views) as count_views from total_pageviews where domain_code like "en%" 
and page_title Not like "Main_Page" and page_title Not like "Special:Search" 
and page_title not like "-" group by page_title order by count_views desc limit 1;