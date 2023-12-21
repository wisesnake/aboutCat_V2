package com.aboutcat.admin.member.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aboutcat.member.vo.MemberVO;

public interface AdminMemberDAO {

	public List<MemberVO> selectAllMembers();

	public ArrayList<MemberVO> searchMemberList(HashMap condMap) throws DataAccessException;
	public MemberVO memberDetail(String member_id) throws DataAccessException;
	public void modifyMemberInfo(HashMap memberMap) throws DataAccessException;

}
