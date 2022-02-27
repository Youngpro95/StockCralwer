package com.stock.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.stock.domain.StockNewsVO;
import com.stock.domain.StockVO;
import com.stock.service.StockService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/stock")
public class StockController {
	
	
	@Autowired
	private StockService service;
	
	// list 페이지로 이동
	@GetMapping(value = "/list")
	public void GetList(Model model) {
		
		log.info("리스트출력");
		
	}
	
	//ajax ViList 응답으로 보내기
	@ResponseBody
	@GetMapping(value = "/ajax")
	public List<StockVO> GetTestAjax() {
		
		log.info("AJAX VI LiST호출");
		
		return service.getList();
	}

	//ajax VINewsList 응답으로 보내기
	@ResponseBody
	@GetMapping(value = "/ajaxNews")
	public List<StockNewsVO> GetNewsLiST(@RequestParam("stknm")String stk_nm){

		log.info(service.getNewsList(stk_nm));
		
		return service.getNewsList(stk_nm);
		
	}
	
	
	
}
