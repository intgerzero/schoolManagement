<%@ page language="java" import="java.util.*,java.sql.*,javax.sql.*,javax.naming.*,javax.servlet.http.HttpSession,com.studentsystem.*" pageEncoding="GBK"%>
<%!  List<Course> Courseinfo=new ArrayList<Course>();
     Course temp;
     String message;
%>
<% 
    message=(String)session.getAttribute("message");
    Courseinfo=(List<Course>)session.getAttribute("MyCourseinfo"); 
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
<% 
   Courseinfo=(List<Course>)session.getAttribute("MyCourseinfo"); 
%>

<html>
  <body>
      <h2>ѡ�ν��</h2> 
      <form action="Studentservlet" method="post">
      <input type="hidden" name="item" value="2">
      <table border="1">
      <tr>
        <td>�γ̺� </td>
        <td>�γ���</td>
        <td>��ʱ</td>
        <td>ѧ��</td>
        <td>����ѧ��</td>
        <td>�Ͽ�ʱ��</td>
        <td>ѡ������</td>
        <td>�ڿν�ʦ</td>
       
        <td>ȡ��ѡ��</td>
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
       <td><%=temp.getStudentSum()%></td>
       <td><%=temp.getTeachername()%></td>
       <td><input type="checkbox" name=<%=temp.getCourseNo()%> value=<%=temp.getCourseNo()%>>
       </td>
       </tr>
       <%
       }%>
      </table>
       <input type="submit" value="ȷ��" >
       <input type="reset" value="����">
      </form>
  </body>
</html>
