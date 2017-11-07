package cn.steven.chatroom.Controller;

import cn.steven.Model.User;
import cn.steven.Service.UserInfoService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.UUID;


@Controller
@RequestMapping("/chat")
public class ChatController {
	@GetMapping("/")
	public String loginpage() {
		return "index";
	}

//	@Autowired
//	private UserInfoService userInfoService;

	// 登录进入聊天主页面
	@PostMapping("/login")
	public String login(User loginUser, HttpServletRequest request) {
		HttpSession session = request.getSession();
		// 登录操作
		// 判断是否是一个已经登录的用户，没有则登录
		if (session.getAttribute("loginUser") != null) {
			// 清除旧的用户
			session.removeAttribute("loginUser");
		}
		loginUser.setId(loginUser.getNickname());
		// 将用户放入session
		session.setAttribute("loginUser", loginUser);

		User user = new User();
		user.setId(loginUser.getId());
		user.setNickname(loginUser.getNickname());
		user.setPassword(loginUser.getPassword());
//		System.out.println(user.getId());
//		System.out.println(user.getNickname());
//		System.out.println(user.getPassword());
//		userInfoService.save(user);

		return "redirect:/chat/mainpage";
	}
	
	// 跳转到聊天室页面
	@GetMapping("/mainpage")
	public String mainpage(HttpServletRequest request) {
		//判断，如果没有session，则跳到登录页面
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			return "index";
		}else{
			return "mainpage";
		}
	}

}
