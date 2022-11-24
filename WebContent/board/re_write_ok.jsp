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
	
	String userid = (String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	String b_idx = request.getParameter("b_idx");
	
	String re_content = request.getParameter("re_content");
	
	try{
		conn = Dbconn.getConnection();
		if(conn!=null){
			String sql = "insert into tb_reply(re_userid, re_name, re_content, re_boardidx) values (?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			pstmt.setString(2,name);
			pstmt.setString(3,re_content);
			pstmt.setString(4,b_idx);
			pstmt.executeUpdate();
			
%>
	<script>
		alert('✔댓글 작성 완료.');
		location.href="view.jsp?b_idx="+<%=b_idx%>;
	</script>
<%
		}
	}catch(Exception e){
			e.printStackTrace();
		}
	
%>