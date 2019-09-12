<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="com.abc.pay.client.FileUtil"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>  
    <title>My JSP 'MerchantConfig.jsp' starting page</title>
  </head> 
  <body>
<%
	int count = Integer.parseInt(request.getParameter("Count"));
	FileUtil obj = new FileUtil();
	String filePath = FileUtil.class.getResource("/").getPath()+"TrustMerchant.properties"; // 文件路径

    String[] merchantid_arr = null;
    String[] merchantcertfile_arr = null;
    String[] merchantcertpassword_arr = null;
	String merchantID = "";
	String merchantCertFilePath = "";
	String merchantCertPassword = "";
    if (count == 1)
    {               
    	merchantID = request.getParameter("MerchantID");
    	merchantCertFilePath = request.getParameter("MerchantCertFile");
    	merchantCertPassword = request.getParameter("MerchantCertPassword");
    	merchantCertFilePath = merchantCertFilePath.replaceAll("\\\\","/");
        
        obj.write(filePath, obj.read(filePath,merchantID,merchantCertFilePath,merchantCertPassword)); // 读取修改文件      
        
		out.println("MerchantID   = [" + merchantID + "]<br/>");
		out.println("MerchantCertFile   = [" + merchantCertFilePath + "]<br/>");
		out.println("MerchantCertPassword   = [" + merchantCertPassword + "]<br/>");       
    }
    else
    {
        merchantid_arr = request.getParameterValues("MerchantID");
        merchantcertfile_arr = request.getParameterValues("MerchantCertFile");
        merchantcertpassword_arr = request.getParameterValues("MerchantCertPassword");
        
        String merchantidStr = "";
        String merchantcertfileStr = "";
        String merchantcertpasswordStr = "";
        
        for(int i=0; i<merchantid_arr.length-1; i++ ){
	        merchantidStr += merchantid_arr[i] + ",";
	        merchantcertfileStr += merchantcertfile_arr[i] + ",";
	        merchantcertpasswordStr += merchantcertpassword_arr[i] + ",";
	        //out.println("MerchantID" + i + ":" + merchantid_arr[i] + "<br/>");
	        //out.println("MerchantCertFile" + i + ":" + merchantcertfile_arr[i] + "<br/>");
	        //out.println("merchantcertPassword" + i + ":" + merchantcertpassword_arr[i] + "<br/>");
        }
        //最后一个不加逗号
        merchantidStr += merchantid_arr[merchantid_arr.length-1];
        merchantcertfileStr += merchantcertfile_arr[merchantid_arr.length-1];
        merchantcertpasswordStr += merchantcertpassword_arr[merchantid_arr.length-1];
        
        //out.println("merchantidStr:"  + merchantidStr + "<br/>");
        //out.println("merchantcertfileStr:"  + merchantcertfileStr + "<br/>");
        //out.println("merchantcertpasswordStr:"  + merchantcertpasswordStr + "<br/>");
	               
        merchantcertfileStr = merchantcertfileStr.replaceAll("\\\\","/");
        obj.write(filePath, obj.read(filePath,merchantidStr,merchantcertfileStr,merchantcertpasswordStr)); // 读取修改文件              
    }
	out.println("已修改文件路径：" + filePath + "<br/>");
%>

  </body>
</html>
