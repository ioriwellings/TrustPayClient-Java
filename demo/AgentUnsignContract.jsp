<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-��Ȩ֧����Լ����</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>��Ȩ֧����Լ����<br>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Cache-Control", "no-cache");
%>
<%

 //1��������Ȩ֧����Լ�������
        AgentUnSignRequest tRequest = new AgentUnSignRequest();
        tRequest.dicRequest.put("OrderNo", request.getParameter("OrderNo"));                         //������ţ���Ҫ��Ϣ��
        tRequest.dicRequest.put("AgentSignNo", request.getParameter("AgentSignNo"));                 //ǩԼ��ţ���Ҫ��Ϣ��
        tRequest.dicRequest.put("RequestDate", request.getParameter("RequestDate"));                 //�������� ����Ҫ��Ϣ - YYYY/MM/DD��
        tRequest.dicRequest.put("RequestTime", request.getParameter("RequestTime"));                 //����ʱ�� ����Ҫ��Ϣ - HH:MM:SS��

//3��������Ȩ֧����Լ����ȡ��ǩԼ��ַ
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
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>