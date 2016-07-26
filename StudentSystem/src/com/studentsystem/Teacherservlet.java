package com.studentsystem;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
/**
 * ��Ϊ�����ʦ�����servlet����������ֽ�ʦ������Ϣ
 * @version 1.0
 * @author Administrator
 */
public class Teacherservlet extends HttpServlet {

	public void destroy() {
		super.destroy();
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			//�������ݿ�����
			Context initCtx=new InitialContext();
			Context encCtx=(Context)initCtx.lookup("java:comp/env");
			DataSource ds=(DataSource)encCtx.lookup("jdbc/mssql2014");
			Connection con=ds.getConnection();
			Statement st=null;
			ResultSet rs=null;
			String coursename=null;
			String username=null;
			HttpSession session=request.getSession();
			username=(String)session.getAttribute("userid");
			String hidden=request.getParameter("item");
			//�������ֵ�һ�κ�֮��Ŀγ��������ǵڶ��Σ����session�л�ȡ
			if((String)session.getAttribute("coursename")==null)
			{
			  coursename=new String(request.getParameter("coursename").getBytes("ISO8859_1"));
			  session.setAttribute("coursename",coursename);
			}
			else
				coursename=(String)session.getAttribute("coursename");
			List<Student> MyStudent=new ArrayList<Student>();
			//��ȡ�ı������ر���1����ʾ��ѯѡ��ĳ�ſε�����ѧ����ѧ�ţ������ͳɼ�
			if(hidden.equals("1"))
			{
			    PreparedStatement ps=null;//Ԥ��ѯ
			    //SQL���ĺ��壺��ʾͨ����ϵѧ����SC��TC���γ̱����ѡ����ѡ���¼��ʦ�Ľ��ڵ�ĳһ�ſε�ѧ����ѧ�ź��������ɼ�
			    ps=con.prepareStatement("SELECT StudentInfo.StudentNo,StudentInfo.Name,StudentInfo.ClassNo,SC.Result FROM CourseInfo,TC,StudentInfo,SC WHERE TC.CourseNo=CourseInfo.CourseNo AND SC.CourseNo=TC.CourseNo AND SC.StudentNo=StudentInfo.StudentNo AND TC.CourseNo=CourseInfo.CourseNo AND CourseInfo.CourseName=? AND TC.TeacherNo=?");
			    ps.setString(1,coursename);
			    ps.setString(2,username);
			    rs=ps.executeQuery();
			    while(rs.next())
			    {
				  System.out.println("ѡ "+coursename+" ��ѧ��������"+rs.getString(2)+"�༶����"+rs.getString(3));
				  Student temp=new Student();
			      temp.setStudentNo(rs.getString(1));
			      temp.setName(rs.getString(2));
			      temp.setClass(rs.getString(3));
			      temp.setCourseGrade(rs.getFloat(4));
			      MyStudent.add(temp);
			    }
			    session.setAttribute("MyStudentinfo",MyStudent);
			    //ת��ԭ����ҳ��
			    request.getRequestDispatcher("/upload_classgrade.jsp").forward(request, response);
			}
			//�ϴ��ɼ��Ĵ���
			else if(hidden.equals("2"))
			{
				MyStudent=(List<Student>)session.getAttribute("MyStudentinfo");
				int size=MyStudent.size();
				TestDB test=new TestDB();
				for(int i=0;i<MyStudent.size();i++)
				{	
					String coursegrade=(String)request.getParameter(MyStudent.get(i).getStudentNo());
					if(coursegrade.length()!=0)
					{
						test.Teacherwork(MyStudent.get(i).getStudentNo(), coursename, new Float(coursegrade));
						System.out.println("ѧ��Ϊ"+MyStudent.get(i).getStudentNo()+"ѡ "+coursename+" �ĳɼ���"+coursegrade);
					    MyStudent.get(i).setCourseGrade(new Float(coursegrade));
					}
					else
					{
						//�ڳɼ�һ���в��Ĭ��ֵΪ0
						test.Teacherwork(MyStudent.get(i).getStudentNo(), coursename,0);
						System.out.println("ѧ��Ϊ"+MyStudent.get(i).getStudentNo()+"ѡ "+coursename+" �ĳɼ���0");
						MyStudent.get(i).setCourseGrade(0);
					}
				}
				session.setAttribute("MyStudentinfo",MyStudent);
				request.getRequestDispatcher("/upload_classgrade.jsp").forward(request, response);
				
			}
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
