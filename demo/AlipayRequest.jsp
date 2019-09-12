<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Cache-Control", "no-cache");
%>
<%
//1、生成订单对象
AlipayRequest tPaymentRequest = new AlipayRequest();
tPaymentRequest.dicOrder.put("PayTypeID", request.getParameter("PayTypeID"));                   //设定交易类型
tPaymentRequest.dicOrder.put("OrderDate", request.getParameter("OrderDate") );                  //设定订单日期 （必要信息 - YYYY/MM/DD）
tPaymentRequest.dicOrder.put("OrderTime", request.getParameter("OrderTime"));                   //设定订单时间 （必要信息 - HH:MM:SS）
tPaymentRequest.dicOrder.put("orderTimeoutDate", request.getParameter("orderTimeoutDate"));     //设定订单有效期
tPaymentRequest.dicOrder.put("OrderNo", request.getParameter("OrderNo"));                       //设定订单编号 （必要信息）
tPaymentRequest.dicOrder.put("CurrencyCode", request.getParameter("CurrencyCode"));             //设定交易币种
tPaymentRequest.dicOrder.put("OrderAmount", request.getParameter("PaymentRequestAmount"));      //设定交易金额
tPaymentRequest.dicOrder.put("Fee", request.getParameter("Fee"));                               //设定手续费金额
tPaymentRequest.dicOrder.put("AccountNo", request.getParameter("AccountNo"));                   //设定支付账户
tPaymentRequest.dicOrder.put("OpenID", request.getParameter("OpenID"));                         //设定用户在子商户公众号下面的ID
tPaymentRequest.dicOrder.put("OrderDesc", request.getParameter("OrderDesc"));                   //设定订单说明
tPaymentRequest.dicOrder.put("OrderURL", request.getParameter("OrderURL"));                     //设定订单地址
tPaymentRequest.dicOrder.put("ReceiverAddress", request.getParameter("ReceiverAddress"));       //收货地址
tPaymentRequest.dicOrder.put("InstallmentMark", request.getParameter("InstallmentMark"));       //分期标识
if (request.getParameter("InstallmentMark") == "1" && request.getParameter("PayTypeID") == "DividedPay")
{
    tPaymentRequest.dicOrder.put("InstallmentCode", request.getParameter("InstallmentCode"));   //设定分期代码
    tPaymentRequest.dicOrder.put("InstallmentNum", request.getParameter("InstallmentNum"));     //设定分期期数
}
tPaymentRequest.dicOrder.put("CommodityType", request.getParameter("CommodityType"));           //设置商品种类
tPaymentRequest.dicOrder.put("BuyIP", request.getParameter("BuyIP"));                           //IP
tPaymentRequest.dicOrder.put("ExpiredDate", request.getParameter("ExpiredDate"));               //设定订单保存时间
tPaymentRequest.dicOrder.put("WAP_QUIT_URL",request.getParameter("WapQuitUrl"));
tPaymentRequest.dicOrder.put("PC_QR_PAY_MODE",request.getParameter("PcQrPayMode"));
tPaymentRequest.dicOrder.put("PC_QRCODE_WIDTH",request.getParameter("PcQrCodeWidth"));
tPaymentRequest.dicOrder.put("TIMEOUT_EXPRESS",request.getParameter("TimeoutExpress"));

//2、订单明细
LinkedHashMap orderitem = new LinkedHashMap();
orderitem.put("SubMerName", "测试二级商户1");    //设定二级商户名称
orderitem.put("SubMerId", "12345");    //设定二级商户代码
orderitem.put("SubMerMCC", "0000");   //设定二级商户MCC码 
orderitem.put("SubMerchantRemarks", "测试");   //二级商户备注项
orderitem.put("ProductID", "IP000001");//商品代码，预留字段
orderitem.put("ProductName", "中国移动IP卡");//商品名称
orderitem.put("UnitPrice", "1.00");//商品总价
orderitem.put("Qty", "1");//商品数量
orderitem.put("ProductRemarks", "测试商品"); //商品备注项
orderitem.put("ProductType", "充值类");//商品类型
orderitem.put("ProductDiscount", "0.9");//商品折扣
orderitem.put("ProductExpiredDate", "10");//商品有效期
tPaymentRequest.orderitems.put(1, orderitem);

