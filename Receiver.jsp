<%@page import="java.sql.*"%>
<%@page import="java.sql.*"%>
<%@page import = "java.util.logging.Logger" %>
      <% Logger logger = Logger.getLogger(this.getClass().getName());%>
<%!
Connection con;
Statement st;
ResultSet rs;
int flag;
long phone_no;
int available_quantity=0;
String Address,Name,surname;
public void jspInit()
{
	try
	{
	 Class.forName("com.mysql.jdbc.Driver"); 
     con= DriverManager.getConnection("jdbc:mysql://localhost:3306/covid_project","root","root");
     st=con.createStatement();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
}
	public void jspDestroy()
	{
		try
		{
			
			con.close();
			st.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

%>
<%
String Obj=request.getParameter("obj");
int Quantity=Integer.parseInt(request.getParameter("Quantity"));

logger.info(request.getParameter("Quantity"));
%>

<%
try
{
String sql1=("select quantity from project where object='"+Obj+"'");

rs=st.executeQuery(sql1);
logger.info(sql1);
if(rs.next())
{
	
	available_quantity=rs.getInt(1);

}
logger.info("available");
logger.info(String.valueOf(available_quantity));
if(available_quantity==0)
{
	flag=2;
}
rs.close();
}
catch(Exception e)
	{
		e.printStackTrace();
		
	}

%>
<%

//logger.info(String.valueOf(available_quantity));
if(available_quantity>=Quantity)
{
	flag=1;
	logger.info(String.valueOf(available_quantity));
try
{
	String sql=("select Address from project where object='"+Obj+"'");
	
	rs=st.executeQuery(sql);
	
	if(rs.next())
	{
		
		Address=rs.getString(1);
	}
logger.info(Address);
	rs.close();
    }
		catch(Exception e)
		 {
			 e.printStackTrace();
		 }
try
{
	String sql=("select Name from project where object='"+Obj+"'");
	
	rs=st.executeQuery(sql);
	
	if(rs.next())
	{
		
		Name=rs.getString(1);
	}

	rs.close();
    }
		catch(Exception e)
		 {
			 e.printStackTrace();
		 }
try
{
	String sql=("select surname from project where object='"+Obj+"'");
	
	rs=st.executeQuery(sql);
	
	if(rs.next())
	{
		
		surname=rs.getString(1);
	}

	rs.close();
    }
		catch(Exception e)
		 {
			 e.printStackTrace();
		 }
try
{
	String sql=("select Phone_no from project where object='"+Obj+"'");
	
	rs=st.executeQuery(sql);
	
	if(rs.next())
	{
		
		phone_no=rs.getLong(1);
	}

	rs.close();
    }
		catch(Exception e)
		 {
			 e.printStackTrace();
		 }

}
%>
<% if(available_quantity>=Quantity)
{
try
	    {
	    logger.info("try in");
		 String sql=("Update project Set quantity=quantity-"+Quantity+ " where Address ='"+Address+"'");
		logger.info(sql);
		int isUpdateSuccess= st.executeUpdate(sql);
	    }
	 catch(Exception e)
	 {
		 e.printStackTrace();
	}
}
%>
<%
try
{logger.info("22");

	String sql2=("ALTER TABLE project order by quantity desc");
	//rs=st.executeQuery(sql2);
	  st.execute(sql2);
	logger.info(sql2);

	
}
catch(Exception e)
{
	e.printStackTrace();
	
}
%>
<html>
<style><%@include file="donar.css"%></style>
<body>

<div class=donar>
<% if (flag==1) { %>
         <h1> Welcome,</h1>
         <h2>Available Donar:-<%=Name%> <%=surname%></h2>
         <h2>Address:-<%=Address%>,Pune </h2>
         <h2>Contact no:-<%=phone_no%></h2>
      <% } else { %>
      <% }if(flag==2){ %>
      <h1>Sorry for inconvenience Demanded object is unavailable at this time.</h1>
       <% }if(flag==0){ %> 
       <h1>Try for small quantity </h1>
      <% } %>
      </div>
<div class=anchor>
<a href="Index.html">Return to Homescreen</a>
</div>
</body></html>








