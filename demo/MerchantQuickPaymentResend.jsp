<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%	response.setHeader("Cache-Control", "no-cache"); 
	request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-��֤���ط�����</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>��֤���ط�����<br>
<%
        //1������֧���������
        QuickPaymentReSend tQuickPaymentReSend = new QuickPaymentReSend();
        tQuickPaymentReSend.dicOrder.put("OrderNo", request.getParameter("txtOrderNo"));                       //�趨������� ����Ҫ��Ϣ��
        tQuickPaymentReSend.dicOrder.put("CurrencyCode",request.getParameter("txtCurrencyCode"));    //�趨���ױ���
        tQuickPaymentReSend.dicOrder.put("OrderAmount",request.getParameter("txtOrderAmount")); //�趨������� ����Ҫ��Ϣ��
        tQuickPaymentReSend.dicOrder.put("OrderDate",request.getParameter("txtOrderDate"));    //�趨�������� ����Ҫ��Ϣ - YYYY/MM/DD��
        tQuickPaymentReSend.dicOrder.put("OrderTime",request.getParameter("txtOrderTime"));                   //�趨����ʱ�� ����Ҫ��Ϣ - HH:MM:SS��

        //2������֧������
        JSON json = tQuickPaymentReSend.postRequest();

        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //3��֧�������ύ�ɹ����̻��Զ����̲���
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
            //4��֧�������ύʧ�ܣ��̻��Զ���������
             out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
             out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
		}

%>

<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>