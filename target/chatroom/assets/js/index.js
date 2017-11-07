$(document).ready(function(){
      $('.qq-xuan li').click(function(){
        $(this).addClass('qq-xuan-li').siblings().removeClass('qq-xuan-li')
      });

      $('.qq-hui-txt').hover(function(){
        var aa = $(this).html()
        $('.qq-hui-txt').attr('title',aa)
      });

      $('.login-close').click(function(){
         $(this).parent().parent().css('display','none')
      });



      $('.qq-exe img').dblclick(function(){
        $('.qq-login').css('display','block').removeClass('mins')
      });



      $('.min').click(function(){
        $(this).parent().parent().parent().addClass('mins')
      });



      $('.qq .close').click(function(){
        $('.qq-chat').css('display','none')
      });

      $('#qq-chat-text').keydown(function(e){
        if(e.keyCode == 27){
          $('.qq-chat').css('display','none')
        }
      });



      $('.close-chat').click(function(){
        $('.qq-chat').css('display','none')
      });

      $(".qq-hui").niceScroll({
        touchbehavior:false,cursorcolor:"#ccc",cursoropacitymax:1,cursorwidth:6,horizrailenabled:true,cursorborderradius:3,autohidemode:true,background:'none',cursorborder:'none'
      });

});