package com.vendorform.vo;

import java.io.InputStream;
import java.sql.Date;

public class FileUpload_vo {
	private String name_vendor, org_type, business_type, owner_name,
			year_establish, owner_contact, owner_altercont, address,
			nature_activity, reg_ssi, vat_tin, exceise_no, cst_no, pan_no,
			trade_no, anual_turnover, reference_no, prev_os, builtup, unbuilt,
			filename, sanctionedkva, actualkva, capacitykva, vend_certi,
			expansion_planning, install_newMac, relative_name, relation_rel,
			hid_h21 = "", hid_h251 = "", hid_h252 = "", hid_u3 = "",
			hid_di = "", hid_mfpl = "", revision_no, hid, approval, company,
			remark;
	InputStream file_blob;
	private Date ssi_date, vat_tindate, revision_date;

	public String getName_vendor() {
		return name_vendor;
	}

	public void setName_vendor(String name_vendor) {
		this.name_vendor = name_vendor;
	}

	public String getOrg_type() {
		return org_type;
	}

	public void setOrg_type(String org_type) {
		this.org_type = org_type;
	}

	public String getBusiness_type() {
		return business_type;
	}

	public void setBusiness_type(String business_type) {
		this.business_type = business_type;
	}

	public String getOwner_name() {
		return owner_name;
	}

	public void setOwner_name(String owner_name) {
		this.owner_name = owner_name;
	}

	public String getYear_establish() {
		return year_establish;
	}

	public void setYear_establish(String year_establish) {
		this.year_establish = year_establish;
	}

	public String getOwner_contact() {
		return owner_contact;
	}

	public void setOwner_contact(String owner_contact) {
		this.owner_contact = owner_contact;
	}

	public String getOwner_altercont() {
		return owner_altercont;
	}

	public void setOwner_altercont(String owner_altercont) {
		this.owner_altercont = owner_altercont;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getNature_activity() {
		return nature_activity;
	}

	public void setNature_activity(String nature_activity) {
		this.nature_activity = nature_activity;
	}

	public String getReg_ssi() {
		return reg_ssi;
	}

	public void setReg_ssi(String reg_ssi) {
		this.reg_ssi = reg_ssi;
	}

	public String getVat_tin() {
		return vat_tin;
	}

	public void setVat_tin(String vat_tin) {
		this.vat_tin = vat_tin;
	}

	public String getExceise_no() {
		return exceise_no;
	}

	public void setExceise_no(String exceise_no) {
		this.exceise_no = exceise_no;
	}

	public String getCst_no() {
		return cst_no;
	}

	public void setCst_no(String cst_no) {
		this.cst_no = cst_no;
	}

	public String getPan_no() {
		return pan_no;
	}

	public void setPan_no(String pan_no) {
		this.pan_no = pan_no;
	}

	public String getTrade_no() {
		return trade_no;
	}

	public void setTrade_no(String trade_no) {
		this.trade_no = trade_no;
	}

	public String getAnual_turnover() {
		return anual_turnover;
	}

	public void setAnual_turnover(String anual_turnover) {
		this.anual_turnover = anual_turnover;
	}

	public String getReference_no() {
		return reference_no;
	}

	public void setReference_no(String reference_no) {
		this.reference_no = reference_no;
	}

	public String getPrev_os() {
		return prev_os;
	}

	public void setPrev_os(String prev_os) {
		this.prev_os = prev_os;
	}

	public String getBuiltup() {
		return builtup;
	}

	public void setBuiltup(String builtup) {
		this.builtup = builtup;
	}

	public String getUnbuilt() {
		return unbuilt;
	}

	public void setUnbuilt(String unbuilt) {
		this.unbuilt = unbuilt;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getSanctionedkva() {
		return sanctionedkva;
	}

	public void setSanctionedkva(String sanctionedkva) {
		this.sanctionedkva = sanctionedkva;
	}

	public String getActualkva() {
		return actualkva;
	}

	public void setActualkva(String actualkva) {
		this.actualkva = actualkva;
	}

	public String getCapacitykva() {
		return capacitykva;
	}

	public void setCapacitykva(String capacitykva) {
		this.capacitykva = capacitykva;
	}

	public String getVend_certi() {
		return vend_certi;
	}

	public void setVend_certi(String vend_certi) {
		this.vend_certi = vend_certi;
	}

	public String getExpansion_planning() {
		return expansion_planning;
	}

	public void setExpansion_planning(String expansion_planning) {
		this.expansion_planning = expansion_planning;
	}

	public String getInstall_newMac() {
		return install_newMac;
	}

	public void setInstall_newMac(String install_newMac) {
		this.install_newMac = install_newMac;
	}

	public String getRelative_name() {
		return relative_name;
	}

	public void setRelative_name(String relative_name) {
		this.relative_name = relative_name;
	}

	public String getRelation_rel() {
		return relation_rel;
	}

	public void setRelation_rel(String relation_rel) {
		this.relation_rel = relation_rel;
	}

	public String getHid_h21() {
		return hid_h21;
	}

	public void setHid_h21(String hid_h21) {
		this.hid_h21 = hid_h21;
	}

	public String getHid_h251() {
		return hid_h251;
	}

	public void setHid_h251(String hid_h251) {
		this.hid_h251 = hid_h251;
	}

	public String getHid_h252() {
		return hid_h252;
	}

	public void setHid_h252(String hid_h252) {
		this.hid_h252 = hid_h252;
	}

	public String getHid_u3() {
		return hid_u3;
	}

	public void setHid_u3(String hid_u3) {
		this.hid_u3 = hid_u3;
	}

	public String getHid_di() {
		return hid_di;
	}

	public void setHid_di(String hid_di) {
		this.hid_di = hid_di;
	}

	public String getHid_mfpl() {
		return hid_mfpl;
	}

	public void setHid_mfpl(String hid_mfpl) {
		this.hid_mfpl = hid_mfpl;
	}

	public InputStream getFile_blob() {
		return file_blob;
	}

	public void setFile_blob(InputStream file_blob) {
		this.file_blob = file_blob;
	}

	public String getRevision_no() {
		return revision_no;
	}

	public void setRevision_no(String revision_no) {
		this.revision_no = revision_no;
	}

	public Date getSsi_date() {
		return ssi_date;
	}

	public void setSsi_date(Date ssi_date) {
		this.ssi_date = ssi_date;
	}

	public Date getVat_tindate() {
		return vat_tindate;
	}

	public void setVat_tindate(Date vat_tindate) {
		this.vat_tindate = vat_tindate;
	}

	public Date getRevision_date() {
		return revision_date;
	}

	public void setRevision_date(Date revision_date) {
		this.revision_date = revision_date;
	}

	public String getHid() {
		return hid;
	}

	public void setHid(String hid) {
		this.hid = hid;
	}

	public String getApproval() {
		return approval;
	}

	public void setApproval(String approval) {
		this.approval = approval;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
