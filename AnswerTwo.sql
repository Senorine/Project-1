
use testdb3;

--table for storing December 27th 2020 page views
create table page_view_jan (
	domain_code string,
	page_title string,
	count_views int,
	total_response_size int)
	
	row format delimited fields terminated by ' ';


LOAD DATA LOCAL INPATH '/home/fsenorine/mypages/pageviews-20210103-230000' INTO TABLE page_view_jan;

--Table for storing the total page views on December  27th 2020
create table jan_total_view(
	page_title string,
	total_count int	
);

--Query for estimating the views per month for an english wikipedia article
insert into jan_total_view select page_title , sum(count_views * 31) from page_view_jan 
where domain_code like "en%" 
and page_title Not like "Main_Page" and page_title Not like "Special:Search" 
and page_title not like "-"
group by page_title ;


--Table for storing January Clickstream data
create table jan_clickstream (
	start_link string,
	current_link string,
	link_type string,
	occurence_count int)
	
	row format delimited fields terminated by '\t';


LOAD DATA LOCAL INPATH '/home/fsenorine/clickstream-enwiki-2020-12.tsv' INTO TABLE jan_clickstream ;

--Table for storing total clickstream data
create table jan_total_clickstream(
	start_link string,
	total_occurence int	
);


insert into jan_total_clickstream select start_link , sum(occurence_count) from jan_clickstream where link_type = "link"
group by start_link ;

--Query for calculating highest fraction of readers following an internal link
select jan_total_view.page_title, jan_total_clickstream.total_occurence/jan_total_view.total_count as frac
from jan_total_clickstream 
inner join jan_total_view on jan_total_clickstream.start_link = jan_total_view.page_title
order by frac desc limit 1;



