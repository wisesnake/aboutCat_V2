package com.aboutcat.member.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.aboutcat.member.vo.MemberVO;

public interface MemberDAO {
	public MemberVO login(Map loginMap) throws Exception;
	public void insertNewMember(MemberVO memberVO) throws DataAccessException;
	public String selectOverlappedID(String id) throws DataAccessException;
}
