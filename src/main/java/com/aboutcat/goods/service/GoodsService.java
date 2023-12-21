package com.aboutcat.goods.service;

import java.util.List;
import java.util.Map;

import com.aboutcat.goods.vo.GoodsVO;

public interface GoodsService {

	
//	public Map
	
	public Map goodsDetail(String goods_id);
	
	public Map <String, List<GoodsVO>> listGoods() throws Exception;

    public List<GoodsVO> searchGoods(String searchWord) throws Exception;

	public List<GoodsVO> keyword(String keyword) throws Exception;
	
	public List<String> keywordSearch(String keyword) throws Exception;

	int keywordcount(String keyword);

	
}
