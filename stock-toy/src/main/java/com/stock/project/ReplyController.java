package com.stock.project;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.stock.domain.ReplyVO;
import com.stock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/replies/")
@Log4j
@AllArgsConstructor
public class ReplyController {

	@Setter(onMethod_ = @Autowired)
	private ReplyService service;
	
	//댓글 리스트
	@GetMapping(value = "/{bno}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") int bno){
		
		log.info("게시물번호 -------" +bno);
		
//		List<ReplyVO> replyList = service.list(bno);
//		return new ResponseEntity<List<ReplyVO>>(replyList, new HttpHeaders(), HttpStatus.OK);
		
		return new ResponseEntity<List<ReplyVO>>(service.list(bno),HttpStatus.OK);
	}

	//댓글 등록
	@PostMapping(value = "/{bno}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE}, consumes="application/json")
	public ResponseEntity<String> insert(@PathVariable("bno") int bno, @RequestBody ReplyVO vo){
		
		log.info("등록 컨트롤러" + vo);
		
		int count = service.register(vo);

		return count == 1 ? new ResponseEntity<String>("ReplyinsertOK",HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR); 
		}
	
	//댓글 수정
	@RequestMapping(value= "/{rno}", method = RequestMethod.PATCH)
	public ResponseEntity<String> update(@PathVariable("rno") int rno, @RequestBody ReplyVO vo){

		log.info(vo);		
		vo.setRno(rno);
		int count = service.update(vo);
		
		log.info(vo);
		
		return count == 1 ? new ResponseEntity<String>("ReplyUpdateOK",HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글삭제
	@DeleteMapping(value="/{rno}" ,produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<String> delete(@RequestBody ReplyVO vo){
		
		log.info("vo----" + vo);
		
		int count = service.delete(vo);
		
		return count == 1 ? new ResponseEntity<String>("ReplyDeleteOK",HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}

}