orderitem = new LinkedHashMap();
orderitem.put("SubMerName", "测试二级商户1");    //设定二级商户名称
orderitem.put("SubMerId", "12345");    //设定二级商户代码
orderitem.put("SubMerMCC", "0000");   //设定二级商户MCC码 
orderitem.put("SubMerchantRemarks", "测试");   //二级商户备注项
orderitem.put("ProductID", "IP000001");//商品代码，预留字段
orderitem.put("ProductName", "中国联通IP卡");//商品名称
orderitem.put("UnitPrice", "1.00");//商品总价
orderitem.put("Qty", "2");//商品数量
orderitem.put("ProductRemarks", "测试商品"); //商品备注项
orderitem.put("ProductType", "充值类");//商品类型
orderitem.put("ProductDiscount", "0.9");//商品折扣
orderitem.put("ProductExpiredDate", "10");//商品有效期
tPaymentRequest.orderitems.put(2, orderitem);

//3、生成支付请求对象
String paymentType = request.getParameter("PaymentType");
tPaymentRequest.dicRequest.put("PaymentType", paymentType);            //设定支付类型
String paymentLinkType  = request.getParameter("PaymentLinkType");                                         
tPaymentRequest.dicRequest.put("PaymentLinkType", paymentLinkType);    //设定支付接入方式
//if (paymentType.equals(Constants.PAY_TYPE_UCBP) && paymentLinkType.equals(Constants.PAY_LINK_TYPE_MOBILE))
//{
    //tPaymentRequest.dicRequest.put("UnionPayLinkType",request.getParameter("UnionPayLinkType"));  //当支付类型为6，支付接入方式为2的条件满足时，需要设置银联跨行移动支付接入方式
//}
tPaymentRequest.dicRequest.put("ReceiveAccount", request.getParameter("ReceiveAccount"));      //设定收款方账号
tPaymentRequest.dicRequest.put("ReceiveAccName", request.getParameter("ReceiveAccName"));      //设定收款方户名
tPaymentRequest.dicRequest.put("NotifyType", request.getParameter("NotifyType"));              //设定通知方式
tPaymentRequest.dicRequest.put("ResultNotifyURL", request.getParameter("ResultNotifyURL"));    //设定通知URL地址
tPaymentRequest.dicRequest.put("MerchantRemarks", request.getParameter("MerchantRemarks"));    //设定附言
tPaymentRequest.dicRequest.put("IsBreakAccount", request.getParameter("IsBreakAccount"));      //设定交易是否分账
tPaymentRequest.dicRequest.put("SplitAccTemplate", request.getParameter("SplitAccTemplate"));  //分账模版编号        


//4、添加分账信息
	String[] SubMerchantID_arr = new String[]{};       
	String[] SplitAmount_arr = new String[]{};  

	SubMerchantID_arr    = request.getParameterValues("SubMerchantID");  
	SplitAmount_arr      = request.getParameterValues("SplitAmount");  

    LinkedHashMap map = null;   
   
	if(SubMerchantID_arr != null){
	     for (int i = 0; i < SubMerchantID_arr.length; i++)
	     {
	         map = new LinkedHashMap();
	         //map.put("SeqNo       ", String.valueOf(i + 1));
	         map.put("SubMerchantID",SubMerchantID_arr[i]);
	         map.put("SplitAmount",SplitAmount_arr[i]);
	         
	         tPaymentRequest.dicSplitAccInfo.put(i+1, map);
	     }
	}     

