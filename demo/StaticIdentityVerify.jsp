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
        QuickIdentityVerifyRequest tRequest = new QuickIdentityVerifyRequest();
        tRequest.dicRequest.put("CustomType",request.getParameter("txtCustomType"));    //�ͻ����� ����Ҫ��Ϣ��
        tRequest.dicRequest.put("ClientName",request.getParameter("txtClientName")); //�ͻ����� ����Ҫ��Ϣ��
        tRequest.dicRequest.put("AccNo",request.getParameter("txtBankCardNo")) ;                    //�����ʺ�       ����Ҫ��Ϣ��
        tRequest.dicRequest.put("CertificateNo",request.getParameter("txtCertificateNo"));              //֤������       ����Ҫ��Ϣ��
        tRequest.dicRequest.put("CertificateType",request.getParameter("ddlCertificateType")); //֤������       ����Ҫ��Ϣ��
        tRequest.dicRequest.put("MobileNo",request.getParameter("txtPhoneNo"));          //�ֻ��ţ���Ҫ��Ϣ��
        tRequest.dicRequest.put("CustomNo",request.getParameter("txtCustomNo"));              //�����ͻ���
        //2�����������֤����ȡ��֧����ַ
        //tRequest.postJSONRequest();
        JSON json = tRequest.postRequest();
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //3�������֤�����ύ�ɹ����̻��Զ��������� 
            out.println("ReturnCode   = [" + ReturnCode + "]<br>");
			out.println("ErrorMessage = [" + ErrorMessage + "]<br>");   
			out.println("TrxType = [" + json.GetKeyValue("TrxType") + "]<br>");           
        }
        else
        {
            //4�������֤�����ύʧ�ܣ��̻��Զ���������
            out.println("ReturnCode   = [" + ReturnCode + "]<br>");
			out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
		}

%>

<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>