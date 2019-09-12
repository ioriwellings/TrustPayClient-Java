<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-身份验证结果接收</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>身份验证结果<br>
<%
//1、取得MSG参数，并利用此参数值生成验证结果对象
PaymentResult tResult = new PaymentResult(request.getParameter("MSG"));
//System.out.println(request.getParameter("MSG"));
//2、判断验证结果状态，进行后续操作
if (tResult.isSuccess()) {
  //3、验证成功
  out.println("户名         = [" + tResult.getValue("AccountName"        ) + "]<br>");

}
else {
  //4、验证失败
  out.println("ReturnCode   = [" + tResult.getReturnCode  () + "]<br>");
  out.println("ErrorMessage = [" + tResult.getErrorMessage() + "]<br>");
}
%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>