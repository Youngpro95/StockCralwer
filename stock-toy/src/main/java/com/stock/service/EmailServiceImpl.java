package com.stock.service;
 
import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
 
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.stock.domain.EmailDTO;
 
@Service // 서비스 빈으로 등록
public class EmailServiceImpl implements EmailService {
 
    @Inject
    JavaMailSender mailSender; // root-context.xml에 설정한 bean, 의존성을 주입
 
    @Override
    public void sendMail(EmailDTO dto) {
        try {
            // 이메일 객체
            MimeMessage msg = mailSender.createMimeMessage();
            msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
            msg.addFrom(new InternetAddress[] { new InternetAddress(dto.getSenderMail(), dto.getSenderName()) });

            msg.setSubject(dto.getSubject(), "utf-8");
            msg.setText(dto.getMessage(), "utf-8");

            mailSender.send(msg);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
