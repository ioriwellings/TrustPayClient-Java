<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%	response.setHeader("Cache-Control", "no-cache"); 
	request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-�˵�����</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>�˵�����<br>
<%
        //1������֧���������
        QuickPaymentRequest tPaymentRequest = new QuickPaymentRequest();

        //1�����ɶ����������󣬲���������ϸ���붨����
        tPaymentRequest.dicOrder.put("PayTypeID", request.getParameter("txtPayTypeID"));    //�趨��������
        tPaymentRequest.dicOrder.put("orderTimeoutDate", request.getParameter("txtorderTimeoutDate"));                     //�趨������Ч��
        tPaymentRequest.dicOrder.put("OrderNo", request.getParameter("txtPaymentRequestNo"));                       //�趨������� ����Ҫ��Ϣ��
        tPaymentRequest.dicOrder.put("CurrencyCode", request.getParameter("txtCurrencyCode"));    //�趨���ױ���
        tPaymentRequest.dicOrder.put("OrderAmount", request.getParameter("txtPaymentRequestAmount"));    //�趨���׽��

        tPaymentRequest.dicOrder.put("ExpiredDate", request.getParameter("txtExpiredDate"));//�趨��������ʱ��
        tPaymentRequest.dicOrder.put("OrderDesc", request.getParameter("txtOrderDesc"));                   //�趨����˵��
        tPaymentRequest.dicOrder.put("OrderDate", request.getParameter("txtOrderDate"));                   //�趨�������� ����Ҫ��Ϣ - YYYY/MM/DD��
        tPaymentRequest.dicOrder.put("OrderTime", request.getParameter("txtOrderTime"));                   //�趨����ʱ�� ����Ҫ��Ϣ - HH:MM:SS��
        tPaymentRequest.dicOrder.put("ReceiverAddress", request.getParameter("txtReceiverAddress"));     //�ջ���ַ
        //tPaymentRequest.dicOrder.put("OrderURL", request.getParameter("txtOrderURL"));                     //�趨������ַ

        //tPaymentRequest.dicOrder.put("Fee", request.getParameter("txtFee")); //�趨�����ѽ��
        tPaymentRequest.dicOrder.put("BuyIP", request.getParameter("txtBuyIP"));                           //IP
        LinkedHashMap<String, String> orderitem = new LinkedHashMap<String, String>();
        orderitem.put("SubMerName","���Զ����̻�1");    //�趨�����̻�����
        orderitem.put("SubMerId","12345");    //�趨�����̻�����
        orderitem.put("SubMerMCC","0000");   //�趨�����̻�MCC�� 
        orderitem.put("SubMerchantRemarks","����");   //�����̻���ע��
        orderitem.put("ProductID","IP000001");//��Ʒ���룬Ԥ���ֶ�
        orderitem.put("ProductName","�й��ƶ�IP��");//��Ʒ����
        orderitem.put("UnitPrice","1.00");//��Ʒ�ܼ�
        orderitem.put("Qty","1");//��Ʒ����
        orderitem.put("ProductRemarks","������Ʒ"); //��Ʒ��ע��
        orderitem.put("ProductType","��ֵ��");//��Ʒ����
        orderitem.put("ProductDiscount","0.9");//��Ʒ�ۿ�
        orderitem.put("ProductExpiredDate","10");//��Ʒ��Ч��
        tPaymentRequest.orderitems.put(1, orderitem);

        orderitem = new LinkedHashMap<String, String>();
        orderitem.put("SubMerName","���Զ����̻�2");    //�趨�����̻�����
        orderitem.put("SubMerId","12345");    //�趨�����̻�����
        orderitem.put("SubMerMCC","0000");   //�趨�����̻�MCC�� 
        orderitem.put("SubMerchantRemarks","����");   //�����̻���ע��
        orderitem.put("ProductID","IP000001");//��Ʒ���룬Ԥ���ֶ�
        orderitem.put("ProductName","�й��ƶ�IP��");//��Ʒ����
        orderitem.put("UnitPrice","1.00");//��Ʒ�ܼ�
        orderitem.put("Qty","2");//��Ʒ����
        orderitem.put("ProductRemarks","������Ʒ"); //��Ʒ��ע��
        orderitem.put("ProductType","��ֵ��");//��Ʒ����
        orderitem.put("ProductDiscount","0.9");//��Ʒ�ۿ�
        orderitem.put("ProductExpiredDate","10");//��Ʒ��Ч��
        tPaymentRequest.orderitems.put(2, orderitem);
        //2������֧���������
        tPaymentRequest.dicRequest.put("CardNo", request.getParameter("txtPaymentAcctNo")); //֧���˻�
        tPaymentRequest.dicRequest.put("MobileNo", request.getParameter("txtMobilePhone"));//�ֻ��ź���λ
        tPaymentRequest.dicRequest.put("CommodityType", request.getParameter("txtCommodityType"));   //������Ʒ����
        tPaymentRequest.dicRequest.put("Installment", request.getParameter("txtInstallment"));  //���ڱ�ʶ
        if (request.getParameter("txtInstallment").toString().equals("1"))
        {
            tPaymentRequest.dicRequest.put("ProjectID", request.getParameter("txtProjectID"));    //�趨���ڴ���
            tPaymentRequest.dicRequest.put("Period", request.getParameter("txtPeriod"));    //�趨��������
        }
        tPaymentRequest.dicRequest.put("PaymentType", request.getParameter("txtPaymentType"));          //�趨֧������
        tPaymentRequest.dicRequest.put("PaymentLinkType", request.getParameter("txtPaymentLinkType"));      //�趨֧�����뷽ʽ
        tPaymentRequest.dicRequest.put("ReceiveAccount", request.getParameter("txtReceiveAccount"));    //�趨�տ�˺�
        tPaymentRequest.dicRequest.put("ReceiveAccName", request.getParameter("txtReceiveAccName"));    //�趨�տ����
        tPaymentRequest.dicRequest.put("MerchantRemarks", request.getParameter("txtMerchantRemarks"));    //�趨����
        tPaymentRequest.dicRequest.put("IsBreakAccount", request.getParameter("txtIsBreakAccount"));    //�趨�����Ƿ����
        tPaymentRequest.dicRequest.put("SplitAccTemplate", request.getParameter("txtSplitAccTemplate"));      //����ģ����

        //3������֧������
        JSON json = tPaymentRequest.postRequest();
                
        //���̻�
        //com.abc.trustpay.client.JSON tTrxResponse = tPaymentRequest.extendPostJSONRequest(1);
        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //4��֧�������ύ�ɹ����̻��Զ���������
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
            //5������ͻ�δǩԼ����ת��ǩԼҳ��
            String PaymentURL = json.GetKeyValue("PaymentURL");
            response.sendRedirect(PaymentURL);
        }
        else
        {
            //6��֧�������ύʧ�ܣ��̻��Զ���������
            out.println("ReturnCode   = [" + ReturnCode + "]<br>");
			out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
		}

%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>