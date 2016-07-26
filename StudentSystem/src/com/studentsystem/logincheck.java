package com.studentsystem;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
 * ��������¼��servlet���������¼�ߵ���ݽ�����֤���Գɹ��ĵ�¼�߰�����ݵĲ�ͬ
 * ת��ͬ��ҳ��
 * @version 1.0
 * @author LBJ
 *
 */
public class logincheck extends HttpServlet {

	public void destroy() {
		super.destroy(); 
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        try {
        	//�������ݿ�
			Context initCtx=new InitialContext();
			Context encCtx=(Context)initCtx.lookup("java:comp/env");
			DataSource ds=(DataSource)encCtx.lookup("jdbc/mssql2014");
			Connection con=ds.getConnection();
			//�ӱ�����ȡ��¼�ߵ�id�����룬����
			String username=request.getParameter("UserID");
			String password=request.getParameter("UserPWD");
			String kind=request.getParameter("Kind");
			//����session�����־û�
			HttpSession session=request.getSession();
			session.setAttribute("userid", username);
			session.setAttribute("UserPWD", password);
			session.setAttribute("UserName", username);	
			//��ѯ���ݿ���userinfo�����鿴�Ƿ��и��û�
			PreparedStatement ps=con.prepareStatement("SELECT * FROM UserInfo WHERE Name=? and Password=? and Kind=?");
			ps.setString(1,username);
			ps.setString(2,password);
			ps.setString(3,kind);
			ResultSet rs=ps.executeQuery();
			
			boolean flag=rs.next();//ע��˴��������������if��ʹ��rs.next()����Ϊ���ǽ����ָ������
			
            if(flag&&kind.equals("0"))	
            {	
            	//�������Ա��Ϣ����
            	request.setAttribute("success",username+password);
            	request.getRequestDispatcher("/Admin.jsp").forward(request, response);
            }
            else if(flag&&kind.equals("1"))	
            {	
            	//�����ʦ��Ϣ����
            	request.setAttribute("success",username+password);
            	List<Student> MyStudent=new ArrayList<Student>();
            	session.setAttribute("MyStudentinfo",MyStudent);
            	request.getRequestDispatcher("/Teacher.jsp").forward(request, response);
            }
            else if(flag&&kind.equals("2"))	
            {	
            	//����ѧ����Ϣ����
            	request.setAttribute("success",username+password);
            	request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
            else 
            {
            	session.setAttribute("message","�û��������ڻ���ѡ�����ݴ���");
            	request.getRequestDispatcher("/Login.jsp").forward(request, response);	
            }
            //B/Sģʽ�����ݿ�����ӦΪ�����ӣ��輰ʱ�Ͽ����ݿ�����
			rs.close();
			ps.close();
			con.close();
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