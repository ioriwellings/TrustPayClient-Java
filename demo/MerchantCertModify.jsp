<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.ArrayList" %>
<%response.setHeader("Cache-Control", "no-cache"); 
request.setCharacterEncoding("GBK");%>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-身份验证请求</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER><br>
<%
	MerchantPara para = MerchantConfig.getUniqueInstance().getPara();
	FileUtil util = new FileUtil();

	int count = Integer.parseInt(request.getParameter("Count"));

    String[] merchantid_arr = null;
    String[] merchantcertfile_arr = null;
    String[] merchantcertpassword_arr = null;
	String merchantID = "";
	String merchantCertFilePath = "";
	String merchantCertPassword = "";
	
	//把原来的配置取出来	        
    //设置商户编号。如果是多商户则在iMerchantIDList放置多条记录
	ArrayList<String> iMerchantIDList = (ArrayList)para.getMerchantIDList();

	//设置商户证书。如果是多商户则在iMerchantCertNameList放置多条记录。注意：商户证书名称顺序要与商户编号顺序一致
	ArrayList<byte[]> iMerchantCertList = para.getMerchantCertFileList();
          
    //设置商户证书密码。如果是多商户则在iMerchantPasswordList放置多条记录。注意：密码顺序要与商户编号顺序一致
	ArrayList<String> iMerchantPasswordList = para.getMerchantCertPasswordList();
	
    if (count == 1)
    {               
    	merchantID = request.getParameter("MerchantID");
    	merchantCertFilePath = request.getParameter("MerchantCertFile");
    	merchantCertPassword = request.getParameter("MerchantCertPassword");
    	merchantCertFilePath = merchantCertFilePath.replaceAll("\\\\","/");
    	
    	out.println("已添加: "+merchantCertFilePath + "<br>");	
		
		//设置商户编号。如果是多商户则在iMerchantIDList放置多条记录
		//iMerchantIDList.add("103881104410001");

		iMerchantIDList.add(merchantID);
	    para.setMerchantIDList(iMerchantIDList);           
		
		//设置商户证书。如果是多商户则在iMerchantCertNameList放置多条记录。注意：商户证书名称顺序要与商户编号顺序一致
		//iMerchantCertList.add(util.readFile("D:/cert/103881104410001.pfx"));

		iMerchantCertList.add(util.readFile(merchantCertFilePath));
	          
	    //设置商户证书密码。如果是多商户则在iMerchantPasswordList放置多条记录。注意：密码顺序要与商户编号顺序一致
		//iMerchantPasswordList.add("11111111");// 商户私钥密码
		iMerchantPasswordList.add(merchantCertPassword);// 商户私钥密码
    }
    else
    {
        merchantid_arr = request.getParameterValues("MerchantID");
        merchantcertfile_arr = request.getParameterValues("MerchantCertFile");
        merchantcertpassword_arr = request.getParameterValues("MerchantCertPassword");
               
        for(int i=0; i<merchantid_arr.length; i++ ){
	        //merchantidStr += merchantid_arr[i] + ",";
	        //merchantcertfileStr += merchantcertfile_arr[i] + ",";
	        //merchantcertpasswordStr += merchantcertpassword_arr[i] + ",";
	        //out.println("MerchantID" + i + ":" + merchantid_arr[i] + "<br/>");
	        //out.println("MerchantCertFile" + i + ":" + merchantcertfile_arr[i] + "<br/>");
	        //out.println("merchantcertPassword" + i + ":" + merchantcertpassword_arr[i] + "<br/>");
        
	        //设置商户编号。如果是多商户则在iMerchantIDList放置多条记录
			iMerchantIDList.add(merchantid_arr[i]);	          
			
			//设置商户证书。如果是多商户则在iMerchantCertNameList放置多条记录。注意：商户证书名称顺序要与商户编号顺序一致
			merchantcertfile_arr[i] = merchantcertfile_arr[i].replaceAll("\\\\","/");
			out.println("已添加: " + merchantcertfile_arr[i] + "<br>");	
			iMerchantCertList.add(util.readFile(merchantcertfile_arr[i]));
		          
		    //设置商户证书密码。如果是多商户则在iMerchantPasswordList放置多条记录。注意：密码顺序要与商户编号顺序一致
			iMerchantPasswordList.add(merchantcertpassword_arr[i]);// 商户私钥密码
        
        }    
        para.setMerchantIDList(iMerchantIDList);       
    }

	//绑定证书
	
	try {
    	CertHelper.bindMerchantCertificate(para,iMerchantCertList,iMerchantPasswordList);
    }catch(TrxException e){
    	out.println(e.getMessage());
    }
%>
<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY>
</HTML>