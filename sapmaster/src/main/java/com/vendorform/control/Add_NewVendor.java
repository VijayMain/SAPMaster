package com.vendorform.control;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List; 

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils; 

import com.vendorform.dao.FileUpload_dao;
import com.vendorform.vo.FileUpload_vo;

@WebServlet("/Add_NewVendor")
public class Add_NewVendor extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		FileItem fileItem = null;
		InputStream file_Input = null;
		try {
			FileUpload_vo bean = new FileUpload_vo();
			ArrayList visible = new ArrayList();
			FileUpload_dao dao = new FileUpload_dao(); 
			HttpSession session = request.getSession();
			InputStream doc_Input = null,photo_Input = null;  
			Date convertedDate = null;
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			/**********************************************************************************************************
			 * For MultipartContent Separate FILE Fields and FORM Fields 
			 **********************************************************************************************************/
			if (ServletFileUpload.isMultipartContent(request)) {
				String fieldName, fieldValue = "";
 				ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
				List fileItemsList;
					fileItemsList = servletFileUpload.parseRequest(request);
					Iterator it = fileItemsList.iterator();
					while (it.hasNext()) {
						FileItem fileItemTemp = (FileItem) it.next();
						if (fileItemTemp.isFormField()) {
							fieldName = fileItemTemp.getFieldName();
							fieldValue = fileItemTemp.getString();
// name_vendor ,org_type , business_type ,  owner_name, year_establish, owner_contact , owner_altercont , address , nature_activity , 
// reg_ssi , ssi_date, vat_tin , vat_tindate , exceise_no , cst_no , pan_no , trade_no , anual_turnover		
// reference_no   prev_os   builtup   unbuilt   filename  sanctionedkva   actualkva   capacitykva   vend_certi    expansion_planning   
// install_newMac   relative_name   relation_rel   hid_h21   hid_h251   hid_h252   hid_u3   hid_di   hid_mfpl 
							if (fieldName.equalsIgnoreCase("name_vendor")) {
								bean.setName_vendor(fieldValue); 
							}if (fieldName.equalsIgnoreCase("org_type")) {
								bean.setOrg_type(fieldValue); 
							}if (fieldName.equalsIgnoreCase("business_type")) {
								bean.setBusiness_type(fieldValue); 
							}if (fieldName.equalsIgnoreCase("owner_name")) {
								bean.setOwner_name(fieldValue); 
							}if (fieldName.equalsIgnoreCase("year_establish")) {
								bean.setYear_establish(fieldValue); 
							}if (fieldName.equalsIgnoreCase("owner_contact")) {
								bean.setOwner_contact(fieldValue); 
							}if (fieldName.equalsIgnoreCase("owner_altercont")) {
								bean.setOwner_altercont(fieldValue); 
							}if (fieldName.equalsIgnoreCase("address")) {
								bean.setAddress(fieldValue); 
							}if (fieldName.equalsIgnoreCase("nature_activity")) {
								bean.setNature_activity(fieldValue); 
							}if (fieldName.equalsIgnoreCase("reg_ssi")) {
								bean.setReg_ssi(fieldValue); 
							}if (fieldName.equalsIgnoreCase("ssi_date")) {
								if(!fieldValue.equalsIgnoreCase("")){
								convertedDate = new java.sql.Date(formatter.parse(fieldValue).getTime());
								bean.setSsi_date(convertedDate); 
								}
							}if (fieldName.equalsIgnoreCase("vat_tin")) {
								bean.setVat_tin(fieldValue); 
							}if (fieldName.equalsIgnoreCase("vat_tindate")) {
								if(!fieldValue.equalsIgnoreCase("")){
								convertedDate = new java.sql.Date(formatter.parse(fieldValue).getTime());
								bean.setVat_tindate(convertedDate);
								}
							}if (fieldName.equalsIgnoreCase("exceise_no")) {
								bean.setExceise_no(fieldValue); 
							}if (fieldName.equalsIgnoreCase("cst_no")) {
								bean.setCst_no(fieldValue); 
							}if (fieldName.equalsIgnoreCase("pan_no")) {
								bean.setPan_no(fieldValue); 
							}if (fieldName.equalsIgnoreCase("trade_no")) {
								bean.setTrade_no(fieldValue); 
							}if (fieldName.equalsIgnoreCase("anual_turnover")) {
								bean.setAnual_turnover(fieldValue); 
							}if (fieldName.equalsIgnoreCase("reference_no")) {
								bean.setReference_no(fieldValue); 
							}if (fieldName.equalsIgnoreCase("prev_os")) {
								bean.setPrev_os(fieldValue); 
							}if (fieldName.equalsIgnoreCase("builtup")) {
								bean.setBuiltup(fieldValue); 
							}if (fieldName.equalsIgnoreCase("unbuilt")) {
								bean.setUnbuilt(fieldValue); 
							}if (fieldName.equalsIgnoreCase("sanctionedkva")) {
								bean.setSanctionedkva(fieldValue); 
							}if (fieldName.equalsIgnoreCase("actualkva")) {
								bean.setActualkva(fieldValue); 
							}if (fieldName.equalsIgnoreCase("capacitykva")) {
								bean.setCapacitykva(fieldValue); 
							}if (fieldName.equalsIgnoreCase("vend_certi")) {
								bean.setVend_certi(fieldValue); 
							}if (fieldName.equalsIgnoreCase("expansion_planning")) {
								bean.setExpansion_planning(fieldValue); 
							}if (fieldName.equalsIgnoreCase("install_newMac")) {
								bean.setInstall_newMac(fieldValue); 
							}
							if (fieldName.equalsIgnoreCase("relative_name")) {
								bean.setRelative_name(fieldValue); 
							}
							if (fieldName.equalsIgnoreCase("relation_rel")) {
								bean.setRelation_rel(fieldValue); 
							}if (fieldName.equalsIgnoreCase("revision_no")) {	      
								bean.setRevision_no(fieldValue); 
							}if (fieldName.equalsIgnoreCase("revision_date")) {
								if(!fieldValue.equalsIgnoreCase("")){
									convertedDate = new java.sql.Date(formatter.parse(fieldValue).getTime());
									bean.setRevision_date(convertedDate);
								}
							}
							if (fieldName.equalsIgnoreCase("hid_h21")) { 
								bean.setHid_h21(fieldValue); 
							}if (fieldName.equalsIgnoreCase("hid_h251")) {
								bean.setHid_h251(fieldValue); 
							}if (fieldName.equalsIgnoreCase("hid_h252")) {
								bean.setHid_h252(fieldValue); 
							}if (fieldName.equalsIgnoreCase("hid_u3")) {
								bean.setHid_u3(fieldValue); 
							}if (fieldName.equalsIgnoreCase("hid_di")) {
								bean.setHid_di(fieldValue); 
							}if (fieldName.equalsIgnoreCase("hid_mfpl")) {
								bean.setHid_mfpl(fieldValue); 
							}
						}
						// *****************************************************************************************************
						else {
							// *************************************************************************************************************
							// IF FILE inputs === >
							// *************************************************************************************************************
							String file_stored = null;
							fileItem = fileItemTemp;
							fieldName = fileItem.getFieldName();
							fieldValue = fileItem.getString();
							
								if (fieldName.equalsIgnoreCase("filename")) {
									file_stored = fileItem.getName(); 
									bean.setFilename(FilenameUtils.getName(file_stored));
									file_Input = new DataInputStream(fileItem.getInputStream());
									bean.setFile_blob(file_Input); 
								}
							}
					}
			}
		dao.uploadFile(session, bean, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}