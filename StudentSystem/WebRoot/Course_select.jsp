<%@ page language="java" import="java.util.*,java.sql.*,javax.sql.*,javax.naming.*,javax.servlet.http.HttpSession,com.studentsystem.*" pageEncoding="GBK"%>
<%!  List<Course> Courseinfo=new ArrayList<Course>();
     Course temp;
     String message;
%>
<% 
    message=(String)session.getAttribute("message");
    Courseinfo=(List<Course>)session.getAttribute("CanCourseinfo"); 
%>
<% 
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
  
  <body>
      <h2>�����ѡ�Σ����¿γ�Ϊ��ѡ�γ̣���������ѡ�γ̣�</h2> 
      <form action="Studentservlet" method="post">
      <input type="hidden" name="item" value="1">
      <table border="1">
      <tr>
        <td>�γ̺� </td>
        <td>�γ���</td>
        <td>��ʱ</td>
        <td>ѧ��</td>
        <td>����ѧ��</td>
        <td>�Ͽ�ʱ��</td>
        <td>�ڿν�ʦ</td>
        <td>ѡ��</td>
        <td>ѡ������</td>
      </tr>
      <tr>
       <%
         for(int i=0;i<Courseinfo.size();i++)
         {
             temp=Courseinfo.get(i); 
        %>
       <td><%=temp.getCourseNo()%></td>
       <td><%=temp.getCouresName()%></td>
       <td><%=temp.getGrade()%></td>
       <td><%=temp.getStudyTime()%></td>
       <td><%=temp.getTerm()%></td>
       <td><%=temp.getWhentoStudy()%></td>
       <td><%=temp.getTeachername()%></td>
       <td><input type="checkbox" name=<%=temp.getCourseNo()%> value=<%=temp.getCourseNo()%>>
       </td>
       <td><%=temp.getStudentSum() %></td>
       </tr>
       <%
       }%>
      </table>
       <input type="submit" value="ȷ��" >
       <input type="reset" value="����">
       </form>
  </body>
</html>
