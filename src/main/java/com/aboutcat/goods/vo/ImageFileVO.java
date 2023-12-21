package com.aboutcat.goods.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ImageFileVO {

	private int goods_id;
	private int goods_image_id;
	private String goods_image_fileName;
	private String goods_image_type;
	private String goods_image_writerid;
	


}
