package com.aboutcat.admin.member.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.aboutcat.member.vo.MemberVO;

@Repository
public class AdminMemberDAOImpl implements AdminMemberDAO{

	
	@Autowired
	SqlSession sqlSession;
	
	
	
	public List<MemberVO> selectAllMembers() {
		List<MemberVO> membersList = sqlSession.selectList("mapper.admin.member.selectMembersListAll");
		return membersList;
	}



	public ArrayList<MemberVO> searchMemberList(HashMap condMap) throws DataAccessException{
		System.out.println("endDate : " + condMap.get("endDate").toString()+"  beginDate :   " + condMap.get("beginDate").toString());
		ArrayList<MemberVO> membersList = (ArrayList)sqlSession.selectList("mapper.admin.member.searchMembersList", condMap);
		return membersList;
	}



	public MemberVO memberDetail(String member_id) throws DataAccessException{
		MemberVO member_info = sqlSession.selectOne("mapper.admin.member.memberDetail",member_id);
		return member_info;
	}
	
	public void modifyMemberInfo(HashMap memberMap) throws DataAccessException{
		sqlSession.update("mapper.admin.member.modifyMemberInfo",memberMap);
	}
}
