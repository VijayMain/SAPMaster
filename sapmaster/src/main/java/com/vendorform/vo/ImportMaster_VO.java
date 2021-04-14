package com.vendorform.vo;

import java.io.InputStream;

public class ImportMaster_VO {

	int Company_Id = 0, Item_Id = 0, crno = 0, srno = 0;
	String fileName = "", datafor = "";
	InputStream file_blob;

	public String getDatafor() {
		return datafor;
	}

	public void setDatafor(String datafor) {
		this.datafor = datafor;
	}

	public int getCompany_Id() {
		return Company_Id;
	}

	public void setCompany_Id(int company_Id) {
		Company_Id = company_Id;
	}

	public int getItem_Id() {
		return Item_Id;
	}

	public void setItem_Id(int item_Id) {
		Item_Id = item_Id;
	}

	public int getCrno() {
		return crno;
	}

	public void setCrno(int crno) {
		this.crno = crno;
	}

	public int getSrno() {
		return srno;
	}

	public void setSrno(int srno) {
		this.srno = srno;
	}

	public InputStream getFile_blob() {
		return file_blob;
	}

	public void setFile_blob(InputStream file_blob) {
		this.file_blob = file_blob;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

}
