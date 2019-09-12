<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%	response.setHeader("Cache-Control", "no-cache"); 
	request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-验证码重发请求</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>验证码重发请求<br>
<%
        //1、生成支付请求对象
        QuickPaymentReSend tQuickPaymentReSend = new QuickPaymentReSend();
        tQuickPaymentReSend.dicOrder.put("OrderNo", request.getParameter("txtOrderNo"));                       //设定订单编号 （必要信息）
        tQuickPaymentReSend.dicOrder.put("CurrencyCode",request.getParameter("txtCurrencyCode"));    //设定交易币种
        tQuickPaymentReSend.dicOrder.put("OrderAmount",request.getParameter("txtOrderAmount")); //设定订单金额 （必要信息）
        tQuickPaymentReSend.dicOrder.put("OrderDate",request.getParameter("txtOrderDate"));    //设定订单日期 （必要信息 - YYYY/MM/DD）
        tQuickPaymentReSend.dicOrder.put("OrderTime",request.getParameter("txtOrderTime"));                   //设定订单时间 （必要信息 - HH:MM:SS）

        //2、传送支付请求
        JSON json = tQuickPaymentReSend.postRequest();

        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //3、支付请求提交成功，商户自定义后继操作
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
            //strMessage.append("ECMerchantType = [ " + json.GetKeyValue("ECMerchantType") + "]<br/>");
            out.println("MerchantID = [" + json.GetKeyValue("MerchantID") + "]<br/>");
            out.println("TrxType = [" + json.GetKeyValue("TrxType") + "]<br/>");
            out.println("OrderNo = [" + json.GetKeyValue("OrderNo") + "]<br/>");
            out.println("Amount = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
            out.println("HostDate = [" + json.GetKeyValue("HostDate") + "]<br/>");
            out.println("HostTime = [" + json.GetKeyValue("HostTime") + "]<br/>");
        }
        else
        {
            //4、支付请求提交失败，商户自定后续动作
             out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
             out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
		}

%>

<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>