function sendit(){
    // 객체 추가
    const userid = document.getElementById('userid');
    const userpw = document.getElementById('userpw');
    const userpw_re = document.getElementById('userpw_re');
    const name = document.getElementById('name');
    const hp = document.getElementById('hp');
    const email = document.getElementById('email');
    const hobby = document.getElementsByName('hobby');
    const isIdCheck = document.getElementById('isIdCheck');

    // 정규 표현식
    const expIdText = /^[A-Za-z]{4,20}$/;
    const expPwText = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[\d])(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;
    const expNameText=/[가-힣]+$/;
    const expHpText=/^\d{3}-\d{3,4}-\d{4}$/;
    const expEmailText=/^[A-Za-z0-9\-\.]+@[A-Za-z0-9\-\.]+\.[A-Za-z0-9]+$/;


    if(userid.value==''){
        alert('아이디를 입력하세요.');
        userid.focus();
        return false;
    }

    if(!expIdText.test(userid.value)){
        alert('아이디는 4자 이상, 20자 이하의 대소문자로 시작하는 조합입니다.');
        userid.focus();
        return false;
    }
    if(isIdCheck.value=="n"){
    	alert('아이디 중복체크 버튼을 눌러 주세요.');
    	return false;
    }

    if((userpw.value=='')||(userpw_re.value=='')||userpw.value!=userpw_re.value){
        alert('비밀번호를 확인하세요.');
        userpw.focus();
        return false;
    }

    if(!expPwText.test(userpw.value)){
        alert('비밀번호 형식을 확인하세요.\n소문자, 대문자, 숫자, 특수문자를 모두 1개 이상 입력해야합니다.');
        userpw.focus();
        return false;
    }
    
    if(!expNameText.test(name.value)){
        alert('이름은 한글로 입력하세요.');
        name.focus();
        return false;
    }

    if(!expHpText.test(hp.value)){
        alert('휴대폰 번호 형식을 확인하세요.\n하이픈(-)을 포함해야 합니다.');
        hp.focus();
        return false;
    }

    if(!expEmailText.test(email.value)){
        alert('이메일 형식을 확인하세요.\'@\'와 \'.\'또는 \'-\'를 포함해야 합니다.');
        email.focus();
        return false;
    }

    let count = 0;
    for(let i in hobby){
        if(hobby[i].checked){
            count++;
        }
    }
    if(count==0){
        alert('취미는 적어도 한 개 이상 선택하세요.');
        return false;
    }


    return true;
}

function clickBtn(){
	const isIdCheck = document.getElementById('isIdCheck');
	const xhr = new XMLHttpRequest();
	const userid = document.getElementById('userid').value;
	xhr.open('get','idcheck.jsp?userid='+userid,true);
	xhr.send();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
			const result = xhr.responseText;
			if(result.trim() == "ok"){
				document.getElementById("checkmsg").innerHTML = "<b>사용할 수 있는 아이디</b>"
					isIdCheck.value="y";
			}else{
				document.getElementById("checkmsg").innerHTML = "<b style='color: red;'>사용할 수 없는 아이디</b>"				
			}
		}
	}
}


function idModify(){
	const isIdCheck = document.getElementById('isIdCheck');
	
	isIdCheck.value="n";
}
























