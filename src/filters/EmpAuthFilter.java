package filters;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.*;

import com.auth.model.AuthService;
import com.auth.model.AuthVO;
import com.emp.model.EmpVO;
import com.members.model.MembersVO;

public class EmpAuthFilter implements Filter {
	
	private FilterConfig config;
	
	public void init (FilterConfig config) {
		this.config = config;
	}
	
	public void destroy() {
		config = null;
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//進行強轉型
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		String uri = req.getRequestURI();
		int last = uri.lastIndexOf("/");
		String compare = uri.substring(0, last);
		if (uri.contains("backend_index.jsp") || uri.contains("loginEmp.jsp")) {
			chain.doFilter(request, response);
			return;
		}
		
		TreeMap<String, String[]> maps = new TreeMap<>();
		maps.put("01", new String[] {"emp", "auth", "dept","func", "title", "update"});
		maps.put("02", new String[] {"members", "payment", "update"});
		maps.put("03", new String[] {"rooms", "roomtype", "roompic", "pickup","choppers", "update"});
		maps.put("04", new String[] {"booking", "pickup","choppers", "update"});
		maps.put("05", new String[] {"item", "item_pics", "item_type", "update"});
		maps.put("06", new String[] {"shop_order", "shop_order_detail", "update"});
		maps.put("07", new String[] {"act", "actevent", "actpic", "acttype" , "update"});
		maps.put("08", new String[] {"actorder",  "update"});
		maps.put("09", new String[] {"services", "serviceType","timeTable",  "update"});
		maps.put("10", new String[] {"serviceOrder","timeTable",  "update"});
		maps.put("11", new String[] {"meal","mealtype",  "update"});
		maps.put("12", new String[] {"mealorder","mealordertail" , "update"});
		EmpVO emp = (EmpVO)req.getSession().getAttribute("empVO");
		AuthService authSvc = new AuthService();
		List<AuthVO> authList = authSvc.getAllByEmp(emp.getEmp_id());
		boolean pass = false;
		for (int i = 0; i < authList.size(); i++) {
			String[] filenames =  maps.get(authList.get(i).getFunc_no());
			if (Arrays.stream(filenames).anyMatch(e -> compare.contains(e))) {
				pass = true;
				break;
			}
		}
		
		if (pass) {
			chain.doFilter(request, response);
		} else {
			req.getSession().setAttribute("authErrorMsg", "權限不足");
			res.sendRedirect(req.getContextPath()+"/backend/backend_index.jsp");
		}
	}
}
