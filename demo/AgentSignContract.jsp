<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<% response.setHeader("Cache-Control", "no-cache");
   request.setCharacterEncoding("GBK"); 
%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-�����֤����</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>�����֤����<br>
<%
       //1��������Ȩ֧��ǩԼ�������
        AgentSignContractRequest tRequest = new AgentSignContractRequest();
        tRequest.agentSignRequest.put("CertificateNo", request.getParameter("txtCertificateNo"));;             //֤������       ����Ҫ��Ϣ��
        tRequest.agentSignRequest.put("CertificateType", request.getParameter("ddlCertificateType"));//֤������       ����Ҫ��Ϣ��ũ�п�����
        tRequest.agentSignRequest.put("NotifyType", request.getParameter("txtNotifyType"));                 //֪ͨ���� ����Ҫ��Ϣ��
        tRequest.agentSignRequest.put("ResultNotifyURL", request.getParameter("txtResultNotifyURL"));         //֪ͨ��ַ����Ҫ��Ϣ��
        tRequest.agentSignRequest.put("OrderNo", request.getParameter("txtOrderNo"));                         //������ţ���Ҫ��Ϣ��
        tRequest.agentSignRequest.put("PaymentLinkType", request.getParameter("txtPaymentLinkType"));                 //�������� ����Ҫ��Ϣ��
        tRequest.agentSignRequest.put("MerCustomNo", request.getParameter("txtMerCustomNo"));                 //�ͻ����        
        tRequest.agentSignRequest.put("CardType", request.getParameter("txtCardType"));                         //ũ�п����� ����Ҫ��Ϣ��
        tRequest.agentSignRequest.put("RequestDate", request.getParameter("txtRequestDate"));                 //��֤�������� ����Ҫ��Ϣ - YYYY/MM/DD��
        tRequest.agentSignRequest.put("RequestTime", request.getParameter("txtRequestTime"));                 //��֤����ʱ�� ����Ҫ��Ϣ - HH:MM:SS��
        tRequest.agentSignRequest.put("InvaidDate", request.getParameter("txtInvaidDate"));                 //ǩԼ��Ч�� ����Ҫ��Ϣ��
        tRequest.agentSignRequest.put("IsSign", request.getParameter("txtIsSign"));                 //ǩԼ��ʶ ����Ҫ��Ϣ��

        //2��������Ȩ֧��ǩԼ����ȡ��ǩԼ��ַ
        JSON json = tRequest.postRequest();
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            out.println("ReturnCode      = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage      = [" + ErrorMessage + "]<br/>");
            out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
            out.println("TrxType      = [" + json.GetKeyValue("TrxType") + "]<br/>");
            
            //3����Ȩ֧��ǩԼ�����ύ�ɹ������ͻ��˵���ǩԼҳ��
            response.sendRedirect(json.GetKeyValue("B2CAgentSignContractURL"));
        }
        else
        {
            //4����Ȩ֧��ǩԼ�����ύʧ�ܣ��̻��Զ���������
            out.println("ReturnCode      = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage      = [" + ErrorMessage + "]<br/>");
}
%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>