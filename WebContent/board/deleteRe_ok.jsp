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

	String re_idx = request.getParameter("re_idx");
	String b_idx = request.getParameter("b_idx");
	String userid = (String)session.getAttribute("userid");
	
	
	
	try{
		conn = Dbconn.getConnection();
		if(conn!=null){
			String sql = "delete from tb_reply where re_idx=?and re_userid=? and re_boardidx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, re_idx);
			pstmt.setString(2,userid);
			pstmt.setString(3,b_idx);
			int res = pstmt.executeUpdate();
			if(res>=1){
			
%>
		<script>
			alert('✔ 댓글이 삭제되었습니다.');
			location.href='view.jsp?b_idx='+<%=b_idx%>;
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