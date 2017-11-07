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
%>
<html>
<head>
    <meta charset="utf-8">
    <title>Win10</title>
    <link href="${pageContext.request.contextPath}/assets/css/style_qq.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/index.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/superslide.2.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/nicescroll.js"></script>


    <script type="text/javascript">
        var path = '<%=basePath%>';            //   localhost:8087/
        //发送人编号
        var from='${sessionScope.loginUser.id}';
        var fromName='${sessionScope.loginUser.nickname}';

        var qq_chat_count = 0;




        var websocket;
        if ('WebSocket' in window) {
            websocket = new WebSocket("ws://" + path + "ws");
        } else if ('MozWebSocket' in window) {
            websocket = new MozWebSocket("ws://" + path + "ws");
        } else {
            websocket = new SockJS("http://" + path + "ws/sockjs");
        }
        //打开Socket,
        websocket.onopen = function(event) {
            console.log("WebSocket:已连接");
        };
        websocket.onmessage = function(event) {
            console.log('Client received a message',event);
            var data=$.parseJSON(event.data);
            console.log("WebSocket:收到一条消息",data);

            //普通消息
            if(data.fromName==fromName && data.from!=undefined && data.from!=null && data.from!="" ){
                data.fromName="我";
                $("#qq_content").append(`
               <li>
                    <span  style='display:block; float:right;' class="qq-chat-you">
                        <span>`+data.date+`</span>
                        <i>`+data.fromName+`</i>
                    </span>
                    <br/>
                    <span  style='display:block; float:right;'>
                        <span>`+data.text+`</span>
                    </span>
                </li>
                `);
            }else if(data.from!=undefined && data.from!=null && data.from!=""){
                if(qq_chat_count == 0){
                    function qq_chat_click() {
                        $('.qq-hui li').click();
                        qq_chat_count++;
                    }
                    qq_chat_click();
                }
                function clickTimeout() {
                    qq_chat_count -=1;
                }
                setTimeout(clickTimeout,7800000);

                $("#qq_content").append(`
                <li>
                    <div class="qq-chat-you blue"><span>`+data.date+`</span><i>`+data.fromName+`</i></div>
                    <div class="qq-chat-ner">`+data.text+`</div>
                </li>
                `);
            }
            //系统消息
            if(data.from==undefined||data.from==null||data.from==""){
                $("#contentUl").empty();
                $("#contentUl").append(`
                    <li><b>`+data.date+`</b><em>系统消息：</em><span>`+data.text+`</span></li>
                `);
                $("#chatUserList").empty();
                $(data.userList).each(function(){
                    if(this.nickname != fromName){
                        $("#chatUserList").append(`
                             <li>
                                    <div class="qq-hui-img"><img src="${pageContext.request.contextPath}/assets/images/head/01.jpg"><i></i></div>
                                    <div class="qq-hui-name"><span>`+this.nickname+`</span><i>`+new Date().Format("yyyy-MM-dd hh:mm:ss")+`</i></div>
                            </li>
                        `);
                    }
                });

                $('.qq-hui li').click(function(){
                    $('.qq-chat').css('display','block').removeClass('mins');
                    $(".qq-chat").empty();
                    $(".qq-chat").append(`
                         <div class="qq-chat-win">
                                <ul>
                                    <li class="she"></li><li class="min"></li><li class="max"></li><li class="close"></li>
                                </ul>
                            </div>
                            <div class="qq-chat-top">
                                <div class="qq-chat-tops">
                                    <div class="qq-chat-t-head"><img src="${pageContext.request.contextPath}/assets/images/head/01.jpg"></div>
                                    <div class="qq-chat-t-name"></div>
                                    <div class="qq-chat-t-shuo">站在别人的雨季，淋湿自己空弹一出戏.....</div>
                                </div>
                                <div class="qq-chat-menu">
                                    <ul>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/icon-01.png"></span></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/icon-02.png"></span></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/icon-03.png"></span><i></i></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/icon-04.png"></span><i></i></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/icon-05.png"></span><i></i></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/icon-06.png"></span></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/icon-07.png"></span><i></i></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="qq-chat-bot">
                                <div class="qq-chat-txt" id="qq-chat-txt">
                                    <ul id="qq_content">

                                    </ul>
                                </div>
                                <div class="qq-chat-text">
                                    <ul>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/menu-01.png"></span></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/menu-02.png"></span></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/menu-03.png"></span></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/menu-04.png"></span></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/menu-05.png"></span><i></i></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/menu-06.png"></span></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/menu-07.png"></span><i></i></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/menu-08.png"></span></li>
                                        <li><span><img src="${pageContext.request.contextPath}/assets/images/chat/menu-09.png"></span><i></i></li>
                                        <li class="fr" style="margin-right:5px;"><span><img src="${pageContext.request.contextPath}/assets/images/chat/menu-10.png"></span><p>消息记录</p><i></i></li>
                                    </ul>
                                    <textarea id="msg" title="按ctrl+enter直接发送"></textarea>
                                    <div class="qq-chat-but">
                                        <span class="sendBtn" to='`+$(this).find('span').html()+`'>发送(S)</span>
                                    </div>
                                </div>
                            </div>
                        `);
                    $('.qq-chat-t-name').html($(this).find('span').html());
                    $('.qq-chat-you span').html($(this).find('span').html());
                    $('.qq-chat-you i').html($(this).find('.qq-hui-name i').html());
                    $('.qq-chat-ner').html($(this).find('.qq-hui-txt').html());
                    $("#qq-chat-text").trigger("focus");
                    $(".sendBtn").on("click",function(){
                        if($('#msg').val()==''){
                            alert("发送内容不能为空,请输入内容")
                        }else {
                            const to = $(this).attr("to");
                            sendMsg(to);
                        }
                    });
                    function sendMsg(to){
                        if(websocket==undefined||websocket==null){
                            alert('您的连接已经丢失，请退出聊天重新进入');
                            return;
                        }
                        var msg=$("#msg").val();
                        if(msg==""){
                            return;
                        }else{
                            var data = {};
                            data["from"] = from;
                            data["fromName"] = fromName;
                            data["to"] = to;
                            data["text"] = msg;
                            websocket.send(JSON.stringify(data));
                            $("#msg").val("");
                        }
                    }
                    $('.close').click(function(){
                        $(this).parent().parent().parent().css('display','none')
                    });

                    scrollToBottom();

                });
            }

        };
        websocket.onclose = function(event) {
            $("#contentUl").append("<li><b>"+new Date().Format("yyyy-MM-dd hh:mm:ss")+"</b><em>系统消息：</em><span>连接已断开！</span></li>");
        };
        websocket.onerror = function(event) {
            $("#contentUl").append("<li><b>"+new Date().Format("yyyy-MM-dd hh:mm:ss")+"</b><em>系统消息：</em><span>连接异常，建议重新登录</span></li>");
        };
        //onload初始化
        $(function(){
            $(document).ready(function () {
//                $('.qq-chat').css('display','block').removeClass('mins');
                $('.qq-chat').css('display','none').addClass('mins')

                $("#this_nickname").text(fromName);
            });
            $("#msg").on("keydown",function(event){
                keySend(event);
            });
        });
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
        function closeWebsocket(){
            if (websocket != null) {
                websocket.close();
                websocket = null;
            }
        }
        function scrollToBottom(){
            var div = document.getElementById('qq-chat-txt');
            div.scrollTop = div.scrollHeight;
        }
        //格式化日期
        Date.prototype.Format = function (fmt) {
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
<div class="qq-exe"><img src="${pageContext.request.contextPath}/assets/images/QQ-ICON.png"><input type="text" value="腾讯QQ" placeholder="腾讯QQ"></div>
<div class="win-bg"><img src="${pageContext.request.contextPath}/assets/images/win-bg.png"></div>

<div align=center>
    <marquee style="FONT-SIZE: 20pt; WIDTH: 50%; FILTER: shadow(color=#AF0530); LINE-HEIGHT: 15pt; FONT-FAMILY: 隶书; HEIGHT: 100px" scrollAmount=5>
        <P align=center>
            <font color=#f90b46 id="contentUl"></font>
        </P>
    </marquee>
</div>
<div class="qq">
    <div class="qq-top">
        <div class="qq-top-icon">
            <i><img src="${pageContext.request.contextPath}/assets/images/qq-top.png"></i>
            <span class="qq-top-02 close"><img src="${pageContext.request.contextPath}/assets/images/qq-top-02.png"></span>
            <span class="qq-top-01 min"><img src="${pageContext.request.contextPath}/assets/images/qq-top-01.png"></span>
        </div>
        <div class="qq-top-name">
            <span id="this_nickname">hahaha</span>
            <dl><dd><img src="${pageContext.request.contextPath}/assets/images/zai.png"></dd><dt><img src="${pageContext.request.contextPath}/assets/images/lv.png"></dt><dt><img src="${pageContext.request.contextPath}/assets/images/svip.png"></dt></dl>
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
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/01.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/02.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/03.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/04.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/05.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/06.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/07.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/08.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/09.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/10.png"></li>
            </ul>
        </div>
        <div class="qq-bou-she">
            <ul>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/11.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/12.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/13.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/14.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/15.png"></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/16.png"><span>查找</span></li>
                <li><img src="${pageContext.request.contextPath}/assets/images/bot-menu/05.png"><span>应用宝</span></li>
            </ul>
        </div>
    </div>
</div>
<div class="qq-chat">

</div>
</body>


</html>
