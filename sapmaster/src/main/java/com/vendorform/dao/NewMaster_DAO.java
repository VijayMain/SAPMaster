package com.vendorform.dao;

import it.muthagroup.connectionUtility.Connection_Utility;
 

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties; 

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;



import com.vendorform.vo.NewMaster_VO;

public class NewMaster_DAO {
	ArrayList<String> emailArray = new ArrayList<String>();
	public void createNewMaster(NewMaster_VO vo, HttpServletResponse response) {
		try {
			PreparedStatement ps_check=null,ps_upload=null,ps_check2=null,ps_check3=null;
			ResultSet rs_check=null,rs_upload=null,rs_check2=null,rs_check3=null,rs_check4=null;
			int cnt = 0;
			String statusRecord = "Data not valid...";
			String masterNewDataString = "",query ="";
			String editDataString=vo.getEditedData();
			
			// *******************************************************************************************************************************************************************
			java.util.Date date = null;
			java.sql.Timestamp timeStamp = null;
			Calendar calendar=Calendar.getInstance();
			calendar.setTime(new Date());
			java.sql.Date dt = new java.sql.Date(calendar.getTimeInMillis());
			java.sql.Time sqlTime=new java.sql.Time(calendar.getTime().getTime());
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			date = simpleDateFormat.parse(dt.toString()+" "+sqlTime.toString());
			timeStamp = new java.sql.Timestamp(date.getTime());
			// *******************************************************************************************************************************************************************
			Connection con =  Connection_Utility.getConnectionMaster();
			Connection con_local =  Connection_Utility.getLocalUserConnection();
			//  System.out.println(" data = " + vo.getMat_name()  + " = " + vo.getPlant() + " = " + vo.getDivision());			
			 
			if(editDataString.equalsIgnoreCase("0")){
			query = "select * from sap_mastertran where mat_name='" + vo.getMat_name() +  "' and plant='" + vo.getPlant() +  "' and division='" + vo.getDivision() +"'";
			ps_check = con.prepareStatement(query);
			rs_check = ps_check.executeQuery();
				 if (!rs_check.next() ) {
					masterNewDataString = vo.getMat_name();						 
					ps_upload = con.prepareStatement("insert into  sap_mastertran(material_no,ind_sector,material_type,plant,storage_loc,sales_org,dist_channel,"
							+ "mat_name,baseUOM,matGroup,oldMaterialNo,ext_matGroup,size_dim,gross_wt,wtUnit,netWt,delivery_unit,division,jocg,josg,joig,"
							+ "tax_ind,matStat_group,acct_assgnGroup,genItemCatGroup,itemCatGroup,mat_grp1,mat_grp2,availability_chk,trans_group,load_group,"
							+ "profitCenter,purchase_Group,batch_indicator,pur_valueKey,mrp_group,abc_indicator,mrpType,reorderPoint,mrp_Controller,"
							+ "lotSizing_proc,min_LotSize,max_LotSize,fixLot,MaxStocklevel,procure_type,specialProc,prod_StorageLoc,backflush,notCoproduct,"
							+ "inhouseProduction,plan_delTime,schMrg_Key,safety_stk,strategy_grp,consume_group,depp_callRqmt,controlCode,prod_supervisor,"
							+ "prod_schedProfile,storage_bin,storage_condition,minRemain_ShelfLife,tot_shelfLife,Serial_noProf,levelof_explitSrNo,insp_setupTick,"
							+ "gr_processingTime,qm_ProcActive,qm_controlKey,certificate_type,valueation_cat,valueation_class,price_control,price_unit,standardPrice,"
							+ "moveing_price,withQty_structure,overhead_group, enable,sale_unit,remark, uid, d_Id, uname,minSafetyStock,stage,sys_date)values(?,?, ?,?, ?,?, ?,?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,?)");
					/*ps_upload = con.prepareStatement("insert into  importfor(code,descr)values(?,?)");*/
					ps_upload.setString(1,vo.getMaterial_no());
					ps_upload.setString(2,vo.getInd_sector());
					ps_upload.setString(3, vo.getMaterial_type());
					ps_upload.setString(4, vo.getPlant());
					ps_upload.setString(5, vo.getStorage_loc());
					ps_upload.setString(6, vo.getSales_org());
					ps_upload.setString(7, vo.getDist_channel());
					ps_upload.setString(8, vo.getMat_name());
					
					ps_upload.setString(9, vo.getBaseUOM());
					ps_upload.setString(10, vo.getMatGroup());
					ps_upload.setString(11, vo.getOldMaterialNo());
					ps_upload.setString(12, vo.getExt_matGroup());
					ps_upload.setString(13, vo.getSize_dim());
					ps_upload.setString(14, vo.getGross_wt());
					ps_upload.setString(15, vo.getWtUnit());
					ps_upload.setString(16, vo.getNetWt());
					ps_upload.setString(17, vo.getDelivery_unit());
					ps_upload.setString(18, vo.getDivision());
					ps_upload.setString(19, vo.getJocg());
					ps_upload.setString(20, vo.getJosg());
					ps_upload.setString(21, vo.getJoig());
					ps_upload.setString(22, vo.getTax_ind());
					ps_upload.setString(23, vo.getMatStat_group());
					ps_upload.setString(24, vo.getAcct_assgnGroup());
					ps_upload.setString(25, vo.getGenItemCatGroup());
					ps_upload.setString(26, vo.getItemCatGroup());
					ps_upload.setString(27,vo.getMat_grp1());
					ps_upload.setString(28, vo.getMat_grp2());
					ps_upload.setString(29, vo.getAvailability_chk());
					ps_upload.setString(30, vo.getTrans_group());
					ps_upload.setString(31, vo.getLoad_group());
					ps_upload.setString(32, vo.getProfitCenter());
					ps_upload.setString(33, vo.getPurchase_Group());
					ps_upload.setString(34, vo.getBatch_indicator());
					ps_upload.setString(35, vo.getPur_valueKey());
					ps_upload.setString(36, vo.getMrp_group());
					ps_upload.setString(37, vo.getAbc_indicator());
					ps_upload.setString(38, vo.getMrpType());
					ps_upload.setString(39, vo.getReorderPoint());
					ps_upload.setString(40, vo.getMrp_Controller());
					ps_upload.setString(41, vo.getLotSizing_proc());
					ps_upload.setString(42, vo.getMin_LotSize());
					ps_upload.setString(43, vo.getMax_LotSize());
					ps_upload.setString(44, vo.getFixLot());
					ps_upload.setString(45, vo.getMaxStocklevel());
					ps_upload.setString(46, vo.getProcure_type());
					ps_upload.setString(47, vo.getSpecialProc());
					ps_upload.setString(48, vo.getProd_StorageLoc());
					ps_upload.setString(49, vo.getBackflush());
					ps_upload.setString(50, vo.getNotCoproduct());
					ps_upload.setString(51, vo.getInhouseProduction());
					ps_upload.setString(52, vo.getPlan_delTime());
					ps_upload.setString(53, vo.getSchMrg_Key());
					ps_upload.setString(54, vo.getSafety_stk());
					ps_upload.setString(55, vo.getStrategy_grp());
					ps_upload.setString(56, vo.getConsume_group());
					ps_upload.setString(57, vo.getDepp_callRqmt());
					ps_upload.setString(58, vo.getControlCode());
					ps_upload.setString(59, vo.getProd_supervisor());
					ps_upload.setString(60, vo.getProd_schedProfile());
					ps_upload.setString(61, vo.getStorage_bin());
					ps_upload.setString(62, vo.getStorage_condition());
					ps_upload.setString(63, vo.getMinRemain_ShelfLife());
					ps_upload.setString(64, vo.getTot_shelfLife());
					ps_upload.setString(65, vo.getSerial_noProf());
					ps_upload.setString(66, vo.getLevelof_explitSrNo());
					ps_upload.setString(67, vo.getInsp_setupTick());
					ps_upload.setString(68, vo.getGr_processingTime());
					ps_upload.setString(69, vo.getQm_ProcActive());
					ps_upload.setString(70, vo.getQm_controlKey());
					ps_upload.setString(71, vo.getCertificate_type());
					ps_upload.setString(72, vo.getValueation_cat());
					ps_upload.setString(73, vo.getValueation_class());
					ps_upload.setString(74, vo.getPrice_control());
					ps_upload.setString(75, vo.getPrice_unit());
					ps_upload.setString(76, vo.getStandardPrice());
					ps_upload.setString(77, vo.getMoveing_price());
					ps_upload.setString(78, vo.getWithQty_structure());
					ps_upload.setString(79, vo.getOverhead_group()); 
					ps_upload.setInt(80,1);
					ps_upload.setString(81, vo.getSale_unit());
					ps_upload.setString(82, vo.getRemark());
					ps_upload.setString(83, vo.getUid());
					ps_upload.setString(84, vo.getD_Id());
					ps_upload.setString(85, vo.getUname());
					ps_upload.setString(86, vo.getMinSafetyStock());
					ps_upload.setString(87, "1");
					ps_upload.setTimestamp(88, timeStamp);
					
					cnt = ps_upload.executeUpdate();
					
					ps_check  =con.prepareStatement("SELECT MAX(id) as maxd FROM sap_mastertran");   
					rs_check = ps_check.executeQuery();
					while (rs_check.next()) { 
						vo.setHid_mstString(rs_check.getString("maxd"));
					 }
					 }
				 }		 
					 if(editDataString.equalsIgnoreCase("1")){
				/*__________________________________________________________________________________________________________________________*/
				/*__________________________________________________________________________________________________________________________*/
						 ps_upload = con.prepareStatement("update sap_mastertran set material_no=?,ind_sector=?,material_type=?,plant=?,storage_loc=?,sales_org=?,dist_channel=?, mat_name=?,baseUOM=?,matGroup=?,oldMaterialNo=?,ext_matGroup=?,size_dim=?,gross_wt=?,wtUnit=?,netWt=?,delivery_unit=?,division=?,jocg=?,josg=?,joig=?,tax_ind=?,matStat_group=?,acct_assgnGroup=?,genItemCatGroup=?,itemCatGroup=?,mat_grp1=?,mat_grp2=?,availability_chk=?,trans_group=?,load_group=?,profitCenter=?,purchase_Group=?,batch_indicator=?,pur_valueKey=?,mrp_group=?,abc_indicator=?,mrpType=?,reorderPoint=?,mrp_Controller=?,lotSizing_proc=?,min_LotSize=?,max_LotSize=?,fixLot=?,MaxStocklevel=?,procure_type=?,specialProc=?,prod_StorageLoc=?,backflush=?,notCoproduct=?,inhouseProduction=?,plan_delTime=?,schMrg_Key=?,safety_stk=?,strategy_grp=?,consume_group=?,depp_callRqmt=?,controlCode=?,prod_supervisor=?,prod_schedProfile=?,storage_bin=?,storage_condition=?,minRemain_ShelfLife=?,tot_shelfLife=?,Serial_noProf=?,levelof_explitSrNo=?,insp_setupTick=?,gr_processingTime=?,qm_ProcActive=?,qm_controlKey=?,certificate_type=?,valueation_cat=?,valueation_class=?,price_control=?,price_unit=?,standardPrice=?,moveing_price=?,withQty_structure=?,overhead_group=?, enable=?,sale_unit=?,remark=?,minSafetyStock=?,stage=?,changeDate=?,last_changeBy=? where id="+Integer.parseInt(vo.getHid_mstString()));
							/*ps_upload = con.prepareStatement("insert into  importfor(code,descr)values(?,?)");*/
							ps_upload.setString(1,vo.getMaterial_no());
							ps_upload.setString(2,vo.getInd_sector());
							ps_upload.setString(3, vo.getMaterial_type());
							ps_upload.setString(4, vo.getPlant());
							ps_upload.setString(5, vo.getStorage_loc());
							ps_upload.setString(6, vo.getSales_org());
							ps_upload.setString(7, vo.getDist_channel());
							ps_upload.setString(8, vo.getMat_name());
							ps_upload.setString(9, vo.getBaseUOM());
							ps_upload.setString(10, vo.getMatGroup());
							ps_upload.setString(11, vo.getOldMaterialNo());
							ps_upload.setString(12, vo.getExt_matGroup());
							ps_upload.setString(13, vo.getSize_dim());
							ps_upload.setString(14, vo.getGross_wt());
							ps_upload.setString(15, vo.getWtUnit());
							ps_upload.setString(16, vo.getNetWt());
							ps_upload.setString(17, vo.getDelivery_unit());
							ps_upload.setString(18, vo.getDivision());
							ps_upload.setString(19, vo.getJocg());
							ps_upload.setString(20, vo.getJosg());
							ps_upload.setString(21, vo.getJoig());
							ps_upload.setString(22, vo.getTax_ind());
							ps_upload.setString(23, vo.getMatStat_group());
							ps_upload.setString(24, vo.getAcct_assgnGroup());
							ps_upload.setString(25, vo.getGenItemCatGroup());
							ps_upload.setString(26, vo.getItemCatGroup());
							ps_upload.setString(27,vo.getMat_grp1());
							ps_upload.setString(28, vo.getMat_grp2());
							ps_upload.setString(29, vo.getAvailability_chk());
							ps_upload.setString(30, vo.getTrans_group());
							ps_upload.setString(31, vo.getLoad_group());
							ps_upload.setString(32, vo.getProfitCenter());
							ps_upload.setString(33, vo.getPurchase_Group());
							ps_upload.setString(34, vo.getBatch_indicator());
							ps_upload.setString(35, vo.getPur_valueKey());
							ps_upload.setString(36, vo.getMrp_group());
							ps_upload.setString(37, vo.getAbc_indicator());
							ps_upload.setString(38, vo.getMrpType());
							ps_upload.setString(39, vo.getReorderPoint());
							ps_upload.setString(40, vo.getMrp_Controller());
							ps_upload.setString(41, vo.getLotSizing_proc());
							ps_upload.setString(42, vo.getMin_LotSize());
							ps_upload.setString(43, vo.getMax_LotSize());
							ps_upload.setString(44, vo.getFixLot());
							ps_upload.setString(45, vo.getMaxStocklevel());
							ps_upload.setString(46, vo.getProcure_type());
							ps_upload.setString(47, vo.getSpecialProc());
							ps_upload.setString(48, vo.getProd_StorageLoc());
							ps_upload.setString(49, vo.getBackflush());
							ps_upload.setString(50, vo.getNotCoproduct());
							ps_upload.setString(51, vo.getInhouseProduction());
							ps_upload.setString(52, vo.getPlan_delTime());
							ps_upload.setString(53, vo.getSchMrg_Key());
							ps_upload.setString(54, vo.getSafety_stk());
							ps_upload.setString(55, vo.getStrategy_grp());
							ps_upload.setString(56, vo.getConsume_group());
							ps_upload.setString(57, vo.getDepp_callRqmt());
							ps_upload.setString(58, vo.getControlCode());
							ps_upload.setString(59, vo.getProd_supervisor());
							ps_upload.setString(60, vo.getProd_schedProfile());
							ps_upload.setString(61, vo.getStorage_bin());
							ps_upload.setString(62, vo.getStorage_condition());
							ps_upload.setString(63, vo.getMinRemain_ShelfLife());
							ps_upload.setString(64, vo.getTot_shelfLife());
							ps_upload.setString(65, vo.getSerial_noProf());
							ps_upload.setString(66, vo.getLevelof_explitSrNo());
							ps_upload.setString(67, vo.getInsp_setupTick());
							ps_upload.setString(68, vo.getGr_processingTime());
							ps_upload.setString(69, vo.getQm_ProcActive());
							ps_upload.setString(70, vo.getQm_controlKey());
							ps_upload.setString(71, vo.getCertificate_type());
							ps_upload.setString(72, vo.getValueation_cat());
							ps_upload.setString(73, vo.getValueation_class());
							ps_upload.setString(74, vo.getPrice_control());
							ps_upload.setString(75, vo.getPrice_unit());
							ps_upload.setString(76, vo.getStandardPrice());
							ps_upload.setString(77, vo.getMoveing_price());
							ps_upload.setString(78, vo.getWithQty_structure());
							ps_upload.setString(79, vo.getOverhead_group()); 
							ps_upload.setInt(80,1);
							ps_upload.setString(81, vo.getSale_unit());
							ps_upload.setString(82, vo.getRemark()); 
							ps_upload.setString(83, vo.getMinSafetyStock());
							ps_upload.setString(84, "1");
							ps_upload.setTimestamp(85, timeStamp);
							ps_upload.setString(86, vo.getUid());
							 
							cnt = ps_upload.executeUpdate();
							masterNewDataString = vo.getMat_name();
							
							ps_upload = con.prepareStatement("select * from sap_mastertran where id="+Integer.parseInt(vo.getHid_mstString()));
							rs_check3 = ps_upload.executeQuery();
							while (rs_check3.next()) {
								ps_check3  = con_local.prepareStatement("select U_Email from user_tbl where U_Id="+ Integer.valueOf(rs_check3.getString("uid")));
								rs_check4 = ps_check3.executeQuery();
								while (rs_check4.next()) {
									emailArray.add(rs_check4.getString("U_Email"));
								}
							}
							
							query = "select * from approval_config_rel where stage>0 and enable=1 and dept_id='mst' and applied_to='mastercreate'";
							ps_check = con.prepareStatement(query);
							rs_check = ps_check.executeQuery();
							while(rs_check.next()){
								emailArray.add(rs_check.getString("email_id"));
							}
							
							if(vo.getPur_id()!=0){
								ps_upload = con.prepareStatement("update sap_mastertran set pur_teamID=? where id="+Integer.parseInt(vo.getHid_mstString()));
								ps_upload.setInt(1, vo.getPur_id());
								cnt = ps_upload.executeUpdate();
							}
							
							if(vo.getWrongID().equalsIgnoreCase("4")){
							ps_upload = con.prepareStatement("update sap_mastertran set stage=?,reject_flag=?,reject_date=?,reject_reason=? where id="+Integer.parseInt(vo.getHid_mstString()));
							ps_upload.setString(1,vo.getWrongID()); 
							ps_upload.setString(2,vo.getWrongID()); 
							ps_upload.setTimestamp(3, timeStamp);
							ps_upload.setString(4,vo.getCancellation());
							
							cnt=ps_upload.executeUpdate();
							this.rejectMaster(vo, response,masterNewDataString,emailArray);							
							}					
							/*__________________________________________________________________________________________________________________________*/	 
					 }
					
					/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
																									 /* Mail Configuration Start */
					/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
				 
						query = "";
						boolean flag=false;
						
						query = "select * from approval_config_rel where stage>0 and enable=1 and dept_id='pur' and applied_to='mastercreate'";
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
						int s_no=1;
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
						
							String subject = "New Material Master : " + masterNewDataString;
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
							sb.append("<b style='color: #0D265E;'>*** This is an automatically generated email from SAP !!! ***</b>");
							sb.append("<p>Please find below Material Master Data and update if any issues : </P>");
							
							sb.append("<table border='1' width='100%'><tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'><th width='5%' height='25'>S. No</th><th>Material Name</th><th>Material Type</th><th>Remark / Details / Required for </th><th>Status</th><th>Purchase Approval</th></tr>");

						    String status="", updated_by="";
						    
						  	ps_check = con.prepareStatement("select * from sap_mastertran where id="+Integer.parseInt(vo.getHid_mstString()));
							rs_check = ps_check.executeQuery();
							while (rs_check.next()) {
								ps_check2 = con.prepareStatement("select * from approval_config where stage in(SELECT stage FROM sap_mastertran where id="+rs_check.getString("id")+")");
								rs_check2 = ps_check2.executeQuery();
								while (rs_check2.next()) {
									status = rs_check2.getString("REMARK");
								}
								
								if(rs_check.getInt("pur_teamID")!=0){
								ps_check2 = con_local.prepareStatement("SELECT  u_name FROM user_tbl where u_id = " + rs_check.getInt("pur_teamID"));
								rs_check2 = ps_check2.executeQuery();
								while (rs_check2.next()) {
								updated_by = rs_check2.getString("u_name"); 
								}
								}
								
							sb.append("<tr><td style='text-align: center;'>"+ s_no +"</td><td>"+ rs_check.getString("mat_name") + "</td><td>"+ rs_check.getString("material_type") +"</td><td>"+rs_check.getString("remark")+"</td><td><b>"+status +"</b></td><td><b> Approved By : "+ updated_by +"</b></td></tr>"); 
								
							s_no ++;
								}
							sb.append("</table>");
							
							flag=true;
							}
							
							sb.append("<p><a href='http://192.168.0.7/sapmaster/'>Click Here</a> </p><p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"+
									"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
									"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
									"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
									"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
									"</font></p>");
						   
						/*	msg.setContent(sb.toString(), "text/html"); 
							Transport transport = mailSession.getTransport("smtp");
							transport.connect(host, user, pass);
							transport.sendMessage(msg, msg.getAllRecipients()); 
							transport.close();     */
							  
							BodyPart messageBodyPart = new MimeBodyPart();
							messageBodyPart.setContent(sb.toString(),"Text/html");
							// Create a multipar message
							/*Multipart multipart = new MimeMultipart();*/

							// Set text message part
							/*multipart.addBodyPart(messageBodyPart);*/

							// Part two is attachment
							/*messageBodyPart = new MimeBodyPart();
														
							String filename = "C:/reportxls/MasterTemplate"+val+".xls"; 
							
							DataSource source = new FileDataSource(filename);
							messageBodyPart.setDataHandler(new DataHandler(source));
							messageBodyPart.setFileName(filename);
							multipart.addBodyPart(messageBodyPart);

							// Send the complete message parts
							msg.setContent(multipart);*/
							 
							if(flag=true && editDataString.equalsIgnoreCase("0")){
								msg.setContent(sb.toString(), "text/html");
								Transport transport = mailSession.getTransport("smtp");
								transport.connect(host, user, pass);
								transport.sendMessage(msg, msg.getAllRecipients()); 
								transport.close();
							}  
							if(vo.getPur_id()!=0){
								msg.setContent(sb.toString(), "text/html");
								Transport transport = mailSession.getTransport("smtp");
								transport.connect(host, user, pass);
								transport.sendMessage(msg, msg.getAllRecipients()); 
								transport.close();
							}
							  
				/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 
			
					statusRecord = "Data upload Successful...."; 
				 response.sendRedirect("Home_MST.jsp?success=" + statusRecord);				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
// *********************************************************************************************************************************************************************************

	
	
	
	
	
// *********************************************************************************************************************************************************************************
// *********************************************************************************************************************************************************************************

	public void rejectMaster(NewMaster_VO vo, HttpServletResponse response, String masterNewDataString, ArrayList<String> emailArray2) {
		try{
			String query = "";
			PreparedStatement ps_check=null,ps_check2=null;
			ResultSet rs_check=null,rs_check2=null;
			boolean flag=false;
			Connection con =  Connection_Utility.getConnectionMaster();
			ArrayList<String> emailArray = new ArrayList<String>();
			query = "select * from approval_config_rel where stage>0  and applied_to='mastercreate'";
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
			int s_no=1,cnt=0;
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
			
			// System.out.println("Array = " + emailArray + " = = " + vo.getHid_mstString());
			
				String subject = "Material Master Rejected : " + masterNewDataString;
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
				 
				sb.append("<b style='color: #0D265E;'>*** This is an automatically generated email from SAP !!! ***</b>");
				sb.append("<p>Below Material Master Data is Rejected : </P>");
				
				sb.append("<table border='1' width='100%'>"
						+ "<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"
						+ "<th width='5%' height='25'>S. No</th>"
						+ "<th>Material Name</th>"
						+ "<th>Material Type</th>"
						+ "<th>Remark / Details / Required for </th>"
						+ "<th>Status</th>"
						+ "<th>Reject Reason</th>"
						+ "<th>Rejected By</th>"
						+ "</tr>");

			    String status="Reject";
			  	ps_check = con.prepareStatement("SELECT * FROM sap_mastertran where id="+Integer.parseInt(vo.getHid_mstString()));
				rs_check = ps_check.executeQuery();
				while (rs_check.next()) {					
				sb.append("<tr><td style='text-align: center;'>"+ s_no +"</td><td>"+ rs_check.getString("mat_name") + "</td><td>"+ rs_check.getString("material_type") +"</td><td>"+rs_check.getString("remark")+"</td><td><b>"+status +"</b></td><td><b>"+rs_check.getString("reject_reason")+"</b></td><td><b>"+vo.getUname()+"</b></td></tr>");
				flag=true;
				}
				sb.append("</table>"); 
				
				sb.append("<p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"+
						"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
						"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
						"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
						"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
						"</font></p>");
			   
				BodyPart messageBodyPart = new MimeBodyPart();
				messageBodyPart.setContent(sb.toString(),"Text/html");
					if(flag=true){
					msg.setContent(sb.toString(), "text/html");
					Transport transport = mailSession.getTransport("smtp");
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients()); 
					transport.close();
				}
				 
	 }catch(Exception e){
		 e.printStackTrace();
	 }
		
		
	}
}