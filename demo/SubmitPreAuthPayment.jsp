<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<% 
request.setCharacterEncoding("GBK");
response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-Ԥ��Ȩȷ��/ȡ��</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>Ԥ��Ȩȷ��/ȡ��<br>
<%
//1��ȡ���˻�����Ҫ����Ϣ
String tPayTypeId      = request.getParameter("txtPayTypeID");
String tOrderDate      = request.getParameter("OrderDate");
String tOrderTime      = request.getParameter("OrderTime");
String tOrderNo      = request.getParameter("OrderNo"  );
String tNewOrderNo      = request.getParameter("OriginalOrderNo"  );
String tCurrencyCode      = request.getParameter("CurrencyCode"  );
String tTrxAmountStr = request.getParameter("OrderAmount");
String tFee = request.getParameter("Fee");
//double  tTrxAmount    = Double.parseDouble(tTrxAmountStr);
String tMerchantRemarks      = request.getParameter("MerchantRemarks"  );

//2�������˻��������
PreAuthPaymentRequest tRequest = new PreAuthPaymentRequest();
tRequest.dicOrder.put("OperateType", tPayTypeId);         //��������       ����Ҫ��Ϣ��
tRequest.dicOrder.put("OrderDate", tOrderDate);           //��������       ����Ҫ��Ϣ��
tRequest.dicOrder.put("OrderTime", tOrderTime);           //����ʱ��       ����Ҫ��Ϣ��
tRequest.dicOrder.put("OrderNo", tOrderNo);               //���ױ��       ����Ҫ��Ϣ��
tRequest.dicOrder.put("OriginalOrderNo", tNewOrderNo);    //ԭ���ױ��       ����Ҫ��Ϣ�� 
tRequest.dicOrder.put("CurrencyCode", tCurrencyCode);     //����       ����Ҫ��Ϣ��
tRequest.dicOrder.put("OrderAmount", tTrxAmountStr);      //���       ����Ҫ��Ϣ��
tRequest.dicOrder.put("Fee", tFee);                       //�����ѽ��     
tRequest.dicOrder.put("MerchantRemarks", tMerchantRemarks);//����

//3�������˻�����ȡ���˻����
JSON json = tRequest.postRequest();
String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");

//4���ж��˻����״̬�����к�������
if (ReturnCode.equals("0000")) {
       //5������ɹ�
        out.println("ReturnCode      = [" + ReturnCode + "]<br/>");
        out.println("ErrorMessage      = [" + ErrorMessage + "]<br/>");
        out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
        out.println("OrderAmount      = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
        out.println("OriginalOrderNo      = [" + json.GetKeyValue("OriginalOrderNo") + "]<br/>");
        out.println("BatchId      = [" + json.GetKeyValue("BatchNo") + "]<br/>");
        out.println("VouchNo      = [" + json.GetKeyValue("VouchNo") + "]<br/>");
        out.println("HostDate      = [" + json.GetKeyValue("HostDate") + "]<br/>");
        out.println("HostTime      = [" + json.GetKeyValue("HostTime") + "]<br/>");
        out.println("iRspRef      = [" + json.GetKeyValue("iRspRef") + "]<br/>");
}
else {
       //6������ʧ��
        out.println("ReturnCode      = [" + ReturnCode + "]<br/>");
        out.println("ErrorMessage      = [" + ErrorMessage + "]<br/>");
}
%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>