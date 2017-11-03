<%--
  Created by IntelliJ IDEA.
  User: Yzf
  Date: 2017/11/3/003
  Time: 15:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getServerName() + ":" + request.getServerPort() + path + "/";// 获得本项目的地址(例如: http://localhost:8080/MyApp/)赋值给basePath变量
    String baseUrlPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <meta charset="utf-8">
    <title>Win10</title>
    <link href="/assets/css/style_qq.css" rel="stylesheet" type="text/css">
    <script src="/assets/js/jquery-2.1.1.min.js"></script>
    <script src="/assets/js/index.js"></script>
    <script src="/assets/js/superslide.2.1.js"></script>
    <script src="/assets/js/nicescroll.js"></script>


    <script type="text/javascript">
        var path = '<%=basePath%>';            //   localhost:8087/
        <%-- var ppp = '<%=baseUrlPath%>';      http://localhost:8087/--%>


        var uid='${sessionScope.loginUser.id}';
        //发送人编号
        var from='${sessionScope.loginUser.id}';
        var fromName='${sessionScope.loginUser.nickname}';
        //接收人编号
        var to="-1";

        // 创建一个Socket实例
        //参数为URL，ws表示WebSocket协议。onopen、onclose和onmessage方法把事件连接到Socket实例上。每个方法都提供了一个事件，以表示Socket的状态。
        var websocket;
        //不同浏览器的WebSocket对象类型不同
        //	alert("ws://" + path + "/ws?uid="+uid);   ws://localhost:8087//ws?uid=296de4d2-7d20-40e9-9941-1303bfd884f9
        if ('WebSocket' in window) {
            websocket = new WebSocket("ws://" + path + "ws");
            //火狐
        } else if ('MozWebSocket' in window) {
            websocket = new MozWebSocket("ws://" + path + "ws");
        } else {
            websocket = new SockJS("http://" + path + "ws/sockjs");
        }


        //打开Socket,
        websocket.onopen = function(event) {
            console.log("WebSocket:已连接");
        }

        // 监听消息
        //onmessage事件提供了一个data属性，它可以包含消息的Body部分。消息的Body部分必须是一个字符串，可以进行序列化/反序列化操作，以便传递更多的数据。
        websocket.onmessage = function(event) {
            console.log('Client received a message',event);
            //var data=JSON.parse(event.data);
            var data=$.parseJSON(event.data);
            console.log("WebSocket:收到一条消息",data);

            //2种推送的消息
            //1.用户聊天信息：发送消息触发
            //2.系统消息：登录和退出触发

            //判断是否是欢迎消息（没用户编号的就是欢迎消息）
            if(data.from==undefined||data.from==null||data.from==""){
                $("#chatUserList").empty();
                $(data.userList).each(function(){
                    $("#chatUserList").append(`
                     <li>
                            <div class="qq-hui-img"><img src="/assets/images/head/01.jpg"><i></i></div>
                            <div class="qq-hui-name"><span>`+this.nickname+`</span><i>`+new Date().Format("yyyy-MM-dd hh:mm:ss")+`</i></div>
                    </li>
                    `);
                });

            }else{
                //===普通消息
                //处理一下个人信息的显示：
                if(data.fromName==fromName){

                    data.fromName="我";
                    $("#contentUl").append("<li><span  style='display:block; float:right;'><em>"+data.fromName+"</em><span>"+data.text+"</span><b>"+data.date+"</b></span></li><br/>");
                }else{
                    $("#contentUl").append("<li><b>"+data.date+"</b><em>"+data.fromName+"</em><span>"+data.text+"</span></li><br/>");
                }

            }

            scrollToBottom();
        };

        // 监听WebSocket的关闭
        websocket.onclose = function(event) {
            $("#contentUl").append("<li><b>"+new Date().Format("yyyy-MM-dd hh:mm:ss")+"</b><em>系统消息：</em><span>连接已断开！</span></li>");
            scrollToBottom();
        };

        //监听异常
        websocket.onerror = function(event) {
            $("#contentUl").append("<li><b>"+new Date().Format("yyyy-MM-dd hh:mm:ss")+"</b><em>系统消息：</em><span>连接异常，建议重新登录</span></li>");
            scrollToBottom();
            console.log("WebSocket:发生错误 ",event);
        };

        //onload初始化
        $(function(){
            //发送消息
            $("#sendBtn").on("click",function(){
                sendMsg();
            });

            //给退出聊天绑定事件
            $("#exitBtn").on("click",function(){
                closeWebsocket();
                location.href="${pageContext.request.contextPath}/index.jsp";
            });

            //给输入框绑定事件
            $("#msg").on("keydown",function(event){
                keySend(event);
            });

            //初始化时如果有消息，则滚动条到最下面：
            scrollToBottom();



        });

        //使用ctrl+回车快捷键发送消息
        function keySend(e) {
            var theEvent = window.event || e;
            var code = theEvent.keyCode || theEvent.which;
            if (theEvent.ctrlKey && code == 13) {
                var msg=$("#msg");
                if (msg.innerHTML == "") {
                    msg.focus();
                    return false;
                }
                sendMsg();
            }
        }

        //发送消息
        function sendMsg(){
            //对象为空了
            if(websocket==undefined||websocket==null){
                //alert('WebSocket connection not established, please connect.');
                alert('您的连接已经丢失，请退出聊天重新进入');
                return;
            }
            //获取用户要发送的消息内容
            var msg=$("#msg").val();
            if(msg==""){
                return;
            }else{
                var data={};
                data["from"]=from;
                data["fromName"]=fromName;
                data["to"]=to;
                data["text"]=msg;
                //发送消息
                websocket.send(JSON.stringify(data));
                //发送完消息，清空输入框
                $("#msg").val("");
            }
        }

        //关闭Websocket连接
        function closeWebsocket(){
            if (websocket != null) {
                websocket.close();
                websocket = null;
            }

        }

        //div滚动条(scrollbar)保持在最底部
