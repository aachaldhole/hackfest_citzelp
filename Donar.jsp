
<%@page import="java.sql.*"%>
<%@page import = "java.util.logging.Logger" %>
      <% Logger logger = Logger.getLogger(this.getClass().getName());%>
<%!
Connection con;
Statement st;
ResultSet rs;
int flag;
int flag2;

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

int Quantity=Integer.parseInt(request.getParameter("Quantity"));
String First_name=request.getParameter("first_name");
String Last_name=request.getParameter("last_name");
String Obj=request.getParameter("obj");

 long Phone_no=Long.parseLong(request.getParameter("Phone_No"));
String Address=request.getParameter("Address");
%>
<%
try
{
	String sql= "insert into project values('"+Obj+"',"+Quantity+",'"+First_name+"','"+Last_name+"',"+Phone_no+",'"+Address+"')";
	 logger.info( sql);
      flag=st.executeUpdate(sql);
     logger.info( sql);
}
    catch(Exception e)
	{
		e.printStackTrace();
		
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
<% if (flag>0)  %><h1>Thank You for Donating,</h1><h2>Receiver Will contact you soon on registered mobile no</h2>
<%  else  %><h2> failed</h2></div>
<div class=anchor>
<a href="Index.html">Return to Homescreen</a>
</div>
</body>
</html>

