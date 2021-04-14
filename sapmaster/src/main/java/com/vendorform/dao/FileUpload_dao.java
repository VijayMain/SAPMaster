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
import javax.servlet.http.HttpSession;

import com.vendorform.vo.FileUpload_vo;


public class FileUpload_dao {
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());
	public void uploadFile(HttpSession session, FileUpload_vo bean, HttpServletResponse response) {
		try { 
			int d_Id = Integer.parseInt(session.getAttribute("dept_id").toString());
			String uname = session.getAttribute("username").toString(); 
			
			String u_name="",success="";
			int vndcode=0,up=0,app_name=0;
			boolean flag = false;
			ArrayList email = new ArrayList(); 
			Connection con = Connection_Utility.getConnectionMaster();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			PreparedStatement ps_use=null;
			ResultSet rs_use = null; 
			PreparedStatement ps_comp = con.prepareStatement("select * from USER_LOGIN where id="+uid);
			ResultSet rs_comp = ps_comp.executeQuery();
			while(rs_comp.next()){
				u_name = rs_comp.getString("U_Name");
				email.add(rs_comp.getString("U_Email"));
			}
			PreparedStatement ps_chk = con.prepareStatement("select * from vnd_info where name='"+bean.getName_vendor()+"'");
			ResultSet rs_chk = ps_chk.executeQuery();
			while (rs_chk.next()) {
				flag = true;
			}
			if(flag==true){
				success = "Already Available !!!";
				response.sendRedirect("New_Vendor.jsp?success="+success);
			}else{
				PreparedStatement ps_upload = con.prepareStatement("insert into vnd_info("
						+ "name,org_type,business_type,owner_name,contact,alt_contact,establish_year,office_adress,activity,reg_ssi, "
						+ "ssi_date,VAT_TIN,VAT_TIN_date,excise_no,cst_reg_no,inc_PANno,trade_licenceno,annual_turnover,reference, "
						+ "prev_oswithacteam,buildup_area,unbuild_area,attach_name,attach_file,totalpower_actual,totalpower_sanctioned, "
						+ "totalpower_capacity,certification,Other_expansion,Other_newMachinary,relative_name,relative_relation, "
						+ "generate_date,rivision_no,rivision_date,created_by,approval_status,enable_id, uid, d_Id, uname)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				ps_upload.setString(1, bean.getName_vendor());
				ps_upload.setString(2, bean.getOrg_type());
				ps_upload.setString(3, bean.getBusiness_type());
				ps_upload.setString(4, bean.getOwner_name());
				ps_upload.setString(5, bean.getOwner_contact());
				ps_upload.setString(6, bean.getOwner_altercont());
				ps_upload.setString(7, bean.getYear_establish());
				ps_upload.setString(8, bean.getAddress());
				ps_upload.setString(9, bean.getNature_activity());
				ps_upload.setString(10, bean.getReg_ssi());
				ps_upload.setDate(11, bean.getSsi_date());
				ps_upload.setString(12, bean.getVat_tin());
				ps_upload.setDate(13, bean.getVat_tindate());
				ps_upload.setString(14, bean.getExceise_no());
				ps_upload.setString(15, bean.getCst_no());
				ps_upload.setString(16, bean.getPan_no());
				ps_upload.setString(17, bean.getTrade_no());
				ps_upload.setString(18, bean.getAnual_turnover());
				ps_upload.setString(19, bean.getReference_no());
				ps_upload.setString(20, bean.getPrev_os());
				ps_upload.setString(21, bean.getBuiltup());
				ps_upload.setString(22, bean.getUnbuilt());
				ps_upload.setString(23, bean.getFilename());
				ps_upload.setBlob(24, bean.getFile_blob());
				ps_upload.setString(25, bean.getActualkva());
				ps_upload.setString(26, bean.getSanctionedkva());
				ps_upload.setString(27, bean.getCapacitykva());
				ps_upload.setString(28, bean.getVend_certi());
				ps_upload.setString(29, bean.getExpansion_planning());
				ps_upload.setString(30, bean.getInstall_newMac());
				ps_upload.setString(31, bean.getRelative_name());
				ps_upload.setString(32, bean.getRelation_rel());
				ps_upload.setDate(33, curr_Date);
				ps_upload.setString(34, bean.getRevision_no());
				ps_upload.setDate(35, bean.getRevision_date());
				ps_upload.setString(36, u_name);
				ps_upload.setString(37, "Pending");
				ps_upload.setInt(38, 1);
				ps_upload.setInt(39, uid);
				ps_upload.setInt(40, d_Id);
				ps_upload.setString(41, uname);
				up = ps_upload.executeUpdate();
				if(up>0){
					ps_use = con.prepareStatement("select max(code) maxcode from vnd_info");
					rs_use = ps_use.executeQuery();
					while (rs_use.next()) {
						vndcode = rs_use.getInt("maxcode");
						bean.setHid(String.valueOf(vndcode));
					}
					if(bean.getHid_h21().equalsIgnoreCase("1")){
						ps_use = con.prepareStatement("select * from vnd_automail where code=1");
						rs_use = ps_use.executeQuery();
						while (rs_use.next()) {
							email.add(rs_use.getString("email"));
							app_name = rs_use.getInt("user");
						}
						
						ps_use = con.prepareStatement("insert into vnd_info_rel(vnd_code,company,approval_status,approved_by,last_updateby,changed_by)value(?,?,?,?,?,?)");
						ps_use.setInt(1, vndcode);
						ps_use.setString(2, "MEPL H21");
						ps_use.setString(3, "Pending");
						ps_use.setInt(4, app_name);
						ps_use.setDate(5, curr_Date);
						ps_use.setString(6, u_name);
						up = ps_use.executeUpdate(); 
						
					}
					if(bean.getHid_h251().equalsIgnoreCase("1")){
						
						ps_use = con.prepareStatement("select * from vnd_automail where code=1");
						rs_use = ps_use.executeQuery();
						while (rs_use.next()) {
							email.add(rs_use.getString("email"));
							app_name = rs_use.getInt("user");
						}
						
						ps_use = con.prepareStatement("insert into vnd_info_rel(vnd_code,company,approval_status,approved_by,last_updateby,changed_by)value(?,?,?,?,?,?)");
						ps_use.setInt(1, vndcode);
						ps_use.setString(2, "MEPL H25(I)");
						ps_use.setString(3, "Pending");
						ps_use.setInt(4, app_name);
						ps_use.setDate(5, curr_Date);
						ps_use.setString(6, u_name);
						up = ps_use.executeUpdate();  
						
						
						 
					}
					if(bean.getHid_h252().equalsIgnoreCase("1")){
						
						ps_use = con.prepareStatement("select * from vnd_automail where code=1");
						rs_use = ps_use.executeQuery();
						while (rs_use.next()) {
							email.add(rs_use.getString("email"));
							app_name = rs_use.getInt("user");
						}
						
						ps_use = con.prepareStatement("insert into vnd_info_rel(vnd_code,company,approval_status,approved_by,last_updateby,changed_by)value(?,?,?,?,?,?)");
						ps_use.setInt(1, vndcode);
						ps_use.setString(2, "MEPL H25(II)");
						ps_use.setString(3, "Pending");
						ps_use.setInt(4, app_name);
						ps_use.setDate(5, curr_Date);
						ps_use.setString(6, u_name);
						up = ps_use.executeUpdate(); 
						
						
						 
					}
					if(bean.getHid_u3().equalsIgnoreCase("1")){
						
						ps_use = con.prepareStatement("select * from vnd_automail where code=1");
						rs_use = ps_use.executeQuery();
						while (rs_use.next()) {
							email.add(rs_use.getString("email"));
							app_name = rs_use.getInt("user");
						}
						
						ps_use = con.prepareStatement("insert into vnd_info_rel(vnd_code,company,approval_status,approved_by,last_updateby,changed_by)value(?,?,?,?,?,?)");
						ps_use.setInt(1, vndcode);
						ps_use.setString(2, "MEPL UNIT III");
						ps_use.setString(3, "Pending");
						ps_use.setInt(4, app_name);
						ps_use.setDate(5, curr_Date);
						ps_use.setString(6, u_name);
						up = ps_use.executeUpdate(); 
						
						
						
					}
					if(bean.getHid_di().equalsIgnoreCase("1")){
						
						ps_use = con.prepareStatement("select * from vnd_automail where code=1");
						rs_use = ps_use.executeQuery();
						while (rs_use.next()) {
							email.add(rs_use.getString("email"));
							app_name = rs_use.getInt("user");
						}
						
						ps_use = con.prepareStatement("insert into vnd_info_rel(vnd_code,company,approval_status,approved_by,last_updateby,changed_by)value(?,?,?,?,?,?)");
						ps_use.setInt(1, vndcode);
						ps_use.setString(2, "DI");
						ps_use.setString(3, "Pending");
						ps_use.setInt(4, app_name);
						ps_use.setDate(5, curr_Date);
						ps_use.setString(6, u_name);
						up = ps_use.executeUpdate(); 
					}
					if(bean.getHid_mfpl().equalsIgnoreCase("1")){
						
						ps_use = con.prepareStatement("select * from vnd_automail where code=1");
						rs_use = ps_use.executeQuery();
						while (rs_use.next()) {
							email.add(rs_use.getString("email"));
							app_name = rs_use.getInt("user");
						}
						
						ps_use = con.prepareStatement("insert into vnd_info_rel(vnd_code,company,approval_status,approved_by,last_updateby,changed_by)value(?,?,?,?,?,?)");
						ps_use.setInt(1, vndcode);
						ps_use.setString(2, "MFPL");
						ps_use.setString(3, "Pending");
						ps_use.setInt(4, app_name);
						ps_use.setDate(5, curr_Date);
						ps_use.setString(6, u_name);
						up = ps_use.executeUpdate(); 
						
					}
		/*----------------------------------------------------------------------------------------------------------*/
		/*--------------------------------------------- Email ------------------------------------------------------*/
					// ----------------------------------------------- Email Start -------------------------------------------------------------------
					
					
					
					String host = "send.one.com";
					String user = "itsupports@muthagroup.com";
					String pass = "itsupports@xyz";
			 		String from = "itsupports@muthagroup.com";
					String subject = "Approval Required";
					boolean sessionDebug = false;
					Properties props = System.getProperties();
					props.put("mail.host", host);
					
					
					
					/*props.put("mail.transport.protocol", "smtp");
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.port", 2525);*/
					
					props.put("mail.transport.protocol", "smtp");
					props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.port", 465);
					
					Session mailSession = Session.getDefaultInstance(props, null);
					mailSession.setDebug(sessionDebug);
					Message msg = new MimeMessage(mailSession);
					msg.setFrom(new InternetAddress(from));
					InternetAddress[] addressTo = new InternetAddress[email.size()];

					for (int p = 0; p < email.size(); p++) {
						addressTo[p] = new InternetAddress(email.get(p).toString());
					}
					
					msg.setRecipients(Message.RecipientType.TO, addressTo); 

					msg.setSubject(subject);
					msg.setSentDate(new Date());
			 		
					StringBuilder sb = new StringBuilder();

					

							PreparedStatement ps_app = con.prepareStatement("select * from vnd_info where code="+bean.getHid());
							ResultSet rs_app = ps_app.executeQuery();
							while(rs_app.next()){
							 
							sb.append("<p><b style='color: #0D265E;font-size:9px'>*** This is an automatically generated email from Mutha Group Vendor System !!! ***</b></p>"+
									"<p style='font-size:11px'><b>Vendor '"+ rs_app.getString("name") +"' is pending for approval !!!</b></p>");  		
							  		
							sb.append("<table border='0' style='font-family: Arial;'>"+
							    "<tr style='background-color: #CCCCCC;font-size: 12px;'>"+
								"<td colspan='7'><strong>(A) General Information &#8658;</strong></td></tr>"+
								"<tr style='background-color: #acc8cc;text-align: center;font-size: 12px;'>"+
							        "<td width='15%'><strong>Vendor  No.</strong> </td>"+
									"<td width='19%'><strong>Name of Firm/Company</strong></td>"+
									"<td width='12%'><strong>Owner</strong></td>"+
									"<td width='14%'><strong>Organization  Type</strong></td>"+
									"<td width='12%'><strong>Business Type</strong></td>"+
									"<td width='13%'><strong>Contact</strong></td>"+
									"<td width='15%'><strong>Alternate Contact</strong></td></tr>");
									
							sb.append("<tr style='font-size: 12px;'>"+
									"<td align='center'>"+bean.getHid() +"</td>"+
									"<td>"+rs_app.getString("Name") +"</td>"+
									"<td>"+rs_app.getString("Owner_name") +"</td>"+
									"<td>"+rs_app.getString("org_type") +"</td>"+
									"<td>"+rs_app.getString("business_type") +"</td>"+
									"<td align='right'>"+rs_app.getString("Contact") +"</td>"+
									"<td align='right'>"+rs_app.getString("alt_contact") +"</td></tr>");
									
							sb.append("<tr style='background-color: #acc8cc;text-align: center;font-size: 12px;'>"+
									"<td><strong>Year Established</strong></td>"+
									"<td colspan='2'><strong>Office Address</strong></td>"+
									"<td colspan='4'><strong>Nature of Activity</strong></td></tr>");
									
							sb.append("<tr style='text-align: center;font-size: 12px;'>"+
									"<td height='23'>"+rs_app.getString("establish_year") +"</td>"+
									"<td colspan='2' align='left'>"+rs_app.getString("office_adress") +"</td>"+
									"<td colspan='4' align='left'>"+rs_app.getString("activity") +"</td></tr>");
									
							sb.append("<tr style='background-color: #CCCCCC;font-size: 12px;'>"+
							    "<td colspan='7'><strong> (B) Financial Information &#8658;</strong></td></tr>"+
								"<tr style='background-color: #acc8cc;text-align: center;font-size: 12px;'>"+
									"<td width='15%'><strong>Reg  No SSI</strong></td>"+
									"<td width='19%'><strong>SSI Date</strong></td>"+
									"<td colspan='2'><strong>VAT/TIN No</strong></td>"+
									"<td width='12%'><strong>VAT/TIN Date</strong></td>"+
									"<td colspan='2'><strong>Central Excise Registration No</strong><strong></strong></td></tr>");
									
							sb.append("<tr style='font-size: 12px;'><td align='left'>"+rs_app.getString("reg_ssi") +"</td>"+
									"<td align='left'>"+rs_app.getString("ssi_date") +"</td>"+
									"<td colspan='2' align='left'>"+rs_app.getString("VAT_TIN") +"</td>"+
									"<td align='left'>"+rs_app.getString("VAT_TIN_date") +"</td>"+
									"<td colspan='2' align='left'>"+rs_app.getString("excise_no") +"</td></tr>");
									
							sb.append("<tr style='background-color: #acc8cc;text-align: center;font-size: 12px;'>"+
									"<td><strong>CST Registration No</strong></td>"+
									"<td colspan='2'><strong>Income Tax PAN No</strong></td>"+
									"<td><strong>Trade License No</strong></td>"+
									"<td><strong>Annual Turnover</strong></td>"+
									"<td><strong>Security Reference</strong></td>"+
									"<td><strong>Prev. o/s with A/cs GTeam</strong></td></tr>");
									
							sb.append("<tr style='text-align: center;font-size: 12px;'>"+
									"<td height='23' align='left'>"+rs_app.getString("cst_reg_no") +"</td>"+
									"<td colspan='2' align='left'>"+rs_app.getString("inc_PANno") +"</td>"+
							        "<td align='left'>"+rs_app.getString("trade_licenceno") +"</td>"+
							        "<td align='right'>"+rs_app.getString("annual_turnover") +"</td>"+
							        "<td align='left'>"+rs_app.getString("reference") +"</td>"+
							        "<td align='right'>"+rs_app.getString("prev_oswithacteam") +"</td></tr>");
									
							sb.append("<tr style='background-color: #CCCCCC;font-size: 12px;'>"+
									"<td colspan='5'><strong> (C) Other Information &#8658;</strong></td>"+
							      	"<td colspan='2' rowspan='4' bgcolor='#FFFFFF'>&nbsp;</td></tr>");
									
							sb.append("<tr style='background-color: #acc8cc;text-align: center;font-size: 12px;'>"+
							        "<td colspan='2' style='background-color:#E2F8FE'><strong>Total Area of Factory</strong></td>"+
									"<td colspan='3' style='background-color:#E2F8FE'><strong>Total Power Required</strong></td></tr>");
									
							sb.append("<tr style='background-color: #acc8cc;text-align: center;font-size: 12px;'>"+
									"<td><strong>Builtup</strong></td>"+
									"<td><strong>Unbuilt</strong></td>"+
									"<td><strong>Sanctioned(KVA)</strong></td>"+
									"<td><strong>Actual Usage(KVA)</strong></td>"+
									"<td><strong>Capacity(KVA)</strong></td></tr>");
									
							sb.append("<tr style='font-size: 12px;'>"+
									"<td align='right'>"+rs_app.getString("buildup_area") +"</td>"+
									"<td align='right'>"+rs_app.getString("unbuild_area") +"</td>"+
									"<td  align='right'>"+rs_app.getString("totalpower_sanctioned") +"</td>"+
									"<td  align='right'>"+rs_app.getString("totalpower_actual") +"</td>"+
									"<td  align='right'>"+rs_app.getString("totalpower_capacity") +"</td></tr>");
									
							sb.append("<tr style='background-color: #acc8cc;text-align: center;font-size: 12px;'>"+
									"<td rowspan='2'><strong>Any Certification to vendor</strong></td>"+
									"<td colspan='3' style='background-color:#E2F8FE'><strong>Other Information</strong></td>"+
									"<td colspan='2' rowspan='2'><p><strong>Relative Name (From Mutha Group)</strong></p></td>"+
									"<td rowspan='2'><strong>Relative Relation</strong></td></tr>");
									
							sb.append("<tr style='background-color: #acc8cc;text-align: center;font-size: 12px;'>"+
									"<td height='23'><strong>Expansion Planning</strong></td>"+
							        "<td colspan='2'><strong>Installation of New Machine</strong></td></tr>");
									
							sb.append("<tr style='text-align: right;font-size: 12px;'>"+
									"<td height='23' align='left'>"+rs_app.getString("certification") +"</td>"+
							        "<td align='left'>"+rs_app.getString("Other_expansion") +"</td>"+
							        "<td colspan='2' align='left'>"+rs_app.getString("Other_newMachinary") +"</td>"+
							        "<td colspan='2' align='left'>"+rs_app.getString("relative_name") +"</td>"+
							        "<td align='left'>"+rs_app.getString("relative_relation") +"</td></tr></table>");
									
							sb.append("<table width='66%' border='0' style='font-family: Arial;'>"+
								"<tr style='background-color: #CCCCCC;font-size: 12px;'>"+
								"<td colspan='7'><strong>(D) </strong><strong>Approval History  &#8658;</strong></td></tr>"+
							    "<tr style='font-size: 12px;text-align:left;background-color:#E2F8FE'>"+
								"<td width='19%' align='center'><strong>Company</strong></td>"+
							    "<td width='20%' align='center'><strong>Status</strong></td>"+
							    "<td width='41%' align='center'><strong>Remark</strong></td>"+
							    "<td width='20%' align='center'><strong>Approved By</strong></td></tr>");
							    
									PreparedStatement ps_history =  con.prepareStatement("select * from vnd_info_rel where vnd_code=" + bean.getHid());
							        ResultSet rs_history = ps_history.executeQuery();
							        while(rs_history.next()){ 
							    
							sb.append("<tr style='font-size: 12px;'><td align='left'>"+rs_history.getString("company") +"</td>"+
							        "<td align='left'>"+rs_history.getString("approval_status") +"</td>"+
							        "<td align='left'>"+rs_history.getString("remark") +"</td>"+
							        "<td align='left'>"+rs_history.getString("changed_by") +"</td></tr>");
							    
									} 
							sb.append("</table>"); 
								}
							sb.append("<p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards</b></P><p>IT | Software Development | Mutha Group Satara.</P><hr><p>"+
							"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
							"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
							"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
							"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b></font></p>");
					
					msg.setContent(sb.toString(), "text/html");
					Transport transport = mailSession.getTransport("smtp");
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients());			
				// ******************************************************************************
					transport.close(); 
				// ----------------------------------------------- Email End ---------------------------------------------------------------------
		/*----------------------------------------------------------------------------------------------------------*/
					 
				}
				success = "Registered successfully......";
				response.sendRedirect("New_Vendor.jsp?success="+success);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}