//        function scrollToBottom(){
//            var div = document.getElementById('qq-hui');
//            div.scrollTop = div.scrollHeight;
//        }
        //格式化日期
        Date.prototype.Format = function (fmt) { //author: meizz
            var o = {
                "M+": this.getMonth() + 1, //月份
                "d+": this.getDate(), //日
                "h+": this.getHours(), //小时
                "m+": this.getMinutes(), //分
                "s+": this.getSeconds(), //秒
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度
                "S": this.getMilliseconds() //毫秒
            };
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }
    </script>
</head>

<body>
<div class="qq-exe"><img src="/assets/images/QQ-ICON.png"><input type="text" value="腾讯QQ" placeholder="腾讯QQ"></div>
<div class="win-bg"><img src="/assets/images/win-bg.png"></div>

<%--<div class="qq-login">--%>
    <%--<div class="login-menu">--%>
        <%--<span></span><span></span><span class="login-close"></span>--%>
    <%--</div>--%>
    <%--<div class="login-ner">--%>
        <%--<div class="login-left">--%>
            <%--<div class="login-head"><img src="/assets/images/QQ-ICON.png"></div>--%>
        <%--</div>--%>
        <%--<div class="login-on">--%>
            <%--<form action="${pageContext.request.contextPath }/chat/login"  method="post">--%>
                <%--<div class="login-txt">--%>
                    <%--<input type="text" name="nickname" placeholder="QQ号码/手机/邮箱" />--%>
                    <%--<input type="password" placeholder="密码" name="password" />--%>
                <%--</div>--%>
                <%--<div class="login-xuan"><span class="fl"><input type="checkbox"><i>记住密码</i></span><span class="fr"><input type="checkbox"><i>自动登录</i></span></div>--%>
                <%--<button class="login-but">安全登录</button>--%>
            <%--</form>--%>
        <%--</div>--%>
        <%--<div class="login-right">--%>
            <%--<a href="http://zc.qq.com/chs/index.html" target="_blank">注册账号</a><a href="https://aq.qq.com/cn2/findpsw/pc/pc_find_pwd_input_account?pw_type=0&aquin=" target="_blank">找回密码</a>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>



