<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.ebpp.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "javax.servlet.ServletOutputStream" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Random" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<%
request.setCharacterEncoding("GB2312");
//ȡ��MSG�����������ô˲���ֵ���ɲ�ѯ�������
String tMSG = request.getParameter("MSG");
System.out.println("��ѯ������[" + tMSG + "]");
SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMddHHmmss");//�������ڸ�ʽ
System.out.println("��ǰʱ��"+df1.format(new Date()));
if (tMSG != null && !tMSG.equals("")) {		  
	System.out.println("��ѯ��Ϣ������...1");
	XMLDocument tResult = new XMLDocument(tMSG);
	System.out.println("��ѯ��Ϣ������...2");
	String tBase64Message = "";
	if (tResult.getValueNoNull("MessageType").equals(IPaymentMerchant.MESSAGETYPE_QREQ)) {
		System.out.println("��ѯ��Ϣ������...3");
		  // ��ǩ
		  //MerchantConfig tMerchantConfig = MerchantConfig.getUniqueInstance();
		  SignService sign = SignService.getUniqueInstance();
		  sign.verifySignXML(tResult);
		  //��ѯ���ճɹ�
		  PaymentMerchant tPaymentMerchant = new PaymentMerchant(tMSG);
		  //ȡ�ò�ѯ������Ϣ����
		  //QueryRequestBean QueryRequestBean = tPaymentMerchant.getQueryReqeustBean();
		  
		  /*�˴�Ϊ���˵�λ�Բ�ѯ������Ϣ������д���,��*/
		  System.out.println("��ѯ��Ϣ������...4");
		  //�����˵���ѯ���(��һ���˵�)
		  PaymentMerchantBean tPaymentMerchantBean = new PaymentMerchantBean();
		  tPaymentMerchantBean.setTAmount(5000.01D);//�趨�˵����
		  tPaymentMerchantBean.setTBillName("ѧ��");//�趨�˵�����
		  
		  SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//�������ڸ�ʽ

		  //Random random = new Random();
		  //String orderNoPart = new Integer(random.nextInt()).toString();
		  //tPaymentMerchantBean.setTBillNo("ON"+ df.format(new Date()));//�趨ҵ���˵���
		  tPaymentMerchantBean.setTBillNo("ON20151127001");//�趨ҵ���˵���
		  
		  tPaymentMerchantBean.setTCreateDate("2015-01-03");//�趨�˵���������(YYY-MM-DD)
		  tPaymentMerchantBean.setTEffectDate("2015-02-03");//�趨�˵���Ч����
		  tPaymentMerchantBean.setTExpiredDate("2015-12-03");//�趨�˵���ֹ����
		  ArrayList tPayerValueList = new ArrayList();
		  tPayerValueList.add("11");//���ݶ�����˵����ͣ��趨�˵���ѯ������Ϣ1
		  tPayerValueList.add("11");//���ݶ�����˵����ͣ��趨�˵���ѯ������Ϣ2		
		  tPaymentMerchantBean.setTPayerValueList(tPayerValueList);//�趨�˵���ѯ������Ϣ
		  tPaymentMerchantBean.setTRemark("");//�趨�˵���ע
		  tPaymentMerchantBean.setTStatus("1");//�趨�˵�֧��״̬��1: δ֧��  2: ֧���ɹ�  3:֧��ʧ�ܣ�
		  ArrayList tVerifyDomainList = new ArrayList();
		  //tVerifyDomainList.add("1");//���ݶ�����˵����ͣ��趨�˵���֤��Ϣ1
		  //tVerifyDomainList.add("1");//���ݶ�����˵����ͣ��趨�˵���֤��Ϣ2
		  //tVerifyDomainList.add("555555");//���ݶ�����˵����ͣ��趨�˵���֤��Ϣ2
		  tPaymentMerchantBean.setTVerifyDomainList(tVerifyDomainList);//�趨�˵���֤��Ϣ
		  ArrayList tBillDetailList = new ArrayList();
		  tBillDetailList.add("aaa");//���ݶ�����˵����ͣ��趨�˵���ϸ��Ϣ1
		  //tBillDetailList.add("95599");//���ݶ�����˵����ͣ��趨�˵���ϸ��Ϣ2
		  //tBillDetailList.add("������ϸ");//���ݶ�����˵����ͣ��趨�˵���ϸ��Ϣ3
		  tPaymentMerchantBean.setTBillDetailList(tBillDetailList);//�趨�˵���ϸ��Ϣ
		  tPaymentMerchant.setBillDataNew("true",1,tPaymentMerchantBean);//���˵���Ϣ���뱨��;1����ȡ��һ���̻�;true��ʾ�з����������˵���false��ʾû�з����������˵�

		  //�����˵���ѯ���(�ڶ����˵�)
		  tPaymentMerchantBean = new PaymentMerchantBean();
		  tPaymentMerchantBean.setTAmount(5000.01D);//�趨�˵����
		  tPaymentMerchantBean.setTBillName("ѧ��");//�趨�˵�����
		  
		  //SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//�������ڸ�ʽ

		  //Random random = new Random();
		  //String orderNoPart = new Integer(random.nextInt()).toString();
		  //tPaymentMerchantBean.setTBillNo("ON"+ df.format(new Date()));//�趨ҵ���˵���
		  tPaymentMerchantBean.setTBillNo("ON20151127002");//�趨ҵ���˵���
		  
		  tPaymentMerchantBean.setTCreateDate("2015-01-03");//�趨�˵���������(YYY-MM-DD)
		  tPaymentMerchantBean.setTEffectDate("2015-02-03");//�趨�˵���Ч����
		  tPaymentMerchantBean.setTExpiredDate("2015-12-03");//�趨�˵���ֹ����
		  tPayerValueList = new ArrayList();
		  tPayerValueList.add("11");//���ݶ�����˵����ͣ��趨�˵���ѯ������Ϣ1
		  tPayerValueList.add("11");//���ݶ�����˵����ͣ��趨�˵���ѯ������Ϣ2		
		  tPaymentMerchantBean.setTPayerValueList(tPayerValueList);//�趨�˵���ѯ������Ϣ
		  tPaymentMerchantBean.setTRemark("");//�趨�˵���ע
		  tPaymentMerchantBean.setTStatus("1");//�趨�˵�֧��״̬��1: δ֧��  2: ֧���ɹ�  3:֧��ʧ�ܣ�
		  tVerifyDomainList = new ArrayList();
		  //tVerifyDomainList.add("2");//���ݶ�����˵����ͣ��趨�˵���֤��Ϣ1
		  //tVerifyDomainList.add("2");//���ݶ�����˵����ͣ��趨�˵���֤��Ϣ2
		  //tVerifyDomainList.add("555555");//���ݶ�����˵����ͣ��趨�˵���֤��Ϣ2
		  tPaymentMerchantBean.setTVerifyDomainList(tVerifyDomainList);//�趨�˵���֤��Ϣ
		  tBillDetailList = new ArrayList();
		  tBillDetailList.add("bbb");//���ݶ�����˵����ͣ��趨�˵���ϸ��Ϣ1
		  //tBillDetailList.add("95599");//���ݶ�����˵����ͣ��趨�˵���ϸ��Ϣ2
		  //tBillDetailList.add("������ϸ");//���ݶ�����˵����ͣ��趨�˵���ϸ��Ϣ3
		  tPaymentMerchantBean.setTBillDetailList(tBillDetailList);//�趨�˵���ϸ��Ϣ
		  tPaymentMerchant.setBillDataNew("true",1,tPaymentMerchantBean);//���˵���Ϣ���뱨��;1����ȡ��һ���̻�;true��ʾ�з����������˵���false��ʾû�з����������˵�  	  

		  //ָ��ȡ�ڼ����̻���
		  tBase64Message = tPaymentMerchant.getBase64MerchantNew(1);//1����ȡ��һ���̻�
		  //System.out.println("["  + tBase64Message + "]");
	}
	try {
	//��Ӧ���
		ServletOutputStream outA = response.getOutputStream();
		outA.write(tBase64Message.getBytes());
		outA.println();
		outA.flush();	
		System.out.println("��ѯ��Ϣ������...e");
	} catch(Exception err) {
		err.getMessage();
	}
}
%>