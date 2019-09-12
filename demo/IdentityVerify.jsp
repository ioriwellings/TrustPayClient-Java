<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%response.setHeader("Cache-Control", "no-cache"); 
request.setCharacterEncoding("GBK");%>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-身份验证请求</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>身份验证请求<br>
<%
        //1、生成身份验证请求对象
        IdentityVerifyRequest tRequest = new IdentityVerifyRequest();
        tRequest.dicRequest.put("CustomType", request.getParameter("txtCustomType")); //客户类型 （必要信息）
        tRequest.dicRequest.put("BankCardNo", request.getParameter("txtBankCardNo")) ;                    //银行帐号       （必要信息）
        tRequest.dicRequest.put("CertificateNo", request.getParameter("txtCertificateNo")) ;              //证件号码       （必要信息）
        tRequest.dicRequest.put("CertificateType", request.getParameter("ddlCertificateType")); //证件类型       （必要信息）
        tRequest.dicRequest.put("ResultNotifyURL", request.getParameter("txtResultNotifyURL"));          //身份验证回传网址（必要信息）
        tRequest.dicRequest.put("OrderDate" , request.getParameter("txtOrderDate"));              //验证请求日期 （必要信息 - YYYY/MM/DD）
        tRequest.dicRequest.put("OrderTime", request.getParameter("txtOrderTime"));              //验证请求时间 （必要信息 - HH:MM:SS）
        tRequest.dicRequest.put("PaymentLinkType" , request.getParameter("txtPaymentLinkType")); //交易渠道 （必要信息 - HH:MM:SS）

        //3、传送身份验证请求并取得支付网址
        //tRequest.postJSONRequest();
        JSON json = tRequest.postRequest();
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {                       
            //4、身份验证请求提交成功，将客户端导向身份验证页面
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
			out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
			out.println("VerifyURL-->"+json.GetKeyValue("VerifyURL"));
			response.sendRedirect(json.GetKeyValue("VerifyURL"));
        }
        else
        {
            //5、身份验证请求提交失败，商户自定后续动作
			out.println("ReturnCode   = [" + ReturnCode + "]<br>");
			out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
		}

%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY>
</HTML>