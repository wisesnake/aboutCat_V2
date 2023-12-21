package com.aboutcat.admin.order.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.aboutcat.member.vo.MemberVO;
import com.aboutcat.order.vo.OrderVO;

@Repository("adminOrderDAO")
public class AdminOrderDAOImpl implements AdminOrderDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<OrderVO> selectOrderList(Map<String,Object> condMap) {
	List<OrderVO> orderList = new ArrayList<OrderVO>();
		orderList = sqlSession.selectList("mapper.admin.order.selectNewOrderList",condMap);
		return orderList;
	}
	
	@Override
	public void changeDeleveryState(Map orderMap) {
		sqlSession.selectList("mapper.admin.order.changeDeliveryState", orderMap);
	}
	
	@Override
	public ArrayList<OrderVO> selectOrderDetail(int order_id){
		ArrayList<OrderVO> orderList = (ArrayList) sqlSession.selectList("mapper.admin.order.selectOrderDetail",order_id);
		return orderList;
	}

	@Override
	public MemberVO selectOrdererInfo(String member_id){
		MemberVO memberVO = sqlSession.selectOne("mapper.admin.order.selectOrdererInfo",member_id);
		return memberVO;
	}

	
	
	
}
