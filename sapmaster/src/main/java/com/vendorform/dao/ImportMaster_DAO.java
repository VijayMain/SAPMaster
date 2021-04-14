package com.vendorform.dao;

import it.muthagroup.connectionUtility.Connection_Utility;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList; 
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vendorform.vo.ImportMaster_VO;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook; 

public class ImportMaster_DAO {

	public void attach_File(HttpServletResponse response, ImportMaster_VO bean, HttpSession session) { 
		try {
			Connection con =  Connection_Utility.getConnectionMaster();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			String d_Id = session.getAttribute("dept_id").toString();
			String uname = session.getAttribute("username").toString(); 
			String  statusRecord = "" ;			
			
			// System.out.println(" database = " + dbName);
			String datafor = bean.getDatafor();
			 
			PreparedStatement ps = con.prepareStatement("insert into fileupload (filename,attachment)values(?,?)");
			ps.setString(1, bean.getFileName());	
			ps.setBlob(2, bean.getFile_blob());   
			int up =	ps.executeUpdate();			
			if(up>0){
				/*____________________________________________________________________________________________________*/
				int ct = 0, val = 0;
				PreparedStatement ps_ct = con.prepareStatement("select MAX(id) as maxid from fileupload");
				ResultSet rs_ct = ps_ct.executeQuery();
				while (rs_ct.next()) {
					ct = rs_ct.getInt("maxid");
				}
				PreparedStatement ps_blb = con.prepareStatement("select * from fileupload where id=" + ct);
				ResultSet rs_blb = ps_blb.executeQuery();
				while (rs_blb.next()) {
					Blob blob = rs_blb.getBlob("attachment");
					InputStream in = blob.getBinaryStream();
					ArrayList alistFile = new ArrayList();
					File folder = new File("C:/reportxls");
					File[] listOfFiles = folder.listFiles();
					String listname = "";
					val = listOfFiles.length + 1;
					File exlFile = new File("C:/reportxls/DataSAPMaster" + val + ".xls");
					OutputStream out = new FileOutputStream(exlFile);
					byte[] buff = new byte[4096]; 		// how much of the blob to read/write at a time
					int len = 0;
					while ((len = in.read(buff)) != -1) {
						out.write(buff, 0, len);
					}
				}
				
				ps_ct = con.prepareStatement("delete FROM [SAPMaster].[dbo].[fileupload]  where id=" + ct);
				int upt = ps_ct.executeUpdate();
				
				String EXCEL_FILE_LOCATION = "C:/reportxls/DataSAPMaster" + val + ".xls";
				Workbook wrk1 = Workbook.getWorkbook(new File(EXCEL_FILE_LOCATION));
				/*____________________________________________________________________________________________________*/
				Sheet sheet1 = wrk1.getSheet(0);
				int rows = sheet1.getRows();
				int cols = sheet1.getColumns(); 
				PreparedStatement ps_check=null,ps_upload=null;
				ResultSet rs_check=null,rs_upload=null;
				int cnt =0;
				// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				if(datafor.equalsIgnoreCase("2")){
				for(int i=1;i<rows;i++){
					Cell colArow1 = sheet1.getCell(0, i);
					Cell colArow2 = sheet1.getCell(1, i);
					Cell colArow3 = sheet1.getCell(2, i);
					Cell colArow4 = sheet1.getCell(3, i);
					String str_colArow1 = colArow1.getContents();
					String str_colArow2 = colArow2.getContents();
					String str_colArow3 = colArow3.getContents();
					String str_colArow4 = colArow4.getContents();
					String query = "select * from master_data where code ='" + str_colArow1 +  "' and descr='" + str_colArow2 +  "' and plant='" + str_colArow3 +  "' and tablekey='" + str_colArow4 +"'";		
					/*String query = "select * from importfor where code ='" + str_colArow1 +  "' and descr='" + str_colArow2 +  "'";*/		
					
					ps_check = con.prepareStatement(query);
					rs_check = ps_check.executeQuery();
						 if (!rs_check.next() ) {
							ps_upload = con.prepareStatement("insert into  master_data(code,descr,plant,tablekey,enable)values(?,?,?,?,?)");
							/*ps_upload = con.prepareStatement("insert into  importfor(code,descr,enable)values(?,?,?)");*/
							ps_upload.setString(1, str_colArow1);
							ps_upload.setString(2, str_colArow2);
							ps_upload.setString(3, str_colArow3);
							ps_upload.setString(4, str_colArow4);
							ps_upload.setInt(5,1);
							cnt = ps_upload.executeUpdate();
							statusRecord = "Import Successful....";
						}else{
							statusRecord = "Already Available....";
						//	System.out.println("Already Available");
						}
				}
				 
				//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				//----------------------------------------------------------- Data Template Uploads ---------------------------------------------------------------------------
				//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				}else if(datafor.equalsIgnoreCase("1")){
					
					for(int i=1;i<rows;i++){
						
						Cell material_no =sheet1.getCell(1, i);
						Cell ind_sector =sheet1.getCell(2, i);
						Cell material_type =sheet1.getCell(3, i);
						Cell plant =sheet1.getCell(4, i);
						Cell storage_loc =sheet1.getCell(5, i);
						Cell sales_org =sheet1.getCell(6, i);
						Cell dist_channel =sheet1.getCell(7, i);
						Cell mat_name =sheet1.getCell(8, i);
						Cell baseUOM =sheet1.getCell(9, i);
						Cell matGroup =sheet1.getCell(10, i);
						Cell oldMaterialNo =sheet1.getCell(11, i);
						Cell ext_matGroup =sheet1.getCell(12, i);
						Cell size_dim =sheet1.getCell(13, i);
						Cell gross_wt =sheet1.getCell(14, i);
						Cell wtUnit =sheet1.getCell(15, i);
						Cell netWt =sheet1.getCell(16, i);
						Cell delivery_unit =sheet1.getCell(17, i);
						Cell division =sheet1.getCell(18, i);
						Cell jocg =sheet1.getCell(19, i);
						Cell josg =sheet1.getCell(20, i);
						Cell joig =sheet1.getCell(21, i);
						Cell tax_ind =sheet1.getCell(22, i);
						Cell matStat_group =sheet1.getCell(23, i);
						Cell acct_assgnGroup =sheet1.getCell(24, i);
						Cell genItemCatGroup =sheet1.getCell(25, i);
						Cell itemCatGroup =sheet1.getCell(26, i);
						Cell mat_grp1 =sheet1.getCell(27, i);
						Cell mat_grp2 =sheet1.getCell(28, i);
						Cell availability_chk =sheet1.getCell(29, i);
						Cell trans_group =sheet1.getCell(30, i);
						Cell load_group =sheet1.getCell(31, i);
						Cell profitCenter =sheet1.getCell(32, i);
						Cell purchase_Group =sheet1.getCell(33, i);
						Cell batch_indicator =sheet1.getCell(34, i);
						Cell pur_valueKey =sheet1.getCell(35, i);
						Cell mrp_group =sheet1.getCell(36, i);
						Cell abc_indicator =sheet1.getCell(37, i);
						Cell mrpType =sheet1.getCell(38, i);
						Cell reorderPoint =sheet1.getCell(39, i);
						Cell mrp_Controller =sheet1.getCell(40, i);
						Cell lotSizing_proc =sheet1.getCell(41, i);
						Cell min_LotSize =sheet1.getCell(42, i);
						Cell max_LotSize =sheet1.getCell(43, i);
						Cell fixLot =sheet1.getCell(44, i);
						Cell MaxStocklevel =sheet1.getCell(45, i);
						Cell procure_type =sheet1.getCell(46, i);
						Cell specialProc =sheet1.getCell(47, i);
						Cell prod_StorageLoc =sheet1.getCell(48, i);
						Cell backflush =sheet1.getCell(49, i);
						Cell notCoproduct =sheet1.getCell(50, i);
						Cell inhouseProduction =sheet1.getCell(51, i);
						Cell plan_delTime =sheet1.getCell(52, i);
						Cell schMrg_Key =sheet1.getCell(53, i);
						Cell safety_stk =sheet1.getCell(54, i);
						Cell strategy_grp =sheet1.getCell(55, i);
						Cell consume_group =sheet1.getCell(56, i);
						Cell depp_callRqmt =sheet1.getCell(57, i);
						Cell controlCode =sheet1.getCell(58, i);
						Cell prod_supervisor =sheet1.getCell(59, i);
						Cell prod_schedProfile =sheet1.getCell(60, i);
						Cell storage_bin =sheet1.getCell(61, i);
						Cell storage_condition =sheet1.getCell(62, i);
						Cell minRemain_ShelfLife =sheet1.getCell(63, i);
						Cell tot_shelfLife =sheet1.getCell(64, i);
						Cell Serial_noProf =sheet1.getCell(65, i);
						Cell levelof_explitSrNo =sheet1.getCell(66, i);
						Cell insp_setupTick =sheet1.getCell(67, i);
						Cell gr_processingTime =sheet1.getCell(68, i);
						Cell qm_ProcActive =sheet1.getCell(69, i);
						Cell qm_controlKey =sheet1.getCell(70, i);
						Cell certificate_type =sheet1.getCell(71, i);
						Cell valueation_cat =sheet1.getCell(72, i);
						Cell valueation_class =sheet1.getCell(73, i);
						Cell price_control =sheet1.getCell(74, i);
						Cell price_unit =sheet1.getCell(75, i);
						Cell standardPrice =sheet1.getCell(76, i);
						Cell moveing_price =sheet1.getCell(77, i);
						Cell withQty_structure =sheet1.getCell(78, i);
						Cell overhead_group =sheet1.getCell(79, i);
						/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/		
						String material_no1 =material_no.getContents();
						String ind_sector1 =ind_sector.getContents();
						String material_type1 =material_type.getContents();
						String plant1 =plant.getContents();
						String storage_loc1 =storage_loc.getContents();
						String sales_org1 =sales_org.getContents();
						String dist_channel1 =dist_channel.getContents();
						String mat_name1 =mat_name.getContents();
						String baseUOM1 =baseUOM.getContents();
						String matGroup1 =matGroup.getContents();
						String oldMaterialNo1 =oldMaterialNo.getContents();
						String ext_matGroup1 =ext_matGroup.getContents();
						String size_dim1 =size_dim.getContents();
						String gross_wt1 =gross_wt.getContents();
						String wtUnit1 =wtUnit.getContents();
						String netWt1 =netWt.getContents();
						String delivery_unit1 =delivery_unit.getContents();
						String division1 =division.getContents();
						String jocg1 =jocg.getContents();
						String josg1 =josg.getContents();
						String joig1 =joig.getContents();
						String tax_ind1 =tax_ind.getContents();
						String matStat_group1 =matStat_group.getContents();
						String acct_assgnGroup1 =acct_assgnGroup.getContents();
						String genItemCatGroup1 =genItemCatGroup.getContents();
						String itemCatGroup1 =itemCatGroup.getContents();
						String mat_grp11 =mat_grp1.getContents();
						String mat_grp21 =mat_grp2.getContents();
						String availability_chk1 =availability_chk.getContents();
						String trans_group1 =trans_group.getContents();
						String load_group1 =load_group.getContents();
						String profitCenter1 =profitCenter.getContents();
						String purchase_Group1 =purchase_Group.getContents();
						String batch_indicator1 =batch_indicator.getContents();
						String pur_valueKey1 =pur_valueKey.getContents();
						String mrp_group1 =mrp_group.getContents();
						String abc_indicator1 =abc_indicator.getContents();
						String mrpType1 =mrpType.getContents();
						String reorderPoint1 =reorderPoint.getContents();
						String mrp_Controller1 =mrp_Controller.getContents();
						String lotSizing_proc1 =lotSizing_proc.getContents();
						String min_LotSize1 =min_LotSize.getContents();
						String max_LotSize1 =max_LotSize.getContents();
						String fixLot1 =fixLot.getContents();
						String MaxStocklevel1 =MaxStocklevel.getContents();
						String procure_type1 =procure_type.getContents();
						String specialProc1 =specialProc.getContents();
						String prod_StorageLoc1 =prod_StorageLoc.getContents();
						String backflush1 =backflush.getContents();
						String notCoproduct1 =notCoproduct.getContents();
						String inhouseProduction1 =inhouseProduction.getContents();
						String plan_delTime1 =plan_delTime.getContents();
						String schMrg_Key1 =schMrg_Key.getContents();
						String safety_stk1 =safety_stk.getContents();
						String strategy_grp1 =strategy_grp.getContents();
						String consume_group1 =consume_group.getContents();
						String depp_callRqmt1 =depp_callRqmt.getContents();
						String controlCode1 =controlCode.getContents();
						String prod_supervisor1 =prod_supervisor.getContents();
						String prod_schedProfile1 =prod_schedProfile.getContents();
						String storage_bin1 =storage_bin.getContents();
						String storage_condition1 =storage_condition.getContents();
						String minRemain_ShelfLife1 =minRemain_ShelfLife.getContents();
						String tot_shelfLife1 =tot_shelfLife.getContents();
						String Serial_noProf1 =Serial_noProf.getContents();
						String levelof_explitSrNo1 =levelof_explitSrNo.getContents();
						String insp_setupTick1 =insp_setupTick.getContents();
						String gr_processingTime1 =gr_processingTime.getContents();
						String qm_ProcActive1 =qm_ProcActive.getContents();
						String qm_controlKey1 =qm_controlKey.getContents();
						String certificate_type1 =certificate_type.getContents();
						String valueation_cat1 =valueation_cat.getContents();
						String valueation_class1 =valueation_class.getContents();
						String price_control1 =price_control.getContents();
						String price_unit1 =price_unit.getContents();
						String standardPrice1 =standardPrice.getContents();
						String moveing_price1 =moveing_price.getContents();
						String withQty_structure1 =withQty_structure.getContents();
						String overhead_group1 =overhead_group.getContents();
						
						String query = "select * from sap_mastertran where material_no ='" + material_no1 +  "' and mat_name='" + mat_name1 +  "' and plant='" + plant1 +  "' and division='" + division1 +"'";		
						/*String query = "select * from importfor where code ='" + str_colArow1 +  "' and descr='" + str_colArow2 +  "'";*/
						
						ps_check = con.prepareStatement(query);
						rs_check = ps_check.executeQuery();	
							 if (!rs_check.next() ) {
								ps_upload = con.prepareStatement("insert into  sap_mastertran(material_no,ind_sector,material_type,plant,storage_loc,sales_org,dist_channel,mat_name,baseUOM,matGroup,oldMaterialNo,ext_matGroup,size_dim,gross_wt,wtUnit,netWt,delivery_unit,division,jocg,josg,joig,tax_ind,matStat_group,acct_assgnGroup,genItemCatGroup,itemCatGroup,mat_grp1,mat_grp2,availability_chk,trans_group,load_group,profitCenter,purchase_Group,batch_indicator,pur_valueKey,mrp_group,abc_indicator,mrpType,reorderPoint,mrp_Controller,lotSizing_proc,min_LotSize,max_LotSize,fixLot,MaxStocklevel,procure_type,specialProc,prod_StorageLoc,backflush,notCoproduct,inhouseProduction,plan_delTime,schMrg_Key,safety_stk,strategy_grp,consume_group,depp_callRqmt,controlCode,prod_supervisor,prod_schedProfile,storage_bin,storage_condition,minRemain_ShelfLife,tot_shelfLife,Serial_noProf,levelof_explitSrNo,insp_setupTick,gr_processingTime,qm_ProcActive,qm_controlKey,certificate_type,valueation_cat,valueation_class,price_control,price_unit,standardPrice,moveing_price,withQty_structure,overhead_group, enable, uid, d_Id, uname,stage)values(?,? , ? , ? , ?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?,	?)");
								/*ps_upload = con.prepareStatement("insert into  importfor(code,descr)values(?,?)");*/
								ps_upload.setString(1,material_no1);
								ps_upload.setString(2,ind_sector1);
								ps_upload.setString(3,material_type1);
								ps_upload.setString(4,plant1);
								ps_upload.setString(5,storage_loc1);
								ps_upload.setString(6,sales_org1);
								ps_upload.setString(7,dist_channel1);
								ps_upload.setString(8,mat_name1);
								ps_upload.setString(9,baseUOM1);
								ps_upload.setString(10,matGroup1);
								ps_upload.setString(11,oldMaterialNo1);
								ps_upload.setString(12,ext_matGroup1);
								ps_upload.setString(13,size_dim1);
								ps_upload.setString(14,gross_wt1);
								ps_upload.setString(15,wtUnit1);
								ps_upload.setString(16,netWt1);
								ps_upload.setString(17,delivery_unit1);
								ps_upload.setString(18,division1);
								ps_upload.setString(19,jocg1);
								ps_upload.setString(20,josg1);
								ps_upload.setString(21,joig1);
								ps_upload.setString(22,tax_ind1);
								ps_upload.setString(23,matStat_group1);
								ps_upload.setString(24,acct_assgnGroup1);
								ps_upload.setString(25,genItemCatGroup1);
								ps_upload.setString(26,itemCatGroup1);
								ps_upload.setString(27,mat_grp11);
								ps_upload.setString(28,mat_grp21);
								ps_upload.setString(29,availability_chk1);
								ps_upload.setString(30,trans_group1);
								ps_upload.setString(31,load_group1);
								ps_upload.setString(32,profitCenter1);
								ps_upload.setString(33,purchase_Group1);
								ps_upload.setString(34,batch_indicator1);
								ps_upload.setString(35,pur_valueKey1);
								ps_upload.setString(36,mrp_group1);
								ps_upload.setString(37,abc_indicator1);
								ps_upload.setString(38,mrpType1);
								ps_upload.setString(39,reorderPoint1);
								ps_upload.setString(40,mrp_Controller1);
								ps_upload.setString(41,lotSizing_proc1);
								ps_upload.setString(42,min_LotSize1);
								ps_upload.setString(43,max_LotSize1);
								ps_upload.setString(44,fixLot1);
								ps_upload.setString(45,MaxStocklevel1);
								ps_upload.setString(46,procure_type1);
								ps_upload.setString(47,specialProc1);
								ps_upload.setString(48,prod_StorageLoc1);
								ps_upload.setString(49,backflush1);
								ps_upload.setString(50,notCoproduct1);
								ps_upload.setString(51,inhouseProduction1);
								ps_upload.setString(52,plan_delTime1);
								ps_upload.setString(53,schMrg_Key1);
								ps_upload.setString(54,safety_stk1);
								ps_upload.setString(55,strategy_grp1);
								ps_upload.setString(56,consume_group1);
								ps_upload.setString(57,depp_callRqmt1);
								ps_upload.setString(58,controlCode1);
								ps_upload.setString(59,prod_supervisor1);
								ps_upload.setString(60,prod_schedProfile1);
								ps_upload.setString(61,storage_bin1);
								ps_upload.setString(62,storage_condition1);
								ps_upload.setString(63,minRemain_ShelfLife1);
								ps_upload.setString(64,tot_shelfLife1);
								ps_upload.setString(65,Serial_noProf1);
								ps_upload.setString(66,levelof_explitSrNo1);
								ps_upload.setString(67,insp_setupTick1);
								ps_upload.setString(68,gr_processingTime1);
								ps_upload.setString(69,qm_ProcActive1);
								ps_upload.setString(70,qm_controlKey1);
								ps_upload.setString(71,certificate_type1);
								ps_upload.setString(72,valueation_cat1);
								ps_upload.setString(73,valueation_class1);
								ps_upload.setString(74,price_control1);
								ps_upload.setString(75,price_unit1);
								ps_upload.setString(76,standardPrice1);
								ps_upload.setString(77,moveing_price1);
								ps_upload.setString(78,withQty_structure1);
								ps_upload.setString(79,overhead_group1);
								ps_upload.setInt(80,1);
								ps_upload.setInt(81,uid);
								ps_upload.setString(82,d_Id);
								ps_upload.setString(83,uname);
								ps_upload.setString(84,"0");
								cnt = ps_upload.executeUpdate();
								statusRecord = "Import Successful....";
							}else{
								statusRecord = "Already Available....";
								// System.out.println("Already Available");
							}
					}
				}else{
					response.sendRedirect("ImportFile.jsp?success=No Data");	
				}
				// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				/*______________________________________________________________________________________________*/				
				
				response.sendRedirect("ImportFile.jsp?success=" + statusRecord);				
			}else{
				response.sendRedirect("ImportFile.jsp?success=" + statusRecord);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
	
	// *******************************************************************************************************************************************************************************
	// *******************************************************************************************************************************************************************************
	// ****************************************************************************** Bulk Material Upload ***********************************************************************
	// *******************************************************************************************************************************************************************************
	// *******************************************************************************************************************************************************************************
	
	public void attachBulkMaterial_File(HttpServletResponse response, ImportMaster_VO bean, HttpSession session) {
		try {
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
			PreparedStatement ps_checkAvail =null;
			ResultSet rs_checkAvail =null;
			
			Connection con =  Connection_Utility.getConnectionMaster();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			String d_Id = session.getAttribute("dept_id").toString();
			String uname = session.getAttribute("username").toString(); 
			String  statusRecord = "";
			 
			String datafor = bean.getDatafor();
			 
			PreparedStatement ps = con.prepareStatement("insert into MaterialMaster_Template (fileName,file_for,enable,attachment,uploaded_by,uploaded_date)values(?,?,?,?,?,?)");
			ps.setString(1, bean.getFileName());
			ps.setString(2, datafor);
			ps.setInt(3, 1);
			ps.setBlob(4, bean.getFile_blob());	 
			ps.setString(5, uname);
			ps.setTimestamp(6, timeStamp);
			
			int up =	ps.executeUpdate();
			
			if(up>0){
				/*____________________________________________________________________________________________________*/
				int ct = 0, val = 0;
				PreparedStatement ps_ct = con.prepareStatement("select MAX(id) as maxid from MaterialMaster_Template");
				ResultSet rs_ct = ps_ct.executeQuery();
				while (rs_ct.next()) {
					ct = rs_ct.getInt("maxid");
				}
				
				PreparedStatement ps_blb = con.prepareStatement("select * from MaterialMaster_Template where id=" + ct);
				ResultSet rs_blb = ps_blb.executeQuery();
				while (rs_blb.next()) {
					Blob blob = rs_blb.getBlob("attachment");
					InputStream in = blob.getBinaryStream();
					ArrayList alistFile = new ArrayList();
					File folder = new File("C:/reportxls");
					File[] listOfFiles = folder.listFiles();
					String listname = "";
					val = listOfFiles.length + 1;
					File exlFile = new File("C:/reportxls/SAPMasterFile" + val + ".xls");
					OutputStream out = new FileOutputStream(exlFile);
					byte[] buff = new byte[4096]; 		// how much of the blob to read/write at a time
					int len = 0;
					while ((len = in.read(buff)) != -1) {
						out.write(buff, 0, len);
					}
				}
								
				String EXCEL_FILE_LOCATION = "C:/reportxls/SAPMasterFile" + val + ".xls";
				Workbook wrk1 = Workbook.getWorkbook(new File(EXCEL_FILE_LOCATION));
				/*____________________________________________________________________________________________________*/
				Sheet sheet1 = wrk1.getSheet(0);
				int rows = sheet1.getRows();
				int cols = sheet1.getColumns(); 
				PreparedStatement ps_check=null,ps_upload=null;
				ResultSet rs_check=null,rs_upload=null;
				int cnt =0;
				ArrayList impDataArrayList = new ArrayList(); 
				ArrayList alreadyAvailMat = new ArrayList(); 
				// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				String valueation_class="";
			
				for(int i=1;i<rows;i++){
					for(int j=0; j<21; j++){
					impDataArrayList.add(sheet1.getCell(j, i).getContents());
					}
					// System.out.println("Data here = " + impDataArrayList.get(1) + " = = " +  impDataArrayList.get(6));
					String query = "select * from sap_mastertran where material_type='" + impDataArrayList.get(1) +  "' and mat_name='" + impDataArrayList.get(6) +  "' and enable=1";
					ps_check = con.prepareStatement(query);
					rs_check = ps_check.executeQuery();
						 if (!rs_check.next() ) {
							 ps_checkAvail =con.prepareStatement("select * from master_data where tablekey ='valueation_class' and plant='halb'");
							 rs_checkAvail = ps_checkAvail.executeQuery();
							 
							ps_upload = con.prepareStatement("insert into  sap_mastertran(mat_name,ind_sector,oldMaterialNo,baseUOM,netWt,plant,wtUnit,matGroup,ext_matGroup,storage_loc,"
									+ "division,genItemCatGroup,gross_wt,sales_org,dist_channel,profitCenter,controlCode,purchase_Group,procure_type,prod_StorageLoc,backflush,strategy_grp,"
									+ "valueation_class,moveing_price,price_control,price_unit,remark,uid,d_Id,uname,material_type,enable,stage,sys_date)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							ps_upload.setString(1,impDataArrayList.get(6).toString())	;
							ps_upload.setString(2,"M")	;
							ps_upload.setString(3,impDataArrayList.get(9).toString())	;
							ps_upload.setString(4,impDataArrayList.get(7).toString())	;
							ps_upload.setString(5,impDataArrayList.get(13).toString())	;
							ps_upload.setString(6,impDataArrayList.get(2).toString())	;
							ps_upload.setString(7,impDataArrayList.get(12).toString())	;
							ps_upload.setString(8,impDataArrayList.get(8).toString())	;
							ps_upload.setString(9,impDataArrayList.get(10).toString())	;
							ps_upload.setString(10,impDataArrayList.get(3).toString())	;
							ps_upload.setString(11,impDataArrayList.get(14).toString())	;
							ps_upload.setString(12,"NORM")	;
							ps_upload.setString(13,impDataArrayList.get(11).toString())	;
							ps_upload.setString(14,impDataArrayList.get(4).toString())	;
							ps_upload.setString(15,impDataArrayList.get(5).toString())	;
							ps_upload.setString(16,impDataArrayList.get(15).toString())	;
							ps_upload.setString(17,impDataArrayList.get(18).toString())	;
							ps_upload.setString(18,impDataArrayList.get(16).toString())	;
							ps_upload.setString(19,"X")	;
							ps_upload.setString(20,impDataArrayList.get(17).toString())	;
							ps_upload.setString(21,"1")	;
							ps_upload.setString(22,"10")	;
							ps_upload.setString(23,valueation_class)	;
							ps_upload.setString(24,impDataArrayList.get(19).toString())	;
							ps_upload.setString(25,"V")	;
							ps_upload.setString(26,"1")	;
							ps_upload.setString(27,impDataArrayList.get(20).toString())	;
							ps_upload.setString(28,String.valueOf(uid))	;
							ps_upload.setString(29,d_Id)	;
							ps_upload.setString(30,uname)	;
							ps_upload.setString(31,impDataArrayList.get(1).toString())	;
							ps_upload.setString(32,"1")	;
							ps_upload.setString(33,"1")	;
							ps_upload.setTimestamp(34,timeStamp)	;

							cnt = ps_upload.executeUpdate();

							statusRecord = "Import Successful....";
							impDataArrayList.clear();
							// System.out.println("Data here = " + statusRecord);
						}else{
							// System.out.println("Data here = " + statusRecord);
							alreadyAvailMat.add( impDataArrayList.get(1).toString() +" " + impDataArrayList.get(6).toString());
							statusRecord = "Already Available....";
							// System.out.println("Already Available " + alreadyAvailMat);
							// System.out.println("Data here = " + statusRecord);
						}
						 impDataArrayList.clear();
				}
				//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
				// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				response.sendRedirect("BulkMat_Create.jsp?success=" + statusRecord);
			}else{
				response.sendRedirect("BulkMat_Create.jsp?success=" + statusRecord);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}