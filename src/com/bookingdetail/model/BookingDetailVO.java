package com.bookingdetail.model;

import java.io.Serializable;

public class BookingDetailVO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String seq_no; //設計目的為避免PK conflict, 但無實際作用
	private String bk_no;
	private String rm_type;
	private Integer rm_subtotal;
	private Integer rm_guest;
	
	public BookingDetailVO() {}

	public String getBk_no() {
		return bk_no;
	}

	public void setBk_no(String bk_no) {
		this.bk_no = bk_no;
	}

	public String getRm_type() {
		return rm_type;
	}

	public void setRm_type(String rm_type) {
		this.rm_type = rm_type;
	}

	public Integer getRm_subtotal() {
		return rm_subtotal;
	}

	public void setRm_subtotal(Integer rm_subtotal) {
		this.rm_subtotal = rm_subtotal;
	}

	public Integer getRm_guest() {
		return rm_guest;
	}

	public void setRm_guest(Integer rm_guest) {
		this.rm_guest = rm_guest;
	}

	public String getSeq_no() {
		return seq_no;
	}

	public void setSeq_no(String seq_no) {
		this.seq_no = seq_no;
	};
}
