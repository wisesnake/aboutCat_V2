package com.aboutcat.cart.vo;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component("cartVO")
@Data
public class CartVO {
	private int cart_id;
	private int goods_id;
	private String member_id;
	private int cart_goods_qty;
	private String creDate;

}
