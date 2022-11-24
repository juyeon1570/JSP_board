<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn" %>

<%@
	include file="./include/sessionCheck.jsp"
%>
<%!
	public static boolean compareHobby(String[] arr, String item){
		for(String i : arr){
			if(i.equals(item)){
				return true;
			}
		}
		return false;
	}
%>
<%
	// String idx = (String)session.getAttribute("idx");	// idx를 사용하면 (auto increment)속도가 유리
	String userid = (String)session.getAttribute("userid");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String mem_name="";
	String mem_hp="";
	String mem_email="";
	String[] hobbyArr=null;
	String mem_ssn1="";
	String mem_ssn2="";
	String mem_zipcode="";
	String mem_address1="";
	String mem_address2="";
	String mem_address3="";
	String mem_gender="";
	
	try{
		conn = Dbconn.getConnection();
		if(conn!=null){
			String sql = "select * from tb_member where mem_userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			rs = pstmt.executeQuery();
			if(rs.next()){
				mem_name = rs.getString("mem_name");
				mem_hp = rs.getString("mem_hp");
				mem_email = rs.getString("mem_email");
				hobbyArr = rs.getString("mem_hobby").split(" ");
				mem_ssn1 = rs.getString("mem_ssn1");
				mem_ssn2 = rs.getString("mem_ssn2");
				mem_zipcode = rs.getString("mem_zipcode");
				mem_address1 = rs.getString("mem_address1");
				mem_address2 = rs.getString("mem_address2");
				mem_address3 = rs.getString("mem_address3");
				mem_gender = rs.getString("mem_gender");
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>정보 수정</title>
    <script defer src="./js/info.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</head>
<body>
    <h2>정보 수정</h2>
    <form action="info_ok.jsp" name="regform" id="regform" onsubmit="return sendit()">
        <p>아이디: <%=userid %></p>
        <p>비밀번호: <input type="password" name="userpw" id="userpw" maxlength="20"></p>
        <p>비밀번호 확인: <input type="password" name="userpw_re" id="userpw_re" maxlength="20"></p>
        <p>이름: <input type="text" name="name" id="name" value="<%=mem_name %>"></p>
        <p>휴대폰 번호: <input type="text" name="hp" id="hp" value="<%=mem_hp %>"></p>
        <p>이메일: <input type="text" name="email" id="email" value="<%=mem_email %>"></p>
        <p>성별: 
            <label>남자<input type="radio" name="gender" value="남자"
				<%if(mem_gender.equals("남자"))out.print("checked"); %>></label>
            <label>여자<input type="radio" name="gender" value="여자"
            	<%if(mem_gender.equals("여자"))out.print("checked"); %>></label>
        </p>
        <p>취미: 
            <label>등산<input type="checkbox" name="hobby" value="등산"
            	<%
            		if(compareHobby(hobbyArr, "등산")) out.print("checked");
            	%>
            ></label>
            	
            <label>게임<input type="checkbox" name="hobby" value="게임"
            	<%if(compareHobby(hobbyArr, "게임")) out.print("checked");%>
            ></label>
            <label>영화감상<input type="checkbox" name="hobby" value="영화감상"
            	<%if(compareHobby(hobbyArr, "영화감상")) out.print("checked");%>
            ></label>
            <label>드라이브<input type="checkbox" name="hobby" value="드라이브"
            	<%if(compareHobby(hobbyArr, "드라이브")) out.print("checked");%>
            ></label>
            <label>운동<input type="checkbox" name="hobby" value="운동"
            	<%if(compareHobby(hobbyArr, "운동")) out.print("checked");%>
            ></label>
        </p>
        <p>주민등록번호:
        	<input type="text" name="ssn1" value=<%=mem_ssn1 %>> - <input type="text" name="ssn2" value=<%=mem_ssn2 %>>
        </p>
        <p>
            우편번호: <input type="text" id="sample6_postcode" name="zipcode" maxlength="5" value=<%=mem_zipcode %>><button type="button" onclick="sample6_execDaumPostcode()">검색</button>
        </p>
        <p>주소: <input type="text" id="sample6_address" name="address1" value="<%=mem_address1 %>"></p>
        <p>상세주소: <input type="text" id="sample6_detailAddress" name="address2" value="<%=mem_address2 %>"></p>
        <p>참고항목: <input type="text" id="sample6_extraAddress" name="address3" value="<%=mem_address3 %>"></p>


        <p><button>수정 완료</button><button type="reset">다시 작성</button><button type="button" onclick="location.href='login.jsp'">돌아가기</button></p>
    </form>
</body>
</html>