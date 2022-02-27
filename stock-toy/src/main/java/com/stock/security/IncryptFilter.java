package com.stock.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

@WebFilter("*.me") //뒤에 .me가 되는 페이지에 전달되는 정보가 필터 적용
public class IncryptFilter implements Filter {

    public IncryptFilter() {
        System.out.println("나도 객체 생성!!");
    }
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
	    // ServletRequest - 부모 / HttpServletRequest - 자식 관계
        HttpServletRequest hRequest = (HttpServletRequest)request;
       
        LoginWrapper lw = new LoginWrapper(hRequest);
       
       
       
        chain.doFilter(lw, response);

	}


}
