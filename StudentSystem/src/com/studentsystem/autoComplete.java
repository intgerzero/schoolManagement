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
 * ��������AJAX���󣬲�����XML�ļ�������������Ϣ
 * @version 1.0
 * @author LBJ
 *
 */
public class autoComplete extends HttpServlet {

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			//�������ݿ�����
			Context initCtx=new InitialContext();
			Context encCtx=(Context)initCtx.lookup("java:comp/env");
			DataSource ds=(DataSource)encCtx.lookup("jdbc/mssql2014");
			Connection con=ds.getConnection();
			Statement st=null;
			ResultSet rs=null;
			//��ȡsession�����������ж�ȡ�û�����������ݿ��ѯ
			HttpSession session=request.getSession();
			//���ñ��뷽ʽ
			request.setCharacterEncoding("UTF-8");
			//���¾�Ϊ��AJAX��ȡ������������
			String name=request.getParameter("name");
			String action=request.getParameter("action");
			String username=request.getParameter("username");
			String changename=request.getParameter("changename");
			String changesex=request.getParameter("changesex");
			String changesubject=request.getParameter("changesubject");
			String changeacademy=request.getParameter("changeacademy");
			String changeno=request.getParameter("changeno");
	        String changephone=request.getParameter("changephone");
			String changeclass=request.getParameter("changeclass");
			String changecardnumber=request.getParameter("changecardnumber");
			String changeprince=request.getParameter("changeprince");
			String changebirthday=request.getParameter("changebirthday");
			String changeemail=request.getParameter("changeemail");
			String changepwd=request.getParameter("changepwd");
			String cno=request.getParameter("classno");
			String cname=request.getParameter("classname");
			String academy=request.getParameter("academy");
			String changecno_classinfo=request.getParameter("changecno");
			String changecname_classinfo=request.getParameter("changecname");
			String changeacademy_classinfo=request.getParameter("changeacademy");
			//���Թ���Ա��ɫ�����޸���Ϣʱ����֤������Ϣ��Ч��Ϊ�գ����������쳣
			if(changename!=null&&changesex!=null&&changesubject!=null&&changeacademy!=null&&changesex!=null&&changecardnumber!=null&&changeprince!=null&&changebirthday!=null&&changeemail!=null)
			{
				changename=new String(request.getParameter("changename").getBytes("ISO8859_1"));
			    changesex=new String(request.getParameter("changesex").getBytes("ISO8859_1"));
			    changesubject=new String(request.getParameter("changesubject").getBytes("ISO8859_1"));
			    changeacademy=new String(request.getParameter("changeacademy").getBytes("ISO8859_1"));
			    changeprince=new String(request.getParameter("changeprince").getBytes("ISO8859_1"));    
			}
			//���nameת������Ҫ,����Ĳ�ͬ����Ҫ����д���ſ��Ի����ȷ�ĺ���
			if(name!=null)
			    name=new String(request.getParameter("name").getBytes("ISO8859_1"));
			if(username!=null)
			    username=new String(request.getParameter("username").getBytes("ISO8859_1"));
			System.out.println("�û�����"+username);
			System.out.println("����:"+name+" action:"+action);
			String kind=request.getParameter("kind");
			System.out.println("Kind:"+kind);
			//����response�ĸ�ʽ
			response.setContentType("text/xml;charset=UTF-8");
			response.setHeader("Cache-Control", "no-cache");
            //������������������XML�ļ�,������ҳ�����
			PrintWriter out = response.getWriter();
			out.println("<response>");//����XML�ļ�ͷ��XML�ļ�����ѧ����ϸѧ����Ϣ
			//ѧ����ɫ��ѯ�ɼ�ʱ��ʵ�������Զ���ȫ�Ĺ��ܣ������»��˵������ưٶ�������
			if("match".equals(action))
			{
				 //���ݿ��ѯ����ʾʹ��LIKE�����йؼ���ƥ��
			     String query="SELECT CourseName FROM CourseInfo WHERE CourseName LIKE'"+name+"%'";
				 st=con.createStatement();
				 rs=st.executeQuery(query);
				 while(rs.next())
				 {
					out.println("<res>"+rs.getString(1)+"</res>");
				 }
				 st.close();
				 rs.close();
				 con.close();
			}
			//������ѧ����ɫ�����ѯ�ɼ��¼�
			else if("search".equals(action))
			{  	
				PreparedStatement ps=null;
				ps=con.prepareStatement("SELECT CourseInfo.CourseNo,CourseInfo.CourseName,CourseInfo.Grade,SC.Result FROM SC,CourseInfo WHERE CourseInfo.CourseNo=SC.CourseNo AND CourseInfo.CourseName=? AND SC.Result!=0 AND SC.StudentNo=?");
				ps.setString(1,name);
				ps.setString(2,username);
				rs=ps.executeQuery();
				while(rs.next())
				{
					System.out.println(rs.getString(1));
					System.out.println(rs.getString(2));
					System.out.println(rs.getString(3));
					System.out.println(rs.getString(4));
					
					out.println("<courseno>"+rs.getString(1)+"</courseno>");
					out.println("<coursename>"+rs.getString(2)+"</coursename>");
					out.println("<coursegrade>"+rs.getString(3)+"</coursegrade>");
					out.println("<result>"+rs.getString(4)+"</result>");
				}
				rs.close();
				con.close();
			}
			//�Թ���Ա��ɫ�����ѯѧ����Ϣ�¼�
			else if("search_student".equals(action))
			{  
				//��Ϊ���ֱ�׼��ѯ����ѧ�ţ������������༶��
				PreparedStatement ps=null;
				//��ѧ��
			    if("0".equals(kind))
			    {	
				   ps=con.prepareStatement("SELECT StudentInfo.StudentNo,StudentInfo.Name,StudentInfo.Phone,StudentInfo.Sex,StudentInfo.Subject,StudentInfo.ClassNo,StudentInfo.Academy,StudentInfo.CardNumber,StudentInfo.Prince,StudentInfo.BirthDay,StudentInfo.Email,UserInfo.Password FROM StudentInfo,UserInfo WHERE  StudentInfo.StudentNo=UserInfo.Name AND StudentInfo.StudentNo=?");
				   ps.setString(1,name);
			    }
			    //������
			    else if("1".equals(kind))
			    {
				   ps=con.prepareStatement("SELECT StudentInfo.StudentNo,StudentInfo.Name,StudentInfo.Phone,StudentInfo.Sex,StudentInfo.Subject,StudentInfo.ClassNo,StudentInfo.Academy,StudentInfo.CardNumber,StudentInfo.Prince,StudentInfo.BirthDay,StudentInfo.Email,UserInfo.Password FROM StudentInfo,UserInfo WHERE  StudentInfo.StudentNo=UserInfo.Name AND StudentInfo.Name=?");
				   ps.setString(1,name);
			    }
			    //���༶��
			    else if("2".equals(kind))
			    { 
				   ps=con.prepareStatement("SELECT StudentInfo.StudentNo,StudentInfo.Name,StudentInfo.Phone,StudentInfo.Sex,StudentInfo.Subject,StudentInfo.ClassNo,StudentInfo.Academy,StudentInfo.CardNumber,StudentInfo.Prince,StudentInfo.BirthDay,StudentInfo.Email,UserInfo.Password FROM StudentInfo,UserInfo WHERE  StudentInfo.StudentNo=UserInfo.Name AND StudentInfo.ClassNo=?");
				   ps.setString(1,name);
			    }  
			    else if("3".equals(kind))
			    {
				   ps=con.prepareStatement("SELECT StudentInfo.StudentNo,StudentInfo.Name,StudentInfo.Phone,StudentInfo.Sex,StudentInfo.Subject,StudentInfo.ClassNo,StudentInfo.Academy,StudentInfo.CardNumber,StudentInfo.Prince,StudentInfo.BirthDay,StudentInfo.Email,UserInfo.Password FROM StudentInfo,UserInfo WHERE  StudentInfo.StudentNo=UserInfo.Name");
			    }
			   //ִ�в�ѯ
               rs=ps.executeQuery();
			   //����XML�ļ�
			   while(rs.next())
			   {
					out.println("<studentno>"+rs.getString(1)+"</studentno>");//ѧ��
					out.println("<studentname>"+rs.getString(2)+"</studentname>");//ѧ������
					out.println("<studentphone>"+rs.getString(3)+"</studentphone>");//�绰
					out.println("<studentsex>"+rs.getString(4)+"</studentsex>");//�Ա�
					out.println("<studentsubject>"+rs.getString(5)+"</studentsubject>");//רҵ
					out.println("<studentclass>"+rs.getString(6)+"</studentclass>");//�༶
					out.println("<studentacademy>"+rs.getString(7)+"</studentacademy>");//ѧԺ
					out.println("<studentcardnumber>"+rs.getString(8)+"</studentcardnumber>");//���֤
					out.println("<studentprince>"+rs.getString(9)+"</studentprince>");//����
					out.println("<studentbirthday>"+rs.getString(10)+"</studentbirthday>");//��������
					out.println("<studentemail>"+rs.getString(11)+"</studentemail>");//ѧ���ʼ�
					out.println("<studentpwd>"+rs.getString(12)+"</studentpwd>");//ѧ������
			   }
			   rs.close();
			   con.close();//B/S�²������ݿ�����ӣ���ѯ��ɺ󼴹ر����ݿ�����
			   
			}
			//����Ա��ɫɾ��ѧ����Ϣ
			else if("delete".equals(action))
			{
				PreparedStatement ps=null;
				PreparedStatement ps_user=null;
				System.out.println("Ҫɾ������"+name);
				//����ɾ�����
				ps=con.prepareStatement("DELETE  FROM StudentInfo WHERE StudentNo=?");  
				ps.setString(1,name);
				ps.execute();
				ps_user=con.prepareStatement("DELETE  FROM UserInfo WHERE Name=?"); 
				ps_user.setString(1,name);
				ps_user.execute();
				con.close();
			}
			//����Ա��ɫ�޸�ѧ����Ϣ
			else if("change".equals(action))
			{
				PreparedStatement ps=null;
				PreparedStatement ps_user=null;
				PreparedStatement ps_check=null;//������ѧ����Ϣ�еİ༶�Ƿ���ClassInfo�д���
				ResultSet rs_check=null;
				System.out.println("Ҫ���ĵ��� "+name+" changename to "+changename+" changeno to "+changeno+" changephone to "+changephone+" changesex to "+changesex+" changeclassto "+changeclass+" changesubject to "+changesubject+" changeacademy to "+changeacademy+" changepwd to "+changepwd);
				//�ȹ�����ѯ��䣬����޸ĵİ༶���Ƿ����
				ps_check=con.prepareStatement("SELECT * FROM ClassInfo WHERE ClassNo=?");
				ps_check.setString(1,changeclass);
				rs_check=ps_check.executeQuery();
				if(rs_check.next())
				{
				ps=con.prepareStatement("UPDATE StudentInfo SET StudentNo=?,Name=?,Phone=?,Sex=?,Subject=?,ClassNo=?,Academy=? WHERE StudentNo=?");  
				ps.setString(1,changeno);
				ps.setString(2,changename);
				ps.setString(3,changephone);
				ps.setString(4,changesex);
				ps.setString(5,changesubject);
				ps.setString(6,changeclass);
				ps.setString(7,changeacademy);
				ps.setString(8,name);
				ps.execute();
				ps_user=con.prepareStatement("UPDATE UserInfo SET Password=? WHERE Name=?"); 
				ps_user.setString(1,changepwd);
				ps_user.setString(2,name);
				ps_user.execute();	
				}
				else 
				{
					//��ӵ�ѧ���İ༶������
					out.println("<message>"+"�޸�ʧ�ܣ�ԭ���޸ĵİ༶�����ڣ�"+"</message>");
				}
				rs_check.close();
				con.close();
			}
			//����Ա��ɫ���ѧ����Ϣ
			else if("add".equals(action))
			{
				PreparedStatement ps=null;
				PreparedStatement ps_user=null;//�����UserInfo����
				PreparedStatement ps_check_class=null;//������ѧ����Ϣ�еİ༶�Ƿ���ClassInfo�д���
				PreparedStatement ps_check_sno=null;//�����ӵ�ѧ���Ƿ����
				ResultSet rs_check_class=null;
				ResultSet rs_check_sno=null;
				System.out.println("Ҫ��ӵ��� "+" changename to "+changename+" changeno to "+changeno+" changephone to "+changephone+" changesex to "+changesex+" changeclassto "+changeclass+" changesubject to "+changesubject+" changeacademy to "+changeacademy+" changepwd to "+changepwd);
				//�ȼ�����ѧ����Ϣ�İ༶���Ƿ����
				ps_check_class=con.prepareStatement("SELECT * FROM ClassInfo WHERE ClassNo=?");
				ps_check_class.setString(1,changeclass);
				rs_check_class=ps_check_class.executeQuery();
				ps_check_sno=con.prepareStatement("SELECT * FROM StudentInfo WHERE StudentNo=?");
				ps_check_sno.setString(1,changeno);
				rs_check_sno=ps_check_sno.executeQuery();
				if(rs_check_class.next())
				{
					if(!rs_check_sno.next())
					{
						out.println("<message>"+"#"+"</message>");//��ʾ�������
					    ps=con.prepareStatement("INSERT INTO StudentInfo(StudentNo,Name,Phone,Sex,Subject,ClassNo,Academy,CardNumber,Prince,Birthday,Email) VALUES (?,?,?,?,?,?,?,?,?,?,?)");  
					    ps.setString(1,changeno);
					    ps.setString(2,changename);
						ps.setString(3,changephone);
						ps.setString(4,changesex);
						ps.setString(5,changesubject);
						ps.setString(6,changeclass);
						ps.setString(7,changeacademy);
						ps.setString(8,changecardnumber);
						ps.setString(9,changeprince);
						ps.setString(10,changebirthday);
						ps.setString(11,changeemail);
						ps.execute();
						ps_user=con.prepareStatement("INSERT INTO UserInfo VALUES (?,?,2)"); 
					    ps_user.setString(1,changeno);
					    ps_user.setString(2,changepwd);
					    ps_user.execute();
					}
					else 
					{
						//��ӵ�ѧ���İ༶������
						out.println("<message>"+"���ʧ�ܣ�ԭ�����ѧ���Ѵ��ڣ�"+"</message>");
					}		
				}
				else
				{
					//��ӵ�ѧ���İ༶������
					out.println("<message>"+"���ʧ�ܣ�ԭ����Ӱ༶�����ڣ�"+"</message>");
				}
				rs_check_class.close();
				rs_check_sno.close();
				ps_check_class.close();
				ps_check_sno.close();
				con.close();
			}
			//��ʦ��ɫʵ�������γ̹ؼ��ֲ�ȫ
			else if("teachermatch".equals(action))
			{
				 String query="SELECT CourseName FROM CourseInfo WHERE CourseName LIKE'"+name+"%'";
				 st=con.createStatement();
				 rs=st.executeQuery(query);
				 
				 while(rs.next())
				 {
					out.println("<res>"+rs.getString(1)+"</res>");
				 }
				 st.close();
				 rs.close();
				 con.close();
			}
			//��ʦ��ɫʵ�ֲ�ѯ�γ�
			else if("search_course".equals(action))
			{
			   PreparedStatement ps=null;   
			   ps=con.prepareStatement("SELECT CourseInfo.CourseNo,CourseInfo.CourseName,CourseInfo.StudyTime,CourseInfo.Grade,CourseInfo.Term,CourseInfo.WhentoStudy FROM CourseInfo,TC WHERE TC.TeacherNo=? AND TC.CourseNo=CourseInfo.CourseNo");  	  
			   ps.setString(1,name);		   
			   rs=ps.executeQuery();
			   while(rs.next())
			   {
					out.println("<courseno>"+rs.getString(1)+"</courseno>");//�γ̺�
					out.println("<coursename>"+rs.getString(2)+"</coursename>");//�γ���
					out.println("<cst>"+rs.getString(3)+"</cst>");//��ʱ
					out.println("<grade>"+rs.getString(4)+"</grade>");//ѧ��
					out.println("<term>"+rs.getString(5)+"</term>");//����ѧ��
					out.println("<cwt>"+rs.getString(6)+"</cwt>");//�Ͽ�ʱ��
			 }
			  
			rs.close();
			con.close();    
			}
			//�����༶
			else if("search_class".equals(action))
			{
			   
			   PreparedStatement ps=null;
			
			   ps=con.prepareStatement("SELECT * FROM ClassInfo");
				   
			   rs=ps.executeQuery();
			   //����XML�ļ�
			   while(rs.next())
			   {
				    System.out.println("�༶��"+rs.getString(1));
					out.println("<classno>"+rs.getString(1)+"</classno>");//�༶��
					out.println("<classname>"+rs.getString(2)+"</classname>");//�༶��
					out.println("<academy>"+rs.getString(3)+"</academy>");//ѧԺ	
			   }
			   rs.close();
			   con.close(); 
			}
			//����Ա�����Ӱ༶
			else if("add_class".equals(action))
			{
				PreparedStatement ps=null;
				PreparedStatement ps_check=null;//������ѧ����Ϣ�еİ༶�Ƿ���ClassInfo�д���
				ResultSet rs_check=null;
				ps_check=con.prepareStatement("SELECT * FROM ClassInfo WHERE ClassNo=?");
				ps_check.setString(1,changecno_classinfo);
				rs_check=ps_check.executeQuery();
				if(!rs_check.next())//��ʾ�༶�Ų����ڣ������
				{
					out.println("<message>"+"#"+"</message>");//���͸���Ϣ����ʾ�������
				ps=con.prepareStatement("INSERT INTO ClassInfo(ClassNo,ClassName,College) VALUES (?,?,?)");  
				ps.setString(1,changecno_classinfo);
				ps.setString(2,changecname_classinfo);
				ps.setString(3,changeacademy_classinfo);
				ps.execute();
				}
				else 
				{
					//��ӵİ༶�Ѵ��ڣ����ʧ��
					out.println("<message>"+"���ʧ�ܣ�ԭ����Ӱ༶�Ѵ��ڣ�"+"</message>");
				}
				rs_check.close();
				con.close();
			}
			out.println("</response>");
			out.close();
			
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}
	public void init() throws ServletException {
		// Put your code here
	}

}
