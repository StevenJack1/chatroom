package cn.steven.Model;

import com.google.gson.annotations.Expose;
import lombok.*;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * DTO类，用来存放聊天的消息
 *
 */
@Entity
@Table

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message {

	//发送者
	@Expose
	@Getter
	@Setter
	public String from;

	//发送者名称
	@Expose
	@Setter
	@Getter
	public String fromName;

	//接收者
	@Expose
	@Getter
	@Setter
	public String to;

	//接收者姓名
	@Expose
	@Getter
	@Setter
	public String toName;


	//发送的文本
	@Expose
	@Setter
	@Getter
	public String text;


	//发送日期
	@Expose
	@Setter
	@Getter
	public Date date;
	
	//在线用户列表
	@Expose
	@Setter
	@Getter
	List<User> userList = new ArrayList<>();
	





	
	

}
