package kr.board.mvc01.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.board.mvc01.entity.Board;
import kr.board.mvc01.mapper.BoardMapper;

@RestController
@RequestMapping("/board")
public class BoardRestController {

	@Autowired
	private BoardMapper boardMapper;
	
//	@GetMapping("/")
	public String main() {
		return "main";
	}
	
	@GetMapping("/all")
	public List<Board> boardList() {
		return boardMapper.getList();
	}
	
	@PostMapping("/new")
	public void boardInsert(Board board) {
		boardMapper.boardInsert(board);
	}
	
	@DeleteMapping("/{idx}")
	public void boardDelete(@PathVariable("idx") Integer idx) {
		boardMapper.boardDelete(idx);
	}
	
	@PutMapping("/update")
	public void boardUpdate(@RequestBody Board board) {
		boardMapper.boardUpdate(board);
	}
	
	@GetMapping("/{idx}")
	public Board boardContent(@PathVariable("idx") Integer idx) {
		return boardMapper.boardContent(idx);
	}
	
	@PutMapping("/count/{idx}")
	public Board boardCount(@PathVariable("idx") Integer idx) {
		boardMapper.boardCount(idx);
		return boardMapper.boardContent(idx);
	}
}
