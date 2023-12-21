package com.aboutcat.goods.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.aboutcat.goods.vo.GoodsVO;
import com.aboutcat.goods.vo.ImageFileVO;

@Repository("goodsDAO")
public class GoodsDAOImpl implements GoodsDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public GoodsVO selectGoodsDetail(String goods_id) {

		GoodsVO goodsVO = (GoodsVO) sqlSession.selectOne("mapper.goods.selectGoodsDetail", goods_id);

		return goodsVO;
	}

	@Override
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException {
		List<ImageFileVO> imageList = (ArrayList) sqlSession.selectList("mapper.goods.selectGoodsDetailImage",
				goods_id);
		return imageList;
	}

	@Override
	public List<GoodsVO> selectGoodsList(String goodsStatus) {
		List<GoodsVO> goodsList = sqlSession.selectList("mapper.goods.selectGoodsList", goodsStatus);

		return goodsList;

	}

	@Override
	public ArrayList selectGoodsBySearchWord(String searchWord) throws DataAccessException {
		ArrayList list = (ArrayList) sqlSession.selectList("mapper.goods.selectGoodsBySearchWord", searchWord);
		return list;
	}

	@Override
	public List<GoodsVO> selectKeyword(String keyword) throws DataAccessException {
		List<GoodsVO> list = sqlSession.selectList("mapper.goods.selectKeyword", keyword);
		return list;

	}

	@Override
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException {
		List<String> list = sqlSession.selectList("mapper.goods.selectKeywordSearch", keyword);
		return list;

	}
	@Override
	public int keywordcount(String keyword) {
		int keywordcount=sqlSession.selectOne("mapper.goods.KeywordCount", keyword);
		System.out.println(keywordcount);
		return keywordcount;
	}

}
