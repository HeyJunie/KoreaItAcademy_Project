package com.koreait.project.jungho.command.TrainerClassCommand;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.project.common.CommonVoidCommand;
import com.koreait.project.jungho.dao.TrainerClassDao;
import com.koreait.project.jungho.dto.TrainerClassDto;

public class SearchClassCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		String search_content = (String)map.get("search_content");
		RedirectAttributes rttr = (RedirectAttributes)map.get("rttr");
		
		TrainerClassDao trainerClassDao = sqlSession.getMapper(TrainerClassDao.class);
		
		List<TrainerClassDto> Searchlist = trainerClassDao.searchClass(search_content);
		
		//rttr.addAttribute("MeetingList", Searchlist);
		//rttr.addAttribute("ClassTags", trainerClassDao.classTag());
		//rttr.addFlashAttribute("MeetingList", Searchlist);
		//rttr.addFlashAttribute("ClassTags", trainerClassDao.classTag());
		model.addAttribute("MeetingList", Searchlist);
		model.addAttribute("ClassTags", trainerClassDao.classTag());
		//rttr.addAttribute("MeetingList", Searchlist);
		
	}

}
