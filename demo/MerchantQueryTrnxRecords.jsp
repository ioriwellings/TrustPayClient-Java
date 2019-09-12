<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-交易流水查询</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>交易流水查询<br>
<%
//1、取得交易流水查询所需要的信息
String tSettleDate = request.getParameter("SettleDate");
String tSettleStartHour = request.getParameter("SettleStartHour");
String tSettleEndHour = request.getParameter("SettleEndHour");
String tZIP = request.getParameter("ZIP");
    
//2、生成交易流水查询请求对象
QueryTrnxRecords tRequest = new QueryTrnxRecords();
tRequest.dicRequest.put("SettleDate",tSettleDate);  //查询日期YYYY/MM/DD （必要信息）
tRequest.dicRequest.put("SettleStartHour",tSettleStartHour);  //查询开始时间段（0-23）
tRequest.dicRequest.put("SettleEndHour",tSettleEndHour);  //查询截止时间段（0-23）
tRequest.dicRequest.put("ZIP",tZIP);

//3、传送交易流水查询请求并取得交易流水
JSON json = tRequest.postRequest();

//4、判断交易流水查询结果状态，进行后续操作
String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");
if (ReturnCode.equals("0000"))
{
    //5、交易流水查询成功，生成交易流水对象
    out.println("ReturnCode      = [" + json.GetKeyValue("ReturnCode") + "]<br/>");
    out.println("ErrorMessage      = [" + json.GetKeyValue("ErrorMessage") + "]<br/>");
    out.println("TrxType      = [" + json.GetKeyValue("TrxType") + "]<br/>");
 	if(tZIP.equals("0")){
 		out.println("DetailRecords      = [" + json.GetKeyValue("DetailRecords") + "]<br/>");
 	}
    if(tZIP.equals("1")) {
    	out.println("ZIPDetailRecords      = [" + ZipUtil.gunzip(json.GetKeyValue("ZIPDetailRecords")) + "]<br/>");
    }

}
else {
    //6、交易流水查询失败
	out.println("ReturnCode   = [" + ReturnCode + "]<br>");
	out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
}
%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>