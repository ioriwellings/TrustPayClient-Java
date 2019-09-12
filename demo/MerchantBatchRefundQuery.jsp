<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.*" %>
<%response.setHeader("Cache-Control", "no-cache");
request.setCharacterEncoding("GBK"); %>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-身份验证请求</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>批量退款查询<br>
<%
        //1、生成退款批量结果查询请求对象
        QueryBatchRequest tQueryBatchRequest = new QueryBatchRequest();
        tQueryBatchRequest.queryBatchRequest.put("BatchDate",request.getParameter("txtBatchDate"));  //订单日期（必要信息）
        tQueryBatchRequest.queryBatchRequest.put("BatchTime",request.getParameter("txtBatchTime")); //订单时间（必要信息）
        tQueryBatchRequest.queryBatchRequest.put("SerialNumber",request.getParameter("txtSerialNumber")); //设定退款批量结果查询请求的流水号（必要信息）

        //2、传送退款批量结果查询请求并取得结果
        JSON json = tQueryBatchRequest.postRequest();

        //3、判断退款批量结果查询状态，进行后续操作
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //4、生成批量对象
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


            //5、取得订单明细
            LinkedHashMap tOrders = json.GetArrayValue("Order");
            if (tOrders.size() <= 0)
            {
                out.println("明细为空！<br/>");
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
            //6、退款批量结果查询失败
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
         } 
%>

<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>