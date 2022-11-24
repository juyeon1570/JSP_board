<%@page import="com.koreait.db.Dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		request.setCharacterEncoding("UTF-8");
		
		String userid = (String)session.getAttribute("userid");
		String b_idx = request.getParameter("b_idx");
		conn = Dbconn.getConnection();

		try{
			conn = Dbconn.getConnection();
			if(conn!=null){
				int b_like=0;
				String sql = "select li_idx from tb_like where li_boardidx=? and li_userid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_idx);
				pstmt.setString(2,userid);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					sql = "update tb_board set b_like=b_like-1 where b_idx=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,b_idx);
					pstmt.executeUpdate();
					
					sql = "delete from tb_like where li_boardidx=? and li_userid=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, b_idx);
					pstmt.setString(2,userid);
					pstmt.executeUpdate();
				}else{
					sql="update tb_board set b_like = b_like + 1 where b_idx=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,b_idx);
					pstmt.executeUpdate();
					
					sql = "insert into tb_like(li_userid, li_boardidx) values(?, ?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userid);
					pstmt.setString(2,b_idx);
					pstmt.executeUpdate();
				}
				
				sql = "select b_like from tb_board where b_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,b_idx);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					b_like = rs.getInt("b_like");
					out.print(b_like);
				}
				%>
				<script>alert('좋아요를 눌렀습니다!');
				location.href="view.jsp?b_idx="+<%=b_idx%>;
				</script>
				<%
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
			
%>
</body>
</html>