<%@page import="com.koreait.db.Dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@
	include file="../include/sessionCheck.jsp"
%>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	request.setCharacterEncoding("UTF-8");
	String b_userid = (String)session.getAttribute("userid");
	String b_name = (String)session.getAttribute("name");
	
	String b_title = request.getParameter("b_title");
	String b_content = request.getParameter("b_content");
	
	try{
		conn = Dbconn.getConnection();
		if(conn!=null){
			String sql = "insert into tb_board(b_userid, b_name, b_title, b_content) values(?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_userid);
			pstmt.setString(2, b_name);
			pstmt.setString(3, b_title);
			pstmt.setString(4, b_content);
			int res = pstmt.executeUpdate();
			if(res>=1){
			
%>
		<script>
			alert('✔ 글이 등록되었습니다.');
			location.href='list.jsp';
		</script>
<%
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>