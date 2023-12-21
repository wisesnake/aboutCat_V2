package com.aboutcat.order.vo;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component("orderVO")
public class OrderVO {
	private int order_seq_num;
	private String member_id;
	private int order_id;
	private int goods_id;
	private String goods_name;
	private int goods_sell_price;
	private int total_goods_price;
	private int cart_goods_qty; //��ٱ��Ͽ� ��� ��ǰ ��
	private int order_goods_qty; //���� �ֹ�  ��ǰ ��
	private String orderer_name;
	private String receiver_name;
	private String receiver_phone;

	
	private String delivery_address;
	private String delivery_message;
	private String delivery_method;
	private String gift_wrapping;
	private String pay_method;
	private String card_com_name;
	private String card_pay_month;
	private String pay_orderer_phone_num; //�޴��� ���� ��ȭ��ȣ
	private String pay_order_time;
	private String delivery_state;  //���� �ֹ� ��ǰ ��� ����
	
	private String final_total_price;
	private int goods_qty;
	private String goods_image_fileName;
	private String orderer_phone;
}
	