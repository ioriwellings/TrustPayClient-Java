<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<%
//1�����ɽ��ײ�ѯ����
String payTypeID = request.getParameter("PayTypeID");
String queryTpye = request.getParameter("QueryType");
if(queryTpye.equals("0")){
	queryTpye = "false";
}else if (queryTpye.equals("1")){
	queryTpye="true";
}

QueryOrderRequest tQueryRequest = new QueryOrderRequest();
tQueryRequest.queryRequest.put("PayTypeID", payTypeID);    //�趨��������
tQueryRequest.queryRequest.put("OrderNo", request.getParameter("OrderNo"));    //�趨������� ����Ҫ��Ϣ��
tQueryRequest.queryRequest.put("QueryDetail", queryTpye);//�趨��ѯ��ʽ
//�����Ҫר�ߵ�ַ�����ô˷�����
//tQueryRequest.setConnectionFlag(true);
JSON json = tQueryRequest.postRequest();
//JSON json = tQueryRequest.extendPostRequest(1);

String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");

if (ReturnCode.equals("0000"))
{
    out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
    out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
    //4����ȡ�����Ϣ
    String orderInfo = json.GetKeyValue("Order");
    if (orderInfo.length() < 1)
    {
        out.println("��ѯ���Ϊ��<br/>");
    }
    else
    {
        //1����ԭ����base64�������Ϣ 
    	Base64 tBase64 = new Base64();
  		String orderDetail = new String(tBase64.decode(orderInfo));
        json.setJsonString(orderDetail);
        out.println("������ϸ" + orderDetail + "<br/>");
        
        if(queryTpye.equals("0")) {
            out.println("PayTypeID      = [" + json.GetKeyValue("PayTypeID") + "]<br/>");
            out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
            out.println("OrderDate      = [" + json.GetKeyValue("OrderDate") + "]<br/>");
            out.println("OrderTime      = [" + json.GetKeyValue("OrderTime") + "]<br/>");
            out.println("OrderAmount      = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
            out.println("Status      = [" + json.GetKeyValue("Status") + "]<br/>");
        }
        else
        {
            LinkedHashMap hashMap = new LinkedHashMap();
            if (payTypeID.equals("ImmediatePay") || payTypeID.equals("PreAuthPay"))
            {
                out.println("PayTypeID      = [" + json.GetKeyValue("PayTypeID") + "]<br/>");
                out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
                out.println("OrderDate      = [" + json.GetKeyValue("OrderDate") + "]<br/>");
                out.println("OrderTime      = [" + json.GetKeyValue("OrderTime") + "]<br/>");
                out.println("OrderAmount      = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
                out.println("Status      = [" + json.GetKeyValue("Status") + "]<br/>");
                out.println("OrderDesc      = [" + json.GetKeyValue("OrderDesc") + "]<br/>");
                out.println("OrderURL      = [" + json.GetKeyValue("OrderURL") + "]<br/>");
                out.println("PaymentLinkType      = [" + json.GetKeyValue("PaymentLinkType") + "]<br/>");
                out.println("AcctNo      = [" + json.GetKeyValue("AcctNo") + "]<br/>");
                out.println("CommodityType      = [" + json.GetKeyValue("CommodityType") + "]<br/>");
                out.println("ReceiverAddress      = [" + json.GetKeyValue("ReceiverAddress") + "]<br/>");
                out.println("BuyIP      = [" + json.GetKeyValue("BuyIP") + "]<br/>");
                out.println("iRspRef      = [" + json.GetKeyValue("iRspRef") + "]<br/>");
                //out.println("HostTime      = [" + json.GetKeyValue("HostTime") + "]<br/>");
                //out.println("HostDate      = [" + json.GetKeyValue("HostDate") + "]<br/>");
                out.println("ReceiveAccount      = [" + json.GetKeyValue("ReceiveAccount") + "]<br/>");
                out.println("ReceiveAccName      = [" + json.GetKeyValue("ReceiveAccName") + "]<br/>");
                out.println("MerchantRemarks      = [" + json.GetKeyValue("MerchantRemarks") + "]<br/>");
                
                //5����Ʒ��ϸ
                hashMap = json.GetArrayValue("OrderItems");
                if(hashMap.size() == 0){
                	out.println("��Ʒ��ϸΪ��");
                }
                else
                {               
                    out.println("��Ʒ��ϸΪ:<br/>");
                    Iterator iter = hashMap.entrySet().iterator();
                    while (iter.hasNext()) {
                    	Map.Entry entry = (Map.Entry) iter.next();
                    	//Object key = entry.getKey();
                    	Hashtable val = (Hashtable)entry.getValue();                  	
                    	
                    	 out.println("SubMerName      = [" + (String)val.get("SubMerName") + "],");
	                     out.println("SubMerId      = [" + (String)val.get("SubMerId") + "],");
	                     out.println("SubMerMCC      = [" + (String)val.get("SubMerMCC") + "],");
	                     out.println("SubMerchantRemarks      = [" + (String)val.get("SubMerchantRemarks") + "],");
	                     out.println("ProductID      = [" + (String)val.get("ProductID") + "],");
	                     out.println("ProductName      = [" + (String)val.get("ProductName") + "],");
	                     out.println("UnitPrice      = [" + (String)val.get("UnitPrice") + "],");
	                     out.println("Qty      = [" + (String)val.get("Qty") + "],");
	                     out.println("ProductRemarks      = [" + (String)val.get("ProductRemarks") + "],");
	                }    
                }
            }            
            else if (payTypeID.equals("DividedPay"))
            {
                out.println("PayTypeID      = [" + json.GetKeyValue("PayTypeID") + "]<br/>");
                out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
                out.println("OrderDate      = [" + json.GetKeyValue("OrderDate") + "]<br/>");
                out.println("OrderTime      = [" + json.GetKeyValue("OrderTime") + "]<br/>");
                out.println("OrderAmount      = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
                out.println("Status      = [" + json.GetKeyValue("Status") + "]<br/>");
                out.println("InstallmentCode      = [" + json.GetKeyValue("InstallmentCode") + "]<br/>");
                out.println("InstallmentNum      = [" + json.GetKeyValue("InstallmentNum") + "]<br/>");
                out.println("PaymentLinkType      = [" + json.GetKeyValue("PaymentLinkType") + "]<br/>");
                out.println("AcctNo      = [" + json.GetKeyValue("AcctNo") + "]<br/>");
                out.println("CommodityType      = [" + json.GetKeyValue("CommodityType") + "]<br/>");
                out.println("ReceiverAddress      = [" + json.GetKeyValue("ReceiverAddress") + "]<br/>");
                out.println("BuyIP      = [" + json.GetKeyValue("BuyIP") + "]<br/>");
                out.println("iRspRef      = [" + json.GetKeyValue("iRspRef") + "]<br/>");
                //out.println("HostTime      = [" + json.GetKeyValue("HostTime") + "]<br/>");
                //out.println("HostDate      = [" + json.GetKeyValue("HostDate") + "]<br/>");
                out.println("ReceiveAccount      = [" + json.GetKeyValue("ReceiveAccount") + "]<br/>");
                out.println("ReceiveAccName      = [" + json.GetKeyValue("ReceiveAccName") + "]<br/>");
                out.println("MerchantRemarks      = [" + json.GetKeyValue("MerchantRemarks") + "]<br/>");

                hashMap = json.GetArrayValue("OrderItems");
                if(hashMap.size() == 0){
                	out.println("��Ʒ��ϸΪ��");
                }
                else
                {
                    out.println("��Ʒ��ϸΪ:<br/>");
                    Iterator iter = hashMap.entrySet().iterator();
                    while (iter.hasNext()) {
                    	Map.Entry entry = (Map.Entry) iter.next();
                    	//Object key = entry.getKey();
                    	Hashtable val = (Hashtable)entry.getValue();                       	
                    	out.println("SubMerName      = [" + (String)val.get("SubMerName") + "],");
	                    out.println("SubMerId      = [" + (String)val.get("SubMerId") + "],");
	                    out.println("SubMerMCC      = [" + (String)val.get("SubMerMCC") + "],");
	                    out.println("SubMerchantRemarks      = [" + (String)val.get("SubMerchantRemarks") + "],");
	                    out.println("ProductID      = [" + (String)val.get("ProductID") + "],");
	                    out.println("ProductName      = [" + (String)val.get("ProductName") + "],");
	                    out.println("UnitPrice      = [" + (String)val.get("UnitPrice") + "],");
	                    out.println("Qty      = [" + (String)val.get("Qty") + "],");
	                    out.println("ProductRemarks      = [" + (String)val.get("ProductRemarks") + "],");
                    }
                }
				hashMap.clear();
                hashMap = json.GetArrayValue("Distribution");
                if (hashMap.size() == 0) {
                    out.println("�����˻���ϢΪ��");
                }
                else
                {
                    out.println("�����˻���Ϣ��ϸΪ:<br/>");
                    Iterator iter = hashMap.entrySet().iterator();
                    while (iter.hasNext()) {
                    	Map.Entry entry = (Map.Entry) iter.next();
                    	//Object key = entry.getKey();
                    	Hashtable val = (Hashtable)entry.getValue();   
                    	out.println("DisAccountNo      = [" + (String)val.get("DisAccountNo") + "],");
                        out.println("DisAccountName      = [" + (String)val.get("DisAccountName") + "],");
                        out.println("DisAmount      = [" + (String)val.get("DisAmount") + "],");
                    }
                }
            }            
            else if (payTypeID.equals("Refund"))
            {
                out.println("PayTypeID      = [" + json.GetKeyValue("PayTypeID") + "]<br/>");
                out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
                out.println("OrderDate      = [" + json.GetKeyValue("OrderDate") + "]<br/>");
                out.println("OrderTime      = [" + json.GetKeyValue("OrderTime") + "]<br/>");
                out.println("RefundAmount      = [" + json.GetKeyValue("RefundAmount") + "]<br/>");
                out.println("Status      = [" + json.GetKeyValue("Status") + "]<br/>");
                out.println("iRspRef      = [" + json.GetKeyValue("iRspRef") + "]<br/>");
                //out.println("HostTime      = [" + json.GetKeyValue("HostTime") + "]<br/>");
                //out.println("HostDate      = [" + json.GetKeyValue("HostDate") + "]<br/>");
                out.println("MerRefundAccountNo      = [" + json.GetKeyValue(" MerRefundAccountNo") + "]<br/>");
                out.println("MerRefundAccountName      = [" + json.GetKeyValue(" MerRefundAccountName") + "]<br/>");
            }           
            else if (payTypeID.equals("AgentPay"))
            {
                out.println("PayTypeID      = [" + json.GetKeyValue("PayTypeID") + "]<br/>");
                out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
                out.println("OrderDate      = [" + json.GetKeyValue("OrderDate") + "]<br/>");
                out.println("OrderTime      = [" + json.GetKeyValue("OrderTime") + "]<br/>");
                out.println("OrderAmount      = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
                out.println("Status      = [" + json.GetKeyValue("Status") + "]<br/>");
                out.println("InstallmentCode      = [" + json.GetKeyValue("InstallmentCode") + "]<br/>");
                out.println("InstallmentNum      = [" + json.GetKeyValue("InstallmentNum") + "]<br/>");
                out.println("PaymentLinkType      = [" + json.GetKeyValue("PaymentLinkType") + "]<br/>");
                out.println("AcctNo      = [" + json.GetKeyValue("AcctNo") + "]<br/>");
                out.println("CommodityType      = [" + json.GetKeyValue("CommodityType") + "]<br/>");
                out.println("ReceiverAddress      = [" + json.GetKeyValue("ReceiverAddress") + "]<br/>");
                out.println("BuyIP      = [" + json.GetKeyValue("BuyIP") + "]<br/>");
                out.println("iRspRef      = [" + json.GetKeyValue("iRspRef") + "]<br/>");
                //out.println("HostTime      = [" + json.GetKeyValue("HostTime") + "]<br/>");
                //out.println("HostDate      = [" + json.GetKeyValue("HostDate") + "]<br/>");
                out.println("ReceiveAccount      = [" + json.GetKeyValue("ReceiveAccount") + "]<br/>");
                out.println("ReceiveAccName      = [" + json.GetKeyValue("ReceiveAccName") + "]<br/>");
                out.println("MerchantRemarks      = [" + json.GetKeyValue("MerchantRemarks") + "]<br/>");
                
                hashMap = json.GetArrayValue("OrderItem");
                if(hashMap.size() == 0){
                	out.println("��Ʒ��ϸΪ��");
                }
                else
                {
                    out.println("��Ʒ��ϸΪ:<br/>");
                    Iterator iter = hashMap.entrySet().iterator();
                    while (iter.hasNext()) {
                    	Map.Entry entry = (Map.Entry) iter.next();
                    	//Object key = entry.getKey();
                    	Hashtable val = (Hashtable)entry.getValue();  
                    	out.println("SubMerName      = [" + (String)val.get("SubMerName") + "],");
	                    out.println("SubMerId      = [" + (String)val.get("SubMerId") + "],");
	                    out.println("SubMerMCC      = [" + (String)val.get("SubMerMCC") + "],");
	                    out.println("SubMerchantRemarks      = [" + (String)val.get("SubMerchantRemarks") + "],");
	                    out.println("ProductID      = [" + (String)val.get("ProductID") + "],");
	                    out.println("ProductName      = [" + (String)val.get("ProductName") + "],");
	                    out.println("UnitPrice      = [" + (String)val.get("UnitPrice") + "],");
	                    out.println("Qty      = [" + (String)val.get("Qty") + "],");
	                    out.println("ProductRemarks      = [" + (String)val.get("ProductRemarks") + "],");
                    }
                }
                //4����ȡ�����˻���Ϣ
                hashMap.clear();
                hashMap = json.GetArrayValue("Distribution");
                if (hashMap.size() == 0) {
                    out.println("�����˻���ϢΪ��");
                }
                else
                {
                    out.println("�����˻���Ϣ��ϸΪ:<br/>");
                    Iterator iter = hashMap.entrySet().iterator();
                    while (iter.hasNext()) {
                    	Map.Entry entry = (Map.Entry) iter.next();
                    	//Object key = entry.getKey();
                    	Hashtable val = (Hashtable)entry.getValue();   
                    	out.println("DisAccountNo      = [" + (String)val.get("DisAccountNo") + "],");
                        out.println("DisAccountName      = [" + (String)val.get("DisAccountName") + "],");
                        out.println("DisAmount      = [" + (String)val.get("DisAmount") + "],");
                    }
                }                         
            }           
            else if (payTypeID.equals("PreAuthed") || payTypeID.equals("PreAuthCancel"))
            {
                out.println("PayTypeID      = [" + json.GetKeyValue("PayTypeID") + "]<br/>");
                out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
                out.println("OrderDate      = [" + json.GetKeyValue("OrderDate") + "]<br/>");
                out.println("OrderTime      = [" + json.GetKeyValue("OrderTime") + "]<br/>");
                out.println("OrderAmount      = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
                out.println("Status      = [" + json.GetKeyValue("Status") + "]<br/>");
                out.println("AcctNo      = [" + json.GetKeyValue("AcctNo") + "]<br/>");
                out.println("iRspRef      = [" + json.GetKeyValue("iRspRef") + "]<br/>");
                //out.println("HostTime      = [" + json.GetKeyValue("HostTime") + "]<br/>");
                //out.println("HostDate      = [" + json.GetKeyValue("HostDate") + "]<br/>");
                out.println("ReceiveAccount      = [" + json.GetKeyValue("ReceiveAccount") + "]<br/>");
                out.println("ReceiveAccName      = [" + json.GetKeyValue("ReceiveAccName") + "]<br/>");
            }
        }
    }
}
else
{
    //6���̻�������ѯʧ��
    out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
    out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
}
%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-�̻�������ѯ</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>�̻�������ѯ<br>

<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>