<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>

<meta charset="utf-8">
<head>
<script type="text/javascript">
	var cnt = 0;
	function fn_addFile() {
		if (cnt == 0) {
			$("#d_file")
					.append(
							"<br>"
									+ "<input  type='file' name='main_image' id='f_main_image' />");
		} else {
			$("#d_file")
					.append(
							"<br>"
									+ "<input  type='file' name='detail_image"+cnt+"' />");
		}

		cnt++;
	}

	function fn_add_new_goods(obj) {
		fileName = $('#f_main_image').val();
		if (fileName != null && fileName != undefined) {
			obj.submit();
		} else {
			alert("메인 이미지는 반드시 첨부해야 합니다.");
			return;
		}

	}
</script>
</head>

<BODY>
	<form action="${contextPath}/admin/goods/addNewGoods.do" method="post"
		enctype="multipart/form-data">
		<h1>상품 등록</h1>
		<div class="tab_container">
			<!-- 내용 들어 가는 곳 -->
			<div class="tab_container" id="container">
				<ul class="tabs">
					<li><a href="#tab1">상품정보</a></li>
					<!-- <li><a href="#tab2">상품목차</a></li>
			<li><a href="#tab3">상품저자소개</a></li> -->
					<li><a href="#tab4">상품소개</a></li>
					<!-- <li><a href="#tab5">출판사 상품 평가</a></li>
			<li><a href="#tab6">추천사</a></li> -->
					<li><a href="#tab7">상품이미지</a></li>
				</ul>
				<div class="tab_container">
					<div class="tab_content" id="tab1">
						<table>
							<tr>
								<td width=200>제품분류</td>
								<td width=500><select name="goods_keyword">
										<option value="food" selected>사료
										<option value="snack">간식
										<option value="toilet">화장실
										<option value="tower">스크래쳐/캣타워
										<option value="toy">장난감
										<option value="carrier">이동장
								</select></td>
							</tr>
							<tr>
								<td>제품이름</td>
								<td><input name="goods_name" type="text" size="40" /></td>
							</tr>
							<td>제품브랜드</td>
							<td><input name="goods_brand" type="text" size="40" /></td>
							</tr>
							<tr>
								<td>제품정가</td>
								<td><input name="goods_price" type="number" size="40" /></td>
							</tr>
							<tr>
								<td>제품판매가</td>
								<td><input name="goods_sell_price" type="number" size="40" /></td>
							</tr>
							<tr>
								<td>제품종류</td>
								<td><select name="goods_status">
										<option value="bestgoods">인기상품</option>
										<option value="newgoods" selected>신상품</option>
										<option value="recommendgoods">추천상품</option>
										<option value="on_sale">판매중</option>
										<option value="buy_out">품절</option>
								</select></td>
							</tr>
							<tr>
								<td><br></td>
							</tr>
						</table>
					</div>
					<div class="tab_content" id="tab4">
						<H4>제품소개</H4>
						<table>
							<tr>
								<td>제품소개</td>
								<td><textarea rows="100" cols="80" name="goods_description"></textarea></td>
							</tr>
						</table>
					</div>

					<div class="tab_content" id="tab7">
						<h4>상품이미지</h4>
						<table>
							<tr>
								<td align="right">이미지파일 첨부</td>

								<td align="left"><input type="button" value="파일 추가"
									onClick="fn_addFile()" /></td>
								<td>
									<div id="d_file"></div>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<div class="clear"></div>
			<center>
				<table>
					<tr>
						<td align=center><input type="button" value="상품 등록하기"
							onClick="fn_add_new_goods(this.form)"></td>
					</tr>
				</table>
			</center>
		</div>
	</form>