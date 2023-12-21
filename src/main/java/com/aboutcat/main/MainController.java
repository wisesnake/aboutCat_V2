package com.aboutcat.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.aboutcat.common.base.BaseController;
import com.aboutcat.goods.service.GoodsService;
import com.aboutcat.goods.vo.GoodsVO;
import com.aboutcat.member.vo.MemberVO;

@Controller("mainController")
@EnableAspectJAutoProxy
public class MainController extends BaseController {

	@Autowired
	private GoodsService goodsService;

	@RequestMapping(value = "/main/main.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {

		MemberVO memberVO = new MemberVO();
//	      memberVO.setMember_id("admin");
//	      HttpSession session= request.getSession();
//	      session=request.getSession();
//	        session.setAttribute("isLogOn", true);
//	        session.setAttribute("memberInfo",memberVO);
		HttpSession session = request.getSession();
		session = request.getSession();
		session.setAttribute("side_menu", "main_menu");

		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		mav.setViewName(viewName);

		Map<String, List<GoodsVO>> goodsMap = goodsService.listGoods();
		mav.addObject("goodsMap", goodsMap);

		return mav;
	}
}
