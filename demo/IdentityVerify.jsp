<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%response.setHeader("Cache-Control", "no-cache"); 
request.setCharacterEncoding("GBK");%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-�����֤����</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>�����֤����<br>
<%
        //1�����������֤�������
        IdentityVerifyRequest tRequest = new IdentityVerifyRequest();
        tRequest.dicRequest.put("CustomType", request.getParameter("txtCustomType")); //�ͻ����� ����Ҫ��Ϣ��
        tRequest.dicRequest.put("BankCardNo", request.getParameter("txtBankCardNo")) ;                    //�����ʺ�       ����Ҫ��Ϣ��
        tRequest.dicRequest.put("CertificateNo", request.getParameter("txtCertificateNo")) ;              //֤������       ����Ҫ��Ϣ��
        tRequest.dicRequest.put("CertificateType", request.getParameter("ddlCertificateType")); //֤������       ����Ҫ��Ϣ��
        tRequest.dicRequest.put("ResultNotifyURL", request.getParameter("txtResultNotifyURL"));          //�����֤�ش���ַ����Ҫ��Ϣ��
        tRequest.dicRequest.put("OrderDate" , request.getParameter("txtOrderDate"));              //��֤�������� ����Ҫ��Ϣ - YYYY/MM/DD��
        tRequest.dicRequest.put("OrderTime", request.getParameter("txtOrderTime"));              //��֤����ʱ�� ����Ҫ��Ϣ - HH:MM:SS��
        tRequest.dicRequest.put("PaymentLinkType" , request.getParameter("txtPaymentLinkType")); //�������� ����Ҫ��Ϣ - HH:MM:SS��

        //3�����������֤����ȡ��֧����ַ
        //tRequest.postJSONRequest();
        JSON json = tRequest.postRequest();
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {                       
            //4�������֤�����ύ�ɹ������ͻ��˵��������֤ҳ��
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
			out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
			out.println("VerifyURL-->"+json.GetKeyValue("VerifyURL"));
			response.sendRedirect(json.GetKeyValue("VerifyURL"));
        }
        else
        {
            //5�������֤�����ύʧ�ܣ��̻��Զ���������
			out.println("ReturnCode   = [" + ReturnCode + "]<br>");
			out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
		}

%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY>
</HTML>