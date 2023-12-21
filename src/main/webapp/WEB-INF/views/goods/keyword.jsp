<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.lang.Math" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	//치환 변수 선언합니다.
	pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
	pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<head>
<title>키워드(keyword)</title>
<script>
		function fn_order_each_goods(goods_id, goods_name, goods_sell_price,
									 goods_image_fileName) {
			var _isLogOn = document.getElementById("isLogOn");
			var isLogOn = _isLogOn.value;

			if (isLogOn == "false" || isLogOn == '') {
				alert("로그인 후 주문이 가능합니다!!!");
			}

			var total_price, final_total_price;

			var formObj = document.createElement("form");
			var i_goods_id = document.createElement("input");
			var i_goods_name = document.createElement("input");
			var i_goods_sell_price = document.createElement("input");
			var i_goods_image_fileName = document.createElement("input");
			var i_order_goods_qty = document.createElement("input");;


			i_goods_id.name = "goods_id";
			i_goods_name.name = "goods_name";
			i_goods_sell_price.name = "goods_sell_price";
			i_goods_image_fileName.name = "goods_image_fileName";
			i_order_goods_qty.name = "order_goods_qty";

			i_goods_id.value = goods_id;
			i_order_goods_qty.value = 1;
			i_goods_name.value = goods_name;
			i_goods_sell_price.value = goods_sell_price;
			i_goods_image_fileName.value = goods_image_fileName;

			formObj.appendChild(i_goods_id);
			formObj.appendChild(i_goods_name);
			formObj.appendChild(i_goods_sell_price);
			formObj.appendChild(i_goods_image_fileName);
			formObj.appendChild(i_order_goods_qty);

			document.body.appendChild(formObj);
			formObj.method = "post";
			formObj.action = "${contextPath}/order/orderEachGoods.do";
			formObj.submit();

		}
		function add_cart(goods_id) {

			if (!${isLogOn eq true}) {
				alert("로그인 후 이용 가능합니다.");
				return;
			}
			$.ajax({
				type: "post",
				async: false, //false인 경우 동기식으로 처리한다.
				url: "${contextPath}/cart/addGoodsInCart.do",
				data: {
					goods_id: goods_id,
					cart_goods_qty: 1
				},
				success: function (data, textStatus) {
					//alert(data);
					//	$('#message').append(data);
					if (data.trim() == 'add_success') {
						alert("상품을 장바구니에 추가하였습니다.");
					} else if (data.trim() == 'already_existed') {
						alert("이미 카트에 등록된 상품입니다.");
					}

				},
				error: function (data, textStatus) {
					alert("에러가 발생했습니다." + data);
				},
				complete: function (data, textStatus) {
					//alert("작업을완료 했습니다");
				}
			}); //end ajax
		}
	</script>

</head>
<body>

	<section id="new_book">
		<h3>새로나온 책</h3>
		<div id="left_scroll">
			<a href='javascript:slide("left");'><img
				src="${contextPath}/resources/image/left.gif"></a>
		</div>
		<div id="carousel_inner">
			<ul id="carousel_ul">
				<c:choose>
					<c:when test="${ List.goods_status eq 'newgoods'  }">
						<li>
							<div id="book">
								<a><h1>새로운 상품이 제품이없습니다.</h1></a>
							</div>
						</li>
					</c:when>
					<c:otherwise>
						<c:forEach var="item" items="${list}">
							<c:if test="${item.goods_status eq 'newgoods'}">
								<li>새로운 상품
									<div id="book">
										<a
											href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
											<img width="75" alt=""
											src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_image_fileName}">
										</a>
										<%-- 				<div class="title">${item.goods_name}</div> --%>
										<div class="title">
											<a
												href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
												${item.goods_name} </a>
										</div>
										<div class="price">
											<span> <fmt:formatNumber value="${item.goods_price}"
													type="number" var="goods_price" /> ${goods_price}원
											</span> <br>
											<fmt:formatNumber
								value="${item.goods_sell_price}" type="number"
								var="discounted_price" /> ${discounted_price}원<c:set var="discount_rate"
							value="${100 - (item.goods_sell_price / item.goods_price) * 100 }" />
						<c:set var="formatted_discount_rate" value="${discount_rate}" />
						(${formatted_discount_rate.intValue()}%할인)
										</div>
									</div>
								</li>
							</c:if>
						</c:forEach>
						<li></li>
					</c:otherwise>
				</c:choose>

			</ul>
		</div>
		<div id="right_scroll">
			<a href='javascript:slide("right");'><img
				src="${contextPath}/resources/image/right.gif"></a>
		</div>
		<input id="hidden_auto_slide_seconds" type="hidden" value="0">

		<div class="clear"></div>
	</section>
	<div class="clear"></div>

	<table id="list_view">
		<tbody>
			<c:forEach var="item" items="${list}">
				<tr>
					<td class="goods_image"><a
						href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
							<img width="75" alt=""
							src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_image_fileName}">
					</a></td>
					<td class="goods_description">
						<h2>
							<a
								href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_name}</a>
					</td>
					
					<td class="price"><span>${item.goods_price }원</span><br>
						<strong> <fmt:formatNumber
								value="${item.goods_sell_price}" type="number"
								var="discounted_price" /> ${discounted_price}원
					</strong><br> <c:set var="discount_rate"
							value="${100 - (item.goods_sell_price / item.goods_price) * 100 }" />
						<c:set var="formatted_discount_rate" value="${discount_rate}" />
						(${formatted_discount_rate.intValue()}%할인)</td>
						
					<td class="buy_btns">
						<UL>
							<li><a href="javascript:add_cart('${item.goods_id}')">장바구니</a></li>
							<li><a
								href="javascript:fn_order_each_goods('${item.goods_id }','${item.goods_name }','${ item.goods_sell_price}','${item.goods_image_fileName}')">구매하기</a></li>
						</UL>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="clear"></div>
	<div id="page_wrap">
		<ul id="page_control">
		    <%
           Object countObj = request.getAttribute("keywordcount");
           int count1 = (countObj instanceof Integer) ? (Integer) countObj : 0;
    int roundedPageCount = (int) Math.ceil((double) count1 / 10);
    pageContext.setAttribute("roundedPageCount", roundedPageCount);
%>
<!-- 			<li><a class="no_border" href="#">Prev</a></li> -->
			<c:set var="page_num" value="0" />
			<c:forEach var="count" begin="1" end="${(keywordcount+9) /10 }" step="1">
				<c:choose>
					<c:when test="${count==1 }">
						<li><a class="page_contrl_active" href="#">${count+page_num*10 }</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="#">${count+page_num*10 }</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
<!-- 			<li><a class="no_border" href="#">Next</a></li> -->
		</ul>
	</div>

	<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}" />