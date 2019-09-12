<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-单笔授权扣款请求</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>单笔授权扣款请求<br>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Cache-Control", "no-cache");
%>
<%
        //1、生成单笔授权扣款请求对象
        AgentPaymentRequest tRequest = new AgentPaymentRequest();
        //2、生成定单订单对象，并将订单明细加入定单中
        tRequest.dicRequest.put("OrderDate", request.getParameter("OrderDate"));                   //设定订单日期 （必要信息 - YYYY/MM/DD）
        tRequest.dicRequest.put("OrderTime", request.getParameter("OrderTime"));                   //设定订单时间 （必要信息 - HH:MM:SS）
        tRequest.dicRequest.put("OrderNo", request.getParameter("OrderNo"));                       //设定订单编号 （必要信息）
        tRequest.dicRequest.put("AgentSignNo", request.getParameter("AgentSignNo"));                       //设定授权支付协议号 （必要信息）
        tRequest.dicRequest.put("CardNo", request.getParameter("CardNo"));                       //设定账号
        tRequest.dicRequest.put("CurrencyCode", request.getParameter("CurrencyCode"));    //设定交易币种 （必要信息）
        tRequest.dicRequest.put("Amount", request.getParameter("Amount"));    //设定交易金额 （必要信息）
        tRequest.dicRequest.put("ReceiverAddress", request.getParameter("ReceiverAddress")); //设定手续费金额
        tRequest.dicRequest.put("Fee", request.getParameter("Fee")); //设定手续费金额
        tRequest.dicRequest.put("CertificateNo", request.getParameter("CertificateNo"));             //证件号码
        tRequest.dicRequest.put("InstallmentMark", request.getParameter("InstallmentMark"));  //分期标识（必要信息）
        if (request.getParameter("InstallmentMark").toString().equals("1"))
        {
            tRequest.dicRequest.put("InstallmentCode", request.getParameter("InstallmentCode"));    //设定分期代码
            tRequest.dicRequest.put("InstallmentNum", request.getParameter("InstallmentNum"));    //设定分期期数
        }
        tRequest.dicRequest.put("CommodityType", request.getParameter("CommodityType"));   //设置商品种类 （必要信息）
        tRequest.dicRequest.put("PaymentLinkType", request.getParameter("PaymentLinkType"));      //设定支付接入方式 （必要信息）
        tRequest.dicRequest.put("BuyIP", request.getParameter("BuyIP")); 
        tRequest.dicRequest.put("ExpiredDate", request.getParameter("ExpiredDate"));//设定订单保存时间
        tRequest.dicRequest.put("ReceiveAccount", request.getParameter("ReceiveAccount"));    //设定收款方账号
        tRequest.dicRequest.put("ReceiveAccName", request.getParameter("ReceiveAccName"));    //设定收款方户名
        tRequest.dicRequest.put("MerchantRemarks", request.getParameter("MerchantRemarks"));    //设定附言
        tRequest.dicRequest.put("IsBreakAccount", request.getParameter("IsBreakAccount"));    //设定交易是否分账
        tRequest.dicRequest.put("SplitAccTemplate", request.getParameter("SplitAccTemplate"));      //分账模版编号

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
		tRequest.orderitems.put(1, orderitem);
		
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
		tRequest.orderitems.put(2, orderitem);

        //3、传送单笔授权扣款请求
        JSON json = tRequest.postRequest();

		String ReturnCode = json.GetKeyValue("ReturnCode");
		String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //4、单笔授权扣款请求提交成功
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
			out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
            out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
            out.println("TrxType      = [" + json.GetKeyValue("TrxType") + "]<br/>");
        }
        else
        {
            //5、单笔授权扣款请求提交失败，商户自定后续动作
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
        }

%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>