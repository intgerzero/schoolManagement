<%@ page language="java" import="java.util.*,java.sql.*,javax.sql.*,javax.naming.*,com.studentsystem.*;" pageEncoding="GBK"%>

<%
      List<Course> Grade=new ArrayList<Course>();
      List<Course> SearchGrade=new ArrayList<Course>();
      Connection con=null;
      DataSource ds=null;
      PreparedStatement ps=null;
      PreparedStatement ps_grade=null;
      //��ȡ���ݿ�������
      try {
			Context initCtx=new InitialContext();
			Context encCtx=(Context)initCtx.lookup("java:comp/env");
			ds=(DataSource)encCtx.lookup("jdbc/mssql2014");
			con=ds.getConnection();
			con.setAutoCommit(false);
	        session=request.getSession();
	        String username;
	        username=(String)session.getAttribute("userid");  
			ps_grade=con.prepareStatement("SELECT CourseInfo.CourseNo,CourseInfo.CourseName,CourseInfo.Grade,SC.Result FROM SC,CourseInfo WHERE CourseInfo.CourseNo=SC.CourseNo AND SC.StudentNo=? AND SC.Result!=0");
			ps_grade.setString(1,username);
			ResultSet rs_grade=ps_grade.executeQuery();
            while (rs_grade.next()) 
	        {     
			    Course temp=new Course();
			    temp.setCourseNo(rs_grade.getString(1));
			    temp.setCourseName(rs_grade.getString(2));
			    temp.setGrade(rs_grade.getFloat(3));
			    temp.setResult(rs_grade.getFloat(4));
			    Grade.add(temp);       
			}	
			rs_grade.close();
			ps_grade.close();
			con.close();
			
			System.out.println("�û���"+username+"�гɼ��Ŀγ̵Ĵ�С:"+Grade.size());
            session.setAttribute("Grade",Grade);
            session.setAttribute("SearchGrade",SearchGrade);		
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
%>
<html>
<head>
   	
   <link rel="stylesheet" type="text/css" href="style.css">
   	<style type="text/css">
   	#mainwrapper 
   	{
   	     width:100%;
   		 height:95%;
   	} 
   
    #content 
    {
    	 overflow:hidden;
    	 float:right;
    	 background:#EE7621;
    	 width:80%;
    	 height:95%;
    }
    #content iframe{
    	 width:100%;
    	 height:100%;
    	 border: 0px;
    }
    #sidebar
    { 
    	overflow:hidden;
    	float:left;
    	background:#2268c8;
    	width:20%;
    	height:95%;
    }
	</style>
</head>
 <body>
	   <div id="mainwrapper">
	   	  <div id="sidebar">
	   	  	<ul>
	   	  	<!--ע��iframe���id��nameҪ��ͬ����Ƕ�׵�html��iframe��id���벻ͬ -->
	   	  		<li><a href="Grade.jsp" target="show_grade" ><span>��ѯ�ɼ� </span> </a>
	   	  		<li><a href="All_Grade.jsp" target="show_grade">��ʾ�������޿γ̳ɼ�</a></li>
	   	  	</ul>
	   	  </div>
	     <div id="content">
	        <iframe id="show_grade" name="show_grade" ></iframe>
	   	 </div>
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