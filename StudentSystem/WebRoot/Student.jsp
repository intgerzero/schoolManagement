<%@ page language="java" import="java.util.*,java.sql.*,javax.sql.*,javax.naming.*,javax.servlet.http.HttpSession" pageEncoding="GBK"%>
<%! String StudentNo;
    String Name;
    String CardNo;
    String Prince;
    String sex;
    String birthday;
    String phone;
    String subject;
    String classnumber;
    String Email;
    String Academy;
    String Photo_temp;
    String Photo;
%>
<% 
   StudentNo=(String)session.getAttribute("StudentNo");
   Name=(String)session.getAttribute("Name");
   CardNo=(String)session.getAttribute("CardNo");
   Prince=(String)session.getAttribute("Prince");
   sex=(String)session.getAttribute("Sex");
   birthday=(String)session.getAttribute("Birthday");
   phone=(String)session.getAttribute("Phone");
   subject=(String)session.getAttribute("Subject");
   classnumber=(String)session.getAttribute("Classnumber");
   Email=(String)session.getAttribute("Email");
   Academy=(String)session.getAttribute("Academy");
   Photo_temp=(String)session.getAttribute("StudentPhoto");
   Photo="../"+Photo_temp;
%>

<html>
  <body>
       <h2>&nbsp;&nbsp;&nbsp;ѧ��������Ϣ</h2> <br>
    <table border=1>
      <tr>
       	<td>ѧ�ţ�</td>
       	<td><%=StudentNo%></td>
       	<td>������</td>
       	<td><%=Name%></td>
      </tr>
      <tr>
       	<td>���֤�ţ�</td>
       	<td><%=CardNo%></td>
       	<td>ʡ�ݣ�</td>
       	<td><%=Prince%></td>
      </tr>
      <tr>
       	<td>�Ա�</td>
       	<td><%=sex%></td>
       	<td>��������</td>
       	<td><%=birthday%></td>
      </tr>
      <tr>
       	<td>��ϵ�绰��</td>
       	<td><%=phone%></td>
       	<td>רҵ��</td>
       	<td><%=subject%></td>
      </tr>
      <tr>
       	<td>�༶��</td>
       	<td><%=classnumber%></td>
       	<td>�������䣺</td>
       	<td><%=Email%></td>
      </tr>
       <tr>
       	<td>ѧԺ��</td>
       	<td><%=Academy%></td>
      </tr>
      <tr>
        <td>��Ƭ</td>
        <td><img src=<%=Photo%>></td>
      </tr>
    </table>
  </body>
</html>
