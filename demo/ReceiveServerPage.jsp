<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<%
//0���趨�̻������ʾҳ��
String tMerchantPage = "";

//1��ȡ��MSG�����������ô˲���ֵ����֧���������
String msg = request.getParameter("MSG");
PaymentResult tResult = new PaymentResult(msg);

//2���ж�֧���������״̬�����к�������
if (tResult.isSuccess()) {
  //3��֧���ɹ�������ǩ�������ɹ�
  tMerchantPage = "http://10.233.4.11:8080/ebusclient/ResultSuccess.jsp";
}
else {
  //4��֧���ɹ�����������ǩ���߽������ĵȲ���ʧ��
  tMerchantPage = "http://10.233.4.11:8080/ebusclient/ResultFail.jsp";
}
%>

<URL><%= tMerchantPage %></URL>

<HTML>
<HEAD>
<meta http-equiv="refresh" content="0; url='<%= tMerchantPage %>'">
</HEAD>
</HTML>