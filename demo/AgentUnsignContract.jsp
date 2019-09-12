<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-授权支付解约请求</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>授权支付解约请求<br>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Cache-Control", "no-cache");
%>
<%

 //1、生成授权支付解约请求对象
        AgentUnSignRequest tRequest = new AgentUnSignRequest();
        tRequest.dicRequest.put("OrderNo", request.getParameter("OrderNo"));                         //订单编号（必要信息）
        tRequest.dicRequest.put("AgentSignNo", request.getParameter("AgentSignNo"));                 //签约编号（必要信息）
        tRequest.dicRequest.put("RequestDate", request.getParameter("RequestDate"));                 //请求日期 （必要信息 - YYYY/MM/DD）
        tRequest.dicRequest.put("RequestTime", request.getParameter("RequestTime"));                 //请求时间 （必要信息 - HH:MM:SS）

//3、传送授权支付解约请求并取得签约网址
JSON json = tRequest.postRequest();
String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");
if (ReturnCode.equals("0000"))
{
	out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
	out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
	out.println("TrxType = [" + json.GetKeyValue("TrxType") + "]<br/>");
	out.println("OrderNo = [" + json.GetKeyValue("OrderNo") + "]<br/>");
}
else
{
	out.println("ReturnCode   = [" + ReturnCode + "]<br>");
	out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
}
%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>