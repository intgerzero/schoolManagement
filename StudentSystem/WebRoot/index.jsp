<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%!
   String username;
%>
<%
   username=(String)session.getAttribute("userid");
%>
<html>
<head>
   <title>ѧ����Ϣ���� </title>
   <link rel="stylesheet" type="text/css" href="style.css" />
   	<style type="text/css">
		#main
		{
		 background-image:url(iframe.jpg);
		 background-repeat:no-repeat;
         text-align:center ;
	     overflow:hidden;
         width: 100%;
	     height:85%;
        }
        #main iframe{
        	width:100%;
        	height: 100%;
        	border:0px;
        }
		</style>
		<script language="javascript">
		 function displayTime()
		 {
		    var vw = new Array("������","����һ","���ڶ�","������","������","������","������");     
		    var today=new Date();  
		    var day = today.getDate(); 
		    var month = today.getMonth() + 1;  //��ȡ�·�
            var year = today.getFullYear();   //��ȡ���
            var week = today.getDay();       //��ȡ������     
		    var hours=today.getHours();         
		    var minutes=today.getMinutes();
		    var seconds=today.getSeconds();         
		    minutes=fixTime(minutes);        
		    seconds=fixTime(seconds);
		    var current_time=hours+":"+minutes+":"+seconds;
		    var year_month=year+ "��" + month + "��"+day+"��"+vw[week];
		    document.all.showTime.value=current_time;
		    document.all.showyearmonth.value=year_month;
		    the_timeout=setTimeout('displayTime();',500);    
		    }
		   function fixTime(the_time){            
		   if(the_time<10)
		   {        
		     the_time="0"+the_time;          
		   }          
		   return the_time;     
		   }//�޶�ʱ����ʾ  
		   function move(image,num)
		   {
		     image.src='../images/menu'+num+'.jpg';
		   }
		   function out(image,num)
		   {
		     image.src='../images/menu_out'+num+'.jpg';
		   }
		</script>
</head>


<body onload="displayTime()">

	<div id="head" >
	    <div id="time" name="mytime">
	       ��ǰʱ�䣺<br>
	       <p><input type="text" name="showyearmonth" style="border:0px;background:rgba(0, 0, 0, 0); "></p>
	      <input type="text" name="showTime" style="border:0px;background:rgba(0, 0, 0, 0); ">
	    </div>
	    <div id="status">
	      <form action="Studentservlet" method="post">
	      	�û�����<%=username%>
	        <input type="hidden" name="item" value="exit">
	        <input type="submit" name="submit" value="ע��">
	      </form>
        </div>
        <div id="menu">
	        <h2>Welcome to Student System!</h2>

	         <a href="index.jsp" >��ҳ</a>
	         <a href="StudentInfo.jsp" target="show" ><span>������Ϣ</span></a>
	         <a href="CourseInfo.jsp" target="show"><span>ѡ�β�ѯ </span></a>
	         <a href="GradeInfo.jsp" target="show"><span>�ɼ���ѯ </span></a>

	    </div>
    </div>
    <div id="main" >

	  <iframe id="show" name="show" src=""></iframe>
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
