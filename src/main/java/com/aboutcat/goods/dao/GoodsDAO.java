package com.aboutcat.goods.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aboutcat.goods.vo.GoodsVO;
import com.aboutcat.goods.vo.ImageFileVO;

public interface GoodsDAO {

	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;

	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException;

	public List<GoodsVO> selectGoodsList(String goodsStatus) throws DataAccessException;

	public List<GoodsVO> selectGoodsBySearchWord(String searchWord) throws DataAccessException;

	public List<GoodsVO> selectKeyword(String keyword) throws DataAccessException;

	public List<String> selectKeywordSearch(String keyword) throws DataAccessException;

	int keywordcount(String keyword);

}
