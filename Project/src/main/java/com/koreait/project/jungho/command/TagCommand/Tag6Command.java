package com.koreait.project.jungho.command.TagCommand;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.project.common.CommonVoidCommand;
import com.koreait.project.jungho.dao.TrainerClassDao;

public class Tag6Command implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String , Object> map = model.asMap();
		String 댄스 = (String)map.get("댄스");
		
		TrainerClassDao trainerClassDao = sqlSession.getMapper(TrainerClassDao.class);
		
		model.addAttribute("MeetingList", trainerClassDao.Tag0(댄스));
		model.addAttribute("ClassTags", trainerClassDao.classTag());

	}

}
