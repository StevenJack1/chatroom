<%--
  Created by IntelliJ IDEA.
  User: Yzf
  Date: 2017/11/3/003
  Time: 15:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Win10</title>
    <link href="${pageContext.request.contextPath}/assets/css/style_qq.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/index.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/superslide.2.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/nicescroll.js"></script>
</head>

<body>
<div class="qq-exe"><img src="${pageContext.request.contextPath}/assets/images/QQ-ICON.png"><input type="text" value="腾讯QQ" placeholder="腾讯QQ"></div>

<div class="win-bg"><img src="${pageContext.request.contextPath}/assets/images/win-bg.png"></div>

<div class="qq-login">
    <div class="login-menu">
        <span></span><span></span><span class="login-close"></span>
    </div>
    <div class="login-ner">
        <div class="login-left">
            <div class="login-head"><img src="${pageContext.request.contextPath}/assets/images/QQ-ICON.png"></div>
        </div>
        <div class="login-on">
            <form action="${pageContext.request.contextPath }/chat/login"  method="post">
                <div class="login-txt">
                    <input type="text" name="nickname" placeholder="QQ号码/手机/邮箱" />
                    <input type="password" placeholder="密码" name="password" />
                </div>
                <div class="login-xuan"><span class="fl"><input type="checkbox"><i>记住密码</i></span><span class="fr"><input type="checkbox"><i>自动登录</i></span></div>
                <button class="login-but">安全登录</button>
            </form>
        </div>
        <div class="login-right">
            <a href="http://zc.qq.com/chs/index.html" target="_blank">注册账号</a><a href="https://aq.qq.com/cn2/findpsw/pc/pc_find_pwd_input_account?pw_type=0&aquin=" target="_blank">找回密码</a>
        </div>
    </div>
</div>
</body>

<script>
    $('.login-but').click(function(){
        if($('.login-txt').find('input').val() == ''){
            alert('请输入账号或者密码')
            return false;
        }
    });
</script>
</html>
