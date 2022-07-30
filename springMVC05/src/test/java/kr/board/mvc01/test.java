package kr.board.mvc01;

import java.util.Optional;

import org.junit.Test;

public class test {

	@Test
	public void test() {
		String str = null;
		String str2 = "";
		int val = 0;
		System.out.println(Optional.ofNullable(str).isEmpty());
		System.out.println(Optional.ofNullable(str).isPresent());
		System.out.println("--------------------------------");
		System.out.println(Optional.ofNullable(str2).isEmpty());
		System.out.println(Optional.ofNullable(str2).isPresent());
		System.out.println("--------------------------------");
		System.out.println(Optional.ofNullable(val).isEmpty());
		System.out.println(Optional.ofNullable(val).isPresent());
	}
}
