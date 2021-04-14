package com.vendorform.control;

import it.muthagroup.connectionUtility.Connection_Utility;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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
import com.vendorform.dao.ImportMaster_DAO; 
import com.vendorform.vo.ImportMaster_VO;
 

@WebServlet("/Sandbox_CNTRL")
public class Sandbox_CNTRL extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		try { 
			InputStream file_Input = null;
			String NewReq = null;
			boolean flag = false;
			HttpSession session = request.getSession();
			// ************************************************************************************************************************
			ImportMaster_VO bean = new ImportMaster_VO();
			ImportMaster_DAO dao = new ImportMaster_DAO();
			/**********************************************************************************************************
			 * For MultipartContent Separate FILE Fields and FORM Fields
			 **********************************************************************************************************/

			if (ServletFileUpload.isMultipartContent(request)) {
				String fieldName, fieldValue = "";
				ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
				List fileItemsList;
				try {
					fileItemsList = servletFileUpload.parseRequest(request);
					// Collect data into list
					FileItem fileItem = null;
					Iterator it = fileItemsList.iterator();
					// iterate list to sort data(i.e. form / file Fields)
					while (it.hasNext()) {
						FileItem fileItemTemp = (FileItem) it.next();
						// if data is form field ==== >
						if (fileItemTemp.isFormField()) {
							// INPUT FORM FIELDS are ==== >
							fieldName = fileItemTemp.getFieldName();
							fieldValue = fileItemTemp.getString();

							// TO SELECT PARTICULAR FORM FIELD ====>
							/*if (fieldName.equalsIgnoreCase("mat_type")) {
								bean.setMat_type(fieldValue);
								System.out.println(bean.getMat_type());
							}*/

						} else {
							// *************************************************************************************************************
							// IF FILE inputs === >
							// *************************************************************************************************************
							String file_stored = null;
							fileItem = fileItemTemp;
							fieldName = fileItem.getFieldName();
							fieldValue = fileItem.getString();
							// *************************************************************************************************************
							// if multiple files then there names are
							// inputName1,inputName2,inputName3,.......
							// *************************************************************************************************************

							System.out.println("File Name in java : " + fieldName);
							file_stored = fileItem.getName();
							bean.setFileName(FilenameUtils.getName(file_stored));
							// System.out.println(FilenameUtils.getName(file_stored));
							file_Input = new DataInputStream(fileItem.getInputStream());
							// System.out.println("Input sr no is = " + k);
						}
						// Attach file ====>
						bean.setFile_blob(file_Input); 
					}
					/*if (bean.getMat_type() != null && bean.getFile_blob()!=null) {
						System.out.println(" name = " + bean.getMat_type());
						dao.attach_File(response, bean, session);
					}*/
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
