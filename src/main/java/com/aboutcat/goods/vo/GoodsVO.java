package com.aboutcat.goods.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class GoodsVO {

	private int goods_id;
	private String goods_name;
	private String goods_brand;
	private int goods_price;
	private int goods_sell_price;
	private int stock;
	private int delivery_charge;
	private String goods_description;
	private String goods_status;
	private String goods_keyword;

	private String goods_image_fileName;

}
