<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%	response.setHeader("Cache-Control", "no-cache"); 
	request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-账单发送</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>账单发送<br>
<%
        //1、生成支付请求对象
        QuickPaymentRequest tPaymentRequest = new QuickPaymentRequest();

        //1、生成定单订单对象，并将订单明细加入定单中
        tPaymentRequest.dicOrder.put("PayTypeID", request.getParameter("txtPayTypeID"));    //设定交易类型
        tPaymentRequest.dicOrder.put("orderTimeoutDate", request.getParameter("txtorderTimeoutDate"));                     //设定订单有效期
        tPaymentRequest.dicOrder.put("OrderNo", request.getParameter("txtPaymentRequestNo"));                       //设定订单编号 （必要信息）
        tPaymentRequest.dicOrder.put("CurrencyCode", request.getParameter("txtCurrencyCode"));    //设定交易币种
        tPaymentRequest.dicOrder.put("OrderAmount", request.getParameter("txtPaymentRequestAmount"));    //设定交易金额

        tPaymentRequest.dicOrder.put("ExpiredDate", request.getParameter("txtExpiredDate"));//设定订单保存时间
        tPaymentRequest.dicOrder.put("OrderDesc", request.getParameter("txtOrderDesc"));                   //设定订单说明
        tPaymentRequest.dicOrder.put("OrderDate", request.getParameter("txtOrderDate"));                   //设定订单日期 （必要信息 - YYYY/MM/DD）
        tPaymentRequest.dicOrder.put("OrderTime", request.getParameter("txtOrderTime"));                   //设定订单时间 （必要信息 - HH:MM:SS）
        tPaymentRequest.dicOrder.put("ReceiverAddress", request.getParameter("txtReceiverAddress"));     //收货地址
        //tPaymentRequest.dicOrder.put("OrderURL", request.getParameter("txtOrderURL"));                     //设定订单网址

        //tPaymentRequest.dicOrder.put("Fee", request.getParameter("txtFee")); //设定手续费金额
        tPaymentRequest.dicOrder.put("BuyIP", request.getParameter("txtBuyIP"));                           //IP
        LinkedHashMap<String, String> orderitem = new LinkedHashMap<String, String>();
        orderitem.put("SubMerName","测试二级商户1");    //设定二级商户名称
        orderitem.put("SubMerId","12345");    //设定二级商户代码
        orderitem.put("SubMerMCC","0000");   //设定二级商户MCC码 
        orderitem.put("SubMerchantRemarks","测试");   //二级商户备注项
        orderitem.put("ProductID","IP000001");//商品代码，预留字段
        orderitem.put("ProductName","中国移动IP卡");//商品名称
        orderitem.put("UnitPrice","1.00");//商品总价
        orderitem.put("Qty","1");//商品数量
        orderitem.put("ProductRemarks","测试商品"); //商品备注项
        orderitem.put("ProductType","充值类");//商品类型
        orderitem.put("ProductDiscount","0.9");//商品折扣
        orderitem.put("ProductExpiredDate","10");//商品有效期
        tPaymentRequest.orderitems.put(1, orderitem);

        orderitem = new LinkedHashMap<String, String>();
        orderitem.put("SubMerName","测试二级商户2");    //设定二级商户名称
        orderitem.put("SubMerId","12345");    //设定二级商户代码
        orderitem.put("SubMerMCC","0000");   //设定二级商户MCC码 
        orderitem.put("SubMerchantRemarks","测试");   //二级商户备注项
        orderitem.put("ProductID","IP000001");//商品代码，预留字段
        orderitem.put("ProductName","中国移动IP卡");//商品名称
        orderitem.put("UnitPrice","1.00");//商品总价
        orderitem.put("Qty","2");//商品数量
        orderitem.put("ProductRemarks","测试商品"); //商品备注项
        orderitem.put("ProductType","充值类");//商品类型
        orderitem.put("ProductDiscount","0.9");//商品折扣
        orderitem.put("ProductExpiredDate","10");//商品有效期
        tPaymentRequest.orderitems.put(2, orderitem);
        //2、生成支付请求对象
        tPaymentRequest.dicRequest.put("CardNo", request.getParameter("txtPaymentAcctNo")); //支付账户
        tPaymentRequest.dicRequest.put("MobileNo", request.getParameter("txtMobilePhone"));//手机号后四位
        tPaymentRequest.dicRequest.put("CommodityType", request.getParameter("txtCommodityType"));   //设置商品种类
        tPaymentRequest.dicRequest.put("Installment", request.getParameter("txtInstallment"));  //分期标识
        if (request.getParameter("txtInstallment").toString().equals("1"))
        {
            tPaymentRequest.dicRequest.put("ProjectID", request.getParameter("txtProjectID"));    //设定分期代码
            tPaymentRequest.dicRequest.put("Period", request.getParameter("txtPeriod"));    //设定分期期数
        }
        tPaymentRequest.dicRequest.put("PaymentType", request.getParameter("txtPaymentType"));          //设定支付类型
        tPaymentRequest.dicRequest.put("PaymentLinkType", request.getParameter("txtPaymentLinkType"));      //设定支付接入方式
        tPaymentRequest.dicRequest.put("ReceiveAccount", request.getParameter("txtReceiveAccount"));    //设定收款方账号
        tPaymentRequest.dicRequest.put("ReceiveAccName", request.getParameter("txtReceiveAccName"));    //设定收款方户名
        tPaymentRequest.dicRequest.put("MerchantRemarks", request.getParameter("txtMerchantRemarks"));    //设定附言
        tPaymentRequest.dicRequest.put("IsBreakAccount", request.getParameter("txtIsBreakAccount"));    //设定交易是否分账
        tPaymentRequest.dicRequest.put("SplitAccTemplate", request.getParameter("txtSplitAccTemplate"));      //分账模版编号

        //3、传送支付请求
        JSON json = tPaymentRequest.postRequest();
                
        //多商户
        //com.abc.trustpay.client.JSON tTrxResponse = tPaymentRequest.extendPostJSONRequest(1);
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //4、支付请求提交成功，商户自定后续动作
            //strMessage.append("ECMerchantType   = [" + json.GetKeyValue("ECMerchantType") + "]<br/>");
            out.println("MerchantID = [" + json.GetKeyValue("MerchantID") + "]<br/>");
            out.println("TrxType = [" + json.GetKeyValue("TrxType") + "]<br/>");
            out.println("OrderNo = [" + json.GetKeyValue("OrderNo") + "]<br/>");
            out.println("Amount = [" + json.GetKeyValue("OrderAmount") + "]<br/>");
            out.println("VerifyDate = [" + json.GetKeyValue("VerifyDate") + "]<br/>");
            out.println("VerifyTime = [" + json.GetKeyValue("VerifyTime") + "]<br/>");
        }
        else if (ReturnCode.equals("AP5095"))
        {
            //5、如果客户未签约，跳转到签约页面
            String PaymentURL = json.GetKeyValue("PaymentURL");
            response.sendRedirect(PaymentURL);
        }
        else
        {
            //6、支付请求提交失败，商户自定后续动作
            out.println("ReturnCode   = [" + ReturnCode + "]<br>");
			out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
		}

%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>