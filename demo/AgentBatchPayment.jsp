<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%@ page import = "java.math.BigDecimal" %>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Cache-Control", "no-cache");
%>
<HTML>
<HEAD>
<TITLE>农行网上支付平台-商户接口范例-委托扣款批量</TITLE>
</HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF'
	ALINK='#FF0000'>
<CENTER>授权扣款扣款批量</CENTER>
<%
	//1、取得委托扣款批量需要的信息
	String batchNo = request.getParameter("BatchNo");
	//String batchDate = request.getParameter("BatchDate");
	String agentCount = request.getParameter("AgentCount");
	String agentAmount = request.getParameter("AgentAmount");
	
	//String orderno_arr[] = null;
	//String orderamount_arr[] = null;
	//String expireddate_arr[] = null;
	//String certificateno_arr[] = null;
	//String contractid_arr[] = null;
	//String productid_arr[] = null;
	//String productname_arr[] = null;
	//String productnum_arr[] = null;
	String seqno_arr[] = null;
    String orderno_arr[] = null;
    String agentsignno_arr[] = null;
    String cardno_arr[] = null;
    String orderamount_arr[] = null;
    String receiveraddress_arr[] = null;
    String fee_arr[] = null;
    String certificateno_arr[] = null;
    String installmentmark_arr[] = null;
    String installmentcode_arr[] = null;
    String installmentnum_arr[] = null;
    String commoditytype_arr[] = null;
    String submername_arr[] = null;
    String submerid_arr[] = null;
    String submermcc_arr[] = null;
    String submerchantremarks_arr[] = null;
    String productid_arr[] = null;
    String productname_arr[] = null;
    String unitprice_arr[] = null;
    String qty_arr[] = null;
    String productremarks_arr[] = null;
    String producttype_arr[] = null;
    String productdiscount_arr[] = null;
    String productexpireddate_arr[] = null;
    String buyip_arr[] = null;
    String remark_arr[] = null;
    String IsBreakAccount_arr[] = null;
    String SplitAccTemplate_arr[] = null;

	int iBatchSize = Integer.parseInt(agentCount);
	
	if (iBatchSize == 1) {
		String seqno = request.getParameter("SeqNo");
        String orderno = request.getParameter("OrderNo");
        String agentsignno = request.getParameter("AgentSignNo");
        String cardno = request.getParameter("CardNo");
        String orderamount = request.getParameter("OrderAmount");
        String receiveraddress = request.getParameter("ReceiverAddress");
        String fee = request.getParameter("Fee");
        String certificateno = request.getParameter("CertificateNo");
        String installmentmark = request.getParameter("InstallmentMark");
        String installmentcode = request.getParameter("InstallmentCode");
        String installmentnum = request.getParameter("InstallmentNum");
        String commoditytype = request.getParameter("CommodityType");
        String submername = request.getParameter("SubMerName");
        String submerid = request.getParameter("SubMerId");
        String submermcc = request.getParameter("SubMerMCC");
        String submerchantremarks = request.getParameter("SubMerchantRemarks");
        String productid = request.getParameter("ProductID");
        String productname = request.getParameter("ProductName");
        String unitprice = request.getParameter("UnitPrice");
        String qty = request.getParameter("Qty");
        String productremarks = request.getParameter("ProductRemarks");
        String producttype = request.getParameter("ProductType");
        String productdiscount = request.getParameter("ProductDiscount");
        String productexpireddate = request.getParameter("ProductExpiredDate");
        String buyip = request.getParameter("BuyIP");
        String remark = request.getParameter("Remark");
		String IsBreakAccount = request.getParameter("IsBreakAccount");
		String SplitAccTemplate = request.getParameter("SplitAccTemplate"); 
		
		seqno_arr = new String[] { seqno };
		orderno_arr = new String[] { orderno };
		agentsignno_arr = new String[] { agentsignno };
		cardno_arr = new String[] { cardno };
		orderamount_arr = new String[] { orderamount };
		receiveraddress_arr = new String[] { receiveraddress };
		fee_arr = new String[] { fee };
		certificateno_arr = new String[] { certificateno };
		installmentmark_arr = new String[] { installmentmark };
		installmentcode_arr = new String[] { installmentcode };
		installmentnum_arr = new String[] { installmentnum };
		commoditytype_arr = new String[] { commoditytype };
		submername_arr = new String[] { submername };
		submerid_arr = new String[] { submerid };
		submermcc_arr = new String[] { submermcc };
		submerchantremarks_arr = new String[] { submerchantremarks };
		productid_arr = new String[] { productid };
		productname_arr = new String[] { productname };
		unitprice_arr = new String[] { unitprice };
		qty_arr = new String[] { qty };
		productremarks_arr = new String[] { productremarks };
		producttype_arr = new String[] { producttype };
		productdiscount_arr = new String[] { productdiscount };
		productexpireddate_arr = new String[] { productexpireddate };
		buyip_arr = new String[] { buyip };
		remark_arr = new String[] { remark };		
		IsBreakAccount_arr = new String[] { IsBreakAccount };
    	SplitAccTemplate_arr = new String[] { SplitAccTemplate };;

	} else {
        
		seqno_arr = request.getParameterValues("SeqNo");
		orderno_arr = request.getParameterValues("OrderNo");
		agentsignno_arr = request.getParameterValues("AgentSignNo");
		cardno_arr = request.getParameterValues("CardNo");
		orderamount_arr = request.getParameterValues("OrderAmount");
		receiveraddress_arr = request.getParameterValues("ReceiverAddress");
		fee_arr = request.getParameterValues("Fee");
		certificateno_arr = request.getParameterValues("CertificateNo");
		installmentmark_arr = request.getParameterValues("InstallmentMark");
		installmentcode_arr = request.getParameterValues("InstallmentCode");
		installmentnum_arr = request.getParameterValues("InstallmentNum");
		commoditytype_arr = request.getParameterValues("CommodityType");
		submername_arr = request.getParameterValues("SubMerName");
		submerid_arr = request.getParameterValues("SubMerId");
		submermcc_arr = request.getParameterValues("SubMerMCC");
		submerchantremarks_arr = request.getParameterValues("SubMerchantRemarks");
		productid_arr = request.getParameterValues("ProductID");
		productname_arr = request.getParameterValues("ProductName");
		unitprice_arr = request.getParameterValues("UnitPrice");
		qty_arr = request.getParameterValues("Qty");
		productremarks_arr = request.getParameterValues("ProductRemarks");
		producttype_arr = request.getParameterValues("ProductType");
		productdiscount_arr = request.getParameterValues("ProductDiscount");
		productexpireddate_arr = request.getParameterValues("ProductExpiredDate");
		buyip_arr = request.getParameterValues("BuyIP");
		remark_arr = request.getParameterValues("Remark");	
		IsBreakAccount_arr = request.getParameterValues("IsBreakAccount");	
		SplitAccTemplate_arr = request.getParameterValues("SplitAccTemplate");		
		
	}
	//2、生成委托扣款批量请求对象
	AgentBatchPaymentRequest tRequest = new AgentBatchPaymentRequest();
	
	 tRequest.agentBatch.put("BatchNo", batchNo);
	 tRequest.agentBatch.put("BatchDate", request.getParameter("BatchDate"));
	 tRequest.agentBatch.put("BatchTime", request.getParameter("BatchTime"));
	 tRequest.agentBatch.put("AgentCount", agentCount);
	 tRequest.agentBatch.put("AgentAmount", agentAmount);

	 tRequest.dicRequest.put("ReceiveAccount", request.getParameter("ReceiveAccount"));
	 tRequest.dicRequest.put("ReceiveAccName", request.getParameter("ReceiveAccName"));
	 tRequest.dicRequest.put("CurrencyCode", request.getParameter("CurrencyCode"));
	 //tRequest.dicRequest.put("IsBreakAccount", request.getParameter("IsBreakAccount"));
	 //tRequest.dicRequest.put("SplitAccTemplate", request.getParameter("SplitAccTemplate"));
	 
	 LinkedHashMap item = null;
	 BigDecimal sum = BigDecimal.ZERO;    
	 for (int i = 0; i < orderno_arr.length; i++)
	 {
	     item = new LinkedHashMap();
	     item.put("SeqNo", seqno_arr[i]);
	     item.put("OrderNo", orderno_arr[i]);
	     item.put("AgentSignNo", agentsignno_arr[i]);
	     item.put("CardNo", cardno_arr[i]);
	     item.put("OrderAmount", orderamount_arr[i]);
	     item.put("ReceiverAddress", receiveraddress_arr[i]);
	     item.put("Fee", fee_arr[i]);
	     item.put("CertificateNo", certificateno_arr[i]);
	     item.put("InstallmentMark", installmentmark_arr[i]);
	     if (installmentmark_arr[i].toString().equals("1"))
	     {
		 	 item.put("InstallmentCode", installmentcode_arr[i]);
		 	 item.put("InstallmentNum", installmentnum_arr[i]);
	     }
	     item.put("CommodityType", commoditytype_arr[i]);
	     item.put("SubMerName", submername_arr[i]);
	     item.put("SubMerId", submerid_arr[i]);
	     item.put("SubMerMCC", submermcc_arr[i]);
	     item.put("SubMerchantRemarks", submerchantremarks_arr[i]);
	     item.put("ProductID", productid_arr[i]);
	     item.put("ProductName", productname_arr[i]);
	     item.put("UnitPrice", unitprice_arr[i]);
	     item.put("Qty", qty_arr[i]);
	     item.put("ProductRemarks", productremarks_arr[i]);
	     item.put("ProductType", producttype_arr[i]);
	     item.put("ProductDiscount", productdiscount_arr[i]);
	     item.put("ProductExpiredDate", productexpireddate_arr[i]);
	     item.put("BuyIP", buyip_arr[i]);
	     item.put("Remark", remark_arr[i]);
	     item.put("IsBreakAccount", IsBreakAccount_arr[i]);
	     item.put("SplitAccTemplate", SplitAccTemplate_arr[i]);
	     tRequest.items.put(i, item);

         BigDecimal bd = new BigDecimal(orderamount_arr[i].toString());
		 sum = sum.add(bd);  
	 }
	 //此处必须设定iSumAmount属性
     tRequest.iSumAmount = sum.doubleValue();

	 //3、传送批量授权扣款请求
	 JSON json = tRequest.postRequest();
	 String ReturnCode = json.GetKeyValue("ReturnCode");
	 String ErrorMessage = json.GetKeyValue("ErrorMessage");
	 if (ReturnCode.equals("0000"))
	 {
	     //4、批量授权扣款请求提交成功
	     out.println("批量受理成功!");
         out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
         out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
         out.println("TrxType   = [" + json.GetKeyValue("TrxType") + "]<br/>");
         out.println("MerchantNo = [" + json.GetKeyValue("MerchantNo") + "]<br/>");
         out.println("SendTime   = [" + json.GetKeyValue("SendTime") + "]<br/>");
	 }
	 else
	 {
	     //5、批量授权扣款请求提交失败，商户自定后续动作
	     out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
	     out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
	 }

%>
<CENTER><a href='Merchant.html'>回商户首页</a></CENTER>
</BODY>
</HTML>