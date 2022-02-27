package com.stock.project;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.stock.domain.Board_AttachDTO;
import com.stock.service.BoardAttachService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/upload/")
public class UploadController {
   
   @Autowired
   private BoardAttachService service; 
   	   //파일생성
      @PostMapping(value="/uploadAjax", produces = "text/plain;charset=UTF-8")
      public ResponseEntity<String> uploadFile(@RequestParam("file")MultipartFile uploadfile,@RequestParam("bno") int bno, Board_AttachDTO dto) throws IOException{
    	 System.out.println("dto-----"+bno);
    	 String uploadFolder = "D:\\My_Python\\Viprogram\\stock-toy\\stock-toy\\src\\main\\webapp\\resources\\images\\" + days();
         String thmnail ="";
         String uploadFileName = uploadfile.getOriginalFilename();
         String UUIDFileName = getUUID(uploadFileName);
         File saveFile = new File(uploadFolder, UUIDFileName);

         	dto.setBoard_bno(service.insertbno());          		   //미리 게시판 번호를 저장해둠
         	dto.setUid_FileName(UUIDFileName);
            dto.setFile_Name(uploadfile.getOriginalFilename());	
            dto.setFile_Path(uploadFolder);
            dto.setFile_Size((int)uploadfile.getSize());
            
            if(bno != 0) {
            	dto.setBoard_bno(bno);
            }
            

            log.info("bno----" + dto.getBoard_bno());
            
            try {
               uploadfile.transferTo(saveFile);          			   //파일 생성
               if(getImage(UUIDFileName, uploadFolder)!=null) {        //섬네일 파일이름 저장
            	   thmnail = days() +"\\"+ getImage(UUIDFileName, uploadFolder);
               }else {
            	   thmnail = UUIDFileName;
               }
               log.info(thmnail);
               service.attach(dto);
            }catch (Exception e) {
               e.printStackTrace();
            }
             return new ResponseEntity<String>(thmnail, HttpStatus.OK);
            }
      
