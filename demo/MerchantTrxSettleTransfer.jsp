<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.text.NumberFormat"%>
 
<% response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-交易对账单下载</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>交易对账单下载<br>
<%
//request.setCharacterEncoding("GBK");

NumberFormat tFormat = NumberFormat.getInstance();
tFormat.setMaximumFractionDigits(2);
tFormat.setGroupingUsed(false);
tFormat.setMinimumFractionDigits(2);

//1、取得商户对账单下载所需要的信息
String tSettleDate = request.getParameter("SettleDate");
String tZIP = request.getParameter("ZIP");
    
//2、生成商户对账单下载请求对象
SettleRequestTransfer tRequest = new SettleRequestTransfer();
tRequest.dicRequest.put("SettleDate",tSettleDate);  //对账日期YYYY/MM/DD （必要信息）
tRequest.dicRequest.put("ZIP",tZIP);

//3、传送商户对账单下载请求并取得对账单
JSON json = tRequest.postRequest();

//4、判断商户对账单下载结果状态，进行后续操作
String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");

if (ReturnCode.equals("0000"))
{
    //5、商户对账单下载成功，生成对账单对象
    out.println("ReturnCode      = [" + json.GetKeyValue("ReturnCode") + "]<br/>");
    out.println("ErrorMessage      = [" + json.GetKeyValue("ErrorMessage") + "]<br/>");
    out.println("TrxType      = [" + json.GetKeyValue("TrxType") + "]<br/>");
    out.println("SettleDate      = [" + json.GetKeyValue("SettleDate") + "]<br/>");
 
 	if(tZIP.equals("0")){
 		out.println("DetailRecords      = [" + json.GetKeyValue("DetailRecords") + "]<br/>");
 	}
    if(tZIP.equals("1")) {
    	out.println("ZIPDetailRecords      = [" + ZipUtil.gunzip(json.GetKeyValue("ZIPDetailRecords")) + "]<br/>");
    }
    
}
else {
    //6、商户账单下载失败
	out.println("ReturnCode   = [" + ReturnCode + "]<br>");
	out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
}
%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>