<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/popup.css">
    <script src="${contextPath}/resources/jquery/notice_popup.js"></script>
    
</head>
<body>
    <!-- 이 부분에 페이지의 내용을 넣으세요 -->

  <div class="popup-container" id="popupContainer">
  <div class="popup">
  	<div class="popName"> 공지사항 </div>
  	<hr>
    <div class="popContent">  
    <p>안녕하세요.<br>
    국내 최대 고양이 인터넷 쇼핑몰<br>
    어바웃 캣입니다. <br>
    항상 즐거운 쇼핑 되시길 바랍니다.<br>
    감사합니다.</p>
    </div>
    <hr>
    <label>
      <input type="checkbox" id="noShow" /> 오늘하루 다시뜨지않음
    </label>
    <button onclick="closePopup()">닫기</button>
  </div>
</div>
<div id="ad_main_banner">
	<ul class="bjqs">	 	
	  <li><img width="775" height="145" src="${contextPath}/resources/image/main_banner01.jpg"></li>
		<li><img width="775" height="145" src="${contextPath}/resources/image/main_banner02.jpg" ></li>
		<li><img width="775" height="145" src="${contextPath}/resources/image/main_banner03.jpg" ></li> 
	</ul>
</div>

<div class="main_book">
	<c:set var="goods_count" value="0" />
	<h3>인기상품</h3>
	<c:forEach var="item" items="${goodsMap.bestgoods}">
		<c:set var="goods_count" value="${goods_count+1 }" />
		<div class="book">
			<a
				href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
				<%-- <img class="link"  src="${contextPath}/resources/image/1px.gif"> --%>

				<img width="121" height="154"
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_image_fileName}">

				<div class="title">${item.goods_name }</div>
				<div class="price">
				<span><s> <fmt:formatNumber
									value="${item.goods_price}" type="number" var="goods_price" />
								${goods_price}원
						</s></span><br>
					<span style="font-weight: bold; color: red;"> <fmt:formatNumber
								value="${item.goods_sell_price}" type="number"
								var="discounted_price" /> ${discounted_price}원 <br> <c:set
								var="discount_rate"
								value="${100 - (item.goods_sell_price / item.goods_price) * 100 }" />
							<c:set var="formatted_discount_rate" value="${discount_rate}" />
							(${formatted_discount_rate.intValue()}%할인)
					</span>
				</div>
		</div>
		</a>
		<c:if test="${goods_count==15   }">
			<div class="book">
				<font size=20> <a href="#">more</a></font>
			</div>
		</c:if>
	</c:forEach>
</div>
<div class="clear"></div>
<div id="ad_sub_banner">
	<img width="770" height="117"
		src="${contextPath}/resources/image/sub_banner01.jpg">
</div>




<div class="main_book">
	<c:set var="goods_count" value="0" />
	<h3>신상품</h3>
	<c:forEach var="item" items="${goodsMap.newgoods }">
		<c:set var="goods_count" value="${goods_count+1 }" />
		<div class="book">
			<a
				href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
				<%-- <img class="link"  src="${contextPath}/resources/image/1px.gif">  --%>

				<img width="121" height="154"
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_image_fileName}">
				<div class="title">${item.goods_name }</div>
				<div class="price">
				<span> <fmt:formatNumber
									value="${item.goods_price}" type="number" var="goods_price" />
								${goods_price}원
						</span><br>
					<span style="font-weight: bold; color: red;"> <fmt:formatNumber
								value="${item.goods_sell_price}" type="number"
								var="discounted_price" /> ${discounted_price}원 <br> <c:set
								var="discount_rate"
								value="${100 - (item.goods_sell_price / item.goods_price) * 100 }" />
							<c:set var="formatted_discount_rate" value="${discount_rate}" />
							(${formatted_discount_rate.intValue()}%할인)
					</span>
				</div>
		</div>
		</a>
		<c:if test="${goods_count==15   }">
			<div class="book">
				<font size=20> <a href="#">more</a></font>
			</div>
		</c:if>
	</c:forEach>
</div>

<div class="clear"></div>
<div id="ad_sub_banner">
	<img width="770" height="117"
		src="${contextPath}/resources/image/sub_banner02.jpg">
</div>


<div class="main_book">
	<c:set var="goods_count" value="0" />
	<h3>추천상품</h3>
	<c:forEach var="item" items="${goodsMap.recommendgoods }">
		<c:set var="goods_count" value="${goods_count+1 }" />
		<div class="book">
			<a
				href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
				<%-- <img class="link"  src="${contextPath}/resources/image/1px.gif"> --%>

				<img width="121" height="154"
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_image_fileName}">
				<div class="title">${item.goods_name }</div>
				<div class="price">
				<span><fmt:formatNumber
									value="${item.goods_price}" type="number" var="goods_price" />
								${goods_price}원
						</span><br>
					<span style="font-weight: bold; color: red;"> <fmt:formatNumber
								value="${item.goods_sell_price}" type="number"
								var="discounted_price" /> ${discounted_price}원 <br> <c:set
								var="discount_rate"
								value="${100 - (item.goods_sell_price / item.goods_price) * 100 }" />
							<c:set var="formatted_discount_rate" value="${discount_rate}" />
							(${formatted_discount_rate.intValue()}%할인)
					</span>
				</div>
		</div>
		</a>
		<c:if test="${goods_count==15   }">
			<div class="book">
				<font size=20> <a href="#">more</a></font>
			</div>
		</c:if>
	</c:forEach>
</div>

</body>
</html>
