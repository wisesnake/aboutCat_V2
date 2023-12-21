<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />

<script type="text/javascript">
	var loopSearch=true;
	function keywordSearch(){
		if(loopSearch==false)
			return;
	 var value=document.frmSearch.searchWord.value;
	 //frmSearch 검색어 입력 폼의 searchWord input 의 value 를 value 초기화(한마디로 검색키워드 입력한거)
		$.ajax({
			type : "get",
			async : true, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/goods/keywordSearch.do", // keywordSearch.do 로 data를 json형태로 전달함.
			data : {keyword:value}, // keywordSearch.do 컨트롤러에 전달되는 데이타는 keyword라는 key를 지닌 js변수의 값(검색키워드)임.
			success : function(data, textStatus) { // 해당 전송이 특별한 예외 없이 성공할 경우, 반환받은 json형태의 결과를 data라는 매개변수로 활용
			    var jsonInfo = JSON.parse(data);
				
				console.log("jsoninfo에는무엇이담겨있을까 : "  + jsonInfo);
				displayResult(jsonInfo);
				//서블릿과 통신이 성공했을 경우, 서블릿이 돌려준 결과를 json으로 파싱한 후, 매개인수로써 사용하여 displayResult 메소드를 호출함.
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다."+data);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
			}
		}); //end ajax	
	}
	
	function displayResult(jsonInfo){
		//위의 keywordSearch 의 ajax 통신(검색창에 입력한 문자열을 spring servlet에 보내서, controller service dao sql 이 검색하여 나온 결과물을 받아왔을경우)
		//이 성공했을 경우, json으로 파싱된 검색결과를 매개인수로 호출되는 메소드.
		var count = jsonInfo.keyword.length;
		if(count > 0) {
		    var html = '';
		    for(var i in jsonInfo.keyword){
			   html += "<a href=\"javascript:select('"+jsonInfo.keyword[i].goods_name+"')\">"+jsonInfo.keyword[i].goods_name+"</a><br/>";
		    }
		    var listView = document.getElementById("suggestList");
		    listView.innerHTML = html;
		    show('suggest');
		}else{
		    hide('suggest');
		} 
	}
	
	function select(selectedKeyword) {
		 document.frmSearch.searchWord.value=selectedKeyword;
		 loopSearch = false;
		 hide('suggest');
	}
		
	function show(elementId) {
		 var element = document.getElementById(elementId);
		 if(element) {
		  element.style.display = 'block';
		 }
		}
	
	function hide(elementId){
	   var element = document.getElementById(elementId);
	   if(element){
		  element.style.display = 'none';
	   }
	}

</script>
<body>
	<div id="logo">
	<a href="${contextPath}/main/main.do">
		<img width="200"  alt="aboutcat" src="${contextPath}/resources/image/Booktopia_Logo0.jpg">
		</a>
	</div>
	<div id="head_link">
		<ul>
		   <c:choose>
		     <c:when test="${isLogOn==true and not empty memberInfo }">
			   <li><a href="${contextPath}/member/logout.do">로그아웃</a></li>
			   <li><a href="${contextPath}/mypage/myPageMain.do">마이페이지</a></li>
			   <li><a href="${contextPath}/cart/myCartList.do">장바구니</a></li>
			 </c:when>
			 <c:otherwise>
			   <li><a href="${contextPath}/member/loginForm.do">로그인</a></li>
			   <li><a href="${contextPath}/member/memberForm.do">회원가입</a></li> 
			 </c:otherwise>
			</c:choose>
			   
      <c:if test="${isLogOn==true and memberInfo.member_id =='admin' }">  
	   	   <li class="no_line"><a href="${contextPath}/admin/goods/adminGoodsMain.do">관리자</a></li>
	    </c:if>
			  
		</ul>
	</div>
	<br>
	<div id="search" >
		<form name="frmSearch" action="${contextPath}/goods/searchGoods.do" >
			<input name="searchWord" class="main_input" type="text"  onKeyUp="keywordSearch()"> 
			<!-- <input type="submit" name="search" class="btn1"  value="검 색" > -->
			<input type="image" name="search" class="btn1" src="${contextPath}/resources/image/searchBtn.png" >
		</form>
	</div>
   <div id="suggest">
        <div id="suggestList"></div>
   </div>
</body>
</html>