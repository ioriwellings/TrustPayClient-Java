<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Cache-Control", "no-cache");
%>
<%
//1������֧���������
InnerPaymentRequest tPaymentRequest = new InnerPaymentRequest();

tPaymentRequest.dicRequest.put("InternalTransferNo", request.getParameter("InternalTransferNo"));        //ת�˽��ױ��
tPaymentRequest.dicRequest.put("RemitterSubMerchantNo", request.getParameter("RemitterSubMerchantNo"));  //ת�������̻����
tPaymentRequest.dicRequest.put("RemitteeSubMerchantNo", request.getParameter("RemitteeSubMerchantNo"));  //ת�뷽���̻����
tPaymentRequest.dicRequest.put("Amount", request.getParameter("TrxAmount"));      //ת�˽��

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

%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-֧������</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>֧������<br>
<%
out.println("ReturnCode   = [" + ReturnCode + "]<br>");
out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
}
%>

<a href='MerchantUnified.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>