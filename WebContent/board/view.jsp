<%@page import="com.koreait.db.Dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
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
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		request.setCharacterEncoding("UTF-8");
	
		String b_idx = request.getParameter("b_idx");
		String userid = (String)session.getAttribute("userid");
		String name = (String)session.getAttribute("name");
		
		String b_title = "";
		String b_regdate = "";
		String b_name = "";
		String b_content = "";
		String b_userid = "";
		int b_hit=0;
		int b_like = 0;
		Boolean isLike=false;
		%>
<script>
function del(idx){
	//alert(idx);
	const yn = confirm('글을 삭제하시겠습니까?');
	if(yn) location.href="delete_ok.jsp?b_idx="+idx;
}

function delRe(re_idx,b_idx){
	//alert(idx);
	const yn = confirm('댓글을 삭제하시겠습니까?');
	if(yn) location.href="deleteRe_ok.jsp?re_idx=" + re_idx + "&b_idx=" + b_idx;
}

function like(){
	const isHeart = document.querySelector("img[title=on]");
	if(isHeart){
		document.getElementById('heart').setAttribute('src', '../none_clicked_heart.png');
		document.getElementById('heart').setAttribute('title', 'off');
	}else{
		document.getElementById('heart').setAttribute('src', '../clicked_heart.png');
		document.getElementById('heart').setAttribute('title', 'on');
	}
	
	const xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
		if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
			document.getElementById('like').innerHTML = xhr.responseText;
		}
	}
	xhr.open('GET', 'like_ok.jsp?b_idx=<%=b_idx%>', true);
	xhr.send();
	
} 
	
	</script>
</head>
<body>
	<h2>글보기</h2>
	<table>
		<%
		
		try{
			conn = Dbconn.getConnection();
			if(conn!=null){
				/* String sql = "update tb_board set b_hit=b_hit+1 where b_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,b_idx);
				pstmt.executeUpdate();
				 */
				 String sql = "select * from tb_hit where hit_boardidx=? and hit_userid=?";
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1,b_idx);
				 pstmt.setString(2,userid);
				 rs = pstmt.executeQuery();
				 if(!rs.next()){
					    sql = "update tb_board set b_hit=b_hit+1 where b_idx=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1,b_idx);
						pstmt.executeUpdate();
						
						sql = "insert into tb_hit(hit_boardidx, hit_userid) values(?, ?)";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1,b_idx);
						pstmt.setString(2,userid);
						pstmt.executeUpdate();
						
				 }
				 
				sql = "select * from tb_board where b_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,b_idx);
				rs = pstmt.executeQuery();
				if(rs.next()){
				 b_title = rs.getString("b_title");
				 b_regdate = rs.getString("b_regdate");
				 b_name = rs.getString("b_name");
				 b_content = rs.getString("b_content");
				 b_userid = rs.getString("b_userid");
				 b_hit = rs.getInt("b_hit");
				 b_like = rs.getInt("b_like");
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
%>
		<tr>
			<th>제목</th><td><%= b_title %></td>
		</tr>
		<tr>
			<th>작성날짜</th><td><%=b_regdate %></td>
		</tr>
		<tr>
			<th>작성자</th><td><%=b_userid %>(<%=b_name %>)</td>
		</tr>
		<tr>
			<th>조회수</th><td><%=b_hit %></td>
		</tr>
		<tr>
			<th>좋아요</th><td>
			<%
				String sql = "select * from tb_like where li_boardidx=? and li_userid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,b_idx);
				pstmt.setString(2,userid);
				ResultSet rs_like = pstmt.executeQuery();
				if(rs_like.next()){
					isLike=true;
				}
				if(isLike){
					%>
						<img id="heart" src="../clicked_heart.png" alt="좋아요" onclick="like()">
					<%
				}else{
					%>
						<img id="heart" src="../none_clicked_heart.png" alt="좋아요" onclick="like()">
					<%
				}
			%><span id="like"><%=b_like %></span>
			</td>
		</tr>
		<tr>
			<th>내용</th><td><%=b_content %></td>
		</tr>
		<tr>
			<td colspan="2">	
		

<% 
	if(b_userid.equals(userid)){
				
%>
	
			<input type="button" value="수정" onclick="location.href='edit.jsp?b_idx=<%=b_idx%>'">
			<input type="button" value="삭제" onClick="del('<%=b_idx %>')">
<%}%>

			<input type="button" value="리스트" onclick="location.href='list.jsp'">
			<%-- <input type ="button" value="좋아요" onclick="location.href='like.jsp?b_idx=<%= b_idx %>'"> --%>
			</td>
		</tr>
	</table>
	<br><br>
	<hr>
	<form method="post" action="re_write_ok.jsp">	
	<input type="hidden" name="b_idx" value="<%=b_idx%>">
	<p><%=userid%>(<%=name%>): <input type="text" name="re_content"><button>확인</button></p>
	</form>
	<hr>
<%
	try{
		conn = Dbconn.getConnection();
		if(conn!=null){
			sql = "select * from tb_reply where re_boardidx=? order by re_idx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,b_idx);
			rs = pstmt.executeQuery();
			while(rs.next()){
				String re_name = rs.getString("re_name");
				String re_userid = rs.getString("re_userid");
				String re_content = rs.getString("re_content");
				String re_regdate = rs.getString("re_regdate");
				int re_idx = rs.getInt("re_idx");
				%>
				<p>
				<%=re_userid%>(<%=re_name %>): <%=re_content %> (<%=re_regdate %>)
				<%
					if(re_userid.equals(userid)){
				%>
						<input type="button" value="삭제" onClick="delRe('<%=re_idx%>','<%=b_idx%>')">
				<%
					}
				%>
				</p>
				<%
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>