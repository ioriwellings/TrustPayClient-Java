<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%response.setHeader("Cache-Control", "no-cache"); 
request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-授权支付签约（商户端）</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>授权支付签约（商户端）<br>
<%
        //1、生成授权支付签约请求对象
        QuickAgentSignContractRequest tRequest = new QuickAgentSignContractRequest();
        tRequest.dicRequest.put("OrderDate", request.getParameter("txtRequestDate"));            //请求日期 （必要信息 - YYYY/MM/DD）
        tRequest.dicRequest.put("OrderTime", request.getParameter("txtRequestTime"));            //请求时间 （必要信息 - HH:MM:SS）
        tRequest.dicRequest.put("OrderNo", request.getParameter("txtOrderNo"));                  //订单编号（必要信息）
        tRequest.dicRequest.put("PaymentLinkType", request.getParameter("txtPaymentLinkType"));  //接入渠道 （必要信息）
        tRequest.dicRequest.put("MerCustomNo", request.getParameter("txtMerCustomNo"));          //客户编号
        tRequest.dicRequest.put("AgentSignNo", request.getParameter("txtAgentSignNo"));          //签约编号
        tRequest.dicRequest.put("CardNo", request.getParameter("txtCardNo"));                    //签约账号  （必要信息）
        tRequest.dicRequest.put("CardType", request.getParameter("txtCardType"));                //农行卡类型（必要信息）
        tRequest.dicRequest.put("MobileNo", request.getParameter("txtMobileNo"));                //签约手机号（必要信息）
        tRequest.dicRequest.put("InvaidDate", request.getParameter("txtInvaidDate"));            //签约有效期（必要信息）
        tRequest.dicRequest.put("IsSign", request.getParameter("txtIsSign"));                    //签约/解约标识 （必要信息）
		tRequest.dicRequest.put("CertificateType", request.getParameter("txtCertificateType"));  //证件类型（必要信息）
		tRequest.dicRequest.put("CertificateNo", request.getParameter("txtCertificateNo")); 	 //证件号码（必要信息）
		tRequest.dicRequest.put("AccName", request.getParameter("txtAccName"));                  //客户姓名（必要信息）
		tRequest.dicRequest.put("CVV2", request.getParameter("txtCVV2"));                        //贷记卡CVV2码（农行卡类型为贷记卡时必输）
		tRequest.dicRequest.put("CardDueDate", request.getParameter("txtCardDueDate"));          //贷记卡到期日（农行卡类型为贷记卡时必输）

        //2、传送授权支付签约请求
        JSON json = tRequest.postRequest();
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //3、授权支付签约请求提交成功，获取返回信息
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
            out.println("TrxType   = [" + json.GetKeyValue("TrxType") + "]<br/>");
            out.println("OrderNo = [" + json.GetKeyValue("OrderNo") + "]<br/>");
        }
        else
        {
            //4、授权支付签约请求提交失败，商户自定后续动作
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
}
%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>