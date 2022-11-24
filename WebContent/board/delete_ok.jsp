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
	
	request.setCharacterEncoding("UTF-8");

	String b_idx = request.getParameter("b_idx");
	String b_userid = (String)session.getAttribute("userid");
	
	
	try{
		conn = Dbconn.getConnection();
		if(conn!=null){
			String sql = "delete from tb_board where b_idx=?and b_userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_idx);
			pstmt.setString(2,b_userid);
			int res = pstmt.executeUpdate();
			if(res>=1){
			
%>
		<script>
			alert('✔ 글이 삭제되었습니다.');
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