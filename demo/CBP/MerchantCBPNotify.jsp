<!--
/*
 * @(#)MerchantCBPNotify.jsp	V1.0	2012/06/04
 *
 * Project: BJP03004
 *
 * Description:
 *    商户接口第三方支付结果通知发送交易范例.
 *
 * Modify Information:
 *    Author        Date        Description
 *    ============  ==========  =======================================
 *    ABC    		2012/06/04  V1.0 Release
 *
 * Copyright Notice:
 *   Copyright (c) 2001-2004 Beijing HiTRUST Technology Co., Ltd.
 *   1808 Room, Science & Technology Building, No. 9 South Street,
 *   Zhong Guan Cun, Haidian District, Beijing ,100081, China
 *   All rights reserved.
 *
 *   This software is the confidential and proprietary information of
 *   HiTRUST.COM, Inc. ("Confidential Information"). You shall not
 *   disclose such Confidential Information and shall use it only in
 *   accordance with the terms of the license agreement you entered
 *   into with HiTRUST.
 */
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.hitrust.trustpay.client.TrxResponse" %>
<%@ page import = "com.abc.pay.client.ebus.CBPNotifyRequest" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<%
	//1、取得第三方支付结果通知发送交易所需要的信息
	String cCBPOrderNo     = request.getParameter("CBPOrderNo"        );
	String cStatus       = request.getParameter("Status"      );
	String cPayDate       = request.getParameter("PayDate"      );
	String cPayBankNo      = request.getParameter("PayBankNo"      );
	String cTrustPayCBPTrxURL =request.getParameter("TrustPayCBPTrxURL");
    String cTxCode      = request.getParameter("TxCode"      );
	String cPayBankOrderNo      = request.getParameter("PayBankOrderNo"      );
	String cPayerAccNo      = request.getParameter("PayerAccNo"      );
	String cPayerName      = request.getParameter("PayerName"      );
	
	//2、生成支付请求对象
	CBPNotifyRequest tCBPNotifyRequest=new CBPNotifyRequest();
	tCBPNotifyRequest.setICBPOrderNo(cCBPOrderNo); //设定第三方账单号
	tCBPNotifyRequest.setIStatus(cStatus);        //设定支付状态
	tCBPNotifyRequest.setIPayDate(cPayDate);      //设定支付日期 
	tCBPNotifyRequest.setIPayBankNo(cPayBankNo);//设定支付银行编号
	tCBPNotifyRequest.setITrustPayIECBPTrxURL(cTrustPayCBPTrxURL);//设定网上支付平台交易网址
    tCBPNotifyRequest.setITxCode(cTxCode);      //设定交易类型
	tCBPNotifyRequest.setIPayBankOrderNo(cPayBankOrderNo); //设定付款银行订单号
	tCBPNotifyRequest.setIPayerAccNo(cPayerAccNo); //设定付款账户
	tCBPNotifyRequest.setIPayerName(cPayerName);   //设定付款户名  
	
	//3、传送支付请求并取得支付网址
     TrxResponse tTrxResponse=tCBPNotifyRequest.extendPostCBPRequest(1,cTrustPayCBPTrxURL);
     if (tTrxResponse.isSuccess()) {
    	   //6、支付请求提交成功，将客户端导向支付页面
    	 out.println("NotifyStatus=[" + tTrxResponse.getReturnCode  () + "]<br>");
    	 out.println("NotifyMessage=[" + tTrxResponse.getErrorMessage  () + "]<br>");
    	}
    	else {
%>
<html>
<head>
<title>农行网上支付平台-商户接口范例-第三方支付结果通知发送交易</title>
</head>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>第三方支付结果通知发送请求<br></CENTER>
<%
  out.println("ReturnCode   = [" + tTrxResponse.getReturnCode  () + "]<br>");
  out.println("ErrorMessage = [" + tTrxResponse.getErrorMessage() + "]<br>");
}
%>
 <CENTER><a href='MerchantCBP.html'>回商户首页</a></CENTER>
</BODY>
</html>