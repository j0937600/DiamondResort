package com.shoppingCart.model;

import java.util.*;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.members.model.MembersVO;
import com.item.model.ItemVO;

@Repository
public class CartDAO implements CartDAO_interface {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    @Transactional
    public void insert(MembersVO membersVO, ItemVO itemVO) {
        try {
            Session session = getSession();
            CartItem cartItem = new CartItem();
            cartItem.setMember(membersVO);
            cartItem.setItem(itemVO);
            cartItem.setQuantity(itemVO.getQuantity());

            session.save(cartItem);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database error occurred: " + e.getMessage());
        }
    }

    @Transactional
    public void insertCo(String sessionID, ItemVO itemVO) {
        try {
            Session session = getSession();
            CartItem cartItem = new CartItem();
            cartItem.setSessionID(sessionID);
            cartItem.setItem(itemVO);
            cartItem.setQuantity(itemVO.getQuantity());

            session.save(cartItem);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database error occurred: " + e.getMessage());
        }
    }

    @Override
    @Transactional
    public void update(MembersVO membersVO, ItemVO itemVO) {
        try {
            Session session = getSession();
            CartItem cartItem = getCartItem(membersVO, itemVO);

            if (cartItem != null) {
                cartItem.setQuantity(cartItem.getQuantity() + itemVO.getQuantity());
                session.update(cartItem);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database error occurred: " + e.getMessage());
        }
    }

    @Transactional
    public void updateCo(String sessionID, ItemVO itemVO) {
        try {
            Session session = getSession();
            CartItem cartItem = getCartItemBySessionID(sessionID, itemVO);

            if (cartItem != null) {
                cartItem.setQuantity(cartItem.getQuantity() + itemVO.getQuantity());
                session.update(cartItem);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database error occurred: " + e.getMessage());
        }
    }

    @Override
    @Transactional
    public void replace(MembersVO membersVO, ItemVO itemVO) {
        try {
            Session session = getSession();
            CartItem cartItem = getCartItem(membersVO, itemVO);

            if (cartItem != null) {
                cartItem.setQuantity(itemVO.getQuantity());
                session.update(cartItem);
            } else {
                insert(membersVO, itemVO);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database error occurred: " + e.getMessage());
        }
    }

    @Transactional
    public void replaceCo(String sessionID, ItemVO itemVO) {
        try {
            Session session = getSession();
            CartItem cartItem = getCartItemBySessionID(sessionID, itemVO);

            if (cartItem != null) {
                cartItem.setQuantity(itemVO.getQuantity());
                session.update(cartItem);
            } else {
                insertCo(sessionID, itemVO);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database error occurred: " + e.getMessage());
        }
    }

    @Override
    @Transactional
    public void delete(MembersVO membersVO, ItemVO itemVO) {
        try {
            Session session = getSession();
            CartItem cartItem = getCartItem(membersVO, itemVO);

            if (cartItem != null) {
                session.delete(cartItem);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database error occurred: " + e.getMessage());
        }
    }

    @Transactional
    public void deleteCo(String sessionID, ItemVO itemVO) {
        try {
            Session session = getSession();
            CartItem cartItem = getCartItemBySessionID(sessionID, itemVO);

            if (cartItem != null) {
                session.delete(cartItem);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database error occurred: " + e.getMessage());
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<CartItem> getAllItem_noByMb_id(String mb_id) {
        try {
            Session session = getSession();
            return session.createQuery("FROM CartItem WHERE member.mb_id = :mb_id", CartItem.class)
                    .setParameter("mb_id", mb_id)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database error occurred: " + e.getMessage());
        }
    }

    @Transactional(readOnly = true)
    public List<CartItem> getAllItem_noBysessionID(String sessionID) {
        try {
            Session session = getSession();
            return session.createQuery("FROM CartItem WHERE sessionID = :sessionID", CartItem.class)
                    .setParameter("sessionID", sessionID)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database error occurred: " + e.getMessage());
        }
    }

    private CartItem getCartItem(MembersVO membersVO, ItemVO itemVO) {
        return (CartItem) getSession()
                .createQuery("FROM CartItem WHERE member = :member AND item = :item")
                .setParameter("member", membersVO)
                .setParameter("item", itemVO)
                .uniqueResult();
    }

    private CartItem getCartItemBySessionID(String sessionID, ItemVO itemVO) {
        return (CartItem) getSession()
                .createQuery("FROM CartItem WHERE sessionID = :sessionID AND item = :item")
                .setParameter("sessionID", sessionID)
                .setParameter("item", itemVO)
                .uniqueResult();
    }
}

	
	@Override
	public Integer getValueByItem_no(String mb_id,String item_no) {
		Integer quantity = 0;
		Jedis jedis = null;
		JedisPool pool = null;
		try {
			
			pool = new JedisPool(host, port);
			jedis = pool.getResource();
			jedis.auth(passwd);

			quantity = new Integer(jedis.hget(mb_id + ":1", item_no));

				
		} catch (Exception e) {
			System.out.println(e.getMessage());
		// Clean up Jedis resources
		} finally {
			if (jedis != null) {
				try {
					jedis.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
			if (pool != null) {
				try {
					pool.destroy();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return quantity;
	}
	
	public Integer getValueByItem_noCo(String sessionID,String item_no) {
		Integer quantity = 0;
		Jedis jedis = null;
		JedisPool pool = null;
		try {
			
			pool = new JedisPool(host, port);
			jedis = pool.getResource();
			jedis.auth(passwd);

			quantity = new Integer(jedis.hget(sessionID + ":1", item_no));

				
		} catch (Exception e) {
			System.out.println(e.getMessage());
		// Clean up Jedis resources
		} finally {
			if (jedis != null) {
				try {
					jedis.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
			if (pool != null) {
				try {
					pool.destroy();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return quantity;
	}
	
	public static void main(String[] args) {

		CartDAO dao = new CartDAO();

		// �憓�
//		ItemVO itemVO = new ItemVO();
//		itemVO.setItem_no("I0007");
//		itemVO.setQuantity(61);	
//		MembersVO membersVO = new MembersVO();
//		membersVO.setMb_id("MEM0000001");
//		dao.insert(membersVO, itemVO);

		// 憓��
//		ItemVO itemVO2 = new ItemVO();
//		itemVO2.setItem_no("I0012");
//		itemVO2.setQuantity(20);	
//		MembersVO membersVO2 = new MembersVO();
//		membersVO2.setMb_id("MEM0000002");
//		dao.update(membersVO2, itemVO2);

		//��
//		ItemVO itemVO3 = new ItemVO();
//		itemVO3.setItem_no("I0010");
//		itemVO3.setQuantity(61);	
//		MembersVO membersVO3 = new MembersVO();
//		membersVO3.setMb_id("MEM0000002");
//		dao.delete(membersVO3,itemVO3);
		
		//�閰�
		
//		System.out.println(dao.getAllItem_noByMb_id("MEM0000001"));
//		System.out.println(dao.getValueByItem_no("MEM0000001","I0001"));		
	}
}