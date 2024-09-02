package com.news.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class NewsDAO implements NewsDAO_interface{
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/resort");
		}catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT =
			"INSERT INTO NEWS (NEWS_NO, NEWS_CONTENT, EMP_ID) VALUES ('NEWS' || LPAD(to_char(NEWS_SEQ.NEXTVAL), 6, 0), ?, ?)";
	private static final String UPDATE = 
			"UPDATE NEWS SET NEWS_CONTENT=?, EMP_ID=? WHERE NEWS_NO=?";
	private static final String DELETE=
			"DELETE FROM NEWS WHERE NEWS_NO=?";
	private static final String GET_ONE_STMT=
			"SELECT * FROM NEWS WHERE NEWS_NO=?";
	private static final String GET_ALL_STMT=
			"SELECT * FROM NEWS ORDER BY NEWS_NO";
	
	public void insert(NewsVO newsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, newsVO.getNews_content());
			pstmt.setString(2, newsVO.getEmp_id());
			
			pstmt.executeUpdate();
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void update(NewsVO newsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, newsVO.getNews_content());
			pstmt.setString(2, newsVO.getEmp_id());
			pstmt.setString(3, newsVO.getNews_no());
			
			pstmt.executeUpdate();
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void delete(String news_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, news_no);
			pstmt.executeUpdate();
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public NewsVO findByNewsno(String news_no) {
		NewsVO newsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1,  news_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				newsVO = new NewsVO();
				newsVO.setNews_no(rs.getString("news_no"));
				newsVO.setNews_content(rs.getString("news_content"));
				newsVO.setNews_time(rs.getTimestamp("news_time"));
				newsVO.setEmp_id(rs.getString("emp_id"));
			}
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return newsVO;
	}

	@Override
	public List<NewsVO> getAll() {
		List<NewsVO> list = new ArrayList<NewsVO>();
		NewsVO newsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				newsVO = new NewsVO();
				newsVO.setNews_no(rs.getString("news_no"));
				newsVO.setNews_content(rs.getString("news_content"));
				newsVO.setNews_time(rs.getTimestamp("news_time"));
				newsVO.setEmp_id(rs.getString("emp_id"));
				list.add(newsVO);
			}
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

}
