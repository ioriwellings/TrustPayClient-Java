<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%response.setHeader("Cache-Control", "no-cache"); 
request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-��Ȩ֧��ǩԼȷ��</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>��Ȩ֧��ǩԼȷ��<br>
<%
         //1��������Ȩ֧��ǩԼȷ���������
        QuickAgentSignConfirm tRequest = new QuickAgentSignConfirm();
        tRequest.dicRequest.put("OrderNo", request.getParameter("txtOrderNo"));           //������ţ���Ҫ��Ϣ��
        tRequest.dicRequest.put("VerifyCode", request.getParameter("txtVerifyCode"));     //��֤�루��Ҫ��Ϣ��

        //2��������Ȩ֧��ǩԼȷ������
        JSON json = tRequest.postRequest();
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //3����Ȩ֧��ǩԼȷ�������ύ�ɹ�
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
            out.println("TrxType   = [" + json.GetKeyValue("TrxType") + "]<br/>");
            out.println("OrderNo = [" + json.GetKeyValue("OrderNo") + "]<br/>");
            out.println("AgentSignNo = [" + json.GetKeyValue("AgentSignNo") + "]<br/>");
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