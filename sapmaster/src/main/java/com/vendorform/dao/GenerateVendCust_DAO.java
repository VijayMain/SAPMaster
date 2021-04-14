package com.vendorform.dao;

import it.muthagroup.connectionUtility.Connection_Utility;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import com.vendorform.vo.NewVendCustMaster_VO;

public class GenerateVendCust_DAO {

	public void setGenerateExcel(NewVendCustMaster_VO vo,
			HttpServletResponse response, ServletContext context) {
		try {
			Connection con =  Connection_Utility.getConnectionMaster();
			PreparedStatement ps_mst = null, ps_mst1=null;
			ResultSet rs_mst = null,rs_mst1=null;
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

			
			ps_mst = con.prepareStatement("update sap_masterVendCust set BP_Group=?, BP_Role=?, Cust_ReconACC=?, Vend_ReconACC=?, Cust_Price_Proc=?, Schema_Group=?, stage=?,acct_assign_grp=?,name_org3=?, name_org4=?"
					+ ",company=?,cust_vend=?,reason_for=?,name_org=?,name_org2=?,postal_code=?,city=?,country=?,region=?,sales_org=?,dist_channel=?,division=?,currency=?,shipping_cond=?,vendor_pay_term=?,cust_pay_term=?,gst_no=?,purchage_group=?,purchase_org=?,vendor_currency=?,inco_term=?,inco_location=?,pan_no=?,email=?,mobile_no=?,remark=?,search_term=?,address1=?,address2=?,address3=?,address4=?,create_date=? where id="+Integer.valueOf(vo.getHid()));
			ps_mst.setString(1, vo.getBP_Group());
			ps_mst.setString(2, vo.getRole());
			ps_mst.setString(3, vo.getCust_recAcc());
			ps_mst.setString(4, vo.getVendor_recAcc());
			ps_mst.setString(5, vo.getCust_priceProc());
			ps_mst.setString(6, vo.getSchema_group());	
			ps_mst.setString(7, "2");
			ps_mst.setString(8, vo.getAcct_assign_grp());
			ps_mst.setString(9, vo.getName_org3());
			ps_mst.setString(10, vo.getName_org4());
			ps_mst.setString(11,  vo.getCompany());	
			ps_mst.setString(12,  vo.getCust_vend());
			ps_mst.setString(13,  vo.getReason_for());
			ps_mst.setString(14,    vo.getName_org());
			ps_mst.setString(15,   vo.getName_org2() );
			ps_mst.setString(16,   vo.getPostal_code() );
			ps_mst.setString(17,    vo.getCity());
			ps_mst.setString(18,   vo.getCountry() );
			ps_mst.setString(19,   vo.getRegion() );
			ps_mst.setString(20,   vo.getSales_org() );
			ps_mst.setString(21,   vo.getDist_channel() );
			ps_mst.setString(22,   vo.getDivision() );
			ps_mst.setString(23,   vo.getCurrency() );
			ps_mst.setString(24,   vo.getShipping_cond() );
			ps_mst.setString(25,   vo.getVendor_pay_term() );
			ps_mst.setString(26,   vo.getCust_pay_term() );
			ps_mst.setString(27,   vo.getGst_no() );
			ps_mst.setString(28,   vo.getPurchage_group() );
			ps_mst.setString(29,   vo.getPurchase_org() );
			ps_mst.setString(30,   vo.getVendor_currency() );
			ps_mst.setString(31,   vo.getInco_term() );
			ps_mst.setString(32,   vo.getInco_location() );
			ps_mst.setString(33,   vo.getPan_no() );
			ps_mst.setString(34,   vo.getEmail() );
			ps_mst.setString(35,   vo.getMobile_no() );
			ps_mst.setString(36,   vo.getRemark() );
			ps_mst.setString(37,   vo.getSearch_term() );
			ps_mst.setString(38,   vo.getAddress1() );
			ps_mst.setString(39,   vo.getAddress2() );
			ps_mst.setString(40,   vo.getAddress3() );
			ps_mst.setString(41,   vo.getAddress4() );	
			ps_mst.setTimestamp(42, timeStamp);
			
			int up = ps_mst.executeUpdate();
			
			//******************************* Excel Format *******************************************
			int row=1,col=0,sr=1;
			ArrayList alistFile = new ArrayList();
			File folder = new File("C:/reportxls");
			File[] listOfFiles = folder.listFiles();
			String listname = "";
			
		 	int val = listOfFiles.length + 1; 
			
			File exlFile = new File("C:/reportxls/BulkUpload"+val+".xls");
		    WritableWorkbook writableWorkbook = Workbook.createWorkbook(exlFile); 
		    WritableSheet writableSheet = writableWorkbook.createSheet("Sheet1", 0);
		    
		    Colour bckcolor = Colour.CORAL;
		    WritableFont font = new WritableFont(WritableFont.ARIAL);
		    font.setColour(Colour.BLACK); 
		    
		    WritableFont fontbold = new WritableFont(WritableFont.ARIAL);
		    fontbold.setColour(Colour.BLACK);
		    fontbold.setBoldStyle(WritableFont.BOLD);
		    
		    WritableCellFormat cellFormat = new WritableCellFormat();
		    cellFormat.setBackground(bckcolor);
		    cellFormat.setAlignment(Alignment.CENTRE);
		    cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK); 
		    cellFormat.setFont(fontbold); 
		    
		    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
		    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
		    font.setColour(Colour.BLACK); 
		    cellRIghtformat.setFont(font);
		    cellRIghtformat.setAlignment(Alignment.RIGHT);
		    
		    WritableCellFormat cellleftformat = new WritableCellFormat(); 
		    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
		    font.setColour(Colour.BLACK); 
		    cellleftformat.setFont(font); 				
		    cellleftformat.setAlignment(Alignment.LEFT);
		    
		    /*System.out.println("SubCOn = " + vo.getCheckBox());*/
		    if(vo.getCheckBox().equalsIgnoreCase("1")){
		    
		    writableSheet.setColumnView(0, 13);
		    writableSheet.setColumnView(1, 13);
		    writableSheet.setColumnView(2, 13);
		    writableSheet.setColumnView(3, 13);
		    writableSheet.setColumnView(4, 13);
		    writableSheet.setColumnView(5, 13);
		    writableSheet.setColumnView(6, 13);
		    writableSheet.setColumnView(7, 13);
		    writableSheet.setColumnView(8, 13);
		    writableSheet.setColumnView(9, 13);
		    writableSheet.setColumnView(10, 13);
		    writableSheet.setColumnView(11, 13);
		    writableSheet.setColumnView(12, 13);
		    writableSheet.setColumnView(13, 13);
		    writableSheet.setColumnView(14, 13);
		    writableSheet.setColumnView(15, 13);
		    writableSheet.setColumnView(16, 13);
		    writableSheet.setColumnView(17, 13);
		    writableSheet.setColumnView(18, 13);
		    writableSheet.setColumnView(19, 13);
		    writableSheet.setColumnView(20, 13);
		    writableSheet.setColumnView(21, 13);
		    writableSheet.setColumnView(22, 13);
		    writableSheet.setColumnView(23, 13);
		    writableSheet.setColumnView(24, 13);
		    writableSheet.setColumnView(25, 13);
		    writableSheet.setColumnView(26, 13);
		    writableSheet.setColumnView(27, 13);
		    writableSheet.setColumnView(28, 13);
		    writableSheet.setColumnView(29, 13);
		    writableSheet.setColumnView(30, 13);
		    writableSheet.setColumnView(31, 13);
		    writableSheet.setColumnView(32, 13);
		    writableSheet.setColumnView(33, 13);
		    writableSheet.setColumnView(34, 13);
		    writableSheet.setColumnView(35, 13);
		    writableSheet.setColumnView(36, 13);
		    writableSheet.setColumnView(37, 13);
		    writableSheet.setColumnView(38, 13);
		    writableSheet.setColumnView(39, 13); 
		    writableSheet.setColumnView(40, 13);  
		    writableSheet.setColumnView(41, 13); 
		    writableSheet.setColumnView(42, 13); 
		    writableSheet.setColumnView(43, 13);
		    writableSheet.setColumnView(44, 13);
		    writableSheet.setColumnView(45, 13);
		    
		    
		    /*Label label=new Label(0, 0, "s_no",cellFormat);writableSheet.addCell(label);*/
		    Label label1=new Label(0, 0, "BP_Group",cellFormat);writableSheet.addCell(label1);
		    Label label2=new Label(1, 0, "BP_Role",cellFormat);writableSheet.addCell(label2);
		    Label label3=new Label(2, 0, "defComp",cellFormat);writableSheet.addCell(label3);
		    Label label4=new Label(3, 0, "name_org",cellFormat);writableSheet.addCell(label4);
		    Label label5=new Label(4, 0, "name_org2",cellFormat);writableSheet.addCell(label5);		    
		    Label label53=new Label(5, 0, "name_org3",cellFormat);writableSheet.addCell(label53);
		    Label label54=new Label(6, 0, "name_org4",cellFormat);writableSheet.addCell(label54);		    
		    Label label6=new Label(7, 0, "search_term",cellFormat);writableSheet.addCell(label6);		    
		    Label label9=new Label(8, 0, "address3",cellFormat);writableSheet.addCell(label9);
		    Label label10=new Label(9, 0, "address4",cellFormat);writableSheet.addCell(label10);   
		    Label label8=new Label(10, 0, "address5",cellFormat);writableSheet.addCell(label8);
		    Label label7=new Label(11, 0, "address6",cellFormat);writableSheet.addCell(label7);		    
		    Label label88=new Label(12, 0, "address2",cellFormat);writableSheet.addCell(label88);
		    Label label77=new Label(13, 0, "address1",cellFormat);writableSheet.addCell(label77);		     
		    Label label11=new Label(14, 0, "postal_code",cellFormat);writableSheet.addCell(label11);
		    Label label12=new Label(15, 0, "city",cellFormat);writableSheet.addCell(label12);
		    Label label13=new Label(16, 0, "country",cellFormat);writableSheet.addCell(label13);
		    Label label14=new Label(17, 0, "region",cellFormat);writableSheet.addCell(label14);
		    Label label15=new Label(18, 0, "language",cellFormat);writableSheet.addCell(label15);		    
		    Label mobile_no1=new Label(19, 0, "mobile_no",cellFormat);writableSheet.addCell(mobile_no1);
		    Label email1=new Label(20, 0, "email",cellFormat);writableSheet.addCell(email1);		    
		    Label label16=new Label(21, 0, "valid_from",cellFormat);writableSheet.addCell(label16);
		    Label label17=new Label(22, 0, "valid_to",cellFormat);writableSheet.addCell(label17);
		    Label label18=new Label(23, 0, "tax_type",cellFormat);writableSheet.addCell(label18);
		    Label label19=new Label(24, 0, "gst_no",cellFormat);writableSheet.addCell(label19);
		    Label label20=new Label(25, 0, "company",cellFormat);writableSheet.addCell(label20);
		    Label label21=new Label(26, 0, "Cust_ReconACC",cellFormat);writableSheet.addCell(label21);
		    Label label22=new Label(27, 0, "Vend_ReconACC",cellFormat);writableSheet.addCell(label22);
		    Label label23=new Label(28, 0, "sales_org",cellFormat);writableSheet.addCell(label23);
		    Label label24=new Label(29, 0, "dist_channel",cellFormat);writableSheet.addCell(label24);
		    Label label25=new Label(30, 0, "division",cellFormat);writableSheet.addCell(label25);
		    Label label26=new Label(31, 0, "currency",cellFormat);writableSheet.addCell(label26);
		    Label label27=new Label(32, 0, "Cust_Price_Proc",cellFormat);writableSheet.addCell(label27);
		    Label label28=new Label(33, 0, "shipping_cond",cellFormat);writableSheet.addCell(label28);
		    Label label29=new Label(34, 0, "inco_term",cellFormat);writableSheet.addCell(label29);
		    Label label30=new Label(35, 0, "inco_location",cellFormat);writableSheet.addCell(label30);
		    Label label31=new Label(36, 0, "cust_pay_term",cellFormat);writableSheet.addCell(label31);
		    Label label32=new Label(37, 0, "acct_assign_grpCust",cellFormat);writableSheet.addCell(label32);
		    Label label33=new Label(38, 0, "cgst",cellFormat);writableSheet.addCell(label33);
		    Label label34=new Label(39, 0, "sgst",cellFormat);writableSheet.addCell(label34);
		    Label label35=new Label(40, 0, "igst",cellFormat);writableSheet.addCell(label35);
		    Label label36=new Label(41, 0, "purchase_org",cellFormat);writableSheet.addCell(label36);
		    Label label37=new Label(42, 0, "vendor_currency",cellFormat);writableSheet.addCell(label37);
		    Label label38=new Label(43, 0, "purchage_group",cellFormat);writableSheet.addCell(label38);
		    Label label39=new Label(44, 0, "Schema_Group",cellFormat);writableSheet.addCell(label39);
		    Label label40=new Label(45, 0, "vendor_pay_term",cellFormat);writableSheet.addCell(label40);

			
			ps_mst1 = con.prepareStatement("SELECT  * FROM sap_masterVendCust where id="+Integer.valueOf(vo.getHid()));
			rs_mst1 = ps_mst1.executeQuery();
			while (rs_mst1.next()) {
				Label BP_Group=new Label(col, row, rs_mst1.getString("BP_Group"),cellleftformat);writableSheet.addCell(BP_Group); col++;
			    Label BP_Role=new Label(col, row, rs_mst1.getString("BP_Role"),cellleftformat);writableSheet.addCell(BP_Role); col++;
			    Label defComp=new Label(col, row, "0003",cellleftformat);writableSheet.addCell(defComp); col++;
			    Label name_org=new Label(col, row, rs_mst1.getString("name_org"),cellleftformat);writableSheet.addCell(name_org); col++;
			    Label name_org2=new Label(col, row, rs_mst1.getString("name_org2"),cellleftformat);writableSheet.addCell(name_org2); col++;
			    
			    Label name_org3=new Label(col, row, rs_mst1.getString("name_org3"),cellleftformat);writableSheet.addCell(name_org3); col++;
			    Label name_org4=new Label(col, row, rs_mst1.getString("name_org4"),cellleftformat);writableSheet.addCell(name_org4); col++;
			    
			    Label search_term=new Label(col, row, rs_mst1.getString("search_term"),cellleftformat);writableSheet.addCell(search_term); col++;
			    Label address3=new Label(col, row, rs_mst1.getString("address3"),cellleftformat);writableSheet.addCell(address3); col++;
			    Label address4=new Label(col, row, rs_mst1.getString("address4"),cellleftformat);writableSheet.addCell(address4); col++;
			    Label address2=new Label(col, row, rs_mst1.getString("address2"),cellleftformat);writableSheet.addCell(address2); col++;
			    Label address1=new Label(col, row, rs_mst1.getString("address1"),cellleftformat);writableSheet.addCell(address1); col++;
			    
			    Label address5=new Label(col, row, "",cellleftformat);writableSheet.addCell(address5); col++;
			    Label address6=new Label(col, row, "",cellleftformat);writableSheet.addCell(address6); col++;
			    
			    
			    
			    
			    Label postal_code=new Label(col, row, rs_mst1.getString("postal_code"),cellleftformat);writableSheet.addCell(postal_code); col++;
			    Label city=new Label(col, row, rs_mst1.getString("city"),cellleftformat);writableSheet.addCell(city); col++;
			    Label country=new Label(col, row, rs_mst1.getString("country"),cellleftformat);writableSheet.addCell(country); col++;
			    Label region=new Label(col, row, rs_mst1.getString("region"),cellleftformat);writableSheet.addCell(region); col++;
			    Label language=new Label(col, row, rs_mst1.getString("language"),cellleftformat);writableSheet.addCell(language); col++;
			    
			    Label mobile_no=new Label(col, row, rs_mst1.getString("mobile_no"),cellleftformat);writableSheet.addCell(mobile_no); col++;
			    Label email=new Label(col, row, rs_mst1.getString("email"),cellleftformat);writableSheet.addCell(email); col++;
			    
			    Label valid_from=new Label(col, row, "",cellleftformat);writableSheet.addCell(valid_from); col++;
			    Label valid_to=new Label(col, row, "",cellleftformat);writableSheet.addCell(valid_to); col++;
			    Label tax_type=new Label(col, row, "IN3",cellleftformat);writableSheet.addCell(tax_type); col++;
			    Label gst_no=new Label(col, row, rs_mst1.getString("gst_no"),cellleftformat);writableSheet.addCell(gst_no); col++;
			    Label company=new Label(col, row, rs_mst1.getString("company"),cellleftformat);writableSheet.addCell(company); col++;
			    Label Cust_ReconACC=new Label(col, row, rs_mst1.getString("Cust_ReconACC"),cellleftformat);writableSheet.addCell(Cust_ReconACC); col++;
			    Label Vend_ReconACC=new Label(col, row, rs_mst1.getString("Vend_ReconACC"),cellleftformat);writableSheet.addCell(Vend_ReconACC); col++;
			    Label sales_org=new Label(col, row, rs_mst1.getString("sales_org"),cellleftformat);writableSheet.addCell(sales_org); col++;
			    Label dist_channel=new Label(col, row, rs_mst1.getString("dist_channel"),cellleftformat);writableSheet.addCell(dist_channel); col++;
			    Label division=new Label(col, row, rs_mst1.getString("division"),cellleftformat);writableSheet.addCell(division); col++;
			    Label currency=new Label(col, row, rs_mst1.getString("currency"),cellleftformat);writableSheet.addCell(currency); col++;
			    Label Cust_Price_Proc=new Label(col, row, rs_mst1.getString("Cust_Price_Proc"),cellleftformat);writableSheet.addCell(Cust_Price_Proc); col++;
			    Label shipping_cond=new Label(col, row, rs_mst1.getString("shipping_cond"),cellleftformat);writableSheet.addCell(shipping_cond); col++;
			    Label inco_term=new Label(col, row, rs_mst1.getString("inco_term"),cellleftformat);writableSheet.addCell(inco_term); col++;
			    Label inco_location=new Label(col, row, rs_mst1.getString("inco_location"),cellleftformat);writableSheet.addCell(inco_location); col++;
			    Label cust_pay_term=new Label(col, row, rs_mst1.getString("cust_pay_term"),cellleftformat);writableSheet.addCell(cust_pay_term); col++;
			    Label acct_assign_grp=new Label(col, row, rs_mst1.getString("acct_assign_grp"),cellleftformat);writableSheet.addCell(acct_assign_grp); col++;
			    Label cgst=new Label(col, row, "0",cellleftformat);writableSheet.addCell(cgst); col++;
			    Label sgst=new Label(col, row, "0",cellleftformat);writableSheet.addCell(sgst); col++;
			    Label igst=new Label(col, row, "0",cellleftformat);writableSheet.addCell(igst); col++;
			    Label purchase_org=new Label(col, row, rs_mst1.getString("purchase_org"),cellleftformat);writableSheet.addCell(purchase_org); col++;
			    Label vendor_currency=new Label(col, row, rs_mst1.getString("vendor_currency"),cellleftformat);writableSheet.addCell(vendor_currency); col++;
			    Label purchage_group=new Label(col, row, rs_mst1.getString("purchage_group"),cellleftformat);writableSheet.addCell(purchage_group); col++;
			    Label Schema_Group=new Label(col, row, rs_mst1.getString("Schema_Group"),cellleftformat);writableSheet.addCell(Schema_Group); col++;
			    Label vendor_pay_term=new Label(col, row, rs_mst1.getString("vendor_pay_term"),cellleftformat);writableSheet.addCell(vendor_pay_term); 
				    
				    if(col==45){
				    	col=0;
				    	row++;
				    }
			}
			writableWorkbook.write();
	    	writableWorkbook.close();			 
	}else {
	/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
	/* -------------------------------------------------------------------------------------------- Other Than Sub  ------------------------------------------------------------------------------------------ */
	/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
if(vo.getVendor_recAcc()!="" && vo.getCust_recAcc().equalsIgnoreCase("")){
	
	// --------------------------------------- Vendor bulk upload --------------------------------------------------------------------------------------------------------------------------------------------
	// --------------------------------------- Vendor bulk upload --------------------------------------------------------------------------------------------------------------------------------------------
	// --------------------------------------- Vendor bulk upload --------------------------------------------------------------------------------------------------------------------------------------------
	
	    writableSheet.setColumnView(0, 13);
	    writableSheet.setColumnView(1, 13);
	    writableSheet.setColumnView(2, 13);
	    writableSheet.setColumnView(3, 13);
	    writableSheet.setColumnView(4, 13);
	    writableSheet.setColumnView(5, 13);
	    writableSheet.setColumnView(6, 13);
	    writableSheet.setColumnView(7, 13);
	    writableSheet.setColumnView(8, 13);
	    writableSheet.setColumnView(9, 13);
	    writableSheet.setColumnView(10, 13);
	    writableSheet.setColumnView(11, 13);
	    writableSheet.setColumnView(12, 13);
	    writableSheet.setColumnView(13, 13);
	    writableSheet.setColumnView(14, 13);
	    writableSheet.setColumnView(15, 13);
	    writableSheet.setColumnView(16, 13);
	    writableSheet.setColumnView(17, 13);
	    writableSheet.setColumnView(18, 13);
	    writableSheet.setColumnView(19, 13);
	    writableSheet.setColumnView(20, 13);
	    writableSheet.setColumnView(21, 13);
	    writableSheet.setColumnView(22, 13);
	    writableSheet.setColumnView(23, 13);
	    writableSheet.setColumnView(24, 13);
	    writableSheet.setColumnView(25, 13);
	    writableSheet.setColumnView(26, 13);
	    writableSheet.setColumnView(27, 13);
	    writableSheet.setColumnView(28, 13);
	    writableSheet.setColumnView(29, 13); 
	    writableSheet.setColumnView(30, 13);
	    writableSheet.setColumnView(31, 13);
	    writableSheet.setColumnView(32, 13);
	    writableSheet.setColumnView(33, 13);
	    
	    Label label=new Label(0, 0, "bp_group",cellFormat);writableSheet.addCell(label);
	    Label label1=new Label(1, 0, "role",cellFormat);writableSheet.addCell(label1);
	    Label label2=new Label(2, 0, "tel_cntr",cellFormat);writableSheet.addCell(label2);
	    Label label3=new Label(3, 0, "mob_cntr",cellFormat);writableSheet.addCell(label3);
	    Label label4=new Label(4, 0, "fax_cntr",cellFormat);writableSheet.addCell(label4);
	    Label label5=new Label(5, 0, "defComp",cellFormat);writableSheet.addCell(label5);
	    Label label6=new Label(6, 0, "name_org",cellFormat);writableSheet.addCell(label6);
	    Label label7=new Label(7, 0, "name_org2",cellFormat);writableSheet.addCell(label7);
	    
	    Label label77=new Label(8, 0, "name_org3",cellFormat);writableSheet.addCell(label77);
	    Label label88=new Label(9, 0, "name_org4",cellFormat);writableSheet.addCell(label88);
	    
	    Label label8=new Label(10, 0, "search_term",cellFormat);writableSheet.addCell(label8);	    
	    Label label9=new Label(11, 0, "address3",cellFormat);writableSheet.addCell(label9);
	    Label label10=new Label(12, 0, "address4",cellFormat);writableSheet.addCell(label10);
	    
	    Label label11=new Label(13, 0, "street_no",cellFormat);writableSheet.addCell(label11);
	    Label label12=new Label(14, 0, "house_no",cellFormat);writableSheet.addCell(label12);
	    
	    Label label155=new Label(15, 0, "address 5",cellFormat);writableSheet.addCell(label155);
	    Label label166=new Label(16, 0, "address 6",cellFormat);writableSheet.addCell(label166);
	    
	    Label label13=new Label(17, 0, "postal_code",cellFormat);writableSheet.addCell(label13);
	    Label label14=new Label(18, 0, "city",cellFormat);writableSheet.addCell(label14);
	    Label label15=new Label(19, 0, "country",cellFormat);writableSheet.addCell(label15);
	    Label label16=new Label(20, 0, "region",cellFormat);writableSheet.addCell(label16);
	    Label label17=new Label(21, 0, "po_box",cellFormat);writableSheet.addCell(label17);
	    Label label18=new Label(22, 0, "language",cellFormat);writableSheet.addCell(label18);
	    
	    Label mob_no=new Label(23, 0, "mob_no",cellFormat);writableSheet.addCell(mob_no);
	    Label mail=new Label(24, 0, "mail",cellFormat);writableSheet.addCell(mail);
	    
	    Label label19=new Label(25, 0, "time_zone",cellFormat);writableSheet.addCell(label19);
	    Label label20=new Label(26, 0, "valid_from",cellFormat);writableSheet.addCell(label20);
	    Label label21=new Label(27, 0, "valid_to",cellFormat);writableSheet.addCell(label21);
	    Label label22=new Label(28, 0, "company",cellFormat);writableSheet.addCell(label22);
	    Label label23=new Label(29, 0, "Vend_ReconACC",cellFormat);writableSheet.addCell(label23);
	    Label label24=new Label(30, 0, "purchase_org",cellFormat);writableSheet.addCell(label24);
	    Label label25=new Label(31, 0, "currency",cellFormat);writableSheet.addCell(label25);
	    Label label26=new Label(32, 0, "vendor_pay_term",cellFormat);writableSheet.addCell(label26);
	    Label label27=new Label(33, 0, "Schema_Group",cellFormat);writableSheet.addCell(label27);
	    Label label28=new Label(34, 0, "txtype",cellFormat);writableSheet.addCell(label28);
	    Label label29=new Label(35, 0, "gst_no",cellFormat);writableSheet.addCell(label29);  
		
		ps_mst1 = con.prepareStatement("SELECT  * FROM sap_masterVendCust where id="+Integer.valueOf(vo.getHid()));
		rs_mst1 = ps_mst1.executeQuery();
		while (rs_mst1.next()) {
			/*jxl.write.Number nolbl = new jxl.write.Number(col, row, sr,cellRIghtformat);
		    writableSheet.addCell(nolbl); 
		    col++;
		    sr++;	*/
		    /*Label s_no=new Label(col, row, rs_mst1.getString("s_no"),cellleftformat);writableSheet.addCell(s_no); col++;*/
		    
			Label bp_group=new Label(col, row, rs_mst1.getString("bp_group"),cellleftformat);writableSheet.addCell(bp_group); col++;
			Label role=new Label(col, row, rs_mst1.getString("BP_Role"),cellleftformat);writableSheet.addCell(role); col++;
			Label tel_cntr=new Label(col, row, rs_mst1.getString("country"),cellleftformat);writableSheet.addCell(tel_cntr); col++;
			Label mob_cntr=new Label(col, row, rs_mst1.getString("country"),cellleftformat);writableSheet.addCell(mob_cntr); col++;
			Label fax_cntr=new Label(col, row, rs_mst1.getString("country"),cellleftformat);writableSheet.addCell(fax_cntr); col++;
			Label defComp=new Label(col, row, "0003",cellleftformat);writableSheet.addCell(defComp); col++;
			
			Label name_org=new Label(col, row, rs_mst1.getString("name_org"),cellleftformat);writableSheet.addCell(name_org); col++;
			Label name_org2=new Label(col, row, rs_mst1.getString("name_org2"),cellleftformat);writableSheet.addCell(name_org2); col++;
			Label name_org22=new Label(col, row, rs_mst1.getString("name_org3"),cellleftformat);writableSheet.addCell(name_org22); col++;
			Label name_org23=new Label(col, row, rs_mst1.getString("name_org4"),cellleftformat);writableSheet.addCell(name_org23); col++;
			
			Label search_term=new Label(col, row, rs_mst1.getString("search_term"),cellleftformat);writableSheet.addCell(search_term); col++;
			
			Label address3=new Label(col, row, rs_mst1.getString("address3"),cellleftformat);writableSheet.addCell(address3); col++;
			Label address4=new Label(col, row, rs_mst1.getString("address4"),cellleftformat);writableSheet.addCell(address4); col++;
			Label address2=new Label(col, row, rs_mst1.getString("address2"),cellleftformat);writableSheet.addCell(address2); col++;
			Label address1=new Label(col, row, rs_mst1.getString("address1"),cellleftformat);writableSheet.addCell(address1); col++;
			
			Label address5=new Label(col, row, "",cellleftformat);writableSheet.addCell(address5); col++;
			Label address6=new Label(col, row, "",cellleftformat);writableSheet.addCell(address6); col++;
						
			Label postal_code=new Label(col, row, rs_mst1.getString("postal_code"),cellleftformat);writableSheet.addCell(postal_code); col++;
			Label city=new Label(col, row, rs_mst1.getString("city"),cellleftformat);writableSheet.addCell(city); col++;
			Label country=new Label(col, row, rs_mst1.getString("country"),cellleftformat);writableSheet.addCell(country); col++;
			Label region=new Label(col, row, rs_mst1.getString("region"),cellleftformat);writableSheet.addCell(region); col++;
			Label po_box=new Label(col, row, "",cellleftformat);writableSheet.addCell(po_box); col++;
			Label language=new Label(col, row, rs_mst1.getString("language"),cellleftformat);writableSheet.addCell(language); col++;
			
			Label mobile_no=new Label(col, row, rs_mst1.getString("mobile_no"),cellleftformat);writableSheet.addCell(mobile_no); col++;
			Label email=new Label(col, row, rs_mst1.getString("email"),cellleftformat);writableSheet.addCell(email); col++;
			
			
			Label time_zone=new Label(col, row, "",cellleftformat);writableSheet.addCell(time_zone); col++;
			Label valid_from=new Label(col, row, "",cellleftformat);writableSheet.addCell(valid_from); col++;
			Label valid_to=new Label(col, row, "",cellleftformat);writableSheet.addCell(valid_to); col++;
			Label company=new Label(col, row, rs_mst1.getString("company"),cellleftformat);writableSheet.addCell(company); col++;
			Label Cust_ReconACC=new Label(col, row, rs_mst1.getString("Vend_ReconACC"),cellleftformat);writableSheet.addCell(Cust_ReconACC); col++;
			Label purchase_org=new Label(col, row, rs_mst1.getString("purchase_org"),cellleftformat);writableSheet.addCell(purchase_org); col++;
			Label currency=new Label(col, row, rs_mst1.getString("currency"),cellleftformat);writableSheet.addCell(currency); col++;
			Label cust_pay_term=new Label(col, row, rs_mst1.getString("vendor_pay_term"),cellleftformat);writableSheet.addCell(cust_pay_term); col++;
			Label Schema_Group=new Label(col, row, rs_mst1.getString("Schema_Group"),cellleftformat);writableSheet.addCell(Schema_Group); col++;
			Label txtype=new Label(col, row, "IN3",cellleftformat);writableSheet.addCell(txtype); col++;
			Label gst_no=new Label(col, row, rs_mst1.getString("gst_no"),cellleftformat);writableSheet.addCell(gst_no);

			    if(col==35){
			    	col=0;
			    	row++;
			    }
		}
		writableWorkbook.write();
    	writableWorkbook.close(); 
	}else if(vo.getCust_recAcc()!="" && vo.getVendor_recAcc().equalsIgnoreCase("")){
		// ---------------------------------------Customer bulk upload ---------------------------------------------------------------------------------------------------------------------------------------
		 writableSheet.setColumnView(0, 13);
		 writableSheet.setColumnView(1, 13);
		 writableSheet.setColumnView(2, 13);
		 writableSheet.setColumnView(3, 13);
		 writableSheet.setColumnView(4, 13);
		 writableSheet.setColumnView(5, 13);
		 writableSheet.setColumnView(6, 13);
		 writableSheet.setColumnView(7, 13);
		 writableSheet.setColumnView(8, 13);
		 writableSheet.setColumnView(9, 13);
		 writableSheet.setColumnView(10, 13);
		 writableSheet.setColumnView(11, 13);
		 writableSheet.setColumnView(12, 13);
		 writableSheet.setColumnView(13, 13);
		 writableSheet.setColumnView(14, 13);
		 writableSheet.setColumnView(15, 13);
		 writableSheet.setColumnView(16, 13);
		 writableSheet.setColumnView(17, 13);
		 writableSheet.setColumnView(18, 13);
		 writableSheet.setColumnView(19, 13);
		 writableSheet.setColumnView(20, 13);
		 writableSheet.setColumnView(21, 13);
		 writableSheet.setColumnView(22, 13);
		 writableSheet.setColumnView(23, 13);
		 writableSheet.setColumnView(24, 13);
		 writableSheet.setColumnView(25, 13);
		 writableSheet.setColumnView(26, 13);
		 writableSheet.setColumnView(27, 13);
		 writableSheet.setColumnView(28, 13);
		 writableSheet.setColumnView(29, 13);
		 writableSheet.setColumnView(30, 13);
		 writableSheet.setColumnView(31, 13);
		 writableSheet.setColumnView(32, 13);
		 writableSheet.setColumnView(33, 13);
		 writableSheet.setColumnView(34, 13);
		 writableSheet.setColumnView(35, 13);
		 writableSheet.setColumnView(36, 13);
		 writableSheet.setColumnView(37, 13);
		 writableSheet.setColumnView(38, 13);
		 writableSheet.setColumnView(39, 13);
		 writableSheet.setColumnView(40, 13);
		 writableSheet.setColumnView(41, 13);
		 writableSheet.setColumnView(42, 13);
		 writableSheet.setColumnView(43, 13);
		 writableSheet.setColumnView(44, 13);
		 writableSheet.setColumnView(45, 13);
		 writableSheet.setColumnView(46, 13);
		 writableSheet.setColumnView(47, 13);
		 writableSheet.setColumnView(48, 13);
		 writableSheet.setColumnView(49, 13);
		 writableSheet.setColumnView(50, 13);
		 writableSheet.setColumnView(51, 13);
		 writableSheet.setColumnView(52, 13);
		 writableSheet.setColumnView(53, 13);
		 writableSheet.setColumnView(54, 13);
		 writableSheet.setColumnView(55, 13);
		 
		 Label BP_GroupLB=new Label(0,0,"BP_Group",cellFormat);writableSheet.addCell(BP_GroupLB);
		 Label BP_RoleLB=new Label(1,0,"BP_Role",cellFormat);writableSheet.addCell(BP_RoleLB);
		 Label TitleLB=new Label(2,0,"Title",cellFormat);writableSheet.addCell(TitleLB);
		 Label name_orgLB=new Label(3,0,"name_org",cellFormat);writableSheet.addCell(name_orgLB);
		 Label name_org2LB=new Label(4,0,"name_org2",cellFormat);writableSheet.addCell(name_org2LB);
		 Label name_org3LB=new Label(5,0,"name_org3",cellFormat);writableSheet.addCell(name_org3LB);
		 Label name_org4LB=new Label(6,0,"name_org4",cellFormat);writableSheet.addCell(name_org4LB);
		 
		 
		 Label search_termLB=new Label(7,0,"search_term",cellFormat);writableSheet.addCell(search_termLB);
		 
		 Label address1LB=new Label(8,0,"HouseNo",cellFormat);writableSheet.addCell(address1LB);
		 Label address2LB=new Label(9,0,"address2",cellFormat);writableSheet.addCell(address2LB);
		 
		 
		 Label address3LB=new Label(10,0,"address3",cellFormat);writableSheet.addCell(address3LB);
		 Label address4LB=new Label(11,0,"address4",cellFormat);writableSheet.addCell(address4LB);
		 
		 Label DistrictLB=new Label(12,0,"District",cellFormat);writableSheet.addCell(DistrictLB);
		 Label postal_codeLB=new Label(13,0,"postal_code",cellFormat);writableSheet.addCell(postal_codeLB);
		 Label cityLB=new Label(14,0,"city",cellFormat);writableSheet.addCell(cityLB);
		 Label countryLB=new Label(15,0,"country",cellFormat);writableSheet.addCell(countryLB);
		 Label regionLB=new Label(16,0,"region",cellFormat);writableSheet.addCell(regionLB);
		 Label languageLB=new Label(17,0,"language",cellFormat);writableSheet.addCell(languageLB);
		 Label telephone_noLB=new Label(18,0,"telephone_no",cellFormat);writableSheet.addCell(telephone_noLB);
		 Label mobile_noLB=new Label(19,0,"mobile_no",cellFormat);writableSheet.addCell(mobile_noLB);
		 Label fax_noLB=new Label(20,0,"fax_no",cellFormat);writableSheet.addCell(fax_noLB);
		 Label emailLB=new Label(21,0,"email",cellFormat);writableSheet.addCell(emailLB);
		 Label ext_business_prtLB=new Label(22,0,"ext_business_prt",cellFormat);writableSheet.addCell(ext_business_prtLB);
		 Label Tax_Number_CategoryLB=new Label(23,0,"Tax_Number_Category",cellFormat);writableSheet.addCell(Tax_Number_CategoryLB);
		 Label gst_noLB=new Label(24,0,"gst_no",cellFormat);writableSheet.addCell(gst_noLB);
		 Label companyLB=new Label(25,0,"company",cellFormat);writableSheet.addCell(companyLB);
		 Label Cust_ReconACCLB=new Label(26,0,"Cust_ReconACC",cellFormat);writableSheet.addCell(Cust_ReconACCLB);
		 Label prev_accNoLB=new Label(27,0,"prev_accNo",cellFormat);writableSheet.addCell(prev_accNoLB);
		 Label sales_orgLB=new Label(28,0,"sales_org",cellFormat);writableSheet.addCell(sales_orgLB);
		 Label dist_channelLB=new Label(29,0,"dist_channel",cellFormat);writableSheet.addCell(dist_channelLB);
		 Label divisionLB=new Label(30,0,"division",cellFormat);writableSheet.addCell(divisionLB);
		 Label custGroupLB=new Label(31,0,"custGroup",cellFormat);writableSheet.addCell(custGroupLB);
		 Label saleOffLB=new Label(32,0,"saleOff",cellFormat);writableSheet.addCell(saleOffLB);
		 Label currencyLB=new Label(33,0,"currency",cellFormat);writableSheet.addCell(currencyLB);
		 Label exchange_rateTimeLB=new Label(34,0,"exchange_rateTime",cellFormat);writableSheet.addCell(exchange_rateTimeLB);
		 Label Cust_Price_ProcLB=new Label(35,0,"Cust_Price_Proc",cellFormat);writableSheet.addCell(Cust_Price_ProcLB);
		 Label cust_stat_growthLB=new Label(36,0,"cust_stat_growth",cellFormat);writableSheet.addCell(cust_stat_growthLB);
		 Label del_priorityLB=new Label(37,0,"del_priority",cellFormat);writableSheet.addCell(del_priorityLB);
		 Label del_plantLB=new Label(38,0,"del_plant",cellFormat);writableSheet.addCell(del_plantLB);
		 Label shipping_condLB=new Label(39,0,"shipping_cond",cellFormat);writableSheet.addCell(shipping_condLB);
		 Label inco_termLB=new Label(40,0,"inco_term",cellFormat);writableSheet.addCell(inco_termLB);
		 Label inco_locationLB=new Label(41,0,"inco_location",cellFormat);writableSheet.addCell(inco_locationLB);
		 Label cust_pay_termLB=new Label(42,0,"cust_pay_term",cellFormat);writableSheet.addCell(cust_pay_termLB);
		 Label acct_assign_grpCustLB=new Label(43,0,"acct_assign_grpCust",cellFormat);writableSheet.addCell(acct_assign_grpCustLB);
		 Label tax_centralGSTLB=new Label(44,0,"tax_centralGST",cellFormat);writableSheet.addCell(tax_centralGSTLB);
		 Label tax_stateGSTLB=new Label(45,0,"tax_stateGST",cellFormat);writableSheet.addCell(tax_stateGSTLB);
		 Label tax_intGSTLB=new Label(46,0,"tax_intGST",cellFormat);writableSheet.addCell(tax_intGSTLB);
		 Label ecc_noLB=new Label(47,0,"ecc_no",cellFormat);writableSheet.addCell(ecc_noLB);
		 Label excise_regNoLB=new Label(48,0,"excise_regNo",cellFormat);writableSheet.addCell(excise_regNoLB);
		 Label excise_ragneLB=new Label(49,0,"excise_ragne",cellFormat);writableSheet.addCell(excise_ragneLB);
		 Label excise_divisionLB=new Label(50,0,"excise_division",cellFormat);writableSheet.addCell(excise_divisionLB);
		 Label excise_commisLB=new Label(51,0,"excise_commis",cellFormat);writableSheet.addCell(excise_commisLB);
		 Label excisetaxindCustLB=new Label(52,0,"excisetaxindCust",cellFormat);writableSheet.addCell(excisetaxindCustLB);
		 Label cst_noLB=new Label(53,0,"cst_no",cellFormat);writableSheet.addCell(cst_noLB);
		 Label lst_noLB=new Label(54,0,"lst_no",cellFormat);writableSheet.addCell(lst_noLB);
		 Label pan_noLB=new Label(55,0,"pan_no",cellFormat);writableSheet.addCell(pan_noLB);
		 Label service_regNoLB=new Label(56,0,"service_regNo",cellFormat);writableSheet.addCell(service_regNoLB);

		 
		ps_mst1 = con.prepareStatement("SELECT  * FROM sap_masterVendCust where id="+Integer.valueOf(vo.getHid()));
		rs_mst1 = ps_mst1.executeQuery();
		while (rs_mst1.next()) {
			
			Label BP_Group =new Label(col, row, rs_mst1.getString("BP_Group"),cellleftformat);writableSheet.addCell(BP_Group); col++;
			Label BP_Role =new Label(col, row, rs_mst1.getString("BP_Role"),cellleftformat);writableSheet.addCell(BP_Role); col++;
			Label Title =new Label(col, row, "0003",cellleftformat);writableSheet.addCell(Title); col++;
			Label name_org =new Label(col, row, rs_mst1.getString("name_org"),cellleftformat);writableSheet.addCell(name_org); col++;
			Label name_org2 =new Label(col, row, rs_mst1.getString("name_org2"),cellleftformat);writableSheet.addCell(name_org2); col++;
			Label name_org3 =new Label(col, row, rs_mst1.getString("name_org3"),cellleftformat);writableSheet.addCell(name_org3); col++;
			Label name_org4 =new Label(col, row, rs_mst1.getString("name_org4"),cellleftformat);writableSheet.addCell(name_org4); col++;
			 
			Label search_term =new Label(col, row, rs_mst1.getString("search_term"),cellleftformat);writableSheet.addCell(search_term); col++;
			
			Label address1 =new Label(col, row, rs_mst1.getString("address2"),cellleftformat);writableSheet.addCell(address1); col++;
			Label address2 =new Label(col, row, rs_mst1.getString("address1"),cellleftformat);writableSheet.addCell(address2); col++;
			
			
			Label address3 =new Label(col, row, rs_mst1.getString("address3"),cellleftformat);writableSheet.addCell(address3); col++;
			Label address4 =new Label(col, row, rs_mst1.getString("address4"),cellleftformat);writableSheet.addCell(address4); col++;
			Label District =new Label(col, row, "",cellleftformat);writableSheet.addCell(District); col++;
			Label postal_code =new Label(col, row, rs_mst1.getString("postal_code"),cellleftformat);writableSheet.addCell(postal_code); col++;
			Label city =new Label(col, row, rs_mst1.getString("city"),cellleftformat);writableSheet.addCell(city); col++;
			Label country =new Label(col, row, rs_mst1.getString("country"),cellleftformat);writableSheet.addCell(country); col++;
			Label region =new Label(col, row, rs_mst1.getString("region"),cellleftformat);writableSheet.addCell(region); col++;
			Label language =new Label(col, row, rs_mst1.getString("language"),cellleftformat);writableSheet.addCell(language); col++;
			Label telephone_no =new Label(col, row, "",cellleftformat);writableSheet.addCell(telephone_no); col++;
			Label mobile_no =new Label(col, row, rs_mst1.getString("mobile_no"),cellleftformat);writableSheet.addCell(mobile_no); col++;
			Label fax_no =new Label(col, row, "",cellleftformat);writableSheet.addCell(fax_no); col++;
			Label email =new Label(col, row, rs_mst1.getString("email"),cellleftformat);writableSheet.addCell(email); col++;
			Label ext_business_prt =new Label(col, row, "",cellleftformat);writableSheet.addCell(ext_business_prt); col++;
			Label IN3 =new Label(col, row, "IN3",cellleftformat);writableSheet.addCell(IN3); col++;
			Label gst_no =new Label(col, row, rs_mst1.getString("gst_no"),cellleftformat);writableSheet.addCell(gst_no); col++;
			Label company =new Label(col, row, rs_mst1.getString("company"),cellleftformat);writableSheet.addCell(company); col++;
			Label Cust_ReconACC =new Label(col, row, rs_mst1.getString("Cust_ReconACC"),cellleftformat);writableSheet.addCell(Cust_ReconACC); col++;
			Label prev_accNo =new Label(col, row, "",cellleftformat);writableSheet.addCell(prev_accNo); col++;
			Label sales_org =new Label(col, row, rs_mst1.getString("sales_org"),cellleftformat);writableSheet.addCell(sales_org); col++;
			Label dist_channel =new Label(col, row, rs_mst1.getString("dist_channel"),cellleftformat);writableSheet.addCell(dist_channel); col++;
			Label division =new Label(col, row, rs_mst1.getString("division"),cellleftformat);writableSheet.addCell(division); col++;
			Label custGroup =new Label(col, row, "",cellleftformat);writableSheet.addCell(custGroup); col++;
			Label saleOff =new Label(col, row, "",cellleftformat);writableSheet.addCell(saleOff); col++;
			Label currency =new Label(col, row, rs_mst1.getString("currency"),cellleftformat);writableSheet.addCell(currency); col++;
			Label exchange_rateTime =new Label(col, row, "",cellleftformat);writableSheet.addCell(exchange_rateTime); col++;
			Label Cust_Price_Proc =new Label(col, row, rs_mst1.getString("Cust_Price_Proc"),cellleftformat);writableSheet.addCell(Cust_Price_Proc); col++;
			Label cust_stat_growth =new Label(col, row, "",cellleftformat);writableSheet.addCell(cust_stat_growth); col++;
			Label del_priority =new Label(col, row, "",cellleftformat);writableSheet.addCell(del_priority); col++;
			Label del_plant =new Label(col, row, "",cellleftformat);writableSheet.addCell(del_plant); col++;
			Label shipping_cond =new Label(col, row, rs_mst1.getString("shipping_cond"),cellleftformat);writableSheet.addCell(shipping_cond); col++;
			Label inco_term =new Label(col, row, rs_mst1.getString("inco_term"),cellleftformat);writableSheet.addCell(inco_term); col++;
			Label inco_location =new Label(col, row, rs_mst1.getString("inco_location"),cellleftformat);writableSheet.addCell(inco_location); col++;
			Label cust_pay_term =new Label(col, row, rs_mst1.getString("cust_pay_term"),cellleftformat);writableSheet.addCell(cust_pay_term); col++;
			Label acct_assign_grpCust =new Label(col, row, rs_mst1.getString("acct_assign_grp"),cellleftformat);writableSheet.addCell(acct_assign_grpCust); col++;
			Label tax_centralGST =new Label(col, row, "0",cellleftformat);writableSheet.addCell(tax_centralGST); col++;
			Label tax_stateGST =new Label(col, row, "0",cellleftformat);writableSheet.addCell(tax_stateGST); col++;
			Label tax_intGST =new Label(col, row, "0",cellleftformat);writableSheet.addCell(tax_intGST); col++;
			Label ecc_no =new Label(col, row, "",cellleftformat);writableSheet.addCell(ecc_no); col++;
			Label excise_regNo =new Label(col, row, "",cellleftformat);writableSheet.addCell(excise_regNo); col++;
			Label excise_ragne =new Label(col, row, "",cellleftformat);writableSheet.addCell(excise_ragne); col++;
			Label excise_division =new Label(col, row, "",cellleftformat);writableSheet.addCell(excise_division); col++;
			Label excise_commis =new Label(col, row, "",cellleftformat);writableSheet.addCell(excise_commis); col++;
			Label excisetaxindCust =new Label(col, row, "",cellleftformat);writableSheet.addCell(excisetaxindCust); col++;
			Label cst_no =new Label(col, row, "",cellleftformat);writableSheet.addCell(cst_no); col++;
			Label lst_no =new Label(col, row, "",cellleftformat);writableSheet.addCell(lst_no); col++;
			Label pan_no =new Label(col, row, rs_mst1.getString("pan_no"),cellleftformat);writableSheet.addCell(pan_no); col++;
			Label service_regNo =new Label(col, row, "",cellleftformat);writableSheet.addCell(service_regNo);

			
			if(col==56){
		    	col=0;
		    	row++;
		    }
		}
		writableWorkbook.write();
    	writableWorkbook.close();
	}
	/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
	/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
	/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */		
	}
	
	    	 String filePath = "C:/reportxls/BulkUpload"+val+".xls"; 
	    	  File downloadFile = new File(filePath);
	    	  FileInputStream inStream = new FileInputStream(downloadFile);
	    	    
	    	  //ServletContext context = getServletContext();
	    	   
	    	  // gets MIME type of the file
	    	  String mimeType = context.getMimeType(filePath);
	    	  if (mimeType == null) {        
	    	      // set to binary type if MIME mapping not found
	    	      mimeType = "application/octet-stream";
	    	  }
	    	    
	    	  // modifies response
	    	  response.setContentType(mimeType);
	    	  response.setContentLength((int) downloadFile.length()); 
	    	  // forces download
	    	  String headerKey = "Content-Disposition";
	    	  String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
	    	  response.setHeader(headerKey, headerValue); 
	    	  inStream.close(); 
	    	  con.close(); 
	    	   
			 // __________________________________________________________________________________________________________________________
	    	  response.sendRedirect("DownloadMaster.jsp?filepath="+filePath+"&hidMst="+vo.getHid()); 
	    	  
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/******************************************************************************************************************************************************************************/
	/********************************************************************* REJECT DATA LOGIC ******************************************************************************/
	/******************************************************************************************************************************************************************************/
	public void setRejectExcel(NewVendCustMaster_VO vo,
			HttpServletResponse response) {
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
			Connection con =  Connection_Utility.getConnectionMaster();
			Connection conLocal = Connection_Utility.getLocalUserConnection();
			PreparedStatement ps_mst = null, ps_mst1=null,ps_check=null,ps_check1=null,ps_mst2=null;
			ResultSet rs_mst = null,rs_mst1=null,rs_check=null,rs_check1=null,rs_mst2=null ;
			String success = "Error Occurred....",user_Req="";
			
			ps_mst = con.prepareStatement("update sap_masterVendCust set reject_date=?,reject_reason=?,rejected_by=?,stage=?  where id="+Integer.valueOf(vo.getHid()));
			ps_mst.setTimestamp(1, timeStamp);
			ps_mst.setString(2, vo.getRejectReason());
			ps_mst.setString(3, vo.getLoginNameString());
			ps_mst.setString(4, "4");
			
			int cnt = ps_mst.executeUpdate();
			if(cnt>0){

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
					
					String subject = "New Customer/Vendor :" + org_NameString +" is Rejected By " + vo.getLoginNameString();
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
								+ "<p>Please find below Rejected Vendor / Customer Data :</P>"
								+ "<table border='1' width='100%'><tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"
								+ "<th width='5%' height='25'> S. No </th>"
								+ "<th>Customer / Vendor For</th>"
								+ "<th>NAME OF ORG</th>"
								+ "<th>Reason / Required For</th>"
								+ "<th>Requester</th>"
								+ "<th>PAN NO </th>"
								+ "<th>Email ID</th>"
								+ "<th>Mobile NO</th>"
								+ "<th>Reject Reason</th></tr>");
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
									+ "</td>" + "<td style='text-align: left;''><b>"+ rs_check.getString("reject_reason")  +" ..Rejected By "+ rs_check.getString("rejected_by")+"</b></td></tr>");
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
					 
				success = vo.getCust_vend() + " Rejected..";
				response.sendRedirect("DownloadMaster.jsp?success="+success+"&hidMst="+vo.getHid()); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
