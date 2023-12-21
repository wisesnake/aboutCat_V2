package com.aboutcat.admin.order.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.aboutcat.member.vo.MemberVO;
import com.aboutcat.order.vo.OrderVO;

public interface AdminOrderDAO {
	public List<OrderVO> selectOrderList(Map<String,Object> condMap);

	public void changeDeleveryState(Map orderMap);
	
	public ArrayList<OrderVO> selectOrderDetail(int order_id);
	
	public MemberVO selectOrdererInfo(String member_id);
	

}
