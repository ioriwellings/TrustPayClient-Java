<!--
/*
 * @(#)MerchantCBPNotify.jsp	V1.0	2012/06/04
 *
 * Project: BJP03004
 *
 * Description:
 *    �̻��ӿڵ�����֧�����֪ͨ���ͽ��׷���.
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
	//1��ȡ�õ�����֧�����֪ͨ���ͽ�������Ҫ����Ϣ
	String cCBPOrderNo     = request.getParameter("CBPOrderNo"        );
	String cStatus       = request.getParameter("Status"      );
	String cPayDate       = request.getParameter("PayDate"      );
	String cPayBankNo      = request.getParameter("PayBankNo"      );
	String cTrustPayCBPTrxURL =request.getParameter("TrustPayCBPTrxURL");
    String cTxCode      = request.getParameter("TxCode"      );
	String cPayBankOrderNo      = request.getParameter("PayBankOrderNo"      );
	String cPayerAccNo      = request.getParameter("PayerAccNo"      );
	String cPayerName      = request.getParameter("PayerName"      );
	
	//2������֧���������
	CBPNotifyRequest tCBPNotifyRequest=new CBPNotifyRequest();
	tCBPNotifyRequest.setICBPOrderNo(cCBPOrderNo); //�趨�������˵���
	tCBPNotifyRequest.setIStatus(cStatus);        //�趨֧��״̬
	tCBPNotifyRequest.setIPayDate(cPayDate);      //�趨֧������ 
	tCBPNotifyRequest.setIPayBankNo(cPayBankNo);//�趨֧�����б��
	tCBPNotifyRequest.setITrustPayIECBPTrxURL(cTrustPayCBPTrxURL);//�趨����֧��ƽ̨������ַ
    tCBPNotifyRequest.setITxCode(cTxCode);      //�趨��������
	tCBPNotifyRequest.setIPayBankOrderNo(cPayBankOrderNo); //�趨�������ж�����
	tCBPNotifyRequest.setIPayerAccNo(cPayerAccNo); //�趨�����˻�
	tCBPNotifyRequest.setIPayerName(cPayerName);   //�趨�����  
	
	//3������֧������ȡ��֧����ַ
     TrxResponse tTrxResponse=tCBPNotifyRequest.extendPostCBPRequest(1,cTrustPayCBPTrxURL);
     if (tTrxResponse.isSuccess()) {
    	   //6��֧�������ύ�ɹ������ͻ��˵���֧��ҳ��
    	 out.println("NotifyStatus=[" + tTrxResponse.getReturnCode  () + "]<br>");
    	 out.println("NotifyMessage=[" + tTrxResponse.getErrorMessage  () + "]<br>");
    	}
    	else {
%>
<html>
<head>
<title>ũ������֧��ƽ̨-�̻��ӿڷ���-������֧�����֪ͨ���ͽ���</title>
</head>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>������֧�����֪ͨ��������<br></CENTER>
<%
  out.println("ReturnCode   = [" + tTrxResponse.getReturnCode  () + "]<br>");
  out.println("ErrorMessage = [" + tTrxResponse.getErrorMessage() + "]<br>");
}
%>
 <CENTER><a href='MerchantCBP.html'>���̻���ҳ</a></CENTER>
</BODY>
</html>