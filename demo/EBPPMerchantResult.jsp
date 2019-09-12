<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>农行网上支付平台-出账单位接口范例-支付结果接收</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>支付结果<br>
<%
String tABC = request.getParameter("ABC");
out.println("tABC         = [" + tABC + "]<br>");

//1、取得MSG参数，并利用此参数值生成支付结果对象
PaymentResult tResult = new PaymentResult(request.getParameter("MSG"));

//2、判断支付结果状态，进行后续操作
if (tResult.isSuccess()) {
  //3、支付成功
  out.println("MerchantID			= [" + tResult.getValue("MerchantID"        ) + "]<br>");//出账单位编号
  out.println("TrxType				= [" + tResult.getValue("TrxType"         ) + "]<br>");//报文交易类型（支付结果）
  out.println("OrderNo				= [" + tResult.getValue("OrderNo"        ) + "]<br>");//交易号(银行系统账单ID号)
  out.println("ProductID 			= [" + tResult.getValue("ProductID"      ) + "]<br>");//出账单位账单号
  out.println("Amount				= [" + tResult.getValue("Amount"       ) + "]<br>");//账单金额
  out.println("BatchNo				= [" + tResult.getValue("BatchNo"       ) + "]<br>");//账单交易批次号
  out.println("HostDate			= [" + tResult.getValue("HostDate") + "]<br>");//主机日期
  out.println("HostTime			= [" + tResult.getValue("HostTime"        ) + "]<br>");//主机时间
  out.println("MerchantRemarks		= [" + tResult.getValue("MerchantRemarks"     ) + "]<br>");//备注
  out.println("PayType				= [" + tResult.getValue("PayType"     ) + "]<br>");//支付方式（PAY01注册客户，PAY02公共客户）
}
else {
  //4、支付失败
  out.println("ReturnCode   = [" + tResult.getReturnCode  () + "]<br>");//出错代码
  out.println("ErrorMessage = [" + tResult.getErrorMessage() + "]<br>");//出错信息
}
%>
<a href='Biller.html'>回首页</a></CENTER>
</BODY></HTML>