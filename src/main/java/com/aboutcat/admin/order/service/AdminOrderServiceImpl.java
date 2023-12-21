package com.aboutcat.admin.order.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutcat.admin.order.dao.AdminOrderDAO;
import com.aboutcat.member.vo.MemberVO;
import com.aboutcat.order.vo.OrderVO;

@Service("adminOrderService")
public class AdminOrderServiceImpl implements AdminOrderService{

	@Autowired
	private AdminOrderDAO adminOrderDAO;

	@Override
	public ArrayList<OrderVO> selectOrderList(Map<String, Object> condMap) {
		ArrayList<OrderVO> orderList = (ArrayList<OrderVO>)adminOrderDAO.selectOrderList(condMap);
		return orderList;
	}
	
	@Override
	public void changeDeliveryState(Map orderMap) {
		adminOrderDAO.changeDeleveryState(orderMap);
	}
	
	@Override
	public Map<String,Object> selectOrderDetail(int order_id){
		Map<String,Object> orderMap = new HashMap<String,Object>();
		
		ArrayList<OrderVO> orderList = adminOrderDAO.selectOrderDetail(order_id);
		OrderVO deliveryInfo = orderList.get(0);
		String member_id = deliveryInfo.getMember_id();
		MemberVO orderer = adminOrderDAO.selectOrdererInfo(member_id);
		orderMap.put("orderList", orderList);
		orderMap.put("orderer", orderer);
		orderMap.put("deliveryInfo",deliveryInfo);
		return orderMap;
	}
	
	
	//selectOrderDetail selectOrdererInfo
}
