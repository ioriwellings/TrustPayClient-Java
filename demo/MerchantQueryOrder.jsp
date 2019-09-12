<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<%
//1、生成交易查询对象
String payTypeID = request.getParameter("PayTypeID");
String queryTpye = request.getParameter("QueryType");
if(queryTpye.equals("0")){
	queryTpye = "false";
}else if (queryTpye.equals("1")){
	queryTpye="true";
}

QueryOrderRequest tQueryRequest = new QueryOrderRequest();
tQueryRequest.queryRequest.put("PayTypeID", payTypeID);    //设定交易类型
tQueryRequest.queryRequest.put("OrderNo", request.getParameter("OrderNo"));    //设定订单编号 （必要信息）
tQueryRequest.queryRequest.put("QueryDetail", queryTpye);//设定查询方式
//如果需要专线地址，调用此方法：
//tQueryRequest.setConnectionFlag(true);
JSON json = tQueryRequest.postRequest();
//JSON json = tQueryRequest.extendPostRequest(1);

String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");

if (ReturnCode.equals("0000"))
{
    out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
    out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
    //4、获取结果信息
    String orderInfo = json.GetKeyValue("Order");
    if (orderInfo.length() < 1)
    {
        out.println("查询结果为空<br/>");
    }
    else
    {
        //1、还原经过base64编码的信息 
    	Base64 tBase64 = new Base64();
  		String orderDetail = new String(tBase64.decode(orderInfo));
        json.setJsonString(orderDetail);
        out.println("订单明细" + orderDetail + "<br/>");
        
        if(queryTpye.equals("0")) {
            out.println("PayTypeID      = [" + json.GetKeyValue("PayTypeID") + "]<br/>");
            out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
            out.println("OrderDate      = [" + json.GetKeyValue("OrderDate") + "]<br/>");
            out.println("OrderTime      = [" + json.GetKeyValue("OrderTime") + "]<br/>");
            out.println("OrderAmount      = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
            out.println("Status      = [" + json.GetKeyValue("Status") + "]<br/>");
        }
        else
        {
            LinkedHashMap hashMap = new LinkedHashMap();
            if (payTypeID.equals("ImmediatePay") || payTypeID.equals("PreAuthPay"))
            {
                out.println("PayTypeID      = [" + json.GetKeyValue("PayTypeID") + "]<br/>");
                out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
                out.println("OrderDate      = [" + json.GetKeyValue("OrderDate") + "]<br/>");
                out.println("OrderTime      = [" + json.GetKeyValue("OrderTime") + "]<br/>");
                out.println("OrderAmount      = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
                out.println("Status      = [" + json.GetKeyValue("Status") + "]<br/>");
                out.println("OrderDesc      = [" + json.GetKeyValue("OrderDesc") + "]<br/>");
                out.println("OrderURL      = [" + json.GetKeyValue("OrderURL") + "]<br/>");
                out.println("PaymentLinkType      = [" + json.GetKeyValue("PaymentLinkType") + "]<br/>");
                out.println("AcctNo      = [" + json.GetKeyValue("AcctNo") + "]<br/>");
                out.println("CommodityType      = [" + json.GetKeyValue("CommodityType") + "]<br/>");
                out.println("ReceiverAddress      = [" + json.GetKeyValue("ReceiverAddress") + "]<br/>");
                out.println("BuyIP      = [" + json.GetKeyValue("BuyIP") + "]<br/>");
                out.println("iRspRef      = [" + json.GetKeyValue("iRspRef") + "]<br/>");
                //out.println("HostTime      = [" + json.GetKeyValue("HostTime") + "]<br/>");
                //out.println("HostDate      = [" + json.GetKeyValue("HostDate") + "]<br/>");
                out.println("ReceiveAccount      = [" + json.GetKeyValue("ReceiveAccount") + "]<br/>");
                out.println("ReceiveAccName      = [" + json.GetKeyValue("ReceiveAccName") + "]<br/>");
                out.println("MerchantRemarks      = [" + json.GetKeyValue("MerchantRemarks") + "]<br/>");
                
                //5、商品明细
                hashMap = json.GetArrayValue("OrderItems");
                if(hashMap.size() == 0){
                	out.println("商品明细为空");
                }
                else
                {               
                    out.println("商品明细为:<br/>");
                    Iterator iter = hashMap.entrySet().iterator();
                    while (iter.hasNext()) {
                    	Map.Entry entry = (Map.Entry) iter.next();
                    	//Object key = entry.getKey();
                    	Hashtable val = (Hashtable)entry.getValue();                  	
                    	
                    	 out.println("SubMerName      = [" + (String)val.get("SubMerName") + "],");
	                     out.println("SubMerId      = [" + (String)val.get("SubMerId") + "],");
	                     out.println("SubMerMCC      = [" + (String)val.get("SubMerMCC") + "],");
	                     out.println("SubMerchantRemarks      = [" + (String)val.get("SubMerchantRemarks") + "],");
	                     out.println("ProductID      = [" + (String)val.get("ProductID") + "],");
	                     out.println("ProductName      = [" + (String)val.get("ProductName") + "],");
	                     out.println("UnitPrice      = [" + (String)val.get("UnitPrice") + "],");
	                     out.println("Qty      = [" + (String)val.get("Qty") + "],");
	                     out.println("ProductRemarks      = [" + (String)val.get("ProductRemarks") + "],");
	                }    
                }
            }            
            else if (payTypeID.equals("DividedPay"))
            {
                out.println("PayTypeID      = [" + json.GetKeyValue("PayTypeID") + "]<br/>");
                out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
                out.println("OrderDate      = [" + json.GetKeyValue("OrderDate") + "]<br/>");
                out.println("OrderTime      = [" + json.GetKeyValue("OrderTime") + "]<br/>");
                out.println("OrderAmount      = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
                out.println("Status      = [" + json.GetKeyValue("Status") + "]<br/>");
                out.println("InstallmentCode      = [" + json.GetKeyValue("InstallmentCode") + "]<br/>");
                out.println("InstallmentNum      = [" + json.GetKeyValue("InstallmentNum") + "]<br/>");
                out.println("PaymentLinkType      = [" + json.GetKeyValue("PaymentLinkType") + "]<br/>");
                out.println("AcctNo      = [" + json.GetKeyValue("AcctNo") + "]<br/>");
                out.println("CommodityType      = [" + json.GetKeyValue("CommodityType") + "]<br/>");
                out.println("ReceiverAddress      = [" + json.GetKeyValue("ReceiverAddress") + "]<br/>");
                out.println("BuyIP      = [" + json.GetKeyValue("BuyIP") + "]<br/>");
                out.println("iRspRef      = [" + json.GetKeyValue("iRspRef") + "]<br/>");
                //out.println("HostTime      = [" + json.GetKeyValue("HostTime") + "]<br/>");
                //out.println("HostDate      = [" + json.GetKeyValue("HostDate") + "]<br/>");
                out.println("ReceiveAccount      = [" + json.GetKeyValue("ReceiveAccount") + "]<br/>");
                out.println("ReceiveAccName      = [" + json.GetKeyValue("ReceiveAccName") + "]<br/>");
                out.println("MerchantRemarks      = [" + json.GetKeyValue("MerchantRemarks") + "]<br/>");

                hashMap = json.GetArrayValue("OrderItems");
                if(hashMap.size() == 0){
                	out.println("商品明细为空");
                }
                else
                {
                    out.println("商品明细为:<br/>");
                    Iterator iter = hashMap.entrySet().iterator();
                    while (iter.hasNext()) {
                    	Map.Entry entry = (Map.Entry) iter.next();
                    	//Object key = entry.getKey();
                    	Hashtable val = (Hashtable)entry.getValue();                       	
                    	out.println("SubMerName      = [" + (String)val.get("SubMerName") + "],");
	                    out.println("SubMerId      = [" + (String)val.get("SubMerId") + "],");
	                    out.println("SubMerMCC      = [" + (String)val.get("SubMerMCC") + "],");
	                    out.println("SubMerchantRemarks      = [" + (String)val.get("SubMerchantRemarks") + "],");
	                    out.println("ProductID      = [" + (String)val.get("ProductID") + "],");
	                    out.println("ProductName      = [" + (String)val.get("ProductName") + "],");
	                    out.println("UnitPrice      = [" + (String)val.get("UnitPrice") + "],");
	                    out.println("Qty      = [" + (String)val.get("Qty") + "],");
	                    out.println("ProductRemarks      = [" + (String)val.get("ProductRemarks") + "],");
                    }
                }
				hashMap.clear();
                hashMap = json.GetArrayValue("Distribution");
                if (hashMap.size() == 0) {
                    out.println("分账账户信息为空");
                }
                else
                {
                    out.println("分账账户信息明细为:<br/>");
                    Iterator iter = hashMap.entrySet().iterator();
                    while (iter.hasNext()) {
                    	Map.Entry entry = (Map.Entry) iter.next();
                    	//Object key = entry.getKey();
                    	Hashtable val = (Hashtable)entry.getValue();   
                    	out.println("DisAccountNo      = [" + (String)val.get("DisAccountNo") + "],");
                        out.println("DisAccountName      = [" + (String)val.get("DisAccountName") + "],");
                        out.println("DisAmount      = [" + (String)val.get("DisAmount") + "],");
                    }
                }
            }            
            else if (payTypeID.equals("Refund"))
            {
                out.println("PayTypeID      = [" + json.GetKeyValue("PayTypeID") + "]<br/>");
                out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
                out.println("OrderDate      = [" + json.GetKeyValue("OrderDate") + "]<br/>");
                out.println("OrderTime      = [" + json.GetKeyValue("OrderTime") + "]<br/>");
                out.println("RefundAmount      = [" + json.GetKeyValue("RefundAmount") + "]<br/>");
                out.println("Status      = [" + json.GetKeyValue("Status") + "]<br/>");
                out.println("iRspRef      = [" + json.GetKeyValue("iRspRef") + "]<br/>");
                //out.println("HostTime      = [" + json.GetKeyValue("HostTime") + "]<br/>");
                //out.println("HostDate      = [" + json.GetKeyValue("HostDate") + "]<br/>");
                out.println("MerRefundAccountNo      = [" + json.GetKeyValue(" MerRefundAccountNo") + "]<br/>");
                out.println("MerRefundAccountName      = [" + json.GetKeyValue(" MerRefundAccountName") + "]<br/>");
            }           
            else if (payTypeID.equals("AgentPay"))
            {
                out.println("PayTypeID      = [" + json.GetKeyValue("PayTypeID") + "]<br/>");
                out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
                out.println("OrderDate      = [" + json.GetKeyValue("OrderDate") + "]<br/>");
                out.println("OrderTime      = [" + json.GetKeyValue("OrderTime") + "]<br/>");
                out.println("OrderAmount      = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
                out.println("Status      = [" + json.GetKeyValue("Status") + "]<br/>");
                out.println("InstallmentCode      = [" + json.GetKeyValue("InstallmentCode") + "]<br/>");
                out.println("InstallmentNum      = [" + json.GetKeyValue("InstallmentNum") + "]<br/>");
                out.println("PaymentLinkType      = [" + json.GetKeyValue("PaymentLinkType") + "]<br/>");
                out.println("AcctNo      = [" + json.GetKeyValue("AcctNo") + "]<br/>");
                out.println("CommodityType      = [" + json.GetKeyValue("CommodityType") + "]<br/>");
                out.println("ReceiverAddress      = [" + json.GetKeyValue("ReceiverAddress") + "]<br/>");
                out.println("BuyIP      = [" + json.GetKeyValue("BuyIP") + "]<br/>");
                out.println("iRspRef      = [" + json.GetKeyValue("iRspRef") + "]<br/>");
                //out.println("HostTime      = [" + json.GetKeyValue("HostTime") + "]<br/>");
                //out.println("HostDate      = [" + json.GetKeyValue("HostDate") + "]<br/>");
                out.println("ReceiveAccount      = [" + json.GetKeyValue("ReceiveAccount") + "]<br/>");
                out.println("ReceiveAccName      = [" + json.GetKeyValue("ReceiveAccName") + "]<br/>");
                out.println("MerchantRemarks      = [" + json.GetKeyValue("MerchantRemarks") + "]<br/>");
                
                hashMap = json.GetArrayValue("OrderItem");
                if(hashMap.size() == 0){
                	out.println("商品明细为空");
                }
                else
                {
                    out.println("商品明细为:<br/>");
                    Iterator iter = hashMap.entrySet().iterator();
                    while (iter.hasNext()) {
                    	Map.Entry entry = (Map.Entry) iter.next();
                    	//Object key = entry.getKey();
                    	Hashtable val = (Hashtable)entry.getValue();  
                    	out.println("SubMerName      = [" + (String)val.get("SubMerName") + "],");
	                    out.println("SubMerId      = [" + (String)val.get("SubMerId") + "],");
	                    out.println("SubMerMCC      = [" + (String)val.get("SubMerMCC") + "],");
	                    out.println("SubMerchantRemarks      = [" + (String)val.get("SubMerchantRemarks") + "],");
	                    out.println("ProductID      = [" + (String)val.get("ProductID") + "],");
	                    out.println("ProductName      = [" + (String)val.get("ProductName") + "],");
	                    out.println("UnitPrice      = [" + (String)val.get("UnitPrice") + "],");
	                    out.println("Qty      = [" + (String)val.get("Qty") + "],");
	                    out.println("ProductRemarks      = [" + (String)val.get("ProductRemarks") + "],");
                    }
                }
                //4、获取分账账户信息
                hashMap.clear();
                hashMap = json.GetArrayValue("Distribution");
                if (hashMap.size() == 0) {
                    out.println("分账账户信息为空");
                }
                else
                {
                    out.println("分账账户信息明细为:<br/>");
                    Iterator iter = hashMap.entrySet().iterator();
                    while (iter.hasNext()) {
                    	Map.Entry entry = (Map.Entry) iter.next();
                    	//Object key = entry.getKey();
                    	Hashtable val = (Hashtable)entry.getValue();   
                    	out.println("DisAccountNo      = [" + (String)val.get("DisAccountNo") + "],");
                        out.println("DisAccountName      = [" + (String)val.get("DisAccountName") + "],");
                        out.println("DisAmount      = [" + (String)val.get("DisAmount") + "],");
                    }
                }                         
            }           
            else if (payTypeID.equals("PreAuthed") || payTypeID.equals("PreAuthCancel"))
            {
                out.println("PayTypeID      = [" + json.GetKeyValue("PayTypeID") + "]<br/>");
                out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
                out.println("OrderDate      = [" + json.GetKeyValue("OrderDate") + "]<br/>");
                out.println("OrderTime      = [" + json.GetKeyValue("OrderTime") + "]<br/>");
                out.println("OrderAmount      = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
                out.println("Status      = [" + json.GetKeyValue("Status") + "]<br/>");
                out.println("AcctNo      = [" + json.GetKeyValue("AcctNo") + "]<br/>");
                out.println("iRspRef      = [" + json.GetKeyValue("iRspRef") + "]<br/>");
                //out.println("HostTime      = [" + json.GetKeyValue("HostTime") + "]<br/>");
                //out.println("HostDate      = [" + json.GetKeyValue("HostDate") + "]<br/>");
                out.println("ReceiveAccount      = [" + json.GetKeyValue("ReceiveAccount") + "]<br/>");
                out.println("ReceiveAccName      = [" + json.GetKeyValue("ReceiveAccName") + "]<br/>");
            }
        }
    }
}
else
{
    //6、商户订单查询失败
    out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
    out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
}
%>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-商户订单查询</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>商户订单查询<br>

<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>