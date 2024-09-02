package com.mealorder.model;

import java.util.List;

import org.json.JSONObject;

import com.mealorderdetail.model.MealOrderDetailVO;

public class MealOrderService {

	private MealOrderDAO_interface dao;
	
	public MealOrderService() {
		dao = new MealOrderDAO();
	}
	
	public MealOrderVO addMealOrder(String bk_no, String rm_no, Integer total_price) {
		MealOrderVO mealOrderVO = new MealOrderVO();

	mealOrderVO.setBk_no(bk_no);
	mealOrderVO.setRm_no(rm_no);
	mealOrderVO.setTotal_price(total_price);
	dao.insert(mealOrderVO);

		return mealOrderVO;
	}

	public MealOrderVO updateMealOrder(String meal_odno, String rm_no, Integer total_price, String od_status) {

		MealOrderVO mealOrderVO = new MealOrderVO();

		mealOrderVO.setMeal_odno(meal_odno);
		mealOrderVO.setRm_no(rm_no);
		mealOrderVO.setTotal_price(total_price);
		mealOrderVO.setOd_status(od_status);
		
		dao.update(mealOrderVO);

		return mealOrderVO;
	}

	public void deleteMealOrder(String meal_odno) {
		dao.delete(meal_odno);
	}

	public MealOrderVO getOneMealOrder(String meal_odno) {
		return dao.findByPrimaryKey(meal_odno);
	}

	public List<MealOrderVO> getAll() {
		return dao.getAll();
	}	
	
	public List<MealOrderVO> getAllByBkNo(String bk_no) {
		return dao.getAllByBkNo(bk_no);
	}	
	
	synchronized public void insertWithDetails(MealOrderVO mealOrderVO, List<MealOrderDetailVO> meallist) {
		dao.insertWithDetails(mealOrderVO, meallist);
	}
}
