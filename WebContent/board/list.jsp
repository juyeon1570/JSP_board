<%@page import="com.koreait.db.Dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@
	include file="../include/sessionCheck.jsp"
%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>
<style>
	table{
		width: 800px;
		border: 1px solid black;
		border-collapse: collapse;
	}
	th, td{
		border: 1px solid black;
		padding: 10px;
		text-align: center;
	}
</style>
</head>
<body>
	<h2>list</h2>
<% 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totalCount = 0;
		int start = 0;
		int pagePerCount = 10;
		int num=0;
		String pageNum=request.getParameter("pageNum");
		if(pageNum!=null && !pageNum.equals("")){
			start = (Integer.parseInt(pageNum)-1)*pagePerCount;
		}else{
			pageNum="1";
			start=0;
		}
		
		request.setCharacterEncoding("UTF-8");
		try{
			conn = Dbconn.getConnection();
			if(conn!=null){
				
				String sql = "select count(b_idx) as total from tb_board";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					totalCount = rs.getInt("total");
				}%>
	<p>총 게시글: <%=totalCount %>개</p>
	<table>
		<tr>
		<th>번호</th>
		<th>제목</th>
		<th>글쓴이</th>
		<th>조회수</th>
		<th>날짜</th>
		<th>좋아요</th>
		</tr>
				<%
				
				sql = "select * from tb_board order by b_idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,start);
				pstmt.setInt(2,pagePerCount);
				//sql = "select * from tb_board order by b_idx desc";
				//pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
					
					String b_idx = rs.getString("b_idx");
					int b_hit = rs.getInt("b_hit");
					int b_like = rs.getInt("b_like");
					String b_userid = rs.getString("b_userid");
					String b_name = rs.getString("b_name");
					String b_title = rs.getString("b_title");
					String b_content = rs.getString("b_content");
					String b_regdate = rs.getString("b_regdate");
					
					SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date date = transFormat.parse(b_regdate);
					long now = System.currentTimeMillis();
					long inputDate = date.getTime();
					
 						String sql2 = "select count(re_idx) as cnt from tb_reply where re_boardidx=?";
						pstmt = conn.prepareStatement(sql2);
						pstmt.setString(1,b_idx);
						ResultSet rs_reply = pstmt.executeQuery();
						String replyCnt = "";
%>
					<tr>
						<td><%
							if(pageNum!=null || pageNum!=""){
								%>
								<%=(totalCount-10*(Integer.parseInt(pageNum)-1))-num %>
								<%
							}else{
								%>
								<%=totalCount-num%>
								<%
							}
						%></td>
						<td><a href="view.jsp?b_idx=<%= b_idx %>">
						<%-- <%
						
						String sql3 = "select TIMESTAMPDIFF(DAY,(select b_regdate from tb_board where b_idx=?),now()) as isNew";
						pstmt = conn.prepareStatement(sql3);
						pstmt.setString(1,b_idx);
						ResultSet rs_new = pstmt.executeQuery();
						
						if(rs_new.next()){
							
							int isNew = Integer.parseInt(rs_new.getString("isNew"));
							
							if(isNew<3){
								%>
								<img src="../new.png" style="width: 25px;">
								<%
							}
						}
					%> --%>
					<%
						if(now - inputDate<(1000*60*60*24)){
							%>
								<img src="../new.png" style="width: 25px;">
							<%
						}
					%>
						<%=b_title %>
						<%
						if(rs_reply.next()){
							int cnt = rs_reply.getInt("cnt");
							if(cnt>0){
								replyCnt = "["+cnt+"]";
							}
						}
						%><%=replyCnt %>
						</a></td>
						<td><%=b_userid %>(<%=b_name %>)</td>
						<td><%=b_hit %></td>
						<td><%=b_regdate %></td>
						<td><%=b_like %></td>
					</tr>
<%
				num++;}%>
					<tr>
					<td colspan="6">
						<%
							int pageNums=0;
							if(totalCount%pagePerCount == 0){
								pageNums = (totalCount/pagePerCount);
							}else{
								pageNums = (totalCount/pagePerCount)+1;
							}
							for(int i=1;i<=totalCount/pagePerCount+1;i++){
								out.print("<a href='list.jsp?pageNum=" + i + "'> [" + i +"]</a>");
							}
						%>
						</td>
					</tr>
	<%			
			}
		}catch(Exception e){
			e.printStackTrace();
		}

%>
	</table>
	<p><a href='write.jsp'>글쓰기</a> | <a href='./../login.jsp'>로그인으로 돌아가기</a></p>
</body>
</html>