use testdb3;

create table dec_total_views(
	page_title string,
	total_count int	
);

insert into dec_total_views select page_title , sum(count_views * 31) from page_view_dec 
where domain_code like "en%" 
and page_title Not like "Main_Page" and page_title Not like "Special:Search" 
and page_title not like "-"
group by page_title ;


create table dec_total_clickstreams(
	start_link string,
	current_link string,
	total_occurence int	
);


insert into dec_total_clickstreams select start_link, current_link, sum(occurence_count) from dec_clickstream 
where link_type = "link"
group by start_link, current_link;

create table frac(
	start_link string,
	current_link string,
	link_frac float	
);


insert into table frac select dec_total_clickstreams.start_link, dec_total_clickstreams.current_link,
dec_total_clickstreams.total_occurence/dec_total_views.total_count 
from dec_total_clickstreams 
inner join dec_total_views on dec_total_clickstreams.start_link = dec_total_views.page_title;

--Query for finding the start of the series with highest fraction clicking internal link
select start_link, current_link, link_frac from frac where start_link = "Hotel_California" 
 order by link_frac desc limit 1;

--Query for finding the next link  with the highest fraction clicking an internal link
select start_link, current_link, link_frac from frac where start_link = "Hotel_California_(Eagles_album)" 
and current_link  != "Hotel_California"
 order by link_frac desc limit 1;
 
--Query for finding the next link with the highest fraction clicking an internal link
select start_link, current_link, link_frac from frac where start_link = "The_Long_Run_(album)" 
and current_link  != "Hotel_California"
 order by link_frac desc limit 1;
 



