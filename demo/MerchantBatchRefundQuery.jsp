<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.*" %>
<%response.setHeader("Cache-Control", "no-cache");
request.setCharacterEncoding("GBK"); %>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-�����֤����</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>�����˿��ѯ<br>
<%
        //1�������˿����������ѯ�������
        QueryBatchRequest tQueryBatchRequest = new QueryBatchRequest();
        tQueryBatchRequest.queryBatchRequest.put("BatchDate",request.getParameter("txtBatchDate"));  //�������ڣ���Ҫ��Ϣ��
        tQueryBatchRequest.queryBatchRequest.put("BatchTime",request.getParameter("txtBatchTime")); //����ʱ�䣨��Ҫ��Ϣ��
        tQueryBatchRequest.queryBatchRequest.put("SerialNumber",request.getParameter("txtSerialNumber")); //�趨�˿����������ѯ�������ˮ�ţ���Ҫ��Ϣ��

        //2�������˿����������ѯ����ȡ�ý��
        JSON json = tQueryBatchRequest.postRequest();

        //3���ж��˿����������ѯ״̬�����к�������
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //4��������������
            out.println("ReturnCode      = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage      = [" + ErrorMessage + "]<br/>");
            out.println("BatchDate      = [" + json.GetKeyValue("BatchDate").toString() + "]<br/>");
            out.println("BatchTime  = [" + json.GetKeyValue("BatchTime").toString() + "]<br/>");
            out.println("SerialNumber  = [" + json.GetKeyValue("SerialNumber").toString() + "]<br/>");
            out.println("BatchStatus  = [" + json.GetKeyValue("BatchStatus").toString() + "]<br/>");
            out.println("MerRefundAccountNo  = [" + json.GetKeyValue("MerRefundAccountNo").toString() + "]<br/>");
            out.println("MerRefundAccountName  = [" + json.GetKeyValue("MerRefundAccountName").toString() + "]<br/>");
            out.println("RefundAmount  = [" + json.GetKeyValue("RefundAmount").toString() + "]<br/>");
            out.println("RefundCount    = [" + json.GetKeyValue("RefundCount").toString() + "]<br/>");
            out.println("SuccessAmount      = [" + json.GetKeyValue("SuccessAmount").toString() + "]<br/>");
            out.println("SuccessCount      = [" + json.GetKeyValue("SuccessCount").toString() + "]<br/>");
            out.println("FailedAmount      = [" + json.GetKeyValue("FailedAmount").toString() + "]<br/>");
            out.println("FailedCount      = [" + json.GetKeyValue("FailedCount").toString() + "]<br/>");


            //5��ȡ�ö�����ϸ
            LinkedHashMap tOrders = json.GetArrayValue("Order");
            if (tOrders.size() <= 0)
            {
                out.println("��ϸΪ�գ�<br/>");
            }
            else 
            {
	            Iterator iter = tOrders.entrySet().iterator();
		        while (iter.hasNext()) {
		            Map.Entry entry = (Map.Entry) iter.next();
		            Hashtable val = (Hashtable)entry.getValue();                  	
		                out.println("OriginalOrderNo      = [" + (String)val.get("OriginalOrderNo") + "],");
			            out.println("RefundOrderNo      = [" + (String)val.get("RefundOrderNo") + "],");
			            out.println("CurrencyCode      = [" + (String)val.get("CurrencyCode") + "],");
			            out.println("RefundAmountCell      = [" + (String)val.get("RefundAmountCell") + "],");
			            out.println("OrderStatus      = [" + (String)val.get("OrderStatus") + "],");
			            out.println("Remark      = [" + (String)val.get("Remark") + "],");
			    }  	            
           }
		}
        else
        {
            //6���˿����������ѯʧ��
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
         } 
%>

<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>