<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%response.setHeader("Cache-Control", "no-cache"); 
request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-��Ȩ֧��������֤���ط����̻��ˣ�</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>��Ȩ֧��������֤���ط����̻��ˣ�<br>
<%
		//1��������Ȩ֧��ǩԼ��֤���ط��������
        QuickAgentSignResendReq tRequest = new QuickAgentSignResendReq();
        tRequest.dicRequest.put("OrderNo", request.getParameter("txtOrderNo"));                         //������ţ���Ҫ��Ϣ��
        tRequest.dicRequest.put("CardNo", request.getParameter("txtCardNo"));                           //ǩԼ�˺�       ����Ҫ��Ϣ��

        //2��������Ȩ֧��ǩԼ��֤���ط�����
        JSON json = tRequest.postRequest();
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //3����Ȩ֧��ǩԼ��֤���ط������ύ�ɹ�����ȡ������Ϣ
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
            out.println("TrxType   = [" + json.GetKeyValue("TrxType") + "]<br/>");
            out.println("OrderNo = [" + json.GetKeyValue("OrderNo") + "]<br/>");
            out.println("CardNo = [" + json.GetKeyValue("CardNo") + "]<br/>");
        }
        else
        {
            //4����Ȩ֧��ǩԼ������֤���ط��ύʧ�ܣ��̻��Զ���������
			out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
        }
%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>