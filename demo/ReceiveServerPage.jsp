<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<%
//0、设定商户结果显示页面
String tMerchantPage = "";

//1、取得MSG参数，并利用此参数值生成支付结果对象
String msg = request.getParameter("MSG");
PaymentResult tResult = new PaymentResult(msg);

//2、判断支付结果处理状态，进行后续操作
if (tResult.isSuccess()) {
  //3、支付成功并且验签、解析成功
  tMerchantPage = "http://10.233.4.11:8080/ebusclient/ResultSuccess.jsp";
}
else {
  //4、支付成功但是由于验签或者解析报文等操作失败
  tMerchantPage = "http://10.233.4.11:8080/ebusclient/ResultFail.jsp";
}
%>

<URL><%= tMerchantPage %></URL>

<HTML>
<HEAD>
<meta http-equiv="refresh" content="0; url='<%= tMerchantPage %>'">
</HEAD>
</HTML>