      //파일삭제
      @PostMapping(value="/removeUploadAjax" ,produces = {MediaType.APPLICATION_JSON_UTF8_VALUE}, consumes="application/json")
      public ResponseEntity<String> removeFile(@RequestBody Board_AttachDTO dto) {
    	  
    	  String DBfileCut = dto.getUid_FileName().replace("!@#", " ");
    	  String SfileCut = dto.getUid_FileName().replace("!@#", " ");
    	  String fileCut2 = "";
//    	  String Dday = dto.getFile_Path().substring(dto.getFile_Path().indexOf("20"),dto.getFile_Path().indexOf("20")+10);
    	  
    	  log.info("FileName--------" + dto.getUid_FileName());
    	  
    	  log.info("dto---" + dto);
//    	  log.info("Dday ----- "  + Dday);
    	  
    	  //파일이름에 THUMB가 있다면
    	  if(dto.getUid_FileName().indexOf("THUMB_") != -1) {
    		  log.info("썸네일이 몇번째에 있나요?--" + dto.getUid_FileName().indexOf("THUMB_"));
    		  
    		  SfileCut = dto.getUid_FileName().substring(dto.getUid_FileName().indexOf("THUMB_")).replace("!@#", " ");
    		  DBfileCut = dto.getUid_FileName().substring(dto.getUid_FileName().indexOf("THUMB_")+6).replace("!@#", " ");
    		  fileCut2 = dto.getUid_FileName().substring(dto.getUid_FileName().indexOf("THUMB_")+6).replace("!@#", " ");
    		  
    	  }

    	  if(dto.getUid_FileName().lastIndexOf("THUMB_") == -1) {
    		  System.out.println("이거 이미지임!!!!!!!!!!!!");
    		  fileCut2 = "THUMB_"+dto.getUid_FileName();
    		  log.info("파일컷2--"+ fileCut2);
    	  }
    	  
    	  String filePath="D:\\My_Python\\Viprogram\\stock-toy\\stock-toy\\src\\main\\webapp\\resources\\images\\"+  days() + "\\" + SfileCut;
    	  String filePath2="D:\\My_Python\\Viprogram\\stock-toy\\stock-toy\\src\\main\\webapp\\resources\\images\\"+  days() + "\\" + fileCut2;

    	  log.info("filePath---" + filePath);
    	  log.info("filePath2---" + filePath2);    	 
    	  
//    	  String filePath="C:\\Users\\PoPo\\Documents\\kimBoard\\board2\\src\\main\\webapp\\resources\\images\\"+  Dday + "\\" + SfileCut;
//    	  String filePath2="C:\\Users\\PoPo\\Documents\\kimBoard\\board2\\src\\main\\webapp\\resources\\images\\"+  Dday + "\\" + fileCut2;
    	  
    	  
    	  boolean check = false;
    	  
    	  File deleteFile = new File(filePath);
    	  File deleteFile2 = new File(filePath2);	  
    	  
    	try {

    		log.info("SfileCUT--------" + SfileCut);
    		log.info("DBfileCUT----" + DBfileCut);
    		service.deleteAttach(DBfileCut); //db삭제

    		  if(fileCut2 != "") {
    			  deleteFile2.delete();
    		  }
				    	  if(deleteFile.exists()) {
				    		  deleteFile.delete();		//파일삭제
				    		  log.info("파일삭제완료");
				    		  check = true;
				    	  }else {
				    		  log.info("파일이 없습니다");
				    		  check = false;
				    	  }
		    	}catch(Exception e){
				  e.printStackTrace();
			  }
	    return check == true ? new ResponseEntity<String>(HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);


      } //end 파일삭제
      
      
      //파일 get 뿌려주기
	@GetMapping(value = "/uploadGet")
      public ResponseEntity<ArrayList> fileList(@RequestParam("bno") int bno){
    	  log.info("controller~~!!"+ bno);

    	  ArrayList<Board_AttachDTO> arr = service.fileListGet(bno);
    	  for(int i=0; i< arr.size(); i++) {
    		
    		  log.info(arr.get(i));
    		  log.info("arr fileName----- " + arr.get(i).getFile_Name().replaceAll(" ", "!@#"));
    		  
    	  }
    	  	
    	  return new ResponseEntity<ArrayList>(arr, HttpStatus.OK);
      }
      
      
      
      
      
      
      //썸네일 생성
      private static String getImage(String fileName, String filePath) throws IOException, InterruptedException {
         
         log.info("파일경로 ----" + filePath);
         log.info("uid파일이름----" + fileName);

         double ratio = 5; //이미지 축소비율
         String type = fileName.substring(fileName.lastIndexOf(".") + 1);
         
         if(type.equalsIgnoreCase("png") || type.equalsIgnoreCase("jpg")) {
            
            log.info("이미지파일입니다");
         
         // 저장된 원본파일로부터 BufferedImage 객체를 생성합니다.
            BufferedImage srcImg = ImageIO.read(new File(filePath + "\\" + fileName)); 
           
        	int tWidth = (int) (srcImg.getWidth() / ratio); // 생성할 썸네일이미지의 너비
        	int tHeight = (int) (srcImg.getHeight() / ratio); // 생성할 썸네일이미지의 높이

        	BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
        	Graphics2D graphic = tImage.createGraphics();
        	Image image = srcImg.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
        	graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
        	graphic.dispose(); // 리소스를 모두 해제
        	
          String thumbName = "THUMB_" + fileName; 
          File thumbFile = new File(filePath, thumbName);
          
          //이미지 생성
          ImageIO.write(tImage, type, thumbFile);
          
          Thread.sleep(1500);	//이클립스 동기화때문에 딜레이줌 
          
          return thumbName;
         }

         return null;
      } //end 썸네일메소드
      
      //파일중복명 UUID
      private static String getUUID(String originalName) {
         
        UUID uid = UUID.randomUUID();
        String UUIDFileName = uid.toString() + "_" + originalName;
        
        return UUIDFileName;
      } //end 파일중복명 UUID 메소드
      
      
      //날짜별 폴더생성
      private String days() {
         
            Date dt = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String datefolder =sdf.format(dt).toString();
            log.info(datefolder);

            File dir = new File("D:\\My_Python\\Viprogram\\stock-toy\\stock-toy\\src\\main\\webapp\\resources\\images", datefolder);
            // 폴더가 없으면 생성     
            if(!dir.exists()){
               dir.mkdir();
            }
            
         return datefolder;

      } //end 날짜별폴더생성 메소드
}