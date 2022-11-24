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
/* 	ResultSet rs = null; */
	
	request.setCharacterEncoding("UTF-8");
	
	String b_title = request.getParameter("b_title");
	String b_content = request.getParameter("b_content");
	String b_idx = request.getParameter("b_idx");
	
	/* String userid = (String)session.getAttribute("b_userid");
	String name = (String)session.getAttribute("b_name"); */
	
	
	try{
		conn = Dbconn.getConnection();
		if(conn!=null){
			String sql = "update tb_board set b_title=? , b_content=? where b_idx=?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_title);
			pstmt.setString(2, b_content);
			pstmt.setString(3, b_idx);
			int res = pstmt.executeUpdate();
			if(res>=1){
			
%>
		<script>
			alert('✔ 글이 수정되었습니다.');
			location.href='view.jsp?b_idx=<%=b_idx %>';
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