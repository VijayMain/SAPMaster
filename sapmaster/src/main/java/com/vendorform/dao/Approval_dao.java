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

import com.vendorform.vo.NewVendCustMaster_VO;

public class Approval_dao {
	private static final java.sql.Date curr_Date = new java.sql.Date(
			System.currentTimeMillis());

	public void approve_Vendor(HttpSession session, NewVendCustMaster_VO vo,
			HttpServletResponse response) {
		try {
			int cnt = 0;
			Connection con = Connection_Utility.getConnectionMaster(); 
			Connection conLocal = Connection_Utility.getLocalUserConnection();
			PreparedStatement ps_check = null, ps_check1 = null, ps_mst = null,ps_mst2=null;
			ResultSet rs_check = null, rs_check1 = null, rs_mst = null,rs_mst2=null;
			String approval_given = "",user_Req="";

			
			
			ps_mst = con.prepareStatement("SELECT * FROM approval_type where id=" + Integer.valueOf(vo.getApproval()));
			rs_mst = ps_mst.executeQuery();
			while (rs_mst.next()) {
				approval_given = rs_mst.getString("approval_Type");
			}
			ps_mst.close();
			rs_mst.close();

			ps_check = con.prepareStatement("select * from approval_VendCust_rel where approval_details='' and id_vendormaster="
							+ Integer.valueOf(vo.getHid()) + " and enable=1");
			rs_check = ps_check.executeQuery();
			if (rs_check.next()) {

				ps_check1 = con.prepareStatement("update approval_VendCust_rel set approval_details=?,approver_name=?,approval_type=?,id_approval=? where approval_details='' and id_vendormaster="
								+ Integer.valueOf(vo.getHid())
								+ " and enable=1");
				ps_check1.setString(1, vo.getRemark());
				ps_check1.setString(2, vo.getUname());
				ps_check1.setString(3, approval_given);
				ps_check1.setInt(4, Integer.valueOf(vo.getApproval()));

				cnt = ps_check1.executeUpdate(); 
				
			} else {
				ps_check1 = con.prepareStatement("insert into approval_VendCust_rel(id_vendormaster, id_approval, approval_details, enable, approver_name, approval_type)values(?,?,?,?,?,?)");

				ps_check1.setInt(1, Integer.valueOf(vo.getHid()));
				ps_check1.setInt(2, Integer.valueOf(vo.getApproval()));
				ps_check1.setString(3, vo.getRemark());
				ps_check1.setInt(4, 1);
				ps_check1.setString(5, vo.getUname());
				ps_check1.setString(6, approval_given);

				cnt = ps_check1.executeUpdate(); 
			}

			if (cnt > 0) {

				/* ------------------------------------------------------- Mail Configuration Start  ----------------------------------------------------------- */

				String query = "";
				boolean flag = false;
				ArrayList<String> emailArray = new ArrayList<String>();
				query = "select * from approval_config_rel where stage>0  and applied_to='vendcustmaster'";
				ps_check = con.prepareStatement(query);
				rs_check = ps_check.executeQuery();
				while (rs_check.next()) {
					emailArray.add(rs_check.getString("email_id"));
				}
				
				
				ps_check1 = con.prepareStatement("select uid from sap_masterVendCust where id="+Integer.valueOf(vo.getHid()));
				rs_check1 = ps_check1.executeQuery();
				while (rs_check1.next()) { 
				ps_check = conLocal.prepareStatement("select U_Email from user_tbl where U_Id ="+rs_check1.getInt("uid"));
				rs_check = ps_check.executeQuery();
				while (rs_check.next()) {
					emailArray.add(rs_check.getString("U_Email"));
				}
				}
				
				String[] recipients = new String[emailArray.size()];
				for (int e = 0; e < emailArray.size(); e++) {
					recipients[e] = emailArray.get(e).toString();
				}

				String host = "", user = "", pass = "", from = "", smtpPort = "", nameAppr="";

				query = "select * from domain_config where enable=1";
				ps_check = con.prepareStatement(query);
				rs_check = ps_check.executeQuery();
				while (rs_check.next()) {
					host = rs_check.getString("hostName");
					user = rs_check.getString("userName");
					pass = rs_check.getString("pass");
					from = rs_check.getString("mailFrom");
					smtpPort = rs_check.getString("smtpPort");
				}
				String org_NameString = "";
				ps_check = con.prepareStatement("select * from sap_masterVendCust where id="+Integer.valueOf(vo.getHid()));
				rs_check = ps_check.executeQuery();
				while (rs_check.next()) {
					org_NameString = rs_check.getString("name_org");
				}
				
				ps_check = con.prepareStatement("SELECT approver_name FROM approval_VendCust_rel where id_vendormaster="+Integer.valueOf(vo.getHid()));
				rs_check = ps_check.executeQuery();
				while (rs_check.next()) {
					nameAppr = rs_check.getString("approver_name");
				}
				
				String subject = "New Customer/Vendor :" + org_NameString +" is " + approval_given;
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

				if (cnt > 0) {
					sb.append("<b style='color: #0D265E;'>*** This is an automatically generated email from SAP !!! ***</b>"
							+ "<p>Please find below Vendor / Customer Data :</P>"
							+ "<table border='1' width='100%'><tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"
							+ "<th width='5%' height='25'> S. No </th>"
							+ "<th>Customer / Vendor For</th>"
							+ "<th>NAME OF ORG</th>"
							+ "<th>Reason / Required For</th>"
							+ "<th>Requester</th>"
							+ "<th>PAN NO </th>"
							+ "<th>Email ID</th>"
							+ "<th>Mobile NO</th>"
							+ "<th>Approval Status</th></tr>");
					int s_no = 1;
					ps_check = con.prepareStatement("select * from sap_masterVendCust where id="+Integer.valueOf(vo.getHid()));
					rs_check = ps_check.executeQuery();
					while (rs_check.next()) {
						ps_mst2 = conLocal.prepareStatement("SELECT * FROM complaintzilla.user_tbl where u_id="+ Integer.parseInt(rs_check.getString("uid")));
						 rs_mst2 = ps_mst2.executeQuery();
							while (rs_mst2.next()) {
								user_Req=rs_mst2.getString("U_Name");
							}
						sb.append("<tr style='font-size: 12px;'>"
								+ "<td style='text-align: right;''>"
								+ s_no
								+ " </td>"
								+ "<td style='text-align: left;''>"
								+ rs_check.getString("cust_vend")
								+ "</td>"
								+ "<td style='text-align: left;''>"
								+ rs_check.getString("name_org")
								+ "</td>"
								
								+ "<td style='text-align: left;''>"
								+ rs_check.getString("reason_for")
								+ "</td>"
								
								+ "<td style='text-align: left;''>"
								+  user_Req
								+ "</td>"
								
								+ "<td style='text-align: left;''>"
								+ rs_check.getString("pan_no")
								+ "</td>"
																
								+ "<td style='text-align: left;''>"
								+ rs_check.getString("email")
								+ "</td>"
								+ "<td style='text-align: right;''>"
								+ rs_check.getString("mobile_no")
								+ "</td>" + "<td style='text-align: left;''><b>"+approval_given+" : "+nameAppr+"</b></td></tr>");
						s_no++;
						flag = true;
					}
					sb.append("</table>");
				}

				sb.append("<p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"
						+ "<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"
						+ "<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"
						+ "it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"
						+ "or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"
						+ "</font></p>");

				if (flag = true) {
					msg.setContent(sb.toString(), "text/html");
					Transport transport = mailSession.getTransport("smtp");
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients());
					transport.close();
				}
				/*
				 * BodyPart messageBodyPart = new MimeBodyPart();
				 * messageBodyPart.setContent(sb.toString(),"Text/html"); //
				 * Create a multipar message Multipart multipart = new
				 * MimeMultipart();
				 * 
				 * // Set text message part
				 * multipart.addBodyPart(messageBodyPart);
				 * 
				 * // Part two is attachment messageBodyPart = new
				 * MimeBodyPart();
				 * 
				 * DataSource source = new FileDataSource(filename);
				 * messageBodyPart.setDataHandler(new DataHandler(source));
				 * messageBodyPart.setFileName(filename);
				 * multipart.addBodyPart(messageBodyPart);
				 */

				// Send the complete message parts
				// msg.setContent(multipart);

				/*
				 * if(flag=true){ Transport transport =
				 * mailSession.getTransport("smtp"); transport.connect(host,
				 * user, pass); transport.sendMessage(msg,
				 * msg.getAllRecipients()); //
				 * **********************************
				 * ********************************************
				 * transport.close(); }
				 */
			}
			response.sendRedirect("Home.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}