<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<%
String message=(String)session.getAttribute("message");//message����ʾ��¼ʧ����Ϣ
if(message!=null)
{
%>
<script type="text/javascript">
	alert("<%=message%>");
	</script>
<%

session.removeAttribute("message");
}
%>

<html>
<head>
   <title>ѧ������ϵͳ��¼���� </title>	
   <link rel="stylesheet" type="text/css" href="style.css" />
   <script type="text/JavaScript">
   	/*�ж��Ƿ�Ϊ����*/
   	function isNumber(str)
   	{
   		var Letters="01234567889";
   		for(var i=0;i<str.length;i++)
   		{
   		  var CheckChar=str.charAt(i);
   		  if(Letters.indexOf(CheckChar)==-1)
   		     return false;
   		}
   		return true;
   	}
   	/*�ж��Ƿ�Ϊ��*/
   	function isEmpty(value)
   	{
   		return /^\s*$/.test(value);
   	}
   	/*��������û����������Ƿ�Ϊ��*/
   	function check()
   	{
   	  if(isEmpty(document.myForm.UserID.value))
   	  {
   	  	alert("��¼������Ϊ��");
   	  	document.myForm.loginName.focus();
   	  	return false;
   	  }	
   	  if(isEmpty(document.myForm.UserPWD.value))
   	  {
   	    alert("���벻��Ϊ��");
   	    document.myForm.password.focus();
   	    return false;	
   	  }
   	  else
   	  {
   	  	 return true;
   	  }
   	}
   	//��ֹ����backspace����ע��֮ǰ�Ľ���
    window.onload=function(){  
    
    document.getElementsByTagName("body")[0].onkeydown =function(){  
        if(event.keyCode==8){  
            var elem = event.srcElement;  
            var name = elem.nodeName;  
              
            if(name!='INPUT' && name!='TEXTAREA'){  
                event.returnValue = false ;  
                return ;  
            }  
            var type_e = elem.type.toUpperCase();  
            if(name=='INPUT' && (type_e!='TEXT' && type_e!='TEXTAREA' && type_e!='PASSWORD' && type_e!='FILE')){  
                event.returnValue = false ;  
                return ;  
            }  
            if(name=='INPUT' && (elem.readOnly==true || elem.disabled ==true)){  
                event.returnValue = false ;  
                return ;  
            }  
        }  
    }  
}  
   	</script>
   	<style type="text/css">
   	*{
      margin:0 auto;
      font-family: "Microsoft YaHei";
    }
   	#myForm {
	   width:400px;
	   height:300px;
	   position:absolute;
	   top:30%;
	   left:50%;
	   margin:-150px 0 0 -200px;
	   background:#FFF;
	   border:3px solid #999;
	    border-radius:10px;
      }
     #main
   	{
   	   height:95%;
   	}
   	#footer
   	{
   	   height:5%;
   	}
   	</style>
  
</head>


<body background="background.jpg" align="center">
	<div align="center" id="main">
	<marquee behavior="alternate" direction="left">---------��ӭʹ��ѧ������ϵͳ--------</marquee>
    <form action="sqltest" method="post" id="myForm">
     <h2>�û���¼<h2/>
     <table>
       <tr>&nbsp;</tr>
      <tr>
       	<td>�û�����</td>
       	<td><input type="text" size="20" name="UserID" id="UserID" class="border-radius"></td>
      </tr>
      <tr>
      	<td>���룺</td>
      	<td><input type="password" size="20" name="UserPWD" id="UserPWD" class="border-radius"></td>
      </tr>
      
      <tr>
      	<td>��ݣ�</td>
      	<td>
         <select name="Kind">
     	    <option value="0" selected>����Ա </option>
     	    <option value="1">��ʦ </option>
     	    <option value="2">ѧ�� </option>
     	   </select>
     	  </td>
     	</tr>

     <tr>
     	<td><input type="submit" value="�ύ" onClick="return check();" id="submit" class="border-radius"></td>
     	<td><input type="reset" value="����" class="border-radius"></td>
     </tr>

    </table>
 </form>
</div>
<div id="footer">
	<div id="copy">
		<div id="copyright">
			<p>CopyRight&copy;2016</p>
			<p>�������ӿƼ���ѧ</p>
			</div>
		</div>
	</div>
</body>
</html>