package com.stock.service;

import com.stock.domain.EmailDTO;

public interface EmailService {
    public void sendMail(EmailDTO dto);
}