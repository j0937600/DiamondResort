package com.roomrsv.model;

import java.util.*;
import java.time.LocalDate;
import javax.persistence.*;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.roomtype.model.*;

public class RoomRsvDAO implements RoomRsvDAO_interface {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void insert(LocalDate rsvDate) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            RoomTypeService rmTypeSvc = new RoomTypeService();
            List<RoomTypeVO> rmtypes = rmTypeSvc.getAll();
            for (RoomTypeVO rmtypevo : rmtypes) {
                RoomRsvVO roomRsvVO = new RoomRsvVO();
                roomRsvVO.setRsv_date(rsvDate);
                roomRsvVO.setRm_type(rmtypevo.getRm_type());
                roomRsvVO.setRm_left(rmtypevo.getRm_qty());
                session.save(roomRsvVO);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("A database error occurred:" + e.getMessage());
        }
    }

    @Override
    public void update(JSONObject bkitem) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Integer stay = Integer.parseInt(bkitem.getString("stay"));
            LocalDate date = LocalDate.parse(bkitem.getString("startDate"));
            String rmtype = bkitem.getString("rmtype");

            for (int i = 0; i < stay; i++) {
                LocalDate currentDate = date.plusDays(i);
                RoomRsvVO rsvvo = getOneByDateNRmType(currentDate, rmtype);
                if (rsvvo == null) {
                    insert(currentDate);
                    rsvvo = getOneByDateNRmType(currentDate, rmtype);
                }
                Integer rmLeft = rsvvo.getRm_left() - 1;
                rsvvo.setRm_left(rmLeft);
                session.update(rsvvo);
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("A database error occurred:" + e.getMessage());
        }
    }

    @Override
    public void cancel(Integer stay, LocalDate startDate, String rmType) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            for (int i = 0; i < stay; i++) {
                LocalDate currentDate = startDate.plusDays(i);
                RoomRsvVO rsvvo = getOneByDateNRmType(currentDate, rmType);
                Integer rmLeft = rsvvo.getRm_left() + 1;
                rsvvo.setRm_left(rmLeft);
                session.update(rsvvo);
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("A database error occurred:" + e.getMessage());
        }
    }

    @Override
    public void delete(LocalDate rsvDate) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            RoomRsvVO rsvvo = getOneByDateNRmType(rsvDate, rmType);
            if (rsvvo != null) {
                session.delete(rsvvo);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("A database error occurred:" + e.getMessage());
        }
    }

    @Override
    public RoomRsvVO getOneByDateNRmType(LocalDate rsvDate, String rm_type) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM RoomRsvVO WHERE rsv_date = :rsvDate AND rm_type = :rmType", RoomRsvVO.class)
                    .setParameter("rsvDate", rsvDate)
                    .setParameter("rmType", rm_type)
                    .uniqueResult();
        }
    }

    @Override
    public List<RoomRsvVO> getAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM RoomRsvVO ORDER BY rsv_date", RoomRsvVO.class).list();
        }
    }

    @Override
    public List<RoomRsvVO> getOneDayByDate(LocalDate rsvDate) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            List<RoomRsvVO> roomRsv = session.createQuery("FROM RoomRsvVO WHERE rsv_date = :rsvDate", RoomRsvVO.class)
                    .setParameter("rsvDate", rsvDate)
                    .list();

            if (roomRsv.isEmpty()) {
                RoomTypeService rmtypeSvc = new RoomTypeService();
                List<RoomTypeVO> rmtypevoList = rmtypeSvc.getAll();
                for (RoomTypeVO rmtypevo : rmtypevoList) {
                    RoomRsvVO rsvvo = new RoomRsvVO();
                    rsvvo.setRsv_date(rsvDate);
                    rsvvo.setRm_type(rmtypevo.getRm_type());
                    rsvvo.setRm_left(rmtypevo.getRm_qty());
                    roomRsv.add(rsvvo);
                }
            }
            return roomRsv;
        }
    }

    @Override
    public List<RoomRsvVO> getAllByRmType(String rmType) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM RoomRsvVO WHERE rm_type = :rmType ORDER BY rsv_date", RoomRsvVO.class)
                    .setParameter("rmType", rmType)
                    .list();
        }
    }

    public void renewQty(String rm_type, Integer upordown) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            List<RoomRsvVO> rsvList = getAllByRmType(rm_type);
            for (RoomRsvVO rsvvo : rsvList) {
                int rmleft = rsvvo.getRm_left() + upordown;
                rsvvo.setRm_left(rmleft);
                session.update(rsvvo);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("A database error occurred:" + e.getMessage());
        }
    }
}
		} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return roomRsv;
	}
	
	public Integer roomCheck(LocalDate rsvDate, Integer stay, String rmType) {
		Connection conn = null;
		Integer rmLeft = null;
		try {
			conn = ds.getConnection();
			RoomTypeService rmtypeSvc = new RoomTypeService();
			RoomTypeVO rmtypevo = rmtypeSvc.getOne(rmType);
			rmLeft = rmtypevo.getRm_qty();
			for (int i = 0; i < stay; i++) {
				RoomRsvVO rsvvo = getOneByDateNRmType(rsvDate.plusDays(i), rmType, conn);
				if (rsvvo == null) {
					continue;
				} 
}
