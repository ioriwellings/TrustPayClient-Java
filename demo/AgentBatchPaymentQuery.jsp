<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.text.NumberFormat"%>
<%@ page import = "java.util.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-��Ȩ�ۿ����������������ѯ</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>��Ȩ�ۿ����������������ѯ<br>
</CENTER>
<%
//1������������Ȩ�ۿ��ѯ�������
AgentBatchPaymentQueryRequest tRequest=new AgentBatchPaymentQueryRequest();
tRequest.agentBatch.put("BatchNo",request.getParameter("BatchNo")); //�������κ�       ����Ҫ��Ϣ��
tRequest.agentBatch.put("BatchDate",request.getParameter("BatchDate")); //��������      YYYY/MM/DD       ����Ҫ��Ϣ��

//2���ͽ�������
JSON json = tRequest.postRequest();

//3���жϽ��״̬�����к�������
String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");
if (ReturnCode.equals("0000"))
{
   //4����ѯ�ɹ�
    out.println("ReturnCode      = [" + json.GetKeyValue("ReturnCode") + "]<br/>");
    out.println("ErrorMessage      = [" + json.GetKeyValue("ErrorMessage") + "]<br/>");
    out.println("BatchNo      = [" + json.GetKeyValue("BatchNo") + "]<br/>");
    out.println("BatchDate      = [" + json.GetKeyValue("BatchDate") + "]<br/>");
    out.println("BatchTime      = [" + json.GetKeyValue("BatchTime") + "]<br/>");
    out.println("AgentAmount      = [" + json.GetKeyValue("AgentAmount") + "]<br/>");
    out.println("AgentCount      = [" + json.GetKeyValue("AgentCount") + "]<br/>");
    out.println("BatchStatus      = [" + json.GetKeyValue("BatchStatus") + "]<br/>");
    out.println("BatchStatusZH      = [" + json.GetKeyValue("BatchStatusZH") + "]<br/>");
    out.println("CurrencyCode      = [" + json.GetKeyValue("CurrencyCode") + "]<br/>");
    out.println("SuccessAmount      = [" + json.GetKeyValue("SuccessAmount") + "]<br/>");
    out.println("SuccessCount      = [" + json.GetKeyValue("SuccessCount") + "]<br/>");
    out.println("FailedAmount      = [" + json.GetKeyValue("FailedAmount") + "]<br/>");
    out.println("FailedCount      = [" + json.GetKeyValue("FailedCount") + "]<br/>");
    
   	LinkedHashMap hashMap = new LinkedHashMap();
    hashMap = json.GetArrayValue("AgentBatchDetail");
    //5��ȡ��������Ȩ�ۿ���ϸ
    if(hashMap.size() == 0)
    {
    	out.println("������Ȩ�ۿ���ϸΪ��<br/>");
    }
    else
    {               
        Iterator iter = hashMap.entrySet().iterator();
        while (iter.hasNext()) {
            Map.Entry entry = (Map.Entry) iter.next();
            Hashtable val = (Hashtable)entry.getValue();                  	
                out.println("SeqNo      = [" + (String)val.get("SeqNo") + "],");
	            out.println("OrderNo      = [" + (String)val.get("OrderNo") + "],");
	            out.println("OrderAmount      = [" + (String)val.get("OrderAmount") + "],");
	            out.println("AgentSignNo      = [" + (String)val.get("AgentSignNo") + "],");
	            out.println("OrderStatus      = [" + (String)val.get("OrderStatus") + "],");
	            out.println("OrderStatusZH      = [" + (String)val.get("OrderStatusZH") + "],");
	        }    
       }
       
}
else {
   //6�����������ѯʧ��
	out.println("ReturnCode   = [" + ReturnCode + "]<br>");
	out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
}
%>
<a href='Merchant.html'>���̻���ҳ</a>
</BODY>
</HTML>