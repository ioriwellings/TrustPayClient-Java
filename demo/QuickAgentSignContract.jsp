<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%response.setHeader("Cache-Control", "no-cache"); 
request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-��Ȩ֧��ǩԼ���̻��ˣ�</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>��Ȩ֧��ǩԼ���̻��ˣ�<br>
<%
        //1��������Ȩ֧��ǩԼ�������
        QuickAgentSignContractRequest tRequest = new QuickAgentSignContractRequest();
        tRequest.dicRequest.put("OrderDate", request.getParameter("txtRequestDate"));            //�������� ����Ҫ��Ϣ - YYYY/MM/DD��
        tRequest.dicRequest.put("OrderTime", request.getParameter("txtRequestTime"));            //����ʱ�� ����Ҫ��Ϣ - HH:MM:SS��
        tRequest.dicRequest.put("OrderNo", request.getParameter("txtOrderNo"));                  //������ţ���Ҫ��Ϣ��
        tRequest.dicRequest.put("PaymentLinkType", request.getParameter("txtPaymentLinkType"));  //�������� ����Ҫ��Ϣ��
        tRequest.dicRequest.put("MerCustomNo", request.getParameter("txtMerCustomNo"));          //�ͻ����
        tRequest.dicRequest.put("AgentSignNo", request.getParameter("txtAgentSignNo"));          //ǩԼ���
        tRequest.dicRequest.put("CardNo", request.getParameter("txtCardNo"));                    //ǩԼ�˺�  ����Ҫ��Ϣ��
        tRequest.dicRequest.put("CardType", request.getParameter("txtCardType"));                //ũ�п����ͣ���Ҫ��Ϣ��
        tRequest.dicRequest.put("MobileNo", request.getParameter("txtMobileNo"));                //ǩԼ�ֻ��ţ���Ҫ��Ϣ��
        tRequest.dicRequest.put("InvaidDate", request.getParameter("txtInvaidDate"));            //ǩԼ��Ч�ڣ���Ҫ��Ϣ��
        tRequest.dicRequest.put("IsSign", request.getParameter("txtIsSign"));                    //ǩԼ/��Լ��ʶ ����Ҫ��Ϣ��
		tRequest.dicRequest.put("CertificateType", request.getParameter("txtCertificateType"));  //֤�����ͣ���Ҫ��Ϣ��
		tRequest.dicRequest.put("CertificateNo", request.getParameter("txtCertificateNo")); 	 //֤�����루��Ҫ��Ϣ��
		tRequest.dicRequest.put("AccName", request.getParameter("txtAccName"));                  //�ͻ���������Ҫ��Ϣ��
		tRequest.dicRequest.put("CVV2", request.getParameter("txtCVV2"));                        //���ǿ�CVV2�루ũ�п�����Ϊ���ǿ�ʱ���䣩
		tRequest.dicRequest.put("CardDueDate", request.getParameter("txtCardDueDate"));          //���ǿ������գ�ũ�п�����Ϊ���ǿ�ʱ���䣩

        //2��������Ȩ֧��ǩԼ����
        JSON json = tRequest.postRequest();
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //3����Ȩ֧��ǩԼ�����ύ�ɹ�����ȡ������Ϣ
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
            out.println("TrxType   = [" + json.GetKeyValue("TrxType") + "]<br/>");
            out.println("OrderNo = [" + json.GetKeyValue("OrderNo") + "]<br/>");
        }
        else
        {
            //4����Ȩ֧��ǩԼ�����ύʧ�ܣ��̻��Զ���������
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
}
%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>