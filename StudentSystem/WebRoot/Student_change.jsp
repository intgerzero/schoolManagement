<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%! String message;
    String phone;
    String Email;
%>
<%
message=(String)session.getAttribute("message");
phone=(String)session.getAttribute("Phone");
Email=(String)session.getAttribute("Email");
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
		<title>�޸���Ϣ</title>
		<script type="text/JavaScript">
		function check_same()
   	    {
   	      var pwd=document.myForm.newpwd.value;
		  var repwd=document.myForm.againpwd.value;
   	      if(pwd!=repwd)
   	      {
   	  	    alert("�����������벻һ��");
   	  	    return false;
   	      }
   	    }
		</script>
	</head>
	<body>
		<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; �޸���Ϣ</h2>
		<form action="Studentservlet" method="post" name="myForm"> 
		<input type="hidden" name="item" value="0">
		<p>1.ѧ�ţ���������Ҫ��Ϣ���޸ģ�����ϵ����Ա
		</p>
		<p>2.���������޸ģ����Բ�����д
		</p>
		<table width="50%" border="1">
			<tr>
				<td>��ϵ��ʽ��</td>
				<td>
					<input type="text" name="phone" autocomplete="off" value=<%=phone%>>
				</td>
			</tr>
			<tr>
				<td >Email��</td>
				<td>
					<input type="text" name="email" autocomplete="off" value=<%=Email%>>
				</td>
			</tr>
			<tr>
                <td >�����룺</td>
                <td><font size="6"><input type="password" name="newpwd" id="newpwd"></font></td>
                
			</tr>
			
			<tr>
			    <td >�ٴ��������룺</td>
                <td><font size="6"><input type="password" name="againpwd" id="againpwd"></font></td>
            </tr>
			<tr>
				<td align="right">
					<input type="submit" name="submit" value="�ύ" onClick="return check_same();"/>
				</td>
				<td>
				    <input type="reset" name="reset" value="����">
				</td>
		    </tr>

		</table>
	</form>
	</body>
</html>
