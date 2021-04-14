package com.vendorform.control;

import java.io.IOException; 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  
import com.vendorform.dao.NewVendCustMaster_DAO;
import com.vendorform.vo.NewVendCustMaster_VO;
 
@WebServlet("/NewCustVend_CreationControl")
public class NewCustVend_CreationControl extends HttpServlet {
	private static final long serialVersionUID = 1L;   
    public NewCustVend_CreationControl() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 try {
			NewVendCustMaster_VO vo = new NewVendCustMaster_VO();
			NewVendCustMaster_DAO dao = new NewVendCustMaster_DAO();
			
			String company  = request.getParameter("company"); 		vo.setCompany(company);
			String cust_vend  = request.getParameter("cust_vend"); 	vo.setCust_vend(cust_vend);
			String reason_for  = request.getParameter("reason_for").toUpperCase();	vo.setReason_for(reason_for);
			String name_org  = request.getParameter("name_org").toUpperCase();		
			
			int lengthname = name_org.length();  
			
			if(lengthname>40){
			
			vo.setName_org(name_org.substring(0, 40));			
			vo.setName_org2(name_org.substring(40, lengthname));
			}else{
				vo.setName_org(name_org);
			}
			
			/* String name_org2  = request.getParameter("name_org2");	vo.setName_org2(name_org2); */
			String search_term  = request.getParameter("search_term").toUpperCase(); vo.setSearch_term(search_term);
			String address1  = request.getParameter("address1").toUpperCase();		vo.setAddress1(address1);
			String address2  = request.getParameter("address2").toUpperCase();		vo.setAddress2(address2);
			String address3  = request.getParameter("address3").toUpperCase();		vo.setAddress3(address3);
			String address4  = request.getParameter("address4").toUpperCase();		vo.setAddress4(address4);
			String postal_code  = request.getParameter("postal_code"); vo.setPostal_code(postal_code);
			String country  = request.getParameter("country");			vo.setCountry(country);
			String city = request.getParameter("city").toUpperCase();						vo.setCity(city);
			String region  = request.getParameter("region");				vo.setRegion(region);
			String language  = request.getParameter("language");		vo.setLanguage(language);
			String sales_org  = request.getParameter("sales_org");		vo.setSales_org(sales_org);
			String dist_channel  = request.getParameter("dist_channel");		vo.setDist_channel(dist_channel);
			String division  = request.getParameter("division");			vo.setDivision(division);
			String currency  = request.getParameter("currency");		vo.setCurrency(currency);
			String shipping_cond  = request.getParameter("shipping_cond");   vo.setShipping_cond(shipping_cond);
			String vendor_pay_term  = request.getParameter("vendor_pay_term"); vo.setVendor_pay_term(vendor_pay_term);
			String cust_pay_term  = request.getParameter("cust_pay_term");    vo.setCust_pay_term(cust_pay_term);
			String gst_no  = request.getParameter("gst_no");					vo.setGst_no(gst_no);
			String purchage_group  = request.getParameter("purchage_group");	vo.setPurchage_group(purchage_group);
			String purchase_org  = request.getParameter("purchase_org");			vo.setPurchase_org(purchase_org);
			String vendor_currency  = request.getParameter("vendor_currency");	vo.setVendor_currency(vendor_currency);
			String inco_term  = request.getParameter("inco_term");					vo.setInco_term(inco_term);
			String inco_location  = request.getParameter("inco_location");		vo.setInco_location(inco_location);
			String pan_no  = request.getParameter("pan_no");						vo.setPan_no(pan_no);
			String email  = request.getParameter("email");								vo.setEmail(email);
			String mobile_no  = request.getParameter("mobile_no");				vo.setMobile_no(mobile_no);
			String remark  = request.getParameter("remark").toUpperCase();							vo.setRemark(remark);
			
			HttpSession session = request.getSession();
			String uid = session.getAttribute("uid").toString();
			
			String uname = session.getAttribute("username").toString(), d_Id = session.getAttribute("dept_id").toString();
			String email_id = session.getAttribute("email_id").toString();
			
			vo.setEmail_id(email_id);
			vo.setUid(uid);
			vo.setDept(d_Id);
			vo.setUname(uname);			  
			vo.setEnable(1);
			vo.setStage("1");  

     //		System.out.println("uid = " + uid + " = uname = " + uname + " = d_id " + d_Id);
			
			dao.addNewVendorCustomer(vo,response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}