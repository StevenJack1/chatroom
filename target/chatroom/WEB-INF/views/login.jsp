<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="">
<meta name="description" content="。">
<title>传智播客在线留言系统</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/lbt.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" type="text/css" media="all" />

</head>
<body>

<div class="loginMain">
	<div class="loginArea">
        <div><font color="red" size="16">${requestScope.errorTips }</font></div>
        <form action="${pageContext.request.contextPath }/chat/login"  method="post">
        	<input type="text" value="请输入您想显示的昵称" name="nickname" id="myText" />
            <button>进入聊天室</button>
        </form>
    </div>
</div>


</body>
<script type="text/javascript">
    $("#myText").focus(function () {
        if( $("#myText").val() == "请输入您想显示的昵称"){
            $("#myText").val("");
            $("#myText").css("color","#333")
        }
    });
    $("#myText").blur(function () {
        if( $("#myText").val() == ""){
            $("#myText").val("请输入您想显示的昵称");
            $("#myText").css("color","#ccc")
        }
    });
</script>
</html>