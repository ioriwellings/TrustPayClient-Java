<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-�����֤�������</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>�����֤���<br>
<%
//1��ȡ��MSG�����������ô˲���ֵ������֤�������
PaymentResult tResult = new PaymentResult(request.getParameter("MSG"));
//System.out.println(request.getParameter("MSG"));
//2���ж���֤���״̬�����к�������
if (tResult.isSuccess()) {
  //3����֤�ɹ�
  out.println("����         = [" + tResult.getValue("AccountName"        ) + "]<br>");

}
else {
  //4����֤ʧ��
  out.println("ReturnCode   = [" + tResult.getReturnCode  () + "]<br>");
  out.println("ErrorMessage = [" + tResult.getErrorMessage() + "]<br>");
}
%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>