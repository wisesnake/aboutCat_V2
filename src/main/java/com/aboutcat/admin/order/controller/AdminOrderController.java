package com.aboutcat.admin.order.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

public interface AdminOrderController {
	public String adminOrderMain(@RequestParam Map<String,String> dateMap, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception;

	public ResponseEntity modifyDeliveryState(Map<String, String> mappedData, HttpServletRequest request, HttpServletResponse response,
			Model model) throws Exception;

	public String getOrderDetail(int order_id,Model model);
}
