<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%@ page import = "java.math.BigDecimal" %>
<%response.setHeader("Cache-Control", "no-cache"); 
request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-单笔退款</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>批量退款<br>
<%   
        StringBuilder strMessage = new StringBuilder("");
        //验证输入信息并取得退款所需要的信息
        String totalCount =  request.getParameter("TotalCount");
         
        String[]orderno_arr = null;
        String[]neworderno_arr = null;
        String[]currencycode_arr = null;
        String[]orderamount_arr = null;
        String[]remark_arr = null;
         
        int batchSize = Integer.parseInt(totalCount);
        if(batchSize == 1){
	         String orderno = request.getParameter("txtOrderNo");
	         String neworderno = request.getParameter("txtNewOrderNo");
	         String currencycode = request.getParameter("txtCurrencyCode");
	         String orderamount = request.getParameter("txtRefundAmount");
	         String remark = request.getParameter("txtRemark");
         	 orderno_arr = new String[] { orderno };
         	 neworderno_arr = new String[] { neworderno };
         	 currencycode_arr = new String[] { currencycode };
         	 orderamount_arr = new String[] { orderamount };
         	 remark_arr = new String[] { remark };
        }
        else {
         	orderno_arr = request.getParameterValues("txtOrderNo");
         	neworderno_arr = request.getParameterValues("txtNewOrderNo");
         	currencycode_arr = request.getParameterValues("txtCurrencyCode");
         	orderamount_arr = request.getParameterValues("txtRefundAmount");
         	remark_arr = request.getParameterValues("txtRemark");
        }

        //1、生成批量退款请求对象
        BatchRefundRequest tBatchRefundRequest = new BatchRefundRequest();
        //取得明细项 
        LinkedHashMap map = null;   
        BigDecimal sum = BigDecimal.ZERO;    
        for (int i = 0; i < orderno_arr.length; i++)
        {
            map = new LinkedHashMap();
            map.put("SeqNo", String.valueOf(i + 1));
            map.put("OrderNo",orderno_arr[i]);
            map.put("NewOrderNo",neworderno_arr[i]);
            map.put("CurrencyCode",currencycode_arr[i]);
            map.put("RefundAmount",orderamount_arr[i]);
            map.put("Remark",remark_arr[i]);
            tBatchRefundRequest.dic.put(i+1, map);
            //此处必须使用BigDecimal，否则会丢精度            
            BigDecimal bd = new BigDecimal(orderamount_arr[i].toString());
			sum = sum.add(bd);
        }
        //此处必须设定iSumAmount属性
        tBatchRefundRequest.iSumAmount = sum.doubleValue();

        tBatchRefundRequest.batchRefundRequest.put("BatchNo",request.getParameter("txtBatchNo")); //批量编号  （必要信息）
        tBatchRefundRequest.batchRefundRequest.put("BatchDate",request.getParameter("txtBatchDate"));  //订单日期  （必要信息）
        tBatchRefundRequest.batchRefundRequest.put("BatchTime",request.getParameter("txtBatchTime")); //订单时间  （必要信息）
        tBatchRefundRequest.batchRefundRequest.put("MerRefundAccountNo",request.getParameter("txtMerRefundAccountNo"));  //商户退款账号
        tBatchRefundRequest.batchRefundRequest.put("MerRefundAccountName",request.getParameter("txtMerRefundAccountName")); //商户退款名
        tBatchRefundRequest.batchRefundRequest.put("TotalCount",request.getParameter("TotalCount"));  //总笔数  （必要信息）
        tBatchRefundRequest.batchRefundRequest.put("TotalAmount",request.getParameter("TotalAmount"));  //总金额 （必要信息）

        //2、传送批量退款请求并取得结果
        JSON json = tBatchRefundRequest.postRequest();

        //3、判断批量退款结果状态，进行后续操作
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //4、批量退款成功
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ResultMessage   = [" + ErrorMessage + "]<br/>");
            out.println("TrxType   = [" + json.GetKeyValue("TrxType") + "]<br/>");
            out.println("TotalCount  = [" + json.GetKeyValue("TotalCount") + "]<br/>");
            out.println("TotalAmount = [" + json.GetKeyValue("TotalAmount") + "]<br/>");
            out.println("SerialNumber  = [" + json.GetKeyValue("SerialNumber") + "]<br/>");
            out.println("HostDate  = [" + json.GetKeyValue("HostDate") + "]<br/>");
            out.println("HostTime  = [" + json.GetKeyValue("HostTime") + "]<br/>");
        }
        else
        {
            //5、批量退款失败
			out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ResultMessage   = [" + ErrorMessage + "]<br/>");
        }
%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>