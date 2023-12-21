package com.aboutcat.admin.order.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.aboutcat.order.vo.OrderVO;

public interface AdminOrderService {
	
	public ArrayList<OrderVO> selectOrderList(Map<String, Object> condMap);

	public void changeDeliveryState(Map orderMap);

	public Map<String,Object> selectOrderDetail(int order_id);
}
