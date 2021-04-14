package com.vendorform.dao;

import it.muthagroup.connectionUtility.Connection_Utility; 

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; 
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;
 
import javax.mail.Message; 
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress; 
import javax.mail.internet.MimeMessage; 
import javax.servlet.http.HttpServletResponse; 

import com.vendorform.vo.NewVendCustMaster_VO;

public class NewVendCustMaster_DAO {

	public void addNewVendorCustomer(NewVendCustMaster_VO vo,
			HttpServletResponse response) {
		try {
			PreparedStatement ps_check = null, ps_upload = null,ps_mst2=null;
			ResultSet rs_check = null, rs_upload = null,rs_mst2=null;
			int vendmaxid = 0, vendappid=0;
			String user_Req="";
			int cnt = 0;
			String statusRecord = "Data not valid or already available....";
			Connection con = Connection_Utility.getConnectionMaster();
			Connection con1 =  Connection_Utility.getLocalUserConnection();
			String query = "select * from sap_masterVendCust where name_org='"
					+ vo.getName_org() + "' and cust_vend='"
					+ vo.getCust_vend() + "' and gst_no='" +vo.getGst_no() + "' and enable=1";
			ps_check = con.prepareStatement(query);
			rs_check = ps_check.executeQuery();
			if (!rs_check.next()) {
				ps_upload = con.prepareStatement("insert into  sap_masterVendCust(company,cust_vend,reason_for,name_org,name_org2,search_term,address1,address2,address3,address4,postal_code,country, city,region,language,sales_org,dist_channel,division,currency,shipping_cond,vendor_pay_term,cust_pay_term,gst_no,purchage_group,purchase_org,vendor_currency,inco_term,inco_location,pan_no,email,mobile_no,remark,uid,dept,enable,stage)"
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				// ps_upload.setString(1,vo.getMaterial_no());
				ps_upload.setString(1,vo.getCompany());
				ps_upload.setString(2,vo.getCust_vend());
				ps_upload.setString(3,vo.getReason_for());
				ps_upload.setString(4,vo.getName_org());
				ps_upload.setString(5,vo.getName_org2());
				ps_upload.setString(6,vo.getSearch_term());
				ps_upload.setString(7,vo.getAddress1());
				ps_upload.setString(8,vo.getAddress2());
				ps_upload.setString(9,vo.getAddress3());
				ps_upload.setString(10,vo.getAddress4());
				ps_upload.setString(11,vo.getPostal_code());
				ps_upload.setString(12,vo.getCountry());
				ps_upload.setString(13, vo.getCity());
				ps_upload.setString(14,vo.getRegion());
				ps_upload.setString(15,vo.getLanguage());
				ps_upload.setString(16,vo.getSales_org());
				ps_upload.setString(17,vo.getDist_channel());
				ps_upload.setString(18,vo.getDivision());
				ps_upload.setString(19,vo.getCurrency());
				ps_upload.setString(20,vo.getShipping_cond());
				ps_upload.setString(21,vo.getVendor_pay_term());
				ps_upload.setString(22,vo.getCust_pay_term());
				ps_upload.setString(23,vo.getGst_no());
				ps_upload.setString(24,vo.getPurchage_group());
				ps_upload.setString(25,vo.getPurchase_org());
				ps_upload.setString(26,vo.getVendor_currency());
				ps_upload.setString(27,vo.getInco_term());
				ps_upload.setString(28,vo.getInco_location());
				ps_upload.setString(29,vo.getPan_no());
				ps_upload.setString(30,vo.getEmail());
				ps_upload.setString(31,vo.getMobile_no());
				ps_upload.setString(32,vo.getRemark());
				ps_upload.setString(33,vo.getUid());
				ps_upload.setString(34,vo.getDept());
				ps_upload.setInt(35,vo.getEnable());
				ps_upload.setString(36,vo.getStage());
				
				cnt = ps_upload.executeUpdate();				
				ps_upload.close(); 
				
				ps_check = con.prepareStatement("SELECT max(id) as id FROM sap_masterVendCust");
				rs_check = ps_check.executeQuery();
				while (rs_check.next()) {
					vendmaxid = rs_check.getInt("id");
				}
				 
				ps_upload = con.prepareStatement("insert into  approval_VendCust_rel(id_vendormaster ,id_approval, approval_details, enable, approver_name, approval_type)values(?,?,?,?,?,?)");
				ps_upload.setInt(1, vendmaxid);
				ps_upload.setInt(2, 1);
				ps_upload.setString(3, "");
				ps_upload.setInt(4, 1);
				ps_upload.setString(5, "");
				ps_upload.setString(6, "");
				
				cnt = ps_upload.executeUpdate();
				ps_upload.close(); 
				
				ps_check = con.prepareStatement("SELECT max(id) as id FROM approval_VendCust_rel");
				rs_check = ps_check.executeQuery();
				while (rs_check.next()) {
					vendappid = rs_check.getInt("id");
				}
				
			/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
																							 /* Mail Configuration Start */
			/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
		 
				query = "";
				boolean flag=false;
				ArrayList<String> emailArray = new ArrayList<String>();
				query = "select * from approval_config_rel where stage>0  and applied_to='vendcustmaster'";
				ps_check = con.prepareStatement(query);
				rs_check = ps_check.executeQuery();					
				while(rs_check.next()){
					emailArray.add(rs_check.getString("email_id"));
				}
				emailArray.add(vo.getEmail_id());
				 
				
				String[] recipients = new String[emailArray.size()];
				for(int e=0;e<emailArray.size();e++){
					recipients[e]=emailArray.get(e).toString(); 
				}
				 
				String host = "", user = "", pass = "", from = "", smtpPort="";
				
				query = "select * from domain_config where enable=1";
				ps_check = con.prepareStatement(query);
				rs_check = ps_check.executeQuery();							
				while(rs_check.next()){
					host = rs_check.getString("hostName");
					user = rs_check.getString("userName");
					pass = rs_check.getString("pass");
			 		from = rs_check.getString("mailFrom");
			 		smtpPort = rs_check.getString("smtpPort");
				}
				 
					String subject = "New Customer/Vendor Approval Request for " + vo.getName_org();
					boolean sessionDebug = false; 
							  
					Properties props = System.getProperties();
					props.put("mail.host", host);
					props.put("mail.transport.protocol", "smtp");
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.port", smtpPort);
					 
					
					
					Session mailSession = Session.getDefaultInstance(props, null);
					mailSession.setDebug(sessionDebug);
					Message msg = new MimeMessage(mailSession);
					msg.setFrom(new InternetAddress(from));
					InternetAddress[] addressTo = new InternetAddress[recipients.length];

					for (int p = 0; p < recipients.length; p++) {
						addressTo[p] = new InternetAddress(recipients[p]);
					}
					
					msg.setRecipients(Message.RecipientType.TO, addressTo); 

					msg.setSubject(subject);
					msg.setSentDate(new Date());
			 		
					StringBuilder sb = new StringBuilder();
					
					if(cnt>0){			
					sb.append("<b style='color: #0D265E;'>*** This is an automatically generated email from SAP !!! ***</b>"+
							"<p>Please find below Pending Vendor / Customer Data :</P>"+
							"<table border='1' width='100%'><tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"+
							"<th width='5%' height='25'> S. No </th>"+
							"<th>Customer / Vendor For</th>"+
							"<th>NAME OF ORG</th>"+
							"<th>Reason / Required For</th>"+
							"<th>Requester</th>"+
							"<th>PAN NO </th>"+
							"<th>Email ID</th>"+
							"<th>Mobile NO</th>"+
							"<th>Approval Status</th></tr>");
					int s_no = 1;
					ps_check = con.prepareStatement("SELECT * FROM sap_masterVendCust where id IN (SELECT id_vendormaster FROM approval_VendCust_rel where id_approval=1)");
					rs_check = ps_check.executeQuery();
					while (rs_check.next()) {
						ps_mst2 = con1.prepareStatement("SELECT * FROM complaintzilla.user_tbl where u_id="+ Integer.parseInt(rs_check.getString("uid")));
						 rs_mst2 = ps_mst2.executeQuery();
							while (rs_mst2.next()) {
								user_Req=rs_mst2.getString("U_Name");
							}
					sb.append("<tr style='font-size: 12px;text-align: center;'>"+
							"<td style='text-align: right;''>"+s_no+" </td>"+
							"<td style='text-align: left;''>"+rs_check.getString("cust_vend")+"</td>"+
							"<td style='text-align: left;''>"+rs_check.getString("name_org")+"</td>"+ 
							"<td style='text-align: left;''>"+rs_check.getString("reason_for")+"</td>"+
							"<td style='text-align: left;''>"+user_Req+"</td>"+
							"<td style='text-align: left;''>"+rs_check.getString("pan_no")+"</td>"+ 
							"<td style='text-align: left;''>"+rs_check.getString("email")+"</td>"+ 
							"<td style='text-align: right;''>"+rs_check.getString("mobile_no")+"</td>"+ 
							"<td style='text-align: left;''><b>Pending</b></td></tr>");
					s_no ++;
					flag=true;
					}
					sb.append("</table><b style='color: #0D265E;'>To check Please</b> <a href='http://192.168.0.7/sapmaster/' style='color: blue;'>Click Here</a>"); 
					}
					sb.append("<p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"+
							"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
							"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
							"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
							"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
							"</font></p>");

					if(flag=true){
					msg.setContent(sb.toString(), "text/html"); 
					Transport transport = mailSession.getTransport("smtp");
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients()); 
					transport.close();  
					}
					/*BodyPart messageBodyPart = new MimeBodyPart();
					messageBodyPart.setContent(sb.toString(),"Text/html");
					// Create a multipar message
					Multipart multipart = new MimeMultipart();

					// Set text message part
					multipart.addBodyPart(messageBodyPart);

					// Part two is attachment
					messageBodyPart = new MimeBodyPart();
					
					DataSource source = new FileDataSource(filename);
					messageBodyPart.setDataHandler(new DataHandler(source));
					messageBodyPart.setFileName(filename);
					multipart.addBodyPart(messageBodyPart);*/

					// Send the complete message parts
					//msg.setContent(multipart);
					
					/*if(flag=true){
					Transport transport = mailSession.getTransport("smtp");
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients());							
					// ******************************************************************************
					transport.close(); 
					}*/
				statusRecord = "Data upload Successful....";
			}
			
			 response.sendRedirect("New_VendCust.jsp?success=" + statusRecord);		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}