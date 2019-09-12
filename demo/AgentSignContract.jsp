<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<% response.setHeader("Cache-Control", "no-cache");
   request.setCharacterEncoding("GBK"); 
%>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-身份验证请求</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>身份验证请求<br>
<%
       //1、生成授权支付签约请求对象
        AgentSignContractRequest tRequest = new AgentSignContractRequest();
        tRequest.agentSignRequest.put("CertificateNo", request.getParameter("txtCertificateNo"));;             //证件号码       （必要信息）
        tRequest.agentSignRequest.put("CertificateType", request.getParameter("ddlCertificateType"));//证件类型       （必要信息）农行卡类型
        tRequest.agentSignRequest.put("NotifyType", request.getParameter("txtNotifyType"));                 //通知类型 （必要信息）
        tRequest.agentSignRequest.put("ResultNotifyURL", request.getParameter("txtResultNotifyURL"));         //通知地址（必要信息）
        tRequest.agentSignRequest.put("OrderNo", request.getParameter("txtOrderNo"));                         //订单编号（必要信息）
        tRequest.agentSignRequest.put("PaymentLinkType", request.getParameter("txtPaymentLinkType"));                 //接入渠道 （必要信息）
        tRequest.agentSignRequest.put("MerCustomNo", request.getParameter("txtMerCustomNo"));                 //客户编号        
        tRequest.agentSignRequest.put("CardType", request.getParameter("txtCardType"));                         //农行卡类型 （必要信息）
        tRequest.agentSignRequest.put("RequestDate", request.getParameter("txtRequestDate"));                 //验证请求日期 （必要信息 - YYYY/MM/DD）
        tRequest.agentSignRequest.put("RequestTime", request.getParameter("txtRequestTime"));                 //验证请求时间 （必要信息 - HH:MM:SS）
        tRequest.agentSignRequest.put("InvaidDate", request.getParameter("txtInvaidDate"));                 //签约有效期 （必要信息）
        tRequest.agentSignRequest.put("IsSign", request.getParameter("txtIsSign"));                 //签约标识 （必要信息）

        //2、传送授权支付签约请求并取得签约网址
        JSON json = tRequest.postRequest();
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            out.println("ReturnCode      = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage      = [" + ErrorMessage + "]<br/>");
            out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
            out.println("TrxType      = [" + json.GetKeyValue("TrxType") + "]<br/>");
            
            //3、授权支付签约请求提交成功，将客户端导向签约页面
            response.sendRedirect(json.GetKeyValue("B2CAgentSignContractURL"));
        }
        else
        {
            //4、授权支付签约请求提交失败，商户自定后续动作
            out.println("ReturnCode      = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage      = [" + ErrorMessage + "]<br/>");
}
%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>