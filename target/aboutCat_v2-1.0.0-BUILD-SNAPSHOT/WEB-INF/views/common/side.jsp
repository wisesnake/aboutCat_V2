<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<nav>
	<ul>
		<c:choose>
			<c:when test="${side_menu=='admin_mode' }">
				<li>
					<H3>주요기능</H3>
					<ul>
						<li><a href="${contextPath}/admin/goods/adminGoodsMain.do">상품관리</a></li>
						<li><a href="${contextPath}/admin/order/adminOrderMain.do">주문관리</a></li>
						<li><a href="${contextPath}/admin/member/adminMemberMain.do">회원관리</a></li>
						<li><a href="#">배송관리</a></li>
						<li><a href="#">게시판관리</a></li>
					</ul>
				</li>
			</c:when>
			<c:when test="${side_menu=='my_page' }">
				<li>
					<h3>주문내역</h3>
					<ul>
						<li><a href="${contextPath}/mypage/listMyOrderHistory.do">주문내역/배송
								조회</a></li>
						<li><a href="#">반품/교환 신청 및 조회</a></li>
						<li><a href="#">취소 주문 내역</a></li>
						<li><a href="#">세금 계산서</a></li>
					</ul>
				</li>
				<li>
					<h3>정보내역</h3>
					<ul>
						<li><a href="${contextPath}/mypage/myDetailInfo.do">회원정보관리</a></li>
						<li><a href="#">나의 주소록</a></li>
						<li><a href="#">개인정보 동의내역</a></li>
						<li><a href="#">회원탈퇴</a></li>
					</ul>
				</li>
			</c:when>
			<c:otherwise>
				<li>
					<h3>카테고리</h3>
					<ul>
						<li><a href="${contextPath}/goods/keyword.do?keyword=food">사료</a></li>
						<li><a href="${contextPath}/goods/keyword.do?keyword=snack">간식</a></li>
						<li><a href="${contextPath}/goods/keyword.do?keyword=toilet">화장실</a></li>
						<li><a href="${contextPath}/goods/keyword.do?keyword=tower">스크래쳐/캣타워</a></li>
						<li><a href="${contextPath}/goods/keyword.do?keyword=toy">장난감</a></li>
						<li><a href="${contextPath}/goods/keyword.do?keyword=carrier">이동장</a></li>
					</ul>
				</li>

			</c:otherwise>
		</c:choose>
	</ul>
</nav>
<div class="clear"></div>

<DIV id="notice">
	<H2>공지사항</H2>
	<UL>

		<c:forEach var="i" begin="1" end="5" step="1">
			<li><a href="#">공지사항입니다.${ i}</a></li>
		</c:forEach>
	</ul>
</div>


<div id="banner">
	<a href="#"><img width="190" height="104"
		src="${contextPath}/resources/image/call_center_logo.jpg"></a>
</div>

</html>