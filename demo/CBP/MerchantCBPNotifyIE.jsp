<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.hitrust.trustpay.client.TrxException" %>
<%@ page import = "com.hitrust.trustpay.client.Base64" %>
<%@ page import = "com.hitrust.trustpay.client.MerchantConfig" %>
<%@ page import = "com.abc.pay.client.ebus.CBPNotifyRequest" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<% request.setCharacterEncoding("gb2312"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//1、取得第三方支付结果通知发送交易所需要的信息
	String cCBPOrderNo     = request.getParameter("CBPOrderNo"        );
	String cStatus       = request.getParameter("Status"      );
	String cPayDate       = request.getParameter("PayDate"      );
	String cPayBankNo      = request.getParameter("PayBankNo"      );
	String cTxCode      = request.getParameter("TxCode"      );
	String cPayBankOrderNo      = request.getParameter("PayBankOrderNo"      );
	String cPayerAccNo      = request.getParameter("PayerAccNo"      );
	String cPayerName      = request.getParameter("PayerName"      );
	
	String tMSG="";
	String tData="";
	
	MerchantConfig tMerchantConfig=MerchantConfig.getUniqueInstance();
	String sTrustPayIECBPTrxURL=request.getParameter("TrustPayIECBPTrxURL"      );
	String sErrorUrl=tMerchantConfig.getMerchantErrorURL();
	
	//2、生成支付请求对象
	CBPNotifyRequest tCBPNotifyRequest=new CBPNotifyRequest();
	tCBPNotifyRequest.setICBPOrderNo(cCBPOrderNo); //设定第三方账单号
	tCBPNotifyRequest.setIStatus(cStatus);        //设定支付状态
	tCBPNotifyRequest.setIPayDate(cPayDate);      //设定支付日期 
	tCBPNotifyRequest.setIPayBankNo(cPayBankNo);//设定支付银行编号
	tCBPNotifyRequest.setITrustPayIECBPTrxURL(sTrustPayIECBPTrxURL);//设定浏览器提交网上第三方支付平台交易网址
	tCBPNotifyRequest.setITxCode(cTxCode);      //设定交易类型
	tCBPNotifyRequest.setIPayBankOrderNo(cPayBankOrderNo); //设定付款银行订单号
	tCBPNotifyRequest.setIPayerAccNo(cPayerAccNo); //设定付款账户
	tCBPNotifyRequest.setIPayerName(cPayerName);   //设定付款户名 
	
	//3、传送支付请求并取得支付网址
    try{
    	tMSG = tCBPNotifyRequest.genCBPSignature(1);
         //Base64加密报文
         Base64 tBase64 = new Base64();
        tData = tBase64.encode(tMSG.getBytes("gb2312"));
  
    }catch (TrxException e){    
       request.setAttribute("tReturnCode", e.getCode());
       request.setAttribute("tErrorMsg", e.getMessage());
       request.getRequestDispatcher("/ErrorPageInternal.jsp").forward(request, response);
       return; 
   } 
%>
	 
<html>
<head><title>农行网上支付平台-第三方支付结果通知发送交易-页面方式</title></head>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>第三方支付结果通知发送交易-页面方式<br>
<form name="form1" method="post" action="<%=sTrustPayIECBPTrxURL%>">
<input type="hidden" name="MSG" value="<%=tData%>">
<input type="hidden" name="errorPage" value="<%=sErrorUrl%>">
<TR><TD colspan=2><INPUT type=submit value="提交">
</form>
</body>
</html>