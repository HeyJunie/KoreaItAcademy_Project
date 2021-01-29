package com.koreait.project.yongsoo.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CreateNewMeetingDto {

	private int user_no;
	private String meeting_title;
	private Date meeting_date;
	private Date start_gather_date;
	private Date end_gather_date;
	private int meeting_max;
	private int meeting_min;
	private int exercise_no;
	private int location1_no;
	private int location2_no;
	private String detail_location;
	private List<String> materialList;
	private String meeting_content;
	
}
