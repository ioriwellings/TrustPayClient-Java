<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Cache-Control", "no-cache");
%>
<%
//1、生成支付请求对象
InnerPaymentRequest tPaymentRequest = new InnerPaymentRequest();

tPaymentRequest.dicRequest.put("InternalTransferNo", request.getParameter("InternalTransferNo"));        //转账交易编号
tPaymentRequest.dicRequest.put("RemitterSubMerchantNo", request.getParameter("RemitterSubMerchantNo"));  //转出方子商户编号
tPaymentRequest.dicRequest.put("RemitteeSubMerchantNo", request.getParameter("RemitteeSubMerchantNo"));  //转入方子商户编号
tPaymentRequest.dicRequest.put("Amount", request.getParameter("TrxAmount"));      //转账金额

JSON json = tPaymentRequest.postRequest();
//JSON json = tPaymentRequest.extendPostRequest(1);

String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");
if (ReturnCode.equals("0000"))
{
	out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
	out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
}
else
{

%>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-支付请求</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>支付请求<br>
<%
out.println("ReturnCode   = [" + ReturnCode + "]<br>");
out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
}
%>

<a href='MerchantUnified.html'>回商户首页</a></CENTER>
</BODY></HTML>