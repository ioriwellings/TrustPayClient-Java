<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%	response.setHeader("Cache-Control", "no-cache"); 
	request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-֧������</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>֧����������<br>
<%
         //1������֧���������
        QuickPaymentSend tQuickPaymentSend = new QuickPaymentSend();

        tQuickPaymentSend.dicOrder.put("OrderNo", request.getParameter("txtOrderNo"));                       //�趨������� ����Ҫ��Ϣ��
        tQuickPaymentSend.dicOrder.put("CurrencyCode", request.getParameter("txtCurrencyCode"));    //�趨���ױ��֣�
        tQuickPaymentSend.dicOrder.put("OrderAmount", request.getParameter("txtOrderAmount")); //�趨������� ����Ҫ��Ϣ��
        tQuickPaymentSend.dicOrder.put("Fee", request.getParameter("txtFee")); //�趨�����ѽ��
        tQuickPaymentSend.dicOrder.put("OrderDate", request.getParameter("txtOrderDate"));                   //�趨�������� ����Ҫ��Ϣ - YYYY/MM/DD��
        tQuickPaymentSend.dicOrder.put("OrderTime", request.getParameter("txtOrderTime"));                   //�趨����ʱ�� ����Ҫ��Ϣ - HH:MM:SS��

        tQuickPaymentSend.dicRequest.put("AccName", request.getParameter("txtAccName"));
        tQuickPaymentSend.dicRequest.put("CertificateType", request.getParameter("txtCertificateType"));
        tQuickPaymentSend.dicRequest.put("CertificateID", request.getParameter("txtCertificateID"));
        tQuickPaymentSend.dicRequest.put("ExpDate", request.getParameter("txtExpDate"));
        tQuickPaymentSend.dicRequest.put("CVV2", request.getParameter("txtCVV2"));
        tQuickPaymentSend.dicRequest.put("VerifyCode", request.getParameter("txtVerifyCode"));
        tQuickPaymentSend.dicRequest.put("PaymentType", request.getParameter("txtPaymentType"));          //�趨֧������
        tQuickPaymentSend.dicRequest.put("PayLinkType", request.getParameter("txtPaymentLinkType"));      //�趨֧�����뷽ʽ
        tQuickPaymentSend.dicRequest.put("MerchantRemarks", request.getParameter("txtMerchantRemarks"));  //�趨�̻���ע��Ϣ

        //2������֧�����󲢷��ؽ��
        JSON json = tQuickPaymentSend.postRequest();

        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //3��֧�������ύ�ɹ������ؽ����Ϣ
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
            //6��֧�������ύʧ�ܣ��̻��Զ���������
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
		}
%>

<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>