<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-������ˮ��ѯ</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>������ˮ��ѯ<br>
<%
//1��ȡ�ý�����ˮ��ѯ����Ҫ����Ϣ
String tSettleDate = request.getParameter("SettleDate");
String tSettleStartHour = request.getParameter("SettleStartHour");
String tSettleEndHour = request.getParameter("SettleEndHour");
String tZIP = request.getParameter("ZIP");
    
//2�����ɽ�����ˮ��ѯ�������
QueryTrnxRecords tRequest = new QueryTrnxRecords();
tRequest.dicRequest.put("SettleDate",tSettleDate);  //��ѯ����YYYY/MM/DD ����Ҫ��Ϣ��
tRequest.dicRequest.put("SettleStartHour",tSettleStartHour);  //��ѯ��ʼʱ��Σ�0-23��
tRequest.dicRequest.put("SettleEndHour",tSettleEndHour);  //��ѯ��ֹʱ��Σ�0-23��
tRequest.dicRequest.put("ZIP",tZIP);

//3�����ͽ�����ˮ��ѯ����ȡ�ý�����ˮ
JSON json = tRequest.postRequest();

//4���жϽ�����ˮ��ѯ���״̬�����к�������
String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");
if (ReturnCode.equals("0000"))
{
    //5��������ˮ��ѯ�ɹ������ɽ�����ˮ����
    out.println("ReturnCode      = [" + json.GetKeyValue("ReturnCode") + "]<br/>");
    out.println("ErrorMessage      = [" + json.GetKeyValue("ErrorMessage") + "]<br/>");
    out.println("TrxType      = [" + json.GetKeyValue("TrxType") + "]<br/>");
 	if(tZIP.equals("0")){
 		out.println("DetailRecords      = [" + json.GetKeyValue("DetailRecords") + "]<br/>");
 	}
    if(tZIP.equals("1")) {
    	out.println("ZIPDetailRecords      = [" + ZipUtil.gunzip(json.GetKeyValue("ZIPDetailRecords")) + "]<br/>");
    }

}
else {
    //6��������ˮ��ѯʧ��
	out.println("ReturnCode   = [" + ReturnCode + "]<br>");
	out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
}
%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>