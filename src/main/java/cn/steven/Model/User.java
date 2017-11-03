package cn.steven.Model;

import com.google.gson.annotations.Expose;
import lombok.*;

import javax.persistence.Entity;
import javax.persistence.Table;

//用户
@Entity
@Table

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
	@Expose
	@Setter
	@Getter
	private String id;//唯一标识属性

	// 账户
	@Expose
	@Setter
	@Getter
	private String nickname;

	// 密码
	@Expose
	@Setter
	@Getter
	private String password;


}
