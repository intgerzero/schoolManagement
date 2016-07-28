<%@ page language="java" import="java.util.*,java.sql.*,javax.sql.*,javax.naming.*,javax.servlet.http.HttpSession,com.studentsystem.*" pageEncoding="gb2312"%>
<%!
   String username;   
   List<Student> Studentinfo=new ArrayList<Student>();
   Student temp;  
   String coursename;
%>
<% 
   username=(String)session.getAttribute("userid");
   Studentinfo=(List<Student>)session.getAttribute("MyStudentinfo");  
%>
<html>
   <!-- ʵ��AJAX��ѯ�Զ���ȫ�б� -->
   <!-- ҳ�����Ϊgb2312��serverlt��λΪUTF-8 -->
  <head >
  <style type="text/css">
   #main
   {
      width:100%;
      height:100px;
      background:#EAEAE0;
   }
    #result
   {
      width:100%;
      height:600px;
      background:#EAEAEA;
   }
  </style>
   <script language="javascript">
        var XMLHttpReq;
        var completeDiv;
        var inputField;
        var completeTable;
        var completeBody;
        function createXMLHttpRequest()
        {
            if(window.XMLHttpRequest)
            {
             XMLHttpReq=new XMLHttpRequest();
            }
            else if(window.SctiveXObject)
            {
                 try
                 {
                    XMLHttpReq=new ActiveXObject("Msxm12.XMLHTTP");     
                 }
                 catch(e)
                 {
                     try{
                       XMLHttpReq=new ActiveXObject("Microsoft.XMLHTTP");
                     }catch(e){}
                 }
            }
        }
        
        function findNames()
        {
            inputField=document.getElementById("names");
            completeTable=document.getElementById("complete_table");
            completeDiv=document.getElementById("popup");
            completeBody=document.getElementById("complete_body");
            if(inputField.value.length>0)
            {
               createXMLHttpRequest();
               var url="autoComplete?action=teachermatch&name="+inputField.value;
               XMLHttpReq.open("GET",url,true);
               XMLHttpReq.onreadystatechange=processMatchResponse;
               XMLHttpReq.send(null);
            }
            else
            {
              clearNames();
            }
            
        }
        function processMatchResponse()
        {
            if(XMLHttpReq.readyState==4)
            {
               if(XMLHttpReq.status==200)
               {
                  setNames(XMLHttpReq.responseXML.getElementsByTagName("res"));
               }
               else
               { 
                  windows.alert("����ҳ�治����!");
               }
            }
        }
        function setNames(names)
        {
            clearNames();
            var size=names.length;
            setOffsets();
            var row,cell,txtNode;
            for(var i=0;i<size;i++)
            {
               var nextNode=names[i].firstChild.data;
               row=document.createElement("tr");
               cell=document.createElement("td");
               cell.onmouseout=function(){this.className='mouseOn';};
               cell.onmouseover=function(){this.className='mouseOver';};
               cell.setAttribute("bgcolor","#FFFAFA");
               cell.setAttribute("border","0");
               cell.onclick=function(){completeField(this);};
               txtNode=document.createTextNode(nextNode);
               cell.appendChild(txtNode);
               row.appendChild(cell);
               completeBody.appendChild(row);
               
            }
        }
        function setOffsets()
        {
             completeTable.style.width=inputField.offsetWidth+"px";
             var left=calculateOffset(inputField,"offsetLeft");
             var top=calculateOffset(inputField,"offsetTop")+inputField.offsetHeight;
             completeDiv.style.border="blcak 1px solid";
             completeDiv.style.left=left+"px";
             completeDiv.style.top=top+"px";
        }
        function calculateOffset(field,attr)
        {
           var offset=0;
           while(field)
           {
              offset+=field[attr];
              field=field.offsetParent;
           }
           return offset;
        }
        function completeField(cell)
        {
           inputField.value=cell.firstChild.nodeValue;
           clearNames();         
        }
        function clearNames()
        {
           var ind=completeBody.childNodes.length;
           for(var i=ind;i>0;i--)
           {
                 completeBody.removeChild(completeBody.childNodes[i-1]);
           }  
           completeDiv.style.border="none";
        }

   </script>
  </head>
  <body bgcolor="white"> 
     <form action="Teacherservlet" method="post"  id="main">
     <input type="hidden" name="item" value="1">
     <table align="center"> 
      <tr>
           <td>����γ���:</td>
           <td>
            <input type="text" id="names" name="coursename" onkeyup="findNames();">
            <div style="position:absolute;"id="popup">
              <table id="complete_table" bgcolor="#FFFAFA" border="0">
               <tbody id="complete_body" ></tbody>
              </table>  
            </div>
           </td>
           <td>
           <input type="submit" value="ȷ��" id="submitcourse" onclick="setCourseName();" >
           </td>
     </tr>
    </table>
     </form>
    <!--�ύ�γ�����autocomplete��ȫ����TeacherServerl�в�ѯ������session�б���ѡ��ѧ������Ϣ���ɼ��ϴ�֮���͸�Teacherseverlet����  -->
     <form action="Teacherservlet" method="post"  align="center" id="result">
      <input type="hidden" name="item" value="2">
      <table border="1"  align="center">
      <tr>
        <td>ѧ��</td>
        <td>����</td>
        <td>�༶</td>
        <td>�ɼ�</td>  
      </tr>
      <tr>
       <%
         for(int i=0;i<Studentinfo.size();i++)
         {
             temp=Studentinfo.get(i); 
        %>
       <td><%=temp.getStudentNo()%></td>
       <td><%=temp.getName()%></td>
       <td><%=temp.getMyClass()%></td>
       <td><input type="text" name=<%=temp.getStudentNo()%> value=<%=temp.getCourseGrade()%>>
       </tr>
       <%
       }%>
      </table>
       <input type="submit" value="ȷ��" >
       <input type="reset" value="����">
      </form>
  </body>
</html>
