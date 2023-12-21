<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="myCartList" value="${cartMap.myCartList}"/>
<c:set var="myGoodsList" value="${cartMap.myGoodsList}"/>

<c:set var="totalGoodsNum" value="0"/>
<!--주문 개수 -->
<c:set var="totalDeliveryPrice" value="2500"/>

<!-- 총 배송비 -->
<c:set var="totalDiscountedPrice" value="0"/>
<!-- 총 할인금액 -->
<head>
    <script type="text/javascript">
        function calcGoodsPrice(goodsprice, obj) {
            var totalPrice, final_total_price, totalNum;
            var goods_qty = document.getElementById("select_goods_qty");
            //alert("총 상품금액"+goods_qty.value);
            var p_totalNum = document.getElementById("p_totalNum");
            var p_totalPrice = document.getElementById("p_totalPrice");
            var p_final_totalPrice = document.getElementById("p_final_totalPrice");
            var h_totalNum = document.getElementById("h_totalNum");
            var h_totalPrice = document.getElementById("h_totalPrice");
            var h_totalDelivery = document.getElementById("h_totalDelivery");
            var h_final_total_price = document.getElementById("h_final_totalPrice");
            if (obj.checked == true) {
                //	alert("체크 했음")

                totalNum = Number(h_totalNum.value) + Number(goods_qty.value);
                //alert("totalNum:"+totalNum);
                totalPrice = Number(h_totalPrice.value)
                    + Number(goods_qty.value * goodsprice);
                //alert("totalPrice:"+totalPrice);
                final_total_price = totalPrice + Number(h_totalDelivery.value);
                //alert("final_total_price:"+final_total_price);
            } else {
                //	alert("h_totalNum.value:"+h_totalNum.value);
                totalNum = Number(h_totalNum.value) - Number(goods_qty.value);
                //	alert("totalNum:"+ totalNum);
                totalPrice = Number(h_totalPrice.value) - Number(goods_qty.value)
                    * goodsprice;
                //	alert("totalPrice="+totalPrice);
                final_total_price = totalPrice - Number(h_totalDelivery.value);
                //	alert("final_total_price:"+final_total_price);
            }

            h_totalNum.value = totalNum;

            h_totalPrice.value = totalPrice;
            h_final_total_price.value = final_total_price;

            p_totalNum.innerHTML = totalNum;
            p_totalPrice.innerHTML = totalPrice;
            p_final_totalPrice.innerHTML = final_total_price;
        }

        function modify_cart_qty(goods_id, goodsprice, index) {
            //alert(index);
            var total_sales_price = $
            {
                total_sales_price
            }
            +"원";
            var length = document.frm_order_all_cart.cart_goods_qty.length;
            var _cart_goods_qty = 0;
            if (length > 1) { //카트에 제품이 한개인 경우와 여러개인 경우 나누어서 처리한다.
                _cart_goods_qty = document.frm_order_all_cart.cart_goods_qty[index].value;
            } else {
                _cart_goods_qty = document.frm_order_all_cart.cart_goods_qty.value;
            }

            var cart_goods_qty = Number(_cart_goods_qty);
            //alert("cart_goods_qty:"+cart_goods_qty);
            console.log(goods_id + " : " + cart_goods_qty);
            $.ajax({
                type: "post",
                async: false, //false인 경우 동기식으로 처리한다.
                url: "${contextPath}/cart/modifyCartQty.do",
                data: {
                    goods_id: goods_id,
                    cart_goods_qty: cart_goods_qty
                },

                success: function (data, textStatus) {
                    //alert(data);
                    if (data.trim() == 'modify_success') {
                        alert("수량을 변경했습니다!!");
                        window.location.href = window.location.href;
                    } else {
                        alert("다시 시도해 주세요!!");
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

        function delete_cart_goods(cart_id) {
            var cart_id = Number(cart_id);
            var formObj = document.createElement("form");
            var i_cart = document.createElement("input");
            i_cart.name = "cart_id";
            i_cart.value = cart_id;

            formObj.appendChild(i_cart);
            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${contextPath}/cart/removeCartGoods.do";
            formObj.submit();
        }

        function fn_order_each_goods(goods_id, goods_name, goods_price,
                                     goods_image_fileName) {
            var total_price, final_total_price, _goods_qty;
            var cart_goods_qty = document.getElementById("cart_goods_qty");

            _order_goods_qty = cart_goods_qty.value; //장바구니에 담긴 개수 만큼 주문한다.
            var formObj = document.createElement("form");
            var i_goods_id = document.createElement("input");
            var i_goods_name = document.createElement("input");
            var i_goods_price = document.createElement("input");
            var i_goods_image_fileName = document.createElement("input");
            var i_order_goods_qty = document.createElement("input");

            i_goods_id.name = "goods_id";
            i_goods_name.name = "goods_name";
            i_goods_price.name = "goods_price";
            i_goods_image_fileName.name = "goods_image_fileName";
            i_order_goods_qty.name = "order_goods_qty";

            i_goods_id.value = goods_id;
            i_order_goods_qty.value = _order_goods_qty;
            i_goods_name.value = goods_name;
            i_goods_price.value = goods_price;
            i_goods_image_fileName.value = goods_image_fileName;

            formObj.appendChild(i_goods_id);
            formObj.appendChild(i_goods_name);
            formObj.appendChild(i_goods_price);
            formObj.appendChild(i_goods_image_fileName);
            formObj.appendChild(i_order_goods_qty);

            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${contextPath}/order/orderEachGoods.do";
            formObj.submit();
        }

        function fn_order_all_cart_goods() {
            //	alert("모두 주문하기");
            var order_goods_qty;
            var order_goods_id;
            var objForm = document.frm_order_all_cart;
            var cart_goods_qty = objForm.cart_goods_qty;
            var h_order_each_goods_qty = objForm.h_order_each_goods_qty;
            var checked_goods = document.getElementsByName("checked_goods");
            var length = checked_goods.length;
            var checkedCheckboxes = document.querySelectorAll('input[name="checked_goods"]:checked');
            var checkedCount = checkedCheckboxes.length;

            if (checkedCount == 0) {
                alert("주문할 상품이 없습니다.");
                return;
            }

            if (length > 1) {
                for (var i = 0; i < length; i++) {
                    if (checked_goods[i].checked == true) {
                        order_goods_id = checked_goods[i].value;
                        order_goods_qty = cart_goods_qty[i].value;
                        cart_goods_qty[i].value = "";
                        cart_goods_qty[i].value = order_goods_id + ":"
                            + order_goods_qty;
                        //alert(select_goods_qty[i].value);
                        console.log(cart_goods_qty[i].value);
                    }
                }
            } else {
                order_goods_id = checked_goods.value;
                order_goods_qty = cart_goods_qty.value;
                cart_goods_qty.value = order_goods_id + ":" + order_goods_qty;
                //alert(select_goods_qty.value);
            }

            objForm.method = "post";
            objForm.action = "${contextPath}/order/orderAllCartGoods.do";
            objForm.submit();
        }

        function calcTot() {
            var totalPrice = 0;
            var totalQty = 0;
            var objForm = document.frm_order_all_cart;
            var checked_goods = objForm.checked_goods;
            var checked_cnt = 0;
            var deliveryCharge = 0;

            for (var i = 0; i < checked_goods.length; i++) {
                if (checked_goods[i].checked == true) {
                    var price = parseFloat(checked_goods[i].getAttribute("price"))
                    var qty = parseFloat(checked_goods[i].getAttribute("qty"))
                    totalPrice += (price * qty);
                    checked_cnt++;
                }
            }
            if (checked_cnt == checked_goods.length) {
                document.getElementById("togglebox").checked = true;
            } else {
                document.getElementById("togglebox").checked = false;
            }
            if (checked_cnt == 0) {
                deliveryCharge = 0;
                document.getElementById("p_totalDeliveryPrice").innerHTML = deliveryCharge
                        .toLocaleString('en-US')
                    + "원";
            } else {
                deliveryCharge = 2500;
                document.getElementById("p_totalDeliveryPrice").innerHTML = deliveryCharge
                        .toLocaleString('en-US')
                    + "원";
            }

            document.getElementById("p_totalGoodsNum").innerHTML = checked_cnt
                + "개";

            document.getElementById("p_totalGoodsPrice").innerHTML = totalPrice
                    .toLocaleString('en-US')
                + "원";

            totalPrice += deliveryCharge;

            document.getElementById("p_final_totalPrice").innerHTML = totalPrice
                    .toLocaleString('en-US')
                + "원";

            document.getElementById("h_final_totalPrice").innerHTML = totalPrice;

        }

        function checkAll() {
            var checkboxes = document.getElementsByName("checked_goods");
            var thisbox = document.getElementById("togglebox");
            for (var i = 0; i < checkboxes.length; i++) {
                checkboxes[i].checked = thisbox.checked;
            }
            calcTot();


        }
    </script>
    <style>
        #right {
            float: right;
        }
    </style>
</head>
<body>
<table class="list_view">
    <tbody align=center>
    <tr style="background: #33ff00">
        <td class="fixed">구분</td>
        <td colspan=2 class="fixed">상품명</td>
        <td>정가</td>
        <td>판매가</td>
        <td>수량</td>
        <td>합계</td>
        <td>주문</td>
    </tr>

    <c:choose>
    <c:when test="${ empty myCartList }">
        <tr>
            <td colspan=8 class="fixed"><strong>장바구니에 상품이 없습니다.</strong>
            </td>
        </tr>
    </c:when>
    <c:otherwise>
    <tr>
        <strong><h1>장바구니</h1></strong>
        <form name="frm_order_all_cart">
                <c:set var="i" value="0"/>
            <c:forEach var="item" items="${myGoodsList }" varStatus="cnt">
            <!-- cartVO에 goods_id FK 기반 조회한 goodVO 객체들 -->
                <c:set var="cart_goods_qty"
                       value="${myCartList[i].cart_goods_qty}"/>
            <!-- 카트 품목개수 : myCartList list컬렉션 객체 중, varstatus 변수인 cnt보다 -1을 한, 즉, 넘어온 유저의 장바구니에 담긴 품목 컬렉션의
인덱스에 담긴 각 개별 품목의 개수 -->
                <c:set var="cart_id" value="${myCartList[i].cart_id}"/>
            <td><input type="checkbox" name="checked_goods"
                       value="${item.goods_id }" onclick="calcTot()"
                       price="${item.goods_sell_price}" qty="${cart_goods_qty }"
                       checked></td>
            <td class="goods_image"><a
                    href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
                <img width="75" alt=""
                     src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_image_fileName}"/>
            </a></td>
            <td>
                <h2>
                    <a
                            href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_name }</a>
                </h2>
            </td>
            <td class="price"><span id="goods_price">${item.goods_price }원</span></td>
            <td><strong> <fmt:formatNumber
                    value="${item.goods_sell_price}" type="number"
                    var="total_sales_price"/> 판매가 ${total_sales_price}원
                <c:set
                        var="discount_rate"
                        value="${100 - (item.goods_sell_price / item.goods_price) * 100 }"/>
                <c:set var="formatted_discount_rate" value="${discount_rate}"/>
                (${formatted_discount_rate.intValue()}%할인)

            </strong></td>
            <td><input type="text" id="cart_goods_qty"
                       name="cart_goods_qty" size=3 value="${cart_goods_qty}"><br>
                <a
                        href="javascript:modify_cart_qty('${item.goods_id }','${item.goods_sell_price }','${cnt.count-1 }');">
                    <img width=25 alt=""
                         src="${contextPath}/resources/image/btn_modify_qty.jpg">
                </a></td>
            <td><strong> <fmt:formatNumber
                    value="${item.goods_sell_price*cart_goods_qty}" type="number"
                    var="total_sales_price"/> <span id="tot_price">${total_sales_price}</span>원
            </strong></td>
            <td><a
                    href="javascript:fn_order_each_goods('${item.goods_id }','${item.goods_name }','${item.goods_sell_price}','${item.goods_image_fileName}');">
                <img width="75" alt=""
                     src="${contextPath}/resources/image/btn_order.jpg">
            </a>
                </A><br> <a href="javascript:delete_cart_goods('${cart_id}');">
                    <img width="75" alt=""
                         src="${contextPath}/resources/image/btn_delete.jpg">
                </a></td>
    </tr>
    <c:set var="totalGoodsPrice"
           value="${totalGoodsPrice+item.goods_sell_price*cart_goods_qty }"/>
    <c:set var="totalGoodsNum" value="${totalGoodsNum+1 }"/>
    <c:set var="i" value="${i = i+1 }"/>
    </c:forEach>
    </tbody>
</table>
<div id="right"><input type="checkbox" onclick="checkAll()" id="togglebox" checked/>전체 체크/해제</div>

<div class="clear"></div>
</c:otherwise>
</c:choose>
<br>
<br>

<table width=80% class="list_view" style="background: #cacaff">
    <tbody>
    <tr align=center class="fixed">
        <td class="fixed">총 주문수</td>
        <td>총 상품금액</td>
        <td></td>
        <td>총 배송비</td>
        <td></td>
        <td>총 할인 금액</td>
        <td></td>
        <td>최종 결제금액</td>
    </tr>
    <tr cellpadding=40 align=center>
        <td id="">
            <p id="p_totalGoodsNum">${totalGoodsNum}개</p> <input
                id="h_totalGoodsNum" type="hidden" value="${totalGoodsNum}"/>
        </td>
        <td>
            <p id="p_totalGoodsPrice">
                <fmt:formatNumber value="${totalGoodsPrice}" type="number"
                                  var="total_goods_price"/>
                ${total_goods_price}원
            </p> <input id="h_totalGoodsPrice" type="hidden"
                        value="${totalGoodsPrice}"/>
        </td>
        <td><img width="25" alt=""
                 src="${contextPath}/resources/image/plus.jpg"></td>
        <td>
            <p id="p_totalDeliveryPrice">
                <fmt:formatNumber value="2500" type="number"
                                  var="total_delivery_price"/>
                ${total_delivery_price}원
            </p> <input id="h_totalDeliveryPrice" type="hidden"
                        value="${totalDeliveryPrice}"/>
        </td>
        <td><img width="25" alt=""
                 src="${contextPath}/resources/image/minus.jpg"></td>
        <td>
            <p id="p_totalSalesPrice">${totalDiscountedPrice}원</p> <input
                id="h_totalSalesPrice" type="hidden" value="${totalSalesPrice}"/>
        </td>
        <td><img width="25" alt=""
                 src="${contextPath}/resources/image/equal.jpg"></td>
        <td>
            <p id="p_final_totalPrice">
                <fmt:formatNumber
                        value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}"
                        type="number" var="total_price"/>
                ${total_price}원
            </p> <input id="h_final_totalPrice" type="hidden"
                        value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}"/>
        </td>
    </tr>
    </tbody>
</table>
<br> <br> <a href="javascript:fn_order_all_cart_goods()">
    <img width="75" alt=""
         src="${contextPath}/resources/image/btn_order_final.jpg">
</a> <a href="#"> <img width="75" alt=""
                       src="${contextPath}/resources/image/btn_shoping_continue.jpg">
</a>
</form>
</body>