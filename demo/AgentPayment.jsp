<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-������Ȩ�ۿ�����</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>������Ȩ�ۿ�����<br>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Cache-Control", "no-cache");
%>
<%
        //1�����ɵ�����Ȩ�ۿ��������
        AgentPaymentRequest tRequest = new AgentPaymentRequest();
        //2�����ɶ����������󣬲���������ϸ���붨����
        tRequest.dicRequest.put("OrderDate", request.getParameter("OrderDate"));                   //�趨�������� ����Ҫ��Ϣ - YYYY/MM/DD��
        tRequest.dicRequest.put("OrderTime", request.getParameter("OrderTime"));                   //�趨����ʱ�� ����Ҫ��Ϣ - HH:MM:SS��
        tRequest.dicRequest.put("OrderNo", request.getParameter("OrderNo"));                       //�趨������� ����Ҫ��Ϣ��
        tRequest.dicRequest.put("AgentSignNo", request.getParameter("AgentSignNo"));                       //�趨��Ȩ֧��Э��� ����Ҫ��Ϣ��
        tRequest.dicRequest.put("CardNo", request.getParameter("CardNo"));                       //�趨�˺�
        tRequest.dicRequest.put("CurrencyCode", request.getParameter("CurrencyCode"));    //�趨���ױ��� ����Ҫ��Ϣ��
        tRequest.dicRequest.put("Amount", request.getParameter("Amount"));    //�趨���׽�� ����Ҫ��Ϣ��
        tRequest.dicRequest.put("ReceiverAddress", request.getParameter("ReceiverAddress")); //�趨�����ѽ��
        tRequest.dicRequest.put("Fee", request.getParameter("Fee")); //�趨�����ѽ��
        tRequest.dicRequest.put("CertificateNo", request.getParameter("CertificateNo"));             //֤������
        tRequest.dicRequest.put("InstallmentMark", request.getParameter("InstallmentMark"));  //���ڱ�ʶ����Ҫ��Ϣ��
        if (request.getParameter("InstallmentMark").toString().equals("1"))
        {
            tRequest.dicRequest.put("InstallmentCode", request.getParameter("InstallmentCode"));    //�趨���ڴ���
            tRequest.dicRequest.put("InstallmentNum", request.getParameter("InstallmentNum"));    //�趨��������
        }
        tRequest.dicRequest.put("CommodityType", request.getParameter("CommodityType"));   //������Ʒ���� ����Ҫ��Ϣ��
        tRequest.dicRequest.put("PaymentLinkType", request.getParameter("PaymentLinkType"));      //�趨֧�����뷽ʽ ����Ҫ��Ϣ��
        tRequest.dicRequest.put("BuyIP", request.getParameter("BuyIP")); 
        tRequest.dicRequest.put("ExpiredDate", request.getParameter("ExpiredDate"));//�趨��������ʱ��
        tRequest.dicRequest.put("ReceiveAccount", request.getParameter("ReceiveAccount"));    //�趨�տ�˺�
        tRequest.dicRequest.put("ReceiveAccName", request.getParameter("ReceiveAccName"));    //�趨�տ����
        tRequest.dicRequest.put("MerchantRemarks", request.getParameter("MerchantRemarks"));    //�趨����
        tRequest.dicRequest.put("IsBreakAccount", request.getParameter("IsBreakAccount"));    //�趨�����Ƿ����
        tRequest.dicRequest.put("SplitAccTemplate", request.getParameter("SplitAccTemplate"));      //����ģ����

        LinkedHashMap orderitem = new LinkedHashMap();
		orderitem.put("SubMerName", "���Զ����̻�1");    //�趨�����̻�����
		orderitem.put("SubMerId", "12345");    //�趨�����̻�����
		orderitem.put("SubMerMCC", "0000");   //�趨�����̻�MCC�� 
		orderitem.put("SubMerchantRemarks", "����");   //�����̻���ע��
		orderitem.put("ProductID", "IP000001");//��Ʒ���룬Ԥ���ֶ�
		orderitem.put("ProductName", "�й��ƶ�IP��");//��Ʒ����
		orderitem.put("UnitPrice", "1.00");//��Ʒ�ܼ�
		orderitem.put("Qty", "1");//��Ʒ����
		orderitem.put("ProductRemarks", "������Ʒ"); //��Ʒ��ע��
		orderitem.put("ProductType", "��ֵ��");//��Ʒ����
		orderitem.put("ProductDiscount", "0.9");//��Ʒ�ۿ�
		orderitem.put("ProductExpiredDate", "10");//��Ʒ��Ч��
		tRequest.orderitems.put(1, orderitem);
		
		orderitem = new LinkedHashMap();
		orderitem.put("SubMerName", "���Զ����̻�1");    //�趨�����̻�����
		orderitem.put("SubMerId", "12345");    //�趨�����̻�����
		orderitem.put("SubMerMCC", "0000");   //�趨�����̻�MCC�� 
		orderitem.put("SubMerchantRemarks", "����");   //�����̻���ע��
		orderitem.put("ProductID", "IP000001");//��Ʒ���룬Ԥ���ֶ�
		orderitem.put("ProductName", "�й���ͨIP��");//��Ʒ����
		orderitem.put("UnitPrice", "1.00");//��Ʒ�ܼ�
		orderitem.put("Qty", "2");//��Ʒ����
		orderitem.put("ProductRemarks", "������Ʒ"); //��Ʒ��ע��
		orderitem.put("ProductType", "��ֵ��");//��Ʒ����
		orderitem.put("ProductDiscount", "0.9");//��Ʒ�ۿ�
		orderitem.put("ProductExpiredDate", "10");//��Ʒ��Ч��
		tRequest.orderitems.put(2, orderitem);

        //3�����͵�����Ȩ�ۿ�����
        JSON json = tRequest.postRequest();

		String ReturnCode = json.GetKeyValue("ReturnCode");
		String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //4��������Ȩ�ۿ������ύ�ɹ�
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
			out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
            out.println("OrderNo      = [" + json.GetKeyValue("OrderNo") + "]<br/>");
            out.println("TrxType      = [" + json.GetKeyValue("TrxType") + "]<br/>");
        }
        else
        {
            //5��������Ȩ�ۿ������ύʧ�ܣ��̻��Զ���������
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
        }

%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY></HTML>