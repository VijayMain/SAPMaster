package com.vendorform.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vendorform.dao.NewMaster_DAO;
import com.vendorform.vo.NewMaster_VO;

@WebServlet("/NewMaster_CreationControl")
public class NewMaster_CreationControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			NewMaster_VO vo = new NewMaster_VO();
			NewMaster_DAO dao = new NewMaster_DAO();

			String editedData = request.getParameter("editedData");
			
			String mat_name = request.getParameter("mat_name");
			String ind_sector = request.getParameter("ind_sector");
			String oldMaterialNo = request.getParameter("oldMaterialNo");
			String baseUOM = request.getParameter("baseUOM");
			String netWt = request.getParameter("netWt");
			String plant = request.getParameter("plant");
			String wtUnit = request.getParameter("wtUnit");
			String matGroup = request.getParameter("matGroup");
			String size_dim = request.getParameter("size_dim");
			String ext_matGroup = request.getParameter("ext_matGroup");
			String storage_loc = request.getParameter("storage_loc");
			String division = request.getParameter("division");
			String genItemCatGroup = request.getParameter("genItemCatGroup");
			String gross_wt = request.getParameter("gross_wt");
			String sales_org = request.getParameter("sales_org");
			String jocg = request.getParameter("jocg");
			String dist_channel = request.getParameter("dist_channel");
			String josg = request.getParameter("josg");
			String sale_unit = request.getParameter("sale_unit");
			String joig = request.getParameter("joig");
			String acct_assgnGroup = request.getParameter("acct_assgnGroup");
			String mat_grp1 = request.getParameter("mat_grp1");
			String itemCatGroup = request.getParameter("itemCatGroup");
			String mat_grp2 = request.getParameter("mat_grp2");
			String availability_chk = request.getParameter("availability_chk");
			String load_group = request.getParameter("load_group");
			String trans_group = request.getParameter("trans_group");
			String profitCenter = request.getParameter("profitCenter");
			String controlCode = request.getParameter("controlCode");
			String purchase_Group = request.getParameter("purchase_Group");
			String pur_valueKey = request.getParameter("pur_valueKey");
			String tax_ind = request.getParameter("tax_ind");
			String gr_processingTime = request.getParameter("gr_processingTime");
			String mrpType = request.getParameter("mrpType");
			String lotSizing_proc = request.getParameter("lotSizing_proc");
			String mrp_group = request.getParameter("mrp_group");
			String min_LotSize = request.getParameter("min_LotSize");
			String reorderPoint = request.getParameter("reorderPoint");
			String max_LotSize = request.getParameter("max_LotSize");
			String abc_indicator = request.getParameter("abc_indicator");
			String fixLot = request.getParameter("fixLot");
			String mrp_Controller = request.getParameter("mrp_Controller");
			String MaxStocklevel = request.getParameter("MaxStocklevel");
			String procure_type = request.getParameter("procure_type");
			String plan_delTime = request.getParameter("plan_delTime");
			String specialProc = request.getParameter("specialProc");
			String schMrg_Key = request.getParameter("schMrg_Key");
			String prod_StorageLoc = request.getParameter("prod_StorageLoc");
			String backflush = request.getParameter("backflush");
			String minSafetyStock = request.getParameter("minSafetyStock");
			String safety_stk = request.getParameter("safety_stk");
			String inhouseProduction = request.getParameter("inhouseProduction");
			String strategy_grp = request.getParameter("strategy_grp");
			String prod_supervisor = request.getParameter("prod_supervisor");
			String batch_indicator = request.getParameter("batch_indicator");
			String prod_schedProfile = request.getParameter("prod_schedProfile");
			String minRemain_ShelfLife = request.getParameter("minRemain_ShelfLife");
			String tot_shelfLife = request.getParameter("tot_shelfLife");
			String insp_setupTick = request.getParameter("insp_setupTick");
			String qm_ProcActive = request.getParameter("qm_ProcActive");
			String qm_controlKey = request.getParameter("qm_controlKey");
			String valueation_class = request.getParameter("valueation_class");
			String moveing_price = request.getParameter("moveing_price");
			String price_control = request.getParameter("price_control");
			String withQty_structure = request.getParameter("withQty_structure");
			String price_unit = request.getParameter("price_unit");
			String overhead_group = request.getParameter("overhead_group");
			String standardPrice = request.getParameter("standardPrice");
			String remark = request.getParameter("remark");

			String material_type = request.getParameter("material_type");   
			
			vo.setMat_name(mat_name.toUpperCase());
			vo.setInd_sector(ind_sector);
			vo.setOldMaterialNo(oldMaterialNo);
			vo.setBaseUOM(baseUOM);
			vo.setNetWt(netWt);
			vo.setPlant(plant);
			vo.setWtUnit(wtUnit);
			vo.setMatGroup(matGroup);
			vo.setSize_dim(size_dim);
			vo.setExt_matGroup(ext_matGroup);
			vo.setStorage_loc(storage_loc.toUpperCase());
			vo.setDivision(division);
			vo.setGenItemCatGroup(genItemCatGroup);
			vo.setGross_wt(gross_wt);
			vo.setSales_org(sales_org);
			vo.setJocg(jocg);
			vo.setDist_channel(dist_channel);
			vo.setJosg(josg);
			vo.setSale_unit(sale_unit);
			vo.setJoig(joig);
			vo.setAcct_assgnGroup(acct_assgnGroup);
			vo.setMat_grp1(mat_grp1);
			vo.setItemCatGroup(itemCatGroup);
			vo.setMat_grp2(mat_grp2);
			vo.setAvailability_chk(availability_chk);
			vo.setLoad_group(load_group);
			vo.setTrans_group(trans_group);
			vo.setProfitCenter(profitCenter);
			vo.setControlCode(controlCode);
			vo.setPurchase_Group(purchase_Group);
			vo.setPur_valueKey(pur_valueKey);
			vo.setTax_ind(tax_ind);
			vo.setGr_processingTime(gr_processingTime);
			vo.setMrpType(mrpType);
			vo.setLotSizing_proc(lotSizing_proc);
			vo.setMrp_group(mrp_group);
			vo.setMin_LotSize(min_LotSize);
			vo.setReorderPoint(reorderPoint);
			vo.setMax_LotSize(max_LotSize);
			vo.setAbc_indicator(abc_indicator);
			vo.setFixLot(fixLot);
			vo.setMrp_Controller(mrp_Controller);
			vo.setMaxStocklevel(MaxStocklevel);
			vo.setProcure_type(procure_type);
			vo.setPlan_delTime(plan_delTime);
			vo.setSpecialProc(specialProc);
			vo.setSchMrg_Key(schMrg_Key);
			vo.setProd_StorageLoc(prod_StorageLoc);
			vo.setBackflush(backflush);
			vo.setMinSafetyStock(minSafetyStock);
			vo.setSafety_stk(safety_stk);
			vo.setInhouseProduction(inhouseProduction);
			vo.setStrategy_grp(strategy_grp);
			vo.setProd_supervisor(prod_supervisor);
			vo.setBatch_indicator(batch_indicator);
			vo.setProd_schedProfile(prod_schedProfile);
			vo.setMinRemain_ShelfLife(minRemain_ShelfLife);
			vo.setTot_shelfLife(tot_shelfLife);
			vo.setInsp_setupTick(insp_setupTick);
			vo.setQm_ProcActive(qm_ProcActive);
			vo.setQm_controlKey(qm_controlKey);
			vo.setValueation_class(valueation_class);
			vo.setMoveing_price(moveing_price);
			vo.setPrice_control(price_control);
			vo.setWithQty_structure(withQty_structure);
			vo.setPrice_unit(price_unit);
			vo.setOverhead_group(overhead_group);
			vo.setStandardPrice(standardPrice);
			vo.setRemark(remark);
			vo.setMaterial_type(material_type);

			HttpSession session = request.getSession();
			String uid = session.getAttribute("uid").toString();

			String email_id = session.getAttribute("email_id").toString();
			vo.setEmail_id(email_id);

			String uname = session.getAttribute("username").toString(), d_Id = session.getAttribute("dept_id").toString();

			vo.setUid(uid);
			vo.setD_Id(d_Id);
			vo.setUname(uname);
			vo.setEditedData(editedData);
			
			if(vo.getEditedData().equalsIgnoreCase("1")){
				vo.setMaterial_type(request.getParameter("typeMat"));
				vo.setHid_mstString(request.getParameter("hid"));
				int pur_id = Integer.valueOf(request.getParameter("pur_id"));
				vo.setPur_id(pur_id);
				
				if(request.getParameterValues("wrongID")!=null){
					String[] names = request.getParameterValues("wrongID");
					vo.setWrongID(names[0].toString());
					vo.setCancellation(request.getParameter("cancellation"));
				}
			}
			dao.createNewMaster(vo, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}