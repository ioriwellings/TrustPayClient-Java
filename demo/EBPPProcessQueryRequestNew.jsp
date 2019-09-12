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
//取得MSG参数，并利用此参数值生成查询请求对象
String tMSG = request.getParameter("MSG");
System.out.println("查询请求报文[" + tMSG + "]");
SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
System.out.println("当前时间"+df1.format(new Date()));
if (tMSG != null && !tMSG.equals("")) {		  
	System.out.println("查询信息处理中...1");
	XMLDocument tResult = new XMLDocument(tMSG);
	System.out.println("查询信息处理中...2");
	String tBase64Message = "";
	if (tResult.getValueNoNull("MessageType").equals(IPaymentMerchant.MESSAGETYPE_QREQ)) {
		System.out.println("查询信息处理中...3");
		  // 验签
		  //MerchantConfig tMerchantConfig = MerchantConfig.getUniqueInstance();
		  SignService sign = SignService.getUniqueInstance();
		  sign.verifySignXML(tResult);
		  //查询接收成功
		  PaymentMerchant tPaymentMerchant = new PaymentMerchant(tMSG);
		  //取得查询请求信息对象
		  //QueryRequestBean QueryRequestBean = tPaymentMerchant.getQueryReqeustBean();
		  
		  /*此处为出账单位对查询请求信息对象进行处理,略*/
		  System.out.println("查询信息处理中...4");
		  //生成账单查询结果(第一条账单)
		  PaymentMerchantBean tPaymentMerchantBean = new PaymentMerchantBean();
		  tPaymentMerchantBean.setTAmount(5000.01D);//设定账单金额
		  tPaymentMerchantBean.setTBillName("学费");//设定账单名称
		  
		  SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式

		  //Random random = new Random();
		  //String orderNoPart = new Integer(random.nextInt()).toString();
		  //tPaymentMerchantBean.setTBillNo("ON"+ df.format(new Date()));//设定业务账单号
		  tPaymentMerchantBean.setTBillNo("ON20151127001");//设定业务账单号
		  
		  tPaymentMerchantBean.setTCreateDate("2015-01-03");//设定账单建立日期(YYY-MM-DD)
		  tPaymentMerchantBean.setTEffectDate("2015-02-03");//设定账单生效日期
		  tPaymentMerchantBean.setTExpiredDate("2015-12-03");//设定账单截止日期
		  ArrayList tPayerValueList = new ArrayList();
		  tPayerValueList.add("11");//根据定义的账单类型，设定账单查询条件信息1
		  tPayerValueList.add("11");//根据定义的账单类型，设定账单查询条件信息2		
		  tPaymentMerchantBean.setTPayerValueList(tPayerValueList);//设定账单查询条件信息
		  tPaymentMerchantBean.setTRemark("");//设定账单备注
		  tPaymentMerchantBean.setTStatus("1");//设定账单支付状态（1: 未支付  2: 支付成功  3:支付失败）
		  ArrayList tVerifyDomainList = new ArrayList();
		  //tVerifyDomainList.add("1");//根据定义的账单类型，设定账单验证信息1
		  //tVerifyDomainList.add("1");//根据定义的账单类型，设定账单验证信息2
		  //tVerifyDomainList.add("555555");//根据定义的账单类型，设定账单验证信息2
		  tPaymentMerchantBean.setTVerifyDomainList(tVerifyDomainList);//设定账单验证信息
		  ArrayList tBillDetailList = new ArrayList();
		  tBillDetailList.add("aaa");//根据定义的账单类型，设定账单明细信息1
		  //tBillDetailList.add("95599");//根据定义的账单类型，设定账单明细信息2
		  //tBillDetailList.add("测试明细");//根据定义的账单类型，设定账单明细信息3
		  tPaymentMerchantBean.setTBillDetailList(tBillDetailList);//设定账单明细信息
		  tPaymentMerchant.setBillDataNew("true",1,tPaymentMerchantBean);//将账单信息加入报文;1代表取第一个商户;true表示有符合条件的账单，false表示没有符合条件的账单

		  //生成账单查询结果(第二条账单)
		  tPaymentMerchantBean = new PaymentMerchantBean();
		  tPaymentMerchantBean.setTAmount(5000.01D);//设定账单金额
		  tPaymentMerchantBean.setTBillName("学费");//设定账单名称
		  
		  //SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式

		  //Random random = new Random();
		  //String orderNoPart = new Integer(random.nextInt()).toString();
		  //tPaymentMerchantBean.setTBillNo("ON"+ df.format(new Date()));//设定业务账单号
		  tPaymentMerchantBean.setTBillNo("ON20151127002");//设定业务账单号
		  
		  tPaymentMerchantBean.setTCreateDate("2015-01-03");//设定账单建立日期(YYY-MM-DD)
		  tPaymentMerchantBean.setTEffectDate("2015-02-03");//设定账单生效日期
		  tPaymentMerchantBean.setTExpiredDate("2015-12-03");//设定账单截止日期
		  tPayerValueList = new ArrayList();
		  tPayerValueList.add("11");//根据定义的账单类型，设定账单查询条件信息1
		  tPayerValueList.add("11");//根据定义的账单类型，设定账单查询条件信息2		
		  tPaymentMerchantBean.setTPayerValueList(tPayerValueList);//设定账单查询条件信息
		  tPaymentMerchantBean.setTRemark("");//设定账单备注
		  tPaymentMerchantBean.setTStatus("1");//设定账单支付状态（1: 未支付  2: 支付成功  3:支付失败）
		  tVerifyDomainList = new ArrayList();
		  //tVerifyDomainList.add("2");//根据定义的账单类型，设定账单验证信息1
		  //tVerifyDomainList.add("2");//根据定义的账单类型，设定账单验证信息2
		  //tVerifyDomainList.add("555555");//根据定义的账单类型，设定账单验证信息2
		  tPaymentMerchantBean.setTVerifyDomainList(tVerifyDomainList);//设定账单验证信息
		  tBillDetailList = new ArrayList();
		  tBillDetailList.add("bbb");//根据定义的账单类型，设定账单明细信息1
		  //tBillDetailList.add("95599");//根据定义的账单类型，设定账单明细信息2
		  //tBillDetailList.add("测试明细");//根据定义的账单类型，设定账单明细信息3
		  tPaymentMerchantBean.setTBillDetailList(tBillDetailList);//设定账单明细信息
		  tPaymentMerchant.setBillDataNew("true",1,tPaymentMerchantBean);//将账单信息加入报文;1代表取第一个商户;true表示有符合条件的账单，false表示没有符合条件的账单  	  

		  //指定取第几个商户号
		  tBase64Message = tPaymentMerchant.getBase64MerchantNew(1);//1代表取第一个商户
		  //System.out.println("["  + tBase64Message + "]");
	}
	try {
	//回应结果
		ServletOutputStream outA = response.getOutputStream();
		outA.write(tBase64Message.getBytes());
		outA.println();
		outA.flush();	
		System.out.println("查询信息处理中...e");
	} catch(Exception err) {
		err.getMessage();
	}
}
%>