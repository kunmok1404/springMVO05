package kr.board.mvc01.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.board.mvc01.entity.Board;

@Mapper
public interface BoardMapper {

	public List<Board> getList(); // 게시판 전체목록 조회 
	public void boardInsert(Board vo);
	public Board boardContent(Integer idx);
	public void boardDelete(Integer idx);
	public void boardUpdate(Board vo);
	@Update("UPDATE myboard SET COUNT=COUNT+1 WHERE IDX=#{idx}")
	public void boardCount(Integer idx);
}