<div class="qq">
    <div class="qq-top">
        <div class="qq-top-icon">
            <i><img src="/assets/images/qq-top.png"></i>
            <span class="qq-top-02 close"><img src="/assets/images/qq-top-02.png"></span>
            <span class="qq-top-01 min"><img src="/assets/images/qq-top-01.png"></span>
        </div>
        <div class="qq-top-name">
            <span id="this_nickname">hahaha</span>
            <dl><dd><img src="/assets/images/zai.png"></dd><dt><img src="/assets/images/lv.png"></dt><dt><img src="/assets/images/svip.png"></dt></dl>
        </div>
        <div class="qq-top-shuo"><input type="text" value="啊啊啊啊"></div>
        <div class="qq-top-menu">
            <ul>
                <li></li><li></li><li></li><li></li>
            </ul>
            <span class="qq-top-001"></span>
            <span class="qq-top-002"></span>
        </div>
        <div class="qq-serch">搜索：联系人、讨论组、群、企业</div>
    </div>
    <div class="qq-xuan">
        <ul>
            <li class="qq-xuan-li"><span></span><i></i></li>
            <li><span></span><i></i></li>
            <li><span></span><i></i></li>
            <li><span></span><i></i></li>
        </ul>
    </div>
    <div class="qq-hui">
        <ul id="chatUserList">
            <%--<li>--%>
                <%--<div class="qq-hui-img"><img src="/assets/images/head/01.jpg"><i></i></div>--%>
                <%--<div class="qq-hui-name"><span>室外摄影大师</span><i>16:30</i></div>--%>
            <%--</li>--%>
        </ul>
    </div>

    <%--qq界面底部--%>
    <div class="qq-bot">
        <div class="qq-menu">
            <ul>
                <li><img src="/assets/images/bot-menu/01.png"></li>
                <li><img src="/assets/images/bot-menu/02.png"></li>
                <li><img src="/assets/images/bot-menu/03.png"></li>
                <li><img src="/assets/images/bot-menu/04.png"></li>
                <li><img src="/assets/images/bot-menu/05.png"></li>
                <li><img src="/assets/images/bot-menu/06.png"></li>
                <li><img src="/assets/images/bot-menu/07.png"></li>
                <li><img src="/assets/images/bot-menu/08.png"></li>
                <li><img src="/assets/images/bot-menu/09.png"></li>
                <li><img src="/assets/images/bot-menu/10.png"></li>
            </ul>
        </div>
        <div class="qq-bou-she">
            <ul>
                <li><img src="/assets/images/bot-menu/11.png"></li>
                <li><img src="/assets/images/bot-menu/12.png"></li>
                <li><img src="/assets/images/bot-menu/13.png"></li>
                <li><img src="/assets/images/bot-menu/14.png"></li>
                <li><img src="/assets/images/bot-menu/15.png"></li>
                <li><img src="/assets/images/bot-menu/16.png"><span>查找</span></li>
                <li><img src="/assets/images/bot-menu/05.png"><span>应用宝</span></li>
            </ul>
        </div>
    </div>
</div>

<div class="qq-chat">
    <div class="qq-chat-win">
        <ul>
            <li class="she"></li><li class="min"></li><li class="max"></li><li class="close"></li>
        </ul>
    </div>
    <div class="qq-chat-top">
        <div class="qq-chat-tops">
            <div class="qq-chat-t-head"><img src=""></div>
            <div class="qq-chat-t-name"></div>
            <div class="qq-chat-t-shuo">站在别人的雨季，淋湿自己空弹一出戏.....</div>
        </div>
        <div class="qq-chat-menu">
            <ul>
                <li><span><img src="/assets/images/chat/icon-01.png"></span></li>
                <li><span><img src="/assets/images/chat/icon-02.png"></span></li>
                <li><span><img src="/assets/images/chat/icon-03.png"></span><i></i></li>
                <li><span><img src="/assets/images/chat/icon-04.png"></span><i></i></li>
                <li><span><img src="/assets/images/chat/icon-05.png"></span><i></i></li>
                <li><span><img src="/assets/images/chat/icon-06.png"></span></li>
                <li><span><img src="/assets/images/chat/icon-07.png"></span><i></i></li>
            </ul>
        </div>
    </div>
    <div class="qq-chat-bot">
        <div class="qq-chat-txt">
            <ul>
                <li>
                    <div class="qq-chat-you blue"><span></span><i></i></div>
                    <div class="qq-chat-ner">在么？找你有点事</div>
                </li>
            </ul>
        </div>
        <div class="qq-chat-text">
            <ul>
                <li><span><img src="/assets/images/chat/menu-01.png"></span></li>
                <li><span><img src="/assets/images/chat/menu-02.png"></span></li>
                <li><span><img src="/assets/images/chat/menu-03.png"></span></li>
                <li><span><img src="/assets/images/chat/menu-04.png"></span></li>
                <li><span><img src="/assets/images/chat/menu-05.png"></span><i></i></li>
                <li><span><img src="/assets/images/chat/menu-06.png"></span></li>
                <li><span><img src="/assets/images/chat/menu-07.png"></span><i></i></li>
                <li><span><img src="/assets/images/chat/menu-08.png"></span></li>
                <li><span><img src="/assets/images/chat/menu-09.png"></span><i></i></li>
                <li class="fr" style="margin-right:5px;"><span><img src="/assets/images/chat/menu-10.png"></span><p>消息记录</p><i></i></li>
            </ul>
            <textarea id="qq-chat-text"></textarea>
            <div class="qq-chat-but">
                <span class="fasong">发送(S)</span>
                <span class="close-chat">关闭(C)</span>
            </div>
        </div>
    </div>
</div>
</body>


</html>
