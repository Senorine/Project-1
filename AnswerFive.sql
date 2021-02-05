use testdb3;

--Table for storing page revision dataset
create table page_revisions (
	wiki_db string,
	event_entity string,
	event_type string,
	event_timestamp string,
	event_comment_escaped string,
	
	event_user_id int,
	event_user_text_historical_escaped string,
	event_user_text_escaped string,
	event_user_blocks_historical_string string,
	event_user_blocks_string string,
	event_user_groups_historical_string string,
	event_user_groups_string string,
	event_user_is_bot_by_historical_string string,
	event_user_is_bot_by_string string,
	event_user_is_created_by_self boolean,
	event_user_is_created_by_system boolean,
	event_user_is_created_by_peer boolean,
	event_user_is_anonymous boolean,
	event_user_registration_timestamp string,
	event_user_creation_timestamp string,
	event_user_first_edit_timestamp string,
	event_user_revision_count int,
	event_user_secconds_since_previous_revision int,
	
	page_id int,
	page_title_historical_escaped string,
	page_title_escaped string,
	page_namespace_historical int,
	page_namespace_is_content_historical boolean,
	page_namespace int,
	page_namespace_is_content boolean,
	page_is_redirect boolean,
	page_is_deleted boolean,
	page_creation_timestamp string,
	page_first_edit_timestamp string,
	page_revision_count int,
	page_seconds_since_previous_revision int,
	
	user_id int,
	user_text_historical_escaped string,
	user_text_escaped string,
	user_blocks_historical_string string,
	user_blocks_string string,
	user_groups_historical_string string,
	user_groups_string string,
	user_is_bot_by_historical_string string,
	user_is_bot_by_string string,
	user_is_created_by_self boolean,
	user_is_created_by_system boolean,
	user_is_created_by_peer boolean,
	user_is_anonymous boolean,
	user_registration_timestamp string,
	user_creation_timestamp string,
	user_first_edit_timestamp string,
	
	revision_id int,
	revision_parent_id int,
	revision_minor_edit boolean,
	revision_deleted_parts_string string,
	revision_deleted_parts_are_suppressed boolean,
	revision_text_bytes int,
	revision_text_bytes_diff int,
	revision_text_sha1 string,
	revision_content_model string,
	revision_content_format string,
	revision_is_deleted_by_page_deletion boolean,
	revision_deleted_by_page_deletion_timestamp string,
	revision_is_identity_reverted boolean,
	revision_first_identity_reverting_revision_id int,
	revision_seconds_to_identity_revert int,
	revision_is_identity_revert boolean,
	revision_is_from_before_page_creation boolean,
	revision_tags_string string
			
)
	
	row format delimited fields terminated by '\t';
	
LOAD DATA LOCAL INPATH '/home/fsenorine/2021-01.enwiki.2021-01.tsv' INTO TABLE page_revisions ;



--Query for calulating the estimated average number of days since an english wikipedia page has been revised
select avg(page_seconds_since_previous_revision) * 0.000278 from page_revisions ;

--Query for calulating the estimated average number of page views per day for an english wikipedia artice
select avg(count_views) from page_view_jan where domain_code like "en%";

