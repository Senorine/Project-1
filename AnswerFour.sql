use testdb3;

--Table for storing peak hour usage in the Americas
create table americas (
	domain_code string,
	page_title string,
	count_views int,
	total_response_size int)
	
	row format delimited fields terminated by ' ';
	
LOAD DATA LOCAL INPATH '/home/fsenorine/mypages/pageviews-20210103-020000' INTO TABLE americas ;

--Table for storing peak hour usage outside of the Americas
create table non_americas (
	domain_code string,
	page_title string,
	count_views int,
	total_response_size int)
	
	row format delimited fields terminated by ' ';

LOAD DATA LOCAL INPATH '/home/fsenorine/mypages/pageviews-20210103-160000' INTO TABLE non_americas ;

create table americas_total(
	page_title string,
	total_count int	
);


insert into americas_total select page_title , sum(count_views) from americas 
where page_title Not like "Main_Page" and page_title Not like "Special:Search" 
and page_title not like "-"
group by page_title ;

create table non_americas_total(
	page_title string,
	total_count int	
);

insert into non_americas_total select page_title , sum(count_views) from non_americas 
where page_title Not like "Main_Page" and page_title Not like "Special:Search" 
and page_title not like "-"
group by page_title ;


--Query for estimating a page that is more popular in the Americas
select americas_total.page_title , americas_total.total_count , non_americas_total.total_count 
from  americas_total
inner join non_americas_total on americas_total.page_title = non_americas_total.page_title 
where americas_total.total_count > 15000
and non_americas_total.total_count < 500;


