<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.ArrayList" %>
<%response.setHeader("Cache-Control", "no-cache"); 
request.setCharacterEncoding("GBK");%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-�����֤����</TITLE></HEAD>
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
	
	//��ԭ��������ȡ����	        
    //�����̻���š�����Ƕ��̻�����iMerchantIDList���ö�����¼
	ArrayList<String> iMerchantIDList = (ArrayList)para.getMerchantIDList();

	//�����̻�֤�顣����Ƕ��̻�����iMerchantCertNameList���ö�����¼��ע�⣺�̻�֤������˳��Ҫ���̻����˳��һ��
	ArrayList<byte[]> iMerchantCertList = para.getMerchantCertFileList();
          
    //�����̻�֤�����롣����Ƕ��̻�����iMerchantPasswordList���ö�����¼��ע�⣺����˳��Ҫ���̻����˳��һ��
	ArrayList<String> iMerchantPasswordList = para.getMerchantCertPasswordList();
	
    if (count == 1)
    {               
    	merchantID = request.getParameter("MerchantID");
    	merchantCertFilePath = request.getParameter("MerchantCertFile");
    	merchantCertPassword = request.getParameter("MerchantCertPassword");
    	merchantCertFilePath = merchantCertFilePath.replaceAll("\\\\","/");
    	
    	out.println("�����: "+merchantCertFilePath + "<br>");	
		
		//�����̻���š�����Ƕ��̻�����iMerchantIDList���ö�����¼
		//iMerchantIDList.add("103881104410001");

		iMerchantIDList.add(merchantID);
	    para.setMerchantIDList(iMerchantIDList);           
		
		//�����̻�֤�顣����Ƕ��̻�����iMerchantCertNameList���ö�����¼��ע�⣺�̻�֤������˳��Ҫ���̻����˳��һ��
		//iMerchantCertList.add(util.readFile("D:/cert/103881104410001.pfx"));

		iMerchantCertList.add(util.readFile(merchantCertFilePath));
	          
	    //�����̻�֤�����롣����Ƕ��̻�����iMerchantPasswordList���ö�����¼��ע�⣺����˳��Ҫ���̻����˳��һ��
		//iMerchantPasswordList.add("11111111");// �̻�˽Կ����
		iMerchantPasswordList.add(merchantCertPassword);// �̻�˽Կ����
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
        
	        //�����̻���š�����Ƕ��̻�����iMerchantIDList���ö�����¼
			iMerchantIDList.add(merchantid_arr[i]);	          
			
			//�����̻�֤�顣����Ƕ��̻�����iMerchantCertNameList���ö�����¼��ע�⣺�̻�֤������˳��Ҫ���̻����˳��һ��
			merchantcertfile_arr[i] = merchantcertfile_arr[i].replaceAll("\\\\","/");
			out.println("�����: " + merchantcertfile_arr[i] + "<br>");	
			iMerchantCertList.add(util.readFile(merchantcertfile_arr[i]));
		          
		    //�����̻�֤�����롣����Ƕ��̻�����iMerchantPasswordList���ö�����¼��ע�⣺����˳��Ҫ���̻����˳��һ��
			iMerchantPasswordList.add(merchantcertpassword_arr[i]);// �̻�˽Կ����
        
        }    
        para.setMerchantIDList(iMerchantIDList);       
    }

	//��֤��
	
	try {
    	CertHelper.bindMerchantCertificate(para,iMerchantCertList,iMerchantPasswordList);
    }catch(TrxException e){
    	out.println(e.getMessage());
    }
%>
<a href='Merchant.html'>���̻���ҳ</a></CENTER>
</BODY>
</HTML>