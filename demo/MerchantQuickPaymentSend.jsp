<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%	response.setHeader("Cache-Control", "no-cache"); 
	request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-支付请求</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>支付请求请求<br>
<%
         //1、生成支付请求对象
        QuickPaymentSend tQuickPaymentSend = new QuickPaymentSend();

        tQuickPaymentSend.dicOrder.put("OrderNo", request.getParameter("txtOrderNo"));                       //设定订单编号 （必要信息）
        tQuickPaymentSend.dicOrder.put("CurrencyCode", request.getParameter("txtCurrencyCode"));    //设定交易币种，
        tQuickPaymentSend.dicOrder.put("OrderAmount", request.getParameter("txtOrderAmount")); //设定订单金额 （必要信息）
        tQuickPaymentSend.dicOrder.put("Fee", request.getParameter("txtFee")); //设定手续费金额
        tQuickPaymentSend.dicOrder.put("OrderDate", request.getParameter("txtOrderDate"));                   //设定订单日期 （必要信息 - YYYY/MM/DD）
        tQuickPaymentSend.dicOrder.put("OrderTime", request.getParameter("txtOrderTime"));                   //设定订单时间 （必要信息 - HH:MM:SS）

        tQuickPaymentSend.dicRequest.put("AccName", request.getParameter("txtAccName"));
        tQuickPaymentSend.dicRequest.put("CertificateType", request.getParameter("txtCertificateType"));
        tQuickPaymentSend.dicRequest.put("CertificateID", request.getParameter("txtCertificateID"));
        tQuickPaymentSend.dicRequest.put("ExpDate", request.getParameter("txtExpDate"));
        tQuickPaymentSend.dicRequest.put("CVV2", request.getParameter("txtCVV2"));
        tQuickPaymentSend.dicRequest.put("VerifyCode", request.getParameter("txtVerifyCode"));
        tQuickPaymentSend.dicRequest.put("PaymentType", request.getParameter("txtPaymentType"));          //设定支付类型
        tQuickPaymentSend.dicRequest.put("PayLinkType", request.getParameter("txtPaymentLinkType"));      //设定支付接入方式
        tQuickPaymentSend.dicRequest.put("MerchantRemarks", request.getParameter("txtMerchantRemarks"));  //设定商户备注信息

        //2、传送支付请求并返回结果
        JSON json = tQuickPaymentSend.postRequest();

        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //3、支付请求提交成功，返回结果信息
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
            //strMessage.append("ECMerchantType   = [" + json.GetKeyValue("ECMerchantType") + "]<br/>");
            out.println("MerchantID = [" + json.GetKeyValue("MerchantID") + "]<br/>");
            out.println("TrxType = [" + json.GetKeyValue("TrxType") + "]<br/>");
            out.println("OrderNo = [" + json.GetKeyValue("OrderNo") + "]<br/>");
            out.println("Amount = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
            out.println("HostDate = [" + json.GetKeyValue("HostDate") + "]<br/>");
            out.println("HostTime = [" + json.GetKeyValue("HostTime") + "]<br/>");
        }
        else
        {
            //6、支付请求提交失败，商户自定后续动作
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
		}
%>

<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>