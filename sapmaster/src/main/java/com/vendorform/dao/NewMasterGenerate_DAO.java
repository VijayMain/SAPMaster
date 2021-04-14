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

import com.vendorform.vo.NewMasterGenerate_VO;

public class NewMasterGenerate_DAO {

	public void generateExcel(NewMasterGenerate_VO vo,
			HttpServletResponse response, ArrayList idList, ServletContext context) {
		try {
			/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
			java.util.Date date = null;
			java.sql.Timestamp timeStamp = null;
			Calendar calendar=Calendar.getInstance();
			calendar.setTime(new Date());
			java.sql.Date dt = new java.sql.Date(calendar.getTimeInMillis());

			java.sql.Time sqlTime=new java.sql.Time(calendar.getTime().getTime());
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			date = simpleDateFormat.parse(dt.toString()+" "+sqlTime.toString());
			timeStamp = new java.sql.Timestamp(date.getTime());
			
				int insertID = 0, totalColumns=0,up=0;
				Connection con =  Connection_Utility.getConnectionMaster();
				PreparedStatement ps_check = null, ps_check1 = null;
				ResultSet rs_check = null, rs_check1 = null;
				ps_check = con.prepareStatement("SELECT max(id) as id FROM sap_mastertran");
				rs_check = ps_check.executeQuery();
				while (rs_check.next()) {
					insertID = rs_check.getInt("id");
				}
				
				for(int i=0;i<idList.size();i++){
					
					ps_check = con.prepareStatement("SELECT * FROM sap_mastertran where id ="+ Integer.valueOf(idList.get(i).toString()) +" and stage!='4'");
					rs_check = ps_check.executeQuery();
					while (rs_check.next()) {
						ps_check1 = con.prepareStatement("update sap_mastertran set stage=?,generate_date=? where id="+Integer.valueOf(idList.get(i).toString()));
						ps_check1.setString(1, "0");
						ps_check1.setTimestamp(2, timeStamp);
						
						up=ps_check1.executeUpdate();	
					}
				}
				/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
																									 Excel Configuration Start    
				 -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
				
				int row=1,col=0;
				ArrayList alistFile = new ArrayList();
				File folder = new File("C:/reportxls");
				File[] listOfFiles = folder.listFiles();
				String listname = "";  
				
			 	int val = listOfFiles.length + 1;
				
				File exlFile = new File("C:/reportxls/MasterTemplate"+val+".xls");
			    WritableWorkbook writableWorkbook = Workbook.createWorkbook(exlFile); 
			    WritableSheet writableSheet = writableWorkbook.createSheet("Sheet1", 0);
			    
			    Colour bckcolor = Colour.GRAY_25;
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
			        
			    /*writableSheet.mergeCells(0, 0, 10, 0);
			    Label labelName = new Label(0, 0,  "Overdue Vendor Payment of ",cellFormat);
			    writableSheet.addCell(labelName);
			    
			    for (int i = 0; i <= totalColumns; i++) {
			    writableSheet.setColumnView(i, 15);
			    }*/
			    Label label = new Label(0, 0, "Sr.No",cellFormat);
			    writableSheet.addCell(label);
			    
			    ArrayList<String> tempHead = new ArrayList<String>();
			    ps_check = con.prepareStatement("select * from sap_mastertemplate where enable=1 order by position"); 
				rs_check = ps_check.executeQuery();
				while (rs_check.next()) {
					tempHead.add(rs_check.getString("tableColumn"));
					Label label1 = new Label(rs_check.getInt("position"), 0, rs_check.getString("tempHeader_name"),cellFormat);
				    writableSheet.addCell(label1);
				}
			    //***********************************************************************************************************************************
				
				int sno=0;
				for(int i=0;i<idList.size();i++){
				sno++;
					Label column1 = new Label(col, row, String.valueOf(sno),cellRIghtformat);
	 			    writableSheet.addCell(column1);
	 			    col++;
	 			    
				for(int e=0;e<tempHead.size();e++){
				//System.out.println(tempHead.get(e).toString());
					
				if(!tempHead.get(e).toString().equalsIgnoreCase("JTC1")){
				ps_check = con.prepareStatement("SELECT  " + tempHead.get(e).toString() + " FROM sap_mastertran where id=" + Integer.valueOf(idList.get(i).toString()));
				rs_check = ps_check.executeQuery();
				while (rs_check.next()) {
					if(rs_check.getString(tempHead.get(e).toString())==null || rs_check.getString(tempHead.get(e).toString())=="null"){
						Label column = new Label(col, row, String.valueOf(""),cellleftformat);
		 			    writableSheet.addCell(column);
		 			    col++;
					}else{
						Label column = new Label(col, row, rs_check.getString(tempHead.get(e).toString()),cellleftformat);
		 			    writableSheet.addCell(column);
		 			    col++;
					}
			    }
				}else{
			    	Label column = new Label(col, row, String.valueOf("0"),cellleftformat);
	 			    writableSheet.addCell(column);
	 			    col++;
			    }
				}
				row++;
				col=0;
				}
			  		// Write and close the workbook
			    	writableWorkbook.write();
			    	writableWorkbook.close();
			    	
			    	//***********************************************************************************************************************************
			    	String filePath = "C:/reportxls/MasterTemplate"+val+".xls"; 
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
			    	  response.sendRedirect("Home_MST.jsp?filepath="+filePath); 
			    	//***********************************************************************************************************************************
			    	
		} catch (Exception e) {
			e.printStackTrace();
		} 
}
}
