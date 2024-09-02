package com.rooms.model;

import java.util.List;

import com.roomtype.model.RoomTypeVO;

public interface RoomsDAO_interface {
	public String insert(RoomsVO rmvo);
	public void update(RoomsVO rmvo);
	public void update_checkin(RoomsVO rmvo);
	public void update_checkout(RoomsVO rmvo);
	public void delete(String rmno);
	public List<RoomsVO> getAllByStatus(String rmstatus);
	public List<RoomsVO> getAllByRmType(String rmtype);
	public List<RoomsVO> getAllByMbId(String mb_id);
	public List<RoomsVO> getAllByBkNo(String bk_no);
	public List<RoomsVO> getAll();
}
