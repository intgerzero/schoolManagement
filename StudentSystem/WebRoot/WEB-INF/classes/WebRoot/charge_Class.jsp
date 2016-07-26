<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<html>
  <head>
   <style type="text/css">
   #head
   {
      width:100%;
      height:50px;
      background:#CDB38B;
   }
   #main
   {
      width:100%;
      height:600px;
      background:#EAEAEA;
   }
   #nextpage
   {
     width:100%;
     height:30px;
     background:#EAEAEA;
   }
   .tablelist tr:hover,.tablelist tr.backrow
   {
      background-color:#c4c4ff;
   }
   </style>
   <script lang="javascript">
        var XMLHttpReq;
        var message;
        var inputField;
        var cno;
        var cname;
        var academy;
        var pageSum=1;
        var lastpagenode;
        var currentpage=1;
        var page=new Array(30);
        //����AJAX����
        function createXMLHttpRequest()
        {
            //���ݲ�ͬ�����������
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
        //��ѯѧ����Ϣ ��after_add_class ��ʾ�Ƿ������ѧ��ֻ�����ʾ����Ϊ��Ҫ��ȡ�༶��Ϣ
        //��Ϊ������ѯ����ɾ���͸�����Ϣ����֮�󣬲�ѯ������������ҳ���У�����Ҫ�ٴ�����
        //�����ѧ��֮���������ţ��԰������ѯ���֮������
        function search(after_add_class)
        { 
           var url;
           createXMLHttpRequest();
           if(after_add_class!=null)
           {
              url="autoComplete?action=search_class&name="+after_add_class;
           }
           else
           {
             inputField=document.getElementById("search");
             kind=document.getElementById("kind");
             var url="autoComplete?action=search_class";
           }
           XMLHttpReq.open("GET",url,true);
           XMLHttpReq.onreadystatechange=processSearchResponse;
           XMLHttpReq.send(null);
        }
        //״̬��Ӧ����
        function processSearchResponse()
        {
          if(XMLHttpReq.readyState==4)
          {
             if(XMLHttpReq.status==200)
             {
                //�����������㣬���ʾ��Ӧ����
                clearNames();
                //����Ϊ��autoComplete�л�ȡ��XML�ļ��н�������
                cno=XMLHttpReq.responseXML.getElementsByTagName("classno");
                cname=XMLHttpReq.responseXML.getElementsByTagName("classname");
                academy=XMLHttpReq.responseXML.getElementsByTagName("academy");
                var size=cno.length;//��ȡ��Ϣ������С�����ڷ�ҳ��ʾ
                //һҳ����5����¼
                if(size<=5)
                   pageSum=1;
                for(var k=1;k<=size;k++)
                  if(k>5)
                  {
                     size=size-5
                     k=1;
                     pageSum++;
                  }    
                lastpagenode=size%5;
                for(var j=1;j<=pageSum;j++)
                   page[j]=5;
                if(lastpagenode!=0)
                   page[pageSum]=lastpagenode;
                document.getElementById("currentpage").value=currentpage;
                document.getElementById("sumpage").value=pageSum;
                
                for(var i=0;i<page[1];i++)
                {
                   showitems(i);
                }
             }
          }
        }
        //���������ҳ���ϳ��ֵ���Ϣ���
        function clearNames()
        {
           var sortlist=document.getElementById("sortlist");
           var ind=sortlist.childNodes.length;
           for(var i=ind;i>0;i--)
           {
                 sortlist.removeChild(sortlist.childNodes[i-1]);
           }  
        }
        //�����һҳ
        function forwardpage()
        {
           if(currentpage>1)
           {
                currentpage--;
                document.getElementById("currentpage").value=currentpage;
                clearNames();
                for(var i=(currentpage-1)*5;i<(currentpage-1)*5+page[currentpage];i++)
                {
                   showitems(i);
                }              
           }
        }
        //�����һҳ
        function nextpage()
        {
           if(currentpage<pageSum)
           {
                currentpage++;
                document.getElementById("currentpage").value=currentpage;
                clearNames();
                for(var i=(currentpage-1)*5;i<(currentpage-1)*5+page[currentpage];i++)
                {
                   showitems(i);
                }
       }
       }
        //��ѧ�����֮ǰ�������
       function before_add_showinfo()
       {
             clearNames();
             var row,cell_cno,cell_cname,cell_academy;
             row=document.createElement("tr");        
             cell_cno=document.createElement("td");
             var cnochange=document.createElement("input");
             cnochange.setAttribute("type","text");
             cnochange.setAttribute("width","20px");
             cnochange.setAttribute("id","textcno");
             cell_cno.appendChild(cnochange);
             row.appendChild(cell_cno);
             
             cell_cname=document.createElement("td");
             var cnamechange=document.createElement("input");
             cnamechange.setAttribute("type","text");
             cnamechange.setAttribute("width","20px");
             cnamechange.setAttribute("id","textcname");
             cell_cname.appendChild(cnamechange);
             row.appendChild(cell_cname);
               
             cell_academy=document.createElement("td");
             var academychange=document.createElement("input");
             academychange.setAttribute("type","text");
             academychange.setAttribute("width","20px");
             academychange.setAttribute("id","textacademy");
             cell_academy.appendChild(academychange);
             row.appendChild(cell_academy);
             
             cell_deleteinfo=document.createElement("td");
             var deleteinfo=document.createElement("input");
             deleteinfo.setAttribute("type","button");
             deleteinfo.setAttribute("value","ȷ��");
             deleteinfo.onclick=function(){addinfo();};
             cell_deleteinfo.appendChild(deleteinfo);
             row.appendChild(cell_deleteinfo);
             
             cell_deleteinfo=document.createElement("td");
             var deleteinfo=document.createElement("input");
             deleteinfo.setAttribute("type","button");
             deleteinfo.setAttribute("value","ȡ��");
             deleteinfo.onclick=function(){window.location.href ="charge_Class.jsp";};
             cell_deleteinfo.appendChild(deleteinfo);
             row.appendChild(cell_deleteinfo);   
             document.getElementById("sortlist").appendChild(row);
       }
       //��Ӱ༶��Ϣ
       function addinfo()
       {
           createXMLHttpRequest();
           var no=document.getElementById("textcno").value;
           var name=document.getElementById("textcname").value;
           var academy=document.getElementById("textacademy").value;
           if(no.length!=0&&name.length!=0&&academy.length!=0)
           {
              
              var url="autoComplete?action=add_class&changecno="+no+"&changecname="+name+"&changeacademy="+academy;
              XMLHttpReq.open("GET",url,true);
              XMLHttpReq.onreadystatechange=addStateChange;
              XMLHttpReq.send(null); 
           }
           else 
              alert("������������Ϣ");
       }
       //״̬��Ӧ����
       function addStateChange()
       {
           if(XMLHttpReq.readyState==4)
          {
             if(XMLHttpReq.status==200)
             {
                var after_add_class=document.getElementById("textcno").value;
                message=XMLHttpReq.responseXML.getElementsByTagName("message");
                //������ʾ������Ϣ��������İ�Ų�����ʱ���������
                if(message[0].firstChild.data!="#")
                {
                   alert(message[0].firstChild.data);
                }
                pageSum=1;
                search(after_add_class);
             }
          }
       }
       //��ʾ��Ϣ
       function showitems(i)
       {
             var cno_nextNode=cno[i].firstChild.data;
             var cname_nextNode=cname[i].firstChild.data;
             var academy_nextNode=academy[i].firstChild.data;
             var row,cell_cno,cell_cname,cell_academy;
             row=document.createElement("tr");
                 
             cell_cno=document.createElement("td");
             cell_cno.appendChild(document.createTextNode(cno_nextNode));
             row.appendChild(cell_cno);
                   
             cell_cname=document.createElement("td");
             cell_cname.appendChild(document.createTextNode(cname_nextNode));
             row.appendChild(cell_cname);
             
             cell_academy=document.createElement("td");
             cell_academy.appendChild(document.createTextNode(academy_nextNode));
             row.appendChild(cell_academy);
                         
             document.getElementById("sortlist").appendChild(row);
        }
        //�����Ǳ�ѡ�е��б�ɫ
        var rows=document.getElementByTagName('tr');
        for(var i=0;i<rows.length;i++)
        {
            rows[i].onmouseover=function()
            {
               this.className='backrow';
            }
            rows[i].onmouseout=function()
            {
               this.className=this.className.replace('backrow','');
            }
 
        }
   </script>
  </head>
<body>
   <div id="head" align="center">
     <table>
       <tr>
         <td>
           <input type="button" onclick="search();" value="�����ʾ���а༶">
         </td>
       </tr>
       <tr>
         <td>
         <input type="button" value="***��Ӱ༶***" onclick="before_add_showinfo();">
         </td>
         <td> </td>
         <td> </td>
         <td><br>
       </tr>
     </table>
   </div>
   <div id="main" align="center">
    <table border="1px" width="1300px" class='tablelist'>
     <tr>
          <td align="center" width="20px">���</td>
          <td align="center" width="20px">����</td>
          <td align="center" width="20px">ѧԺ</td>
          <td align="center" width="20px">����</td>
          <td align="center" width="20px">����</td>
     </tr>
     <tbody id="sortlist">
     </tbody>
    </table>
   </div>
   <div id="nextpage" align="center">
      ��<input type="text" id="currentpage" style="width:20px" readonly="true">ҳ&nbsp;&nbsp;&nbsp;
      <input type="button" value="��һҳ" onclick="forwardpage();">&nbsp;
      <input type="button" value="��һҳ" onclick="nextpage();">&nbsp;&nbsp;&nbsp;
      ��<input type="text" id="sumpage" style="width:20px" readonly="true">ҳ
    </div>
  </body>
</html>
