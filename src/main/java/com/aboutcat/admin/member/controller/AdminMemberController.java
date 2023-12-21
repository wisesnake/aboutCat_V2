package com.aboutcat.admin.member.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aboutcat.admin.member.service.AdminMemberService;
import com.aboutcat.member.vo.MemberVO;

import lombok.extern.log4j.Log4j2;



public interface AdminMemberController {
	

	public String adminMemberMain(Map<String, String> params, HttpServletRequest request, HttpServletResponse response,	Model model) throws Exception;
	public String memberDetail(HttpServletRequest request, HttpServletResponse response,Model model)  throws Exception;
	public void modifyMemberInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public String deleteMember(HttpServletRequest request, HttpServletResponse response,Model model)  throws Exception;
}
