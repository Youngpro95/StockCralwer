package com.stock.project;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.stock.domain.BoardDTO;
import com.stock.domain.Criteria;
import com.stock.domain.MemberDTO;
import com.stock.domain.PageDTO;
import com.stock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	@Autowired
	private BoardService serivce;
	
	@GetMapping("/list")
	public void getList(Criteria cri, Model model) {
		log.info("------------------");
		log.info("controller list");
		log.info("------------------");
		
		if(cri.getKeyword() != null && cri.getType() != null) {
			int total = serivce.serachTotal(cri);
			model.addAttribute("list", serivce.serach(cri));
			model.addAttribute("page", new PageDTO(cri, total));
			log.info("키워드있다~!!!!!~~"+cri);
			log.info(total);
		} else if((cri.getKeyword() == null && cri.getType() == null)) {
			int total = serivce.totalCount();
			model.addAttribute("list", serivce.getList(cri));
			model.addAttribute("page", new PageDTO(cri, total));
			log.info("키워드없음~~~"+cri);
			log.info(total);
			}
		}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register2(BoardDTO dto, HttpServletRequest req){
		
		HttpSession session = req.getSession();
		log.info("session----" + session.getAttribute("memberNick"));
		
		if(session.getAttribute("memberNick") == null) {
			return "redirect:/board/register";
		}
		
		log.info("------------------");
		log.info("register post:" + dto);
		log.info("------------------");
		
		int titleCheck = boardDataCheck(dto);
		
		log.info("titleCheck-----" + titleCheck);
		
		
			if(titleCheck == 0) {
			serivce.register(dto);
			dto.setAttach(dto.getBno());

			}

			log.info("게시글번호----- " + dto);
			log.info(dto.getUpdateDate());
			
			return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	public void get(Criteria cri, int bno,Model model) {
		log.info("cri --------" + cri);
		
		serivce.clickViews(bno);
		
		log.info("게시물 조회수증가--------" + bno);
		
		model.addAttribute("list", serivce.get(bno));
	}
	
	@GetMapping("/modify")
	public void modify(int bno,Model model) {
		model.addAttribute("list", serivce.get(bno));
	}
	
	@PostMapping("/modify2")
	public String modify2(BoardDTO dto) {
		
		log.info("------------------");
		log.info("수정테슽트" + dto.getClass().getName());
		log.info("------------------");
		 serivce.modify(dto);
		return "redirect:/board/list";
	}
	
	@GetMapping("/delete")
	public String delete(int bno) {
		
		log.info("------------------");
		log.info("삭제완료~");
		log.info("------------------");
		serivce.delete(bno);
		return "redirect:/board/list";
	}
	

	//특수문자 공백,걸러줌
	public static int boardDataCheck(BoardDTO dto) {
		
		boolean regexTitle = Pattern.matches("[ ]", dto.getTitle());
//		boolean regexContent = Pattern.matches("[ ]", dto.getContent());
//		boolean regexWriter = Pattern.matches("[ ]", dto.getWriter());

		log.info("dto.getTitle().length()--- "+ dto.getTitle().length());
		
			//이름은 특수문자금자 1~20글자 사이	
				if(dto.getTitle().length() <=0) return 1;
				if(regexTitle == true) return 1;
				
		return 0;
	}
	
	
	
}