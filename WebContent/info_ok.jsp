<%@page import="com.koreait.db.Dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@
	include file="./include/sessionCheck.jsp"
%>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	request.setCharacterEncoding("UTF-8");
	String userid = (String)session.getAttribute("userid");
	String userpw = request.getParameter("userpw");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String email = request.getParameter("email");
	String gender = request.getParameter("gender");
	String[] hobby = request.getParameterValues("hobby");
	String ssn1 = request.getParameter("ssn1");
	String ssn2 = request.getParameter("ssn2");
	String zipcode = request.getParameter("zipcode");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");
	
	String sql = "";
	
	
	
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			//System.out.println("DB 연결 성공!");
			sql = "select mem_idx from tb_member where mem_userid=? and mem_userpw=sha2(?,256)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			pstmt.setString(2,userpw);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				sql = "update tb_member set mem_name=?, mem_hp=?, mem_email=?, mem_hobby=?, mem_ssn1=?, mem_ssn2=?, mem_zipcode=?, mem_address1=?, mem_address2=?, mem_address3=?, mem_gender=? where mem_userid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,name);
				pstmt.setString(2,hp);
				pstmt.setString(3,email);
				String hobbyStr="";
				for(int i=0;i<hobby.length;i++){
					hobbyStr = hobbyStr + hobby[i] + " ";
				}
				pstmt.setString(4,hobbyStr);
				pstmt.setString(5, ssn1);
				pstmt.setString(6, ssn2);
				pstmt.setString(7,zipcode);
				pstmt.setString(8,address1);
				pstmt.setString(9,address2);
				pstmt.setString(10,address3);
				pstmt.setString(11,gender);
				pstmt.setString(12,userid);
				
				pstmt.executeUpdate();
				
%>
			<script>
				alert('변경되었습니다ㅣ!');
				location.href='login.jsp';
			</script>
<%

			}else{
				//비밀번호 틀림
%>
			<script>
				alert('비밀번호를 확인하세요!');
				history.back();
			</script>
<%
			}
			

		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>