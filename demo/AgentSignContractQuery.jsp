<%
/*
 * @(#)AgentSignContractQuery.jsp	V3.0.0	2014/09/18
 *
 *
 * Description:
 *    ǩԼ/��Լ�����ѯ��������
 *
 * Modify Information:
 *    Author        Date        Description
 *    ============  ==========  =======================================
 *    abc           2014/09/18  create
 */
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-ί�пۿ�ǩԼ�����ѯ</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>ί�пۿ�ǩԼ�����ѯ<br>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Cache-Control", "no-cache");
%>
<%
//1��ȡ���̻�ί�пۿ�ǩԼ��ѯ����Ҫ����Ϣ
String tAgentSignNo   = request.getParameter("AgentSignNo"  );

//2�������̻�ί�пۿ�ǩԼ��ѯ�������
QueryAgentSignRequest tRequest = new QueryAgentSignRequest();
tRequest.dicRequest.put("OrderNo", request.getParameter("OrderNo"));  //ǩԼ���           ����Ҫ��Ϣ��

//3�������̻�ί�пۿ�ǩԼ��ѯ����ȡ�ö�����ѯ���
JSON json = tRequest.postRequest();
String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");
if (ReturnCode.equals("0000"))
{
	//4����ȡ�����Ϣ
    out.println("ReturnCode      = [" + ReturnCode + "]<br/>");
    out.println("ErrorMessage      = [" + ErrorMessage + "]<br/>");
    out.println("TrxType      = [" + json.GetKeyValue("TrxType") + "]<br/>");
    out.println("MerchantNo      = [" + json.GetKeyValue("MerchantNo") + "]<br/>");
    out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
    out.println("AgentSignNo      = [" + json.GetKeyValue("AgentSignNo") + "]<br/>");
    out.println("CertificateNo      = [" + json.GetKeyValue("CertificateNo") + "]<br/>");
    out.println("CertificateType      = [" + json.GetKeyValue("CertificateType") + "]<br/>");
    out.println("Last4CardNo      = [" + json.GetKeyValue("Last4CardNo") + "]<br/>");
    out.println("SignDate      = [" + json.GetKeyValue("SignDate") + "]<br/>");
    out.println("UnSignDate      = [" + json.GetKeyValue("UnSignDate") + "]<br/>");
    out.println("AgentSignStatus      = [" + json.GetKeyValue("AgentSignStatus") + "]<br/>");
    out.println("AccountType      = [" + json.GetKeyValue("AccountType") + "]<br/>");
    out.println("PaymentLinkType      = [" + json.GetKeyValue("PaymentLinkType") + "]<br/>");
    out.println("InvaidDate      = [" + json.GetKeyValue("InvaidDate") + "]<br/>");    
}
else
{
	out.println("ReturnCode   = [" + ReturnCode + "]<br>");
	out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
}
%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>