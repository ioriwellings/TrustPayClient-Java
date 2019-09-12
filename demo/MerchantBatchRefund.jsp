<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%@ page import = "java.math.BigDecimal" %>
<%response.setHeader("Cache-Control", "no-cache"); 
request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-�����˿�</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>�����˿�<br>
<%   
        StringBuilder strMessage = new StringBuilder("");
        //��֤������Ϣ��ȡ���˿�����Ҫ����Ϣ
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

        //1�����������˿��������
        BatchRefundRequest tBatchRefundRequest = new BatchRefundRequest();
        //ȡ����ϸ�� 
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
            //�˴�����ʹ��BigDecimal������ᶪ����            
            BigDecimal bd = new BigDecimal(orderamount_arr[i].toString());
			sum = sum.add(bd);
        }
        //�˴������趨iSumAmount����
        tBatchRefundRequest.iSumAmount = sum.doubleValue();

        tBatchRefundRequest.batchRefundRequest.put("BatchNo",request.getParameter("txtBatchNo")); //�������  ����Ҫ��Ϣ��
        tBatchRefundRequest.batchRefundRequest.put("BatchDate",request.getParameter("txtBatchDate"));  //��������  ����Ҫ��Ϣ��
        tBatchRefundRequest.batchRefundRequest.put("BatchTime",request.getParameter("txtBatchTime")); //����ʱ��  ����Ҫ��Ϣ��
        tBatchRefundRequest.batchRefundRequest.put("MerRefundAccountNo",request.getParameter("txtMerRefundAccountNo"));  //�̻��˿��˺�
        tBatchRefundRequest.batchRefundRequest.put("MerRefundAccountName",request.getParameter("txtMerRefundAccountName")); //�̻��˿���
        tBatchRefundRequest.batchRefundRequest.put("TotalCount",request.getParameter("TotalCount"));  //�ܱ���  ����Ҫ��Ϣ��
        tBatchRefundRequest.batchRefundRequest.put("TotalAmount",request.getParameter("TotalAmount"));  //�ܽ�� ����Ҫ��Ϣ��

        //2�����������˿�����ȡ�ý��
        JSON json = tBatchRefundRequest.postRequest();

        //3���ж������˿���״̬�����к�������
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //4�������˿�ɹ�
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
            //5�������˿�ʧ��
			out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ResultMessage   = [" + ErrorMessage + "]<br/>");
        }
%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>