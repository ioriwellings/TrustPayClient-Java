<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<% 
request.setCharacterEncoding("GBK");
response.setHeader("Cache-Control", "no-cache"); %>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-预授权确认/取消</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>预授权确认/取消<br>
<%
//1、取得退货所需要的信息
String tPayTypeId      = request.getParameter("txtPayTypeID");
String tOrderDate      = request.getParameter("OrderDate");
String tOrderTime      = request.getParameter("OrderTime");
String tOrderNo      = request.getParameter("OrderNo"  );
String tNewOrderNo      = request.getParameter("OriginalOrderNo"  );
String tCurrencyCode      = request.getParameter("CurrencyCode"  );
String tTrxAmountStr = request.getParameter("OrderAmount");
String tFee = request.getParameter("Fee");
//double  tTrxAmount    = Double.parseDouble(tTrxAmountStr);
String tMerchantRemarks      = request.getParameter("MerchantRemarks"  );

//2、生成退货请求对象
PreAuthPaymentRequest tRequest = new PreAuthPaymentRequest();
tRequest.dicOrder.put("OperateType", tPayTypeId);         //交易类型       （必要信息）
tRequest.dicOrder.put("OrderDate", tOrderDate);           //交易日期       （必要信息）
tRequest.dicOrder.put("OrderTime", tOrderTime);           //交易时间       （必要信息）
tRequest.dicOrder.put("OrderNo", tOrderNo);               //交易编号       （必要信息）
tRequest.dicOrder.put("OriginalOrderNo", tNewOrderNo);    //原交易编号       （必要信息） 
tRequest.dicOrder.put("CurrencyCode", tCurrencyCode);     //币种       （必要信息）
tRequest.dicOrder.put("OrderAmount", tTrxAmountStr);      //金额       （必要信息）
tRequest.dicOrder.put("Fee", tFee);                       //手续费金额     
tRequest.dicOrder.put("MerchantRemarks", tMerchantRemarks);//附言

//3、传送退货请求并取得退货结果
JSON json = tRequest.postRequest();
String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");

//4、判断退货结果状态，进行后续操作
if (ReturnCode.equals("0000")) {
       //5、处理成功
        out.println("ReturnCode      = [" + ReturnCode + "]<br/>");
        out.println("ErrorMessage      = [" + ErrorMessage + "]<br/>");
        out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
        out.println("OrderAmount      = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
        out.println("OriginalOrderNo      = [" + json.GetKeyValue("OriginalOrderNo") + "]<br/>");
        out.println("BatchId      = [" + json.GetKeyValue("BatchNo") + "]<br/>");
        out.println("VouchNo      = [" + json.GetKeyValue("VouchNo") + "]<br/>");
        out.println("HostDate      = [" + json.GetKeyValue("HostDate") + "]<br/>");
        out.println("HostTime      = [" + json.GetKeyValue("HostTime") + "]<br/>");
        out.println("iRspRef      = [" + json.GetKeyValue("iRspRef") + "]<br/>");
}
else {
       //6、处理失败
        out.println("ReturnCode      = [" + ReturnCode + "]<br/>");
        out.println("ErrorMessage      = [" + ErrorMessage + "]<br/>");
}
%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>