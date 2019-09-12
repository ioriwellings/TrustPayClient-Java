<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.hitrust.trustpay.client.TrxException" %>
<%@ page import = "com.hitrust.trustpay.client.Base64" %>
<%@ page import = "com.hitrust.trustpay.client.MerchantConfig" %>
<%@ page import = "com.abc.pay.client.ebus.CBPNotifyRequest" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<% request.setCharacterEncoding("gb2312"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//1��ȡ�õ�����֧�����֪ͨ���ͽ�������Ҫ����Ϣ
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
	
	//2������֧���������
	CBPNotifyRequest tCBPNotifyRequest=new CBPNotifyRequest();
	tCBPNotifyRequest.setICBPOrderNo(cCBPOrderNo); //�趨�������˵���
	tCBPNotifyRequest.setIStatus(cStatus);        //�趨֧��״̬
	tCBPNotifyRequest.setIPayDate(cPayDate);      //�趨֧������ 
	tCBPNotifyRequest.setIPayBankNo(cPayBankNo);//�趨֧�����б��
	tCBPNotifyRequest.setITrustPayIECBPTrxURL(sTrustPayIECBPTrxURL);//�趨������ύ���ϵ�����֧��ƽ̨������ַ
	tCBPNotifyRequest.setITxCode(cTxCode);      //�趨��������
	tCBPNotifyRequest.setIPayBankOrderNo(cPayBankOrderNo); //�趨�������ж�����
	tCBPNotifyRequest.setIPayerAccNo(cPayerAccNo); //�趨�����˻�
	tCBPNotifyRequest.setIPayerName(cPayerName);   //�趨����� 
	
	//3������֧������ȡ��֧����ַ
    try{
    	tMSG = tCBPNotifyRequest.genCBPSignature(1);
         //Base64���ܱ���
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
<head><title>ũ������֧��ƽ̨-������֧�����֪ͨ���ͽ���-ҳ�淽ʽ</title></head>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>������֧�����֪ͨ���ͽ���-ҳ�淽ʽ<br>
<form name="form1" method="post" action="<%=sTrustPayIECBPTrxURL%>">
<input type="hidden" name="MSG" value="<%=tData%>">
<input type="hidden" name="errorPage" value="<%=sErrorUrl%>">
<TR><TD colspan=2><INPUT type=submit value="�ύ">
</form>
</body>
</html>