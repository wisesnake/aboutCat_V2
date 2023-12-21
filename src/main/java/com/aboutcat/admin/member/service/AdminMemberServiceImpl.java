package com.aboutcat.admin.member.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutcat.admin.member.dao.AdminMemberDAO;
import com.aboutcat.member.vo.MemberVO;


@Service
public class AdminMemberServiceImpl implements AdminMemberService{
	@Autowired
	AdminMemberDAO adminMemberDAO;



	public ArrayList<MemberVO> listMember(HashMap condMap) throws Exception {
		ArrayList<MemberVO> memberList = adminMemberDAO.searchMemberList(condMap);
		System.out.println(memberList);
		return memberList;
	}



	public MemberVO memberDetail(String member_id) throws Exception {
		MemberVO member_info = adminMemberDAO.memberDetail(member_id);
		return member_info;
	}


	
	public void  modifyMemberInfo(HashMap memberMap) throws Exception{
		 String member_id=(String)memberMap.get("member_id");
		 adminMemberDAO.modifyMemberInfo(memberMap);
	}

}
