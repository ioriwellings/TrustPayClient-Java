<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%response.setHeader("Cache-Control", "no-cache"); 
request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-授权支付短信验证码重发（商户端）</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>授权支付短信验证码重发（商户端）<br>
<%
		//1、生成授权支付签约验证码重发请求对象
        QuickAgentSignResendReq tRequest = new QuickAgentSignResendReq();
        tRequest.dicRequest.put("OrderNo", request.getParameter("txtOrderNo"));                         //订单编号（必要信息）
        tRequest.dicRequest.put("CardNo", request.getParameter("txtCardNo"));                           //签约账号       （必要信息）

        //2、传送授权支付签约验证码重发请求
        JSON json = tRequest.postRequest();
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //3、授权支付签约验证码重发请求提交成功，获取返回信息
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
            out.println("TrxType   = [" + json.GetKeyValue("TrxType") + "]<br/>");
            out.println("OrderNo = [" + json.GetKeyValue("OrderNo") + "]<br/>");
            out.println("CardNo = [" + json.GetKeyValue("CardNo") + "]<br/>");
        }
        else
        {
            //4、授权支付签约请求验证码重发提交失败，商户自定后续动作
			out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
        }
%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>