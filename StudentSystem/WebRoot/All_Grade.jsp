<%@ page language="java" import="java.util.*,java.sql.*,javax.sql.*,javax.naming.*,com.studentsystem.*;" pageEncoding="GBK"%>
<%!  List<Course> Courseinfo=new ArrayList<Course>();
     Course temp;
%>
<% 
    Courseinfo=(List<Course>)session.getAttribute("Grade"); 
    System.out.println("��All_grade��Grade�Ĵ�С:"+Courseinfo.size());
%>

<html>
  <body>
      <h2>���пγ̳ɼ�</h2> 
      <form action="Studentservlet" method="post">
      <input type="hidden" name="item" value="2">
      <table border="1">
      <tr>
        <td>�γ̺�</td>
        <td>�γ���</td>
        <td>ѧ��</td>
        <td>�ɼ�</td>
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
       <td><%=temp.getResult()%></td>
       </tr>
       <%
       }%>
      </table>
      </form>
  </body>
</html>