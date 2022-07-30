package kr.board.mvc01.entity;

import lombok.Data;

@Data
public class AuthVO {

	private int no; // 일련번호
	private String memID; //회원 아이디
	private String auth; // 회원권한
	
}