package com.koreait.project.yongsoo.dao;

import java.util.List;

import com.koreait.project.dto.CommentsDto;
import com.koreait.project.yongsoo.dto.CommentTemDto;

public interface CommentDao {

	// 특정 모임 게시글에 달린 댓글 리스트를 불러오기 위한 메소드
	public List<CommentTemDto> getCommentList(int meeting_no);
	
	// 특정 모임 게시글에 댓글을 추가하는 메소드
	public int addComment(CommentsDto commentsDto);
	
	// 댓글 삭제 메소드
	public int deleteComment(int comment_no);
	
}
