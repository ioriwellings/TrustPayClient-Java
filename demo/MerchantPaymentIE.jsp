<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Cache-Control", "no-cache");
%>
<%
//1�����ɶ�������
PaymentRequest tPaymentRequest = new PaymentRequest();
tPaymentRequest.dicOrder.put("PayTypeID", request.getParameter("PayTypeID"));                   //�趨��������
tPaymentRequest.dicOrder.put("OrderDate", request.getParameter("OrderDate") );                  //�趨�������� ����Ҫ��Ϣ - YYYY/MM/DD��
tPaymentRequest.dicOrder.put("OrderTime", request.getParameter("OrderTime"));                   //�趨����ʱ�� ����Ҫ��Ϣ - HH:MM:SS��
tPaymentRequest.dicOrder.put("orderTimeoutDate", request.getParameter("orderTimeoutDate"));     //�趨������Ч��
tPaymentRequest.dicOrder.put("OrderNo", request.getParameter("OrderNo"));                       //�趨������� ����Ҫ��Ϣ��
tPaymentRequest.dicOrder.put("CurrencyCode", request.getParameter("CurrencyCode"));             //�趨���ױ���
tPaymentRequest.dicOrder.put("OrderAmount", request.getParameter("PaymentRequestAmount"));      //�趨���׽��
tPaymentRequest.dicOrder.put("Fee", request.getParameter("Fee"));                               //�趨�����ѽ��
tPaymentRequest.dicOrder.put("AccountNo", request.getParameter("AccountNo"));                   //�趨֧���˻�
tPaymentRequest.dicOrder.put("OrderDesc", request.getParameter("OrderDesc"));                   //�趨����˵��
tPaymentRequest.dicOrder.put("OrderURL", request.getParameter("OrderURL"));                     //�趨������ַ
tPaymentRequest.dicOrder.put("ReceiverAddress", request.getParameter("ReceiverAddress"));       //�ջ���ַ
tPaymentRequest.dicOrder.put("InstallmentMark", request.getParameter("InstallmentMark"));       //���ڱ�ʶ
if (request.getParameter("InstallmentMark") == "1" && request.getParameter("PayTypeID") == "DividedPay")
{
    tPaymentRequest.dicOrder.put("InstallmentCode", request.getParameter("InstallmentCode"));   //�趨���ڴ���
    tPaymentRequest.dicOrder.put("InstallmentNum", request.getParameter("InstallmentNum"));     //�趨��������
}
tPaymentRequest.dicOrder.put("CommodityType", request.getParameter("CommodityType"));           //������Ʒ����
tPaymentRequest.dicOrder.put("BuyIP", request.getParameter("BuyIP"));                           //IP
tPaymentRequest.dicOrder.put("ExpiredDate", request.getParameter("ExpiredDate"));               //�趨��������ʱ��

//2��������ϸ
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
tPaymentRequest.orderitems.put(1, orderitem);

orderitem = new LinkedHashMap();
orderitem.put("SubMerName", "���Զ����̻�1");    //�趨�����̻�����
orderitem.put("SubMerId", "12345");    //�趨�����̻�����
orderitem.put("SubMerMCC", "0000");   //�趨�����̻�MCC�� 
orderitem.put("SubMerchantRemarks", "����");   //�����̻���ע��
orderitem.put("ProductID", "IP000001");//��Ʒ���룬Ԥ���ֶ�
orderitem.put("ProductName", "�й��ƶ�IP��");//��Ʒ����
orderitem.put("UnitPrice", "1.00");//��Ʒ�ܼ�
orderitem.put("Qty", "2");//��Ʒ����
orderitem.put("ProductRemarks", "������Ʒ"); //��Ʒ��ע��
orderitem.put("ProductType", "��ֵ��");//��Ʒ����
orderitem.put("ProductDiscount", "0.9");//��Ʒ�ۿ�
orderitem.put("ProductExpiredDate", "10");//��Ʒ��Ч��
tPaymentRequest.orderitems.put(2, orderitem);

 //3������֧���������
String paymentType = request.getParameter("PaymentType");
tPaymentRequest.dicRequest.put("PaymentType", paymentType);            //�趨֧������
String paymentLinkType  = request.getParameter("PaymentLinkType");                                         
tPaymentRequest.dicRequest.put("PaymentLinkType", paymentLinkType);    //�趨֧�����뷽ʽ
if (paymentType.equals(Constants.PAY_TYPE_UCBP) && paymentLinkType.equals(Constants.PAY_LINK_TYPE_MOBILE))
{
    tPaymentRequest.dicRequest.put("UnionPayLinkType",request.getParameter("UnionPayLinkType"));  //��֧������Ϊ6��֧�����뷽ʽΪ2����������ʱ����Ҫ�������������ƶ�֧�����뷽ʽ
}
tPaymentRequest.dicRequest.put("ReceiveAccount", request.getParameter("ReceiveAccount"));    //�趨�տ�˺�
tPaymentRequest.dicRequest.put("ReceiveAccName", request.getParameter("ReceiveAccName"));    //�趨�տ����
tPaymentRequest.dicRequest.put("NotifyType", request.getParameter("NotifyType"));    //�趨֪ͨ��ʽ
tPaymentRequest.dicRequest.put("ResultNotifyURL", request.getParameter("ResultNotifyURL"));    //�趨֪ͨURL��ַ
tPaymentRequest.dicRequest.put("MerchantRemarks", request.getParameter("MerchantRemarks"));    //�趨����
tPaymentRequest.dicRequest.put("IsBreakAccount", request.getParameter("IsBreakAccount"));    //�趨�����Ƿ����
tPaymentRequest.dicRequest.put("SplitAccTemplate", request.getParameter("SplitAccTemplate"));      //����ģ����        


MerchantPara para = MerchantConfig.getUniqueInstance().getPara();
String sTrustPayIETrxURL=para.getTrustPayTrxIEURL();
String sErrorUrl=para.getMerchantErrorURL();
String tSignature="";
try{
	tSignature = tPaymentRequest.genSignature(1);
	}catch (TrxException e){    
	       request.setAttribute("tReturnCode", e.getCode());
	       request.setAttribute("tErrorMsg", e.getMessage());
	       request.getRequestDispatcher("/ErrorPageInternal.jsp").forward(request, response);
	       return; 
	}
%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-֧������</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>֧������<br>
<form name="form1" method="post" action="<%=sTrustPayIETrxURL%>">
<input type="hidden" name="MSG" value="<%=tSignature%>">
<input type="hidden" name="errorPage" value="<%=sErrorUrl%>">
<TR><TD colspan=2><INPUT type=submit value="�ύ">
</form>
</BODY></HTML>