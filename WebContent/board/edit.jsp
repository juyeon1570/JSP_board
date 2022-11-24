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
	
	String b_idx = request.getParameter("b_idx");
	try{
		conn = Dbconn.getConnection();
		if(conn!=null){
			String sql = "select * from tb_board where b_idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,b_idx);
			rs = pstmt.executeQuery();
			if(rs.next()){
				String b_title = rs.getString("b_title");
				String b_name = rs.getString("b_name");
				String b_content = rs.getString("b_content");
				String b_userid = rs.getString("b_userid");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
</head>
<body>
	<h2>글수정</h2>
	<form method="post" action="edit_ok.jsp">
	<input type="hidden" name="b_idx" value="<%=b_idx%>">
		<p>작성자: <%= b_name %>(<%= b_userid %>)</p>
		<p>제목: <input type="text" name="b_title" value="<%= b_title %>"></p>
		<p>내용</p>
		<p><textarea style="width: 300px; height: 200px; resize: none;" name="b_content" ><%= b_content %></textarea></p>
		<p><button>수정</button> <button type="reset">재작성</button>
		<button type="button" onclick="history.back()">뒤로</button></p>
		<%
	}
	}
}catch(Exception e){
	e.printStackTrace();
}
		%>
	</form>
</body>
</html>