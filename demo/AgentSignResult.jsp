<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-��Ȩ֧��ǩԼ��Լ�������</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>ί�пۿ�ǩԼ��Լ���<br>
<%
//1��ȡ��MSG�����������ô˲���ֵ������֤�������
AgentSignResult tResult = new AgentSignResult(request.getParameter("MSG"));
//System.out.println(request.getParameter("MSG"));
//2���ж���֤���״̬�����к�������
if (tResult.isSuccess()) {
  //3��ǩԼ��Լ�ɹ�
  if(tResult.getValue("TrxType").equals(TrxType.TRX_TYPE_EBUS_AgentSignContract_REQ.toUpperCase()))
  {
    out.println("ǩԼ�ɹ�<br>");
    out.println("ǩԼЭ���: [" + tResult.getValue("AgentSignNo") + "]<br>");
    out.println("ǩԼ���ź�4λ: [" + tResult.getValue("Last4CardNo") + "]<br>");
  }else if(tResult.getValue("TrxType").equals(TrxType.TRX_TYPE_AgentUnSignContract_REQ.toUpperCase()))
  {
  	out.println("��Լ�ɹ�<br>");
  }
  out.println("OrderNo         = [" + tResult.getValue("OrderNo"        ) + "]<br>");

}
else {
  //4��ǩԼ��Լʧ��
  out.println("ReturnCode   = [" + tResult.getReturnCode  () + "]<br>");
  out.println("ErrorMessage = [" + tResult.getErrorMessage() + "]<br>");
}
%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>