package kr.board.mvc01.entity;

import java.util.List;

import lombok.Data;

@Data
public class Member {
	
	private Integer memIdx;
	private String memID;
	private String memPassword;
	private String memName;
	private Integer memAge;
	private String memGender;
	private String memEmail;
	private String memProfile;
	private List<AuthVO> authList;
	
	private String memPassword1; // 비밀번호 확인용 
	private String memPassword2; // 비밀번호 확인용

}
