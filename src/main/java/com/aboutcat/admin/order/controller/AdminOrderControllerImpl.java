package com.aboutcat.admin.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.aboutcat.admin.order.service.AdminOrderService;
import com.aboutcat.common.base.BaseController;
import com.aboutcat.order.vo.OrderVO;

@Controller("adminOrderController")
@RequestMapping("/admin/order")
public class AdminOrderControllerImpl extends BaseController implements AdminOrderController {

	@Autowired
	private AdminOrderService adminOrderService;

	@Override
	@RequestMapping(value = "/adminOrderMain.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String adminOrderMain(@RequestParam Map<String, String> dateMap, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		String viewName = (String) request.getAttribute("viewName");

		String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
		String section = dateMap.get("section");
		String pageNum = dateMap.get("pageNum");
		String beginDate = dateMap.get("beginDate");
		String endDate = dateMap.get("endDate");

		if (beginDate == null && endDate == null) {
			String tempDate[] = calcSearchPeriod(fixedSearchPeriod).split(",");
			beginDate = tempDate[0];
			endDate = tempDate[1];
		}
		System.out.println(beginDate);
		System.out.println(endDate);
		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);

		HashMap<String, Object> condMap = new HashMap<String, Object>();
		condMap.put("beginDate", beginDate);
		condMap.put("endDate", endDate);

		if (section == null) {
			section = "1";
		}
		condMap.put("section", section);

		if (pageNum == null) {
			pageNum = "1";
		}
		condMap.put("pageNum", pageNum);

		String beginDate1[] = beginDate.split("-");
		String endDate2[] = endDate.split("-");
		model.addAttribute("beginYear", beginDate1[0]);
		model.addAttribute("beginMonth", beginDate1[1]);
		model.addAttribute("beginDay", beginDate1[2]);
		model.addAttribute("endYear", endDate2[0]);
		model.addAttribute("endMonth", endDate2[1]);
		model.addAttribute("endDay", endDate2[2]);

		ArrayList<OrderVO> orderList = adminOrderService.selectOrderList(condMap);
		model.addAttribute("section", section);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("orderList", orderList);

		return viewName;
	}

	@Override
	@RequestMapping(value = "/modifyDeliveryState.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity modifyDeliveryState(@RequestParam Map<String, String> mappedData, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		String order_id = mappedData.get("order_id");
		String delivery_state = mappedData.get("delivery_state");
		System.out.println(order_id +" 의 배송상태를 변경합니다 : "+delivery_state);
		
		HashMap<String,Object> orderMap = new HashMap<String,Object>();
		orderMap.put("order_id",order_id);
		orderMap.put("delivery_state",delivery_state);
		adminOrderService.changeDeliveryState(orderMap);
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		message  = "mod_success";
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;

	}
	
	
	@Override
	@RequestMapping(value = "/orderDetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String getOrderDetail(int order_id,Model model){
		Map<String,Object> orderMap = adminOrderService.selectOrderDetail(order_id);
		model.addAttribute("orderMap",orderMap);
		//resultMap 에는 주문정보를 담은 orderVO, 그리고 주문자정보를 담음 memberVO 가 그대로 매핑되어서 담겨있음
		
		return "/admin/order/adminOrderDetail";	
	}
}
