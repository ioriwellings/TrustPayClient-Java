<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.text.NumberFormat"%>
 
<% response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-���׶��˵�����</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>���׶��˵�����<br>
<%
//request.setCharacterEncoding("GBK");

NumberFormat tFormat = NumberFormat.getInstance();
tFormat.setMaximumFractionDigits(2);
tFormat.setGroupingUsed(false);
tFormat.setMinimumFractionDigits(2);

//1��ȡ���̻����˵���������Ҫ����Ϣ
String tSettleDate = request.getParameter("SettleDate");
String tZIP = request.getParameter("ZIP");
    
//2�������̻����˵������������
SettleRequestTransfer tRequest = new SettleRequestTransfer();
tRequest.dicRequest.put("SettleDate",tSettleDate);  //��������YYYY/MM/DD ����Ҫ��Ϣ��
tRequest.dicRequest.put("ZIP",tZIP);

//3�������̻����˵���������ȡ�ö��˵�
JSON json = tRequest.postRequest();

//4���ж��̻����˵����ؽ��״̬�����к�������
String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");

if (ReturnCode.equals("0000"))
{
    //5���̻����˵����سɹ������ɶ��˵�����
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
    //6���̻��˵�����ʧ��
	out.println("ReturnCode   = [" + ReturnCode + "]<br>");
	out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
}
%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>