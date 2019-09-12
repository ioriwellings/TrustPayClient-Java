<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-支付结果接收</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>支付结果<br>
<%
//1、取得MSG参数，并利用此参数值生成支付结果对象
String msg = request.getParameter("MSG");
PaymentResult tResult = new PaymentResult(msg);

//2、判断支付结果状态，进行后续操作
if (tResult.isSuccess()) {
  //3、支付成功并且验签、解析成功
  out.println("TrxType         = [" + tResult.getValue("TrxType"        ) + "]<br>");
  out.println("OrderNo         = [" + tResult.getValue("OrderNo"        ) + "]<br>");
  out.println("Amount          = [" + tResult.getValue("Amount"         ) + "]<br>");
  out.println("BatchNo         = [" + tResult.getValue("BatchNo"        ) + "]<br>");
  out.println("VoucherNo       = [" + tResult.getValue("VoucherNo"      ) + "]<br>");
  out.println("HostDate        = [" + tResult.getValue("HostDate"       ) + "]<br>");
  out.println("HostTime        = [" + tResult.getValue("HostTime"       ) + "]<br>");
  out.println("MerchantRemarks = [" + tResult.getValue("MerchantRemarks") + "]<br>");
  out.println("PayType         = [" + tResult.getValue("PayType"        ) + "]<br>");
  out.println("NotifyType      = [" + tResult.getValue("NotifyType"     ) + "]<br>");
  out.println("TrnxNo          = [" + tResult.getValue("iRspRef"        ) + "]<br>");
}
else {
  //4、支付成功但是由于验签或者解析报文等操作失败
  out.println("ReturnCode   = [" + tResult.getReturnCode  () + "]<br>");
  out.println("ErrorMessage = [" + tResult.getErrorMessage() + "]<br>");
}
%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>