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
OutPaymentRequest tPaymentRequest = new OutPaymentRequest();

tPaymentRequest.dicRequest.put("OrderNo", request.getParameter("OrderNo"));          //交易编号
tPaymentRequest.dicRequest.put("SubMerId", request.getParameter("SubMerId"));        //子商户编号
tPaymentRequest.dicRequest.put("Account", request.getParameter("Account"));          //子商户收款账户
tPaymentRequest.dicRequest.put("AccountName", request.getParameter("AccountName"));  //子商户收款账户名称
tPaymentRequest.dicRequest.put("TrxAmount", request.getParameter("TrxAmount"));      //转账金额

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

//tPaymentRequest.extendPostRequest(1);
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