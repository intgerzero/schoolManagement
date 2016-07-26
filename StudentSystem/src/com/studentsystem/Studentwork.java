package com.studentsystem;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 * ��������ѧ�������Servlet�������ִ����ı����ݽ��д������������ݽ���ķ���
 * @version 1.0
 * @author LBJ
 */
public class Studentwork extends HttpServlet {
   
	public void destroy() {
		super.destroy(); 
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//ȷ�������ʽ
		request.setCharacterEncoding("GBK");
		//��ȡsession���󣬼��Ự�������������ݺͳ־û�
		HttpSession session=request.getSession();
		String phone=request.getParameter("phone");//��ȡ����nameΪphone�Ķ���
		String email=request.getParameter("email");//��ȡ����nameΪemail�Ķ���
		String pwd=request.getParameter("newpwd");//��ȡ����nameΪ�޸�����Ķ���
		String hidden=request.getParameter("item");//��ȡ����nameΪitem�Ķ���
		String Coursename=request.getParameter("search_course");//��ȡ����nameΪesearch_course�Ķ���
		//ͨ��Session�־û�����ȡ�û���������ѡ�ĿΣ���ѡ�Ŀ�
		String username=(String)session.getAttribute("userid");
		List<Course> Courseinfo=(List<Course>)session.getAttribute("CanCourseinfo"); 
		List<Course> MyCourseinfo=(List<Course>)session.getAttribute("MyCourseinfo"); 
		
		System.out.println("���ر���"+hidden);
		//�޸�ѧ����Ϣ��
		if(hidden.equals("0"))
		 {
		    session.setAttribute("Phone",phone);//Ŀ�ģ���session������޸ĵ�����
		    session.setAttribute("Email",email);//Ŀ�ģ���session������޸ĵ�����
		    session.setAttribute("message","�޸ĳɹ���");
		    //����һ���µ����ݿ�������󣬶�ѧ���������Ϣ�����޸�
		    TestDB test=new TestDB();
		    test.Studenwork(username, phone, email, pwd);
		    //���ش���ǰ��ҳ��
			request.getRequestDispatcher("/Student_change.jsp").forward(request, response);
		 }
		//ѡ�δ���
		else if(hidden.equals("1"))
		{
			
			for(int i=0;i<Courseinfo.size();)
			{
				//�Կγ̺���Ϊ����checkbox��idֵ
				if((String)request.getParameter(Courseinfo.get(i).getCourseNo())!=null)
				{
					   //�ܽ᣺ÿ�������·������̣����ܱ�֤��ȷ
					   //����������������ݿ⴦��
					   TestDB test=new TestDB();
					   float newsum;
					   newsum=test.Coursework(0, Courseinfo.get(i).getCourseNo(), username);	  
					   Courseinfo.get(i).setStudentSum((int)newsum);
					   MyCourseinfo.add(Courseinfo.get(i));
					   
					   Courseinfo.remove(i);
					   i=0;//����Courseinfoÿ����һ�β������ͻ�仯��С������Ӧ�ô�i=0��ʼ���¼���
				}	
				else i++;
			}
			session.setAttribute("MyCourseinfo",MyCourseinfo);
			session.setAttribute("message","ѡ�γɹ���");
			session.setAttribute("CanCourseinfo",Courseinfo);
			request.getRequestDispatcher("/Course_select.jsp").forward(request, response);		
		}
		
		//ȡ��ѡ��
		else if(hidden.equals("2"))
		{
			int size=MyCourseinfo.size();//����MyCourseinfo.size()����for����������ÿ��ѭ�����ᶯ̬����arraylist��С�������´���
			for(int i=0;i<MyCourseinfo.size();)
			{	
				if((String)request.getParameter(MyCourseinfo.get(i).getCourseNo())!=null)
				{
					   //�ܽ᣺ÿ�������·������̣����ܱ�֤��ȷ
					   //����������������ݿ⴦��
					   TestDB test=new TestDB();
					   float newsum;
					   newsum=test.Coursework(1, MyCourseinfo.get(i).getCourseNo(), username);
					   MyCourseinfo.get(i).setStudentSum((int)newsum);
					   Courseinfo.add(MyCourseinfo.get(i));
					   MyCourseinfo.remove(i);
					   i=0;
					   System.out.println("ok");	   
			   }	
				else i++;
			}
			session.setAttribute("MyCourseinfo",MyCourseinfo);
			session.setAttribute("CanCourseinfo",Courseinfo);
			session.setAttribute("message","ȡ��ѡ�γɹ���");
			request.getRequestDispatcher("/Course.jsp").forward(request, response);	
		}
		//�ɼ���ѯ
		else if(hidden.equals("3"))
		{
			List<Course> Grade=(List<Course>)session.getAttribute("Grade");//Grade ��ʾ��������һ������GradeInfo.jsp��ͨ�������ݿ���
			List<Course> SearchGrade=new ArrayList<Course>();
			for(int i=0;i<Grade.size();i++)
			{
				if(Grade.get(i).getCouresName().equals(Coursename))
					SearchGrade.add(Grade.get(i)); 		
			}				   		   
			session.setAttribute("message","��ѯ�ɹ���"); 
			session.setAttribute("SearchGrade",SearchGrade);
			request.getRequestDispatcher("/Grade.jsp").forward(request, response);	
			
		}
		//ע������
		else if(hidden.equals("exit"))
		{
			session.removeAttribute("StudentNo");
			session.removeAttribute("Name");
			session.removeAttribute("CardNo");
			session.removeAttribute("Prince");
			session.removeAttribute("Sex");
			session.removeAttribute("Phone");
			session.removeAttribute("Subject");
			session.removeAttribute("Classnumber");
			session.removeAttribute("Email");
			session.removeAttribute("Academy");
			session.removeAttribute("userid");
			session.removeAttribute("password");
			session.invalidate();
			response.sendRedirect(request.getContextPath()+"/Login.jsp");
 		}	
	}

	public void init() throws ServletException {
		
	}
}