System.out.println(tPaymentRequest.dicRequest.get("PaymentLinkType"));
JSON json = tPaymentRequest.postRequest();
//JSON json = tPaymentRequest.extendPostRequest(1);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>Javascript QRCode</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/qrcode.min.js"></script>
</head>
<body>
<input id="text" type="text" value="<%=json.GetKeyValue("QRURL") %>" style="width:80%" /><br />
<div id="qrcode" style="width:100px; height:100px; margin-top:15px;"></div>
<textarea name="returnMsg" style="WIDTH: 50%; OVERFLOW-Y: hidden" rows="20" cols="20">
<%
String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");
if (ReturnCode.equals("0000"))
{
	String QRURL = json.GetKeyValue("QRURL");
	//String APP= json.GetKeyValue("APP");
    //String JSAPI= json.GetKeyValue("JSAPI");
	//out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
	//out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
	//out.println("MerchantID = [" + json.GetKeyValue("MerchantID")+ "]<br/>");
	//out.println("TrxType = [" + json.GetKeyValue("TrxType")+ "]<br/>");
	//out.println("OrderNo = [" + json.GetKeyValue("OrderNo")+ "]<br/>");
	//out.println("OrderAmount = [" + json.GetKeyValue("OrderAmount")+ "]<br/>");
	
	//out.println("PaymentURL = [" + json.GetKeyValue("PaymentURL")+ "]<br/>");
	//out.println("HostDate = [" + json.GetKeyValue("HostDate")+ "]<br/>");
	//out.println("HostTime = [" + json.GetKeyValue("HostTime")+ "]<br/>");
	//out.println("PrePayID = [" + json.GetKeyValue("PrePayID")+ "]<br/>");
	
    if(!QRURL.equals("")){
   	    out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
   	    out.println("ErrorMessage =   [" + ErrorMessage + "]<br/>");
		out.println("QRURL = [" + json.GetKeyValue("QRURL")+ "]<br/>");
		out.println("PrePayID = [" + json.GetKeyValue("PrePayID")+ "]<br/>");
		out.println("OrderNo = [" + json.GetKeyValue("OrderNo")+ "]<br/>");
	    out.println("OrderAmount = [" + json.GetKeyValue("OrderAmount")+ "]<br/>");
		out.println("MerchantID     = [" + json.GetKeyValue("MerchantID") + "]<br/>");
		out.println("TrxType        = [" + json.GetKeyValue("TrxType") + "]<br/>");
		out.println("PaymentURL = [" + json.GetKeyValue("PaymentURL")+ "]<br/>");
	    out.println("HostDate = [" + json.GetKeyValue("HostDate")+ "]<br/>");
	    out.println("HostTime = [" + json.GetKeyValue("HostTime")+ "]<br/>");
	}
	else
	{

		out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
		out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
		Base64 tBase64 = new Base64();
		String signOrder = new String(tBase64.decode(json.GetKeyValue("PrePayID")));
		out.println("Sign_Order     = [" + signOrder + "]<br/>");
		out.println("TRADE_NO = [" + json.GetKeyValue("TRADE_NO") + "]<br/>");
	
	}

	//else {
		//out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
		//out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
		//out.println("PaymentURL-->"+json.GetKeyValue("PaymentURL"));
		//response.sendRedirect(json.GetKeyValue("PaymentURL"));
	//}
}
else
{
	out.println("ReturnCode   = [" + ReturnCode + "]<br>");
	out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
}
 %>
</textarea>

<script type="text/javascript">
var qrcode = new QRCode(document.getElementById("qrcode"), {
	width : 100,
	height : 100
});

function makeCode () {		
	var elText = document.getElementById("text");
	
	qrcode.makeCode(elText.value);
}

makeCode();

$("#text").
	on("blur", function () {
		makeCode();
	}).
	on("keydown", function (e) {
		if (e.keyCode == 13) {
			makeCode();
		}
	});
</script>
</body>
</html>