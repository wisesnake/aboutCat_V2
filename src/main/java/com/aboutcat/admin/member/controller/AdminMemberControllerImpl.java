package com.aboutcat.admin.member.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.aboutcat.admin.member.service.AdminMemberService;
import com.aboutcat.common.base.BaseController;
import com.aboutcat.member.vo.MemberVO;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberControllerImpl extends BaseController implements AdminMemberController {
	@Autowired
	AdminMemberService adminMemberService;

	@Override
	@RequestMapping(value = "/adminMemberMain.do")
	public String adminMemberMain(@RequestParam Map<String, String> dateMap, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
//		HttpSession session = request.getSession();
//		String uid = (String) session.getAttribute("user_id");
//		if (!uid.equals("admin")) {
//			request.setAttribute("alert_notAdmin", "관리자 권한이 없습니다.");
//			// 메인페이지 header에서 alert_notAdmin이 null이 아닌경우 해당 페이지 alert으로 뜨게끔 코딩하는걸 가정하고 짠 코드.
//			return "main/main.do";
//		}

//		session.setAttribute("menu_mode", "admin_mode");
		String section = dateMap.get("section");
		String pageNum = dateMap.get("pageNum");
		// 쿼리에서 페이징에 맞게 쿼리결과 뽑아오기 위해 넘길 값

		String searchPeriod = dateMap.get("searchPeriod");
		String beginDate = null, endDate = null;

		String tempDate[] = calcSearchPeriod(searchPeriod).split(",");
		beginDate = tempDate[0];
		endDate = tempDate[1];

		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);

		HashMap<String, Object> condMap = new HashMap<String, Object>();

		if (section == null) {
			section = "1";
		}
		condMap.put("section", section);

		if (pageNum == null) {
			pageNum = "1";
		}
		condMap.put("pageNum", pageNum);
		// 최초요청시 = 클라이언트에서 1페이지를 봄
		
		condMap.put("beginDate", beginDate);
		condMap.put("endDate", endDate);
		//비긴데이트 : 2023-07-23(디폴트4개월전) 엔드데이트 : 2023-11-23(오늘)
		String tempBeginDate[] = beginDate.split("-");
		String tempEndDate[] = endDate.split("-");

		model.addAttribute("beginYear",tempBeginDate[0]);
		model.addAttribute("beginMonth",tempBeginDate[1]);
		model.addAttribute("beginDay",tempBeginDate[2]);
		model.addAttribute("endYear",tempEndDate[0]);
		model.addAttribute("endMonth",tempEndDate[1]);
		model.addAttribute("endDay",tempEndDate[2]);
		
		ArrayList<MemberVO> membersList = adminMemberService.listMember(condMap);
		
		System.out.println(membersList);
		
		model.addAttribute("section",section);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("membersList", membersList);

		
		return "/admin/member/adminMemberMain";
	}

	@Override
	@RequestMapping(value = "/memberDetail.do")
	public String memberDetail(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		String member_id = request.getParameter("member_id");
		MemberVO member_info = adminMemberService.memberDetail(member_id);
		model.addAttribute("member_info",member_info);
		System.out.println(member_info);
		return viewName;
	}

	@Override
	@RequestMapping(value="/modifyMemberInfo.do", method={RequestMethod.POST,RequestMethod.GET})
	public void modifyMemberInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap<String,String> memberMap=new HashMap<String,String>();
		String val[]=null;
		PrintWriter pw=response.getWriter();
		String member_id=request.getParameter("member_id");
		String mod_type=request.getParameter("mod_type");
		String value =request.getParameter("value");
		if(mod_type.equals("member_pw")) {
			memberMap.put("member_pw",value);
		}else if(mod_type.contentEquals("member_gender")) {
			memberMap.put("member_gender", value);
		}else if(mod_type.equals("member_birth")){
			val=value.split(",");
			memberMap.put("birth_year",val[0]);
			memberMap.put("birth_month",val[1]);
			memberMap.put("birth_day",val[2]);
			memberMap.put("birth_day_yinyang",val[3]);
		}else if(mod_type.equals("phone")){
			val=value.split(",");
			val[0] = val[0].replace("-", "");
			System.out.println("phone number :" + val[0]);
			memberMap.put("phone",val[0]);
			memberMap.put("sms_valid_check", val[1]);
		}else if(mod_type.equals("email")){
			val=value.split(",");
//			System.out.println("email : " + value);
			memberMap.put("member_email1",val[0]);
			memberMap.put("member_email2",val[1]);
			memberMap.put("email_valid_check", val[2]);
		}else if(mod_type.equals("address")){
			System.out.println("address : " + value);
			val=value.split(",");
			memberMap.put("postcode",val[0]);
			memberMap.put("address1_new",val[1]);
			memberMap.put("address1_old", val[2]);
			memberMap.put("address2", val[3]);
		}
		
		memberMap.put("member_id", member_id);
		adminMemberService.modifyMemberInfo(memberMap);
		pw.print("mod_success");
		pw.close();	
	}

	@RequestMapping(value="/deleteMember.do" ,method={RequestMethod.POST})
	public String deleteMember(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
		HashMap<String,String> memberMap=new HashMap<String,String>();
		String member_id=request.getParameter("member_id");
		String member_deleted=request.getParameter("member_deleted");
		System.out.println(member_deleted);
		memberMap.put("member_deleted", member_deleted);
		memberMap.put("member_id", member_id);
		
		adminMemberService.modifyMemberInfo(memberMap);
		model.addAttribute("deleted", true);
		return "redirect:/admin/member/adminMemberMain.do";
		
	}
	
	

}
