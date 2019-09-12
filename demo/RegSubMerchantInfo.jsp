<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.abc.pay.client.ebus.*" %>
<%@ page import = "com.abc.pay.client.*" %>
<%@ page import = "java.util.LinkedHashMap" %>
<%	response.setHeader("Cache-Control", "no-cache"); 
	request.setCharacterEncoding("GBK");
%>
<HTML>
<HEAD><TITLE>农行网上支付平台-商户接口范例-支付请求</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>支付请求请求<br>
<%
		String[] Account_arr = new String[]{};       
		String[] AccountName_arr = new String[]{};       
		String[] AccountType_arr = new String[]{};     
		String[] AccountAbisNo_arr = new String[]{};   
		String[] BankNo_arr = new String[]{};           
		String[] MobilePhone_arr = new String[]{};     
		String[] AccStatus_arr = new String[]{};           
		String[] IsABCAccount_arr = new String[]{};    	        
        String totalCount =  request.getParameter("TotalCount"); 
        
        int batchSize = Integer.parseInt(totalCount);
        if(batchSize != 0){
	        if(batchSize == 1){
		         String Account           = request.getParameter("txtAccount");
		         String AccountName       = request.getParameter("txtAccountName");
		         String AccountType       = request.getParameter("txtAccountType");
		         String AccountAbisNo     = request.getParameter("txtAccountAbisNo");
		         String BankNo            = request.getParameter("txtBankNo");
		         String MobilePhone       = request.getParameter("txtMobilePhone");
		         String AccStatus            = request.getParameter("txtAccStatus");
		         String IsABCAccount      = request.getParameter("txtIsABCAccount");
		         
	         	 Account_arr        = new String[] { Account        };
	         	 AccountName_arr    = new String[] { AccountName    };
	         	 AccountType_arr    = new String[] { AccountType    };
	         	 AccountAbisNo_arr  = new String[] { AccountAbisNo  };
	         	 BankNo_arr         = new String[] { BankNo         };
	         	 MobilePhone_arr    = new String[] { MobilePhone    };
	         	 AccStatus_arr      = new String[] { AccStatus      };
	         	 IsABCAccount_arr   = new String[] { IsABCAccount   };
	        }
	        else {
	         	 Account_arr          = request.getParameterValues("txtAccount");  
	             AccountName_arr      = request.getParameterValues("txtAccountName");  
	             AccountType_arr      = request.getParameterValues("txtAccountType");  
	             AccountAbisNo_arr    = request.getParameterValues("txtAccountAbisNo");  
	             BankNo_arr           = request.getParameterValues("txtBankNo");  
	             MobilePhone_arr      = request.getParameterValues("txtMobilePhone");  
	             AccStatus_arr        = request.getParameterValues("txtAccStatus");  
	             IsABCAccount_arr     = request.getParameterValues("txtIsABCAccount");  
	        }
        }
         //1、生成支付请求对象
        RegSubMerchantInfoRequest tMerchantInfo = new RegSubMerchantInfoRequest();

        //2、取得明细项 
        LinkedHashMap map = null;   
   
        for (int i = 0; i < Account_arr.length; i++)
        {
            map = new LinkedHashMap();
            //map.put("SeqNo       ", String.valueOf(i + 1));
            map.put("Account",Account_arr[i]);
            map.put("AccountName",AccountName_arr[i]);
            map.put("AccountType",AccountType_arr[i]); 
            map.put("AccountAbisNo",AccountAbisNo_arr[i]);
            map.put("BankNo",BankNo_arr[i]);
            map.put("MobilePhone",MobilePhone_arr[i]);
            map.put("AccStatus",AccStatus_arr[i]);
            map.put("IsABCAccount",IsABCAccount_arr[i]);
            
            tMerchantInfo.dic.put(i+1, map);
        }
        //3、设置请求值
        //tMerchantInfo.merchantInfoRequest.put("MerchantID", request.getParameter("txtMerchantID")); 
        tMerchantInfo.merchantInfoRequest.put("SubMerId", request.getParameter("txtSubMerId")); 
        tMerchantInfo.merchantInfoRequest.put("SubMerName", request.getParameter("txtSubMerName")); 
        tMerchantInfo.merchantInfoRequest.put("SubMerType", request.getParameter("txtSubMerType")); 
        tMerchantInfo.merchantInfoRequest.put("SubMerSort", request.getParameter("txtSubMerSort")); 
        tMerchantInfo.merchantInfoRequest.put("MCC", request.getParameter("txtMCC"));         
        tMerchantInfo.merchantInfoRequest.put("CertificateType", request.getParameter("txtCertificateType")); 
        tMerchantInfo.merchantInfoRequest.put("CertificateNo", request.getParameter("txtCertificateNo")); 
        tMerchantInfo.merchantInfoRequest.put("ContactName", request.getParameter("txtContactName")); 
        tMerchantInfo.merchantInfoRequest.put("MobileNo", request.getParameter("txtMobileNo")); 
        tMerchantInfo.merchantInfoRequest.put("Address", request.getParameter("txtAddress")); 
        tMerchantInfo.merchantInfoRequest.put("Status", request.getParameter("txtStatus")); 
        tMerchantInfo.merchantInfoRequest.put("Remark", request.getParameter("txtRemark")); 

        //4、传送请求并返回结果
        JSON json = tMerchantInfo.postRequest();

        String ReturnCode = json.GetKeyValue("ReturnCode");
        String ErrorMessage = json.GetKeyValue("ErrorMessage");
        if (ReturnCode.equals("0000"))
        {
            //5、请求提交成功，返回结果信息
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
            //strMessage.append("ECMerchantType   = [" + json.GetKeyValue("ECMerchantType") + "]<br/>");
            out.println("MerchantID = [" + json.GetKeyValue("MerchantID") + "]<br/>");
            out.println("TrxType = [" + json.GetKeyValue("TrxType") + "]<br/>");
        }
        else
        {
            //6、请求提交失败，商户自定后续动作
            out.println("ReturnCode   = [" + ReturnCode + "]<br/>");
            out.println("ErrorMessage = [" + ErrorMessage + "]<br/>");
		}
%>

<a href='Merchant.html'>回商户首页</a></CENTER>
</BODY></HTML>