package com.vendorform.control;

import java.io.IOException; 

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 
import javax.servlet.http.HttpSession;

import com.vendorform.dao.GenerateVendCust_DAO; 
import com.vendorform.vo.NewVendCustMaster_VO;
 
@WebServlet("/Generate_vendCustMaster")
public class Generate_vendCustMaster extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 try {
			 	NewVendCustMaster_VO vo = new NewVendCustMaster_VO();
				GenerateVendCust_DAO dao = new GenerateVendCust_DAO();
				
				String company=request.getParameter("company");    			vo.setCompany(company);
				String cust_vend=request.getParameter("cust_vend"); 			vo.setCust_vend(cust_vend);
				String reason_for=request.getParameter("reason_for");			vo.setReason_for(reason_for);
				String name_org=request.getParameter("name_org");			vo.setName_org(name_org);
				String name_org2=request.getParameter("name_org2");		vo.setName_org2(name_org2);
				String postal_code=request.getParameter("postal_code");	  	vo.setPostal_code(postal_code);
				String city=request.getParameter("city");								vo.setCity(city);
				String country=request.getParameter("country");					vo.setCountry(country);
				String region=request.getParameter("region");						vo.setRegion(region);
				String sales_org=request.getParameter("sales_org");			vo.setSales_org(sales_org);
				String dist_channel=request.getParameter("dist_channel");   vo.setDist_channel(dist_channel);
				String division=request.getParameter("division");					vo.setDivision(division);
				String currency=request.getParameter("currency");				vo.setCurrency(currency);
				String shipping_cond=request.getParameter("shipping_cond"); vo.setShipping_cond(shipping_cond);
				String vendor_pay_term=request.getParameter("vendor_pay_term"); vo.setVendor_pay_term(vendor_pay_term);
				String cust_pay_term=request.getParameter("cust_pay_term");		vo.setCust_pay_term(cust_pay_term);
				String gst_no=request.getParameter("gst_no");						vo.setGst_no(gst_no);
				String purchage_group=request.getParameter("purchage_group");	vo.setPurchage_group(purchage_group);
				String purchase_org=request.getParameter("purchase_org");			vo.setPurchase_org(purchase_org);
				String vendor_currency=request.getParameter("vendor_currency");	vo.setVendor_currency(vendor_currency);
				String inco_term=request.getParameter("inco_term");				vo.setInco_term(inco_term);
				String inco_location=request.getParameter("inco_location");    vo.setInco_location(inco_location);
				String pan_no=request.getParameter("pan_no");						vo.setPan_no(pan_no);
				String email=request.getParameter("email");							vo.setEmail(email);
				String mobile_no=request.getParameter("mobile_no");			vo.setMobile_no(mobile_no);
				String remark=request.getParameter("remark");					vo.setRemark(remark);
				String search_term=request.getParameter("search_term");   vo.setSearch_term(search_term);
				String address1=request.getParameter("address1"); 				vo.setAddress1(address1);
				String address2=request.getParameter("address2");				vo.setAddress2(address2);
				String address3=request.getParameter("address3");				vo.setAddress3(address3);
				String address4=request.getParameter("address4");				vo.setAddress4(address4);
 						
				String hid = request.getParameter("hid");
				String hid_group = request.getParameter("hid_group");
				String role  = request.getParameter("role"); 		
				String cust_recAcc  = request.getParameter("cust_recAcc"); 	
				String vendor_recAcc  = request.getParameter("vendor_recAcc");	
				String cust_priceProc  = request.getParameter("cust_priceProc"); 	
				String schema_group  = request.getParameter("schema_group");	
				String acct_assign_grp = request.getParameter("acct_assign_grp");				
				vo.setCheckBox(request.getParameter("subconVend"));
				
				HttpSession session=request.getSession();
				String uname = session.getAttribute("username").toString();
				vo.setLoginNameString(uname);
				
				String name_org3 = request.getParameter("name_org3"); 		
				vo.setName_org3(name_org3);
				String name_org4 = request.getParameter("name_org4"); 		
				vo.setName_org4(name_org4);
								
				
				
				// System.out.println("name 3 = " + vo.getName_org3() + " Name 4  = " + vo.getName_org4());
				
				vo.setHid(hid);
				vo.setBP_Group(hid_group);
				vo.setAcct_assign_grp(acct_assign_grp);
				vo.setRole(role);
				vo.setCust_recAcc(cust_recAcc);
				vo.setVendor_recAcc(vendor_recAcc);
				vo.setCust_priceProc(cust_priceProc);
				vo.setSchema_group(schema_group);				
				javax.servlet.ServletContext context = getServletContext();
				
				if(request.getParameterValues("reject")!=null){
					String[] reject = request.getParameterValues("reject");
					vo.setReject(reject[0].toString());
					vo.setRejectReason(request.getParameter("rejectReason"));
					
					dao.setRejectExcel(vo,response);
					
				}else{				
					dao.setGenerateExcel(vo,response,context);
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}