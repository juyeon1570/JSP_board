<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String userid = null;
    	if(session.getAttribute("userid")!=null){
    		userid = (String)session.getAttribute("userid");
    	}
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log-inπͺ</title>
</head>
<body>
	<h2>λ‘κ·ΈμΈ</h2>
	<%
		if(userid==null){
	%>
	<form action="login_ok.jsp">
		<p>μμ΄λ: <input type="text" name="userid"></p>
		<p>λΉλ°λ²νΈ: <input type="password" name="userpw"></p>
		<p><button>λ‘κ·ΈμΈ</button></p>
	</form>
	<p>μμ§ νμμ΄ μλμ κ°μ? <a href="member.jsp">νμκ°μ</a></p>
	<%}else{ %>
	<h3><%=userid %>λ νμν©λλ€π</h3>
	<p><a href="logout.jsp">λ‘κ·Έμμ</a> | <a href='info.jsp'>μ λ³΄ μμ </a> | <a href='./board/list.jsp'>κ²μν</a></p>
	<%} %>
</body>
</html>