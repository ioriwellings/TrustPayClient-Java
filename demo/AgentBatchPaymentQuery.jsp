<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.text.NumberFormat"%>
<%@ page import = "java.util.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-授权扣款批量处理结果结果查询</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>授权扣款批量处理结果结果查询<br>
</CENTER>
<%
//1、生成批量授权扣款查询请求对象
AgentBatchPaymentQueryRequest tRequest=new AgentBatchPaymentQueryRequest();
tRequest.agentBatch.put("BatchNo",request.getParameter("BatchNo")); //请求批次号       （必要信息）
tRequest.agentBatch.put("BatchDate",request.getParameter("BatchDate")); //请求日期      YYYY/MM/DD       （必要信息）

//2传送交易请求
JSON json = tRequest.postRequest();

//3、判断结果状态，进行后续操作
String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");
if (ReturnCode.equals("0000"))
{
   //4、查询成功
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
    //5、取得批量授权扣款明细
    if(hashMap.size() == 0)
    {
    	out.println("批量授权扣款明细为空<br/>");
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
   //6、批量结果查询失败
	out.println("ReturnCode   = [" + ReturnCode + "]<br>");
	out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
}
%>
<a href='Merchant.html'>回商户首页</a>
</BODY>
</HTML>