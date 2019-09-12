<%
/*
 * @(#)AgentSignContractQuery.jsp	V3.0.0	2014/09/18
 *
 *
 * Description:
 *    签约/解约结果查询范例程序。
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
<HEAD><TITLE>农行网上支付平台-商户接口范例-委托扣款签约结果查询</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>委托扣款签约结果查询<br>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Cache-Control", "no-cache");
%>
<%
//1、取得商户委托扣款签约查询所需要的信息
String tAgentSignNo   = request.getParameter("AgentSignNo"  );

//2、生成商户委托扣款签约查询请求对象
QueryAgentSignRequest tRequest = new QueryAgentSignRequest();
tRequest.dicRequest.put("OrderNo", request.getParameter("OrderNo"));  //签约编号           （必要信息）

//3、传送商户委托扣款签约查询请求并取得订单查询结果
JSON json = tRequest.postRequest();
String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");
if (ReturnCode.equals("0000"))
{
	//4、获取结果信息
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
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>