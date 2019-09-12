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
UnifiedPaymentRequest tPaymentRequest = new UnifiedPaymentRequest();
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
orderitem.put("ProductName", "�й���ͨIP��");//��Ʒ����
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
//if (paymentType.equals(Constants.PAY_TYPE_UCBP) && paymentLinkType.equals(Constants.PAY_LINK_TYPE_MOBILE))
//{
    //tPaymentRequest.dicRequest.put("UnionPayLinkType",request.getParameter("UnionPayLinkType"));  //��֧������Ϊ6��֧�����뷽ʽΪ2����������ʱ����Ҫ�������������ƶ�֧�����뷽ʽ
//}
tPaymentRequest.dicRequest.put("ReceiveAccount", request.getParameter("ReceiveAccount"));      //�趨�տ�˺�
tPaymentRequest.dicRequest.put("ReceiveAccName", request.getParameter("ReceiveAccName"));      //�趨�տ����
//tPaymentRequest.dicRequest.put("NotifyType", request.getParameter("NotifyType"));              //�趨֪ͨ��ʽ
//tPaymentRequest.dicRequest.put("ResultNotifyURL", request.getParameter("ResultNotifyURL"));    //�趨֪ͨURL��ַ
tPaymentRequest.dicRequest.put("MerchantRemarks", request.getParameter("MerchantRemarks"));    //�趨����
tPaymentRequest.dicRequest.put("IsBreakAccount", request.getParameter("IsBreakAccount"));      //�趨�����Ƿ����
tPaymentRequest.dicRequest.put("SplitAccTemplate", request.getParameter("SplitAccTemplate"));  //����ģ����        


System.out.println(tPaymentRequest.dicRequest.get("PaymentLinkType"));
JSON json = tPaymentRequest.postRequest();
//JSON json = tPaymentRequest.extendPostRequest(1);

String ReturnCode = json.GetKeyValue("ReturnCode");
String ErrorMessage = json.GetKeyValue("ErrorMessage");
if (ReturnCode.equals("0000"))
{
	out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
	out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
	out.println("MerchantID = [" + json.GetKeyValue("MerchantID")+ "]<br/>");
	out.println("TrxType = [" + json.GetKeyValue("TrxType")+ "]<br/>");
	out.println("OrderNo = [" + json.GetKeyValue("OrderNo")+ "]<br/>");
	out.println("OrderAmount = [" + json.GetKeyValue("OrderAmount")+ "]<br/>");
	out.println("QRURL = [" + json.GetKeyValue("QRURL")+ "]<br/>");
	out.println("PaymentURL = [" + json.GetKeyValue("PaymentURL")+ "]<br/>");
	out.println("HostDate = [" + json.GetKeyValue("HostDate")+ "]<br/>");
	out.println("HostTime = [" + json.GetKeyValue("HostTime")+ "]<br/>");
}
else
{
out.println("ReturnCode   = [" + ReturnCode + "]<br>");
out.println("ErrorMessage = [" + ErrorMessage + "]<br>");
}
%>


<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-֧������</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/qrcode.min.js"></script>

</HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<script type="text/javascript">
var qrcode = new QRCode(document.getElementById("qrcode"), {
	width : 100,
	height : 100
});

function makeCode () {		
	var elText = document.getElementById("text");
	
	if (!elText.value) {
		alert("Input a text");
		elText.focus();
		return;
	}
	
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
<CENTER>֧������<br>

<input id="text" type="text" value="<%=json.GetKeyValue("QRURL") %>" style="width:80%" /><br />
<div id="qrcode" style="width:100px; height:100px; margin-top:15px;"></div>

<a href='Merchant.html'>���̻���ҳ</a></CENTER>

</body>
</html>