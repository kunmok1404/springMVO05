package kr.board.mvc01.controller;

import java.io.File;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.board.mvc01.entity.Member;
import kr.board.mvc01.mapper.MemberMapper;

@Controller
public class MemberController {
	
	@Autowired
	private MemberMapper memberMapper;

	@GetMapping("/memJoin.do")
	public String memJoin() {
		return "member/join";
	}
	
	@ResponseBody
	@PostMapping("/memRegisterChk")
	public int memRegisterChk(@RequestBody Member member) {
		Member m = memberMapper.getMemberInfo(member.getMemID());
		return Objects.isNull(m) ? 1 : 0;
	}
	
	// 회원가입처리
	@PostMapping("/memRegister.do")
	public String memRegister(Member member, RedirectAttributes rttr, HttpSession session) {
		if(!memberValid(member)) {
			rttr.addFlashAttribute("msgType", "fail");
			rttr.addFlashAttribute("msg", "필수 입력값을 확인해주세요.");
			return "redirect:/memJoin.do";
		}
		if(!member.getMemPassword1().equals(member.getMemPassword2())) {
			rttr.addFlashAttribute("msgType", "fail");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
			return "redirect:/memJoin.do";
		}
		member.setMemPassword(member.getMemPassword1());
		member.setMemProfile("");
		// 회원가입처리
		int result = memberMapper.memberRegister(member);
		if(result > 0) {
			rttr.addFlashAttribute("msgType", "success");
			rttr.addFlashAttribute("msg", "회원가입이 완료되었습니다.");
			session.setAttribute("mvo", member);
			return "redirect:/";
		} else {
			rttr.addFlashAttribute("msgType", "fail");
			rttr.addFlashAttribute("msg", "회원가입에 실패하였습니다.");
			return "redirect:/memJoin.do";
		}
		
	}
	
	// 로그아웃처리
	@GetMapping("/memLogout.do")
	public String memLogout(HttpSession httpSession) {
		httpSession.invalidate();
		return "redirect:/";
	}
	
	// 로그인화면 이동
	@GetMapping("/memLoginForm.do")
	public String memLoginForm() {
		return "member/login";
	}
	
	// 로그인처리
	@PostMapping("/memLogin.do")
	public String memLogin(Member member, RedirectAttributes rttr, HttpSession session) {
		if(member == null) {
			return "redirect:/";
		}
		if(member.getMemID() == null || member.getMemID().equals("") ||
		   member.getMemPassword() == null || "".equals(member.getMemPassword())){
			rttr.addFlashAttribute("msgType", "fail");
			rttr.addFlashAttribute("msg", "유저정보를 입력해주세요.");
			return "redirect:/memLoginForm.do";
		}
		Member memDto = memberMapper.chkLogin(member);
		if(memDto != null) {
			session.setAttribute("mvo", memDto);
			return "redirect:/";
		} else {
			rttr.addFlashAttribute("msgType", "fail");
			rttr.addFlashAttribute("msg", "아이디 혹은 비밀번호가 일치하지 않습니다.");
			return "redirect:/memLoginForm.do";
		}
	}
	
	// 회원정보수정 화면 이동
	@GetMapping("/updateUserInfo.do")
	public String updateUserInfo() {
		return "member/updateUserForm";
	}
	
	// 회원정보수정 처리
	@PostMapping("/updateUserInfo.do")
	public String updateUser(Member member, RedirectAttributes rttr, HttpSession session) {
		if(!memberValid(member)) {
			rttr.addFlashAttribute("msgType", "fail");
			rttr.addFlashAttribute("msg", "필수 입력값을 확인해주세요.");
			return "redirect:/updateUserForm.do";
		}
		if(!member.getMemPassword1().equals(member.getMemPassword2())) {
			rttr.addFlashAttribute("msgType", "fail");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
			return "redirect:/updateUserForm.do";
		}
		member.setMemPassword(member.getMemPassword1());
		// 회원정보 수정
		int result = memberMapper.memUpdate(member);
		if(result == 1) {
			rttr.addFlashAttribute("msgType", "success");
			rttr.addFlashAttribute("msg", "회원정보가 수정되었습니다.");
			session.setAttribute("mvo", memberMapper.getMemberInfo(member.getMemID()));
			return "redirect:/";
		} else {
			rttr.addFlashAttribute("msgType", "fail");
			rttr.addFlashAttribute("msg", "회원정보수정에 실패했습니다.");
			return "redirect:/updateUserForm.do";
		}
	
	}
	
	// 사진등록화면 이동
	@GetMapping("/userImgForm.do")
	public String userImgForm() {
		return "member/userImgForm";
	}
	
	// 사진등록처리
	@PostMapping("/addUserImg.do")
	public String addUserImg(HttpServletRequest request, HttpSession session, RedirectAttributes rttr) {
		// 1.파일업로드 API(cos.jar)
		MultipartRequest multi = null;
		int fileSize = 10*1024*1024; // 10MB
		String savePath = request.getRealPath("resources/upload"); // 실제경로 얻기
		try {
			// 이미지 업로드
			multi = new MultipartRequest(request, savePath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msgType", "fail");
			rttr.addFlashAttribute("msg", "파일의 크기는 10MB를 넘을 수 없습니다.");
			return "redirect:/userImgForm.do";
		}
		// DB저장
		String memID = multi.getParameter("memID");
		String fileName = "";
		File file = multi.getFile("memProfile");
		if(file != null) { // .PNG .JPG .GIF
			String ext = file.getName().substring(file.getName().lastIndexOf(".")+1).toUpperCase();
			if("PNG".equals(ext) || "JPG".equals(ext) || "GIF".equals(ext)) {
				// 기존실제파일 삭제
				Member mdto = memberMapper.getMemberInfo(memID);
				String originProfile = mdto.getMemProfile();
				File originFile = new File(savePath + File.separator + originProfile);
				
				if(originFile.exists()) {
					originFile.delete();
				}
				fileName = file.getName();
			} else {
				// 이미지 파일이 아니라면 삭제
				if(file.exists()) {
					file.delete();
				}
				rttr.addFlashAttribute("msgType", "fail");
				rttr.addFlashAttribute("msg", "이미지 파일만 업로드 할 수 있습니다.");
				return "redirect:/userImgForm.do";
			}
		}
		// DB => 새로운 이미지 업데이트
		Member member = new Member();
		member.setMemID(memID);
		member.setMemProfile(fileName);
		memberMapper.updateProfile(member);
		Member newMember = memberMapper.getMemberInfo(memID);
		session.setAttribute("mvo", newMember); // 세션새롭게 생성
		rttr.addFlashAttribute("msgType", "success");
		rttr.addFlashAttribute("msg", "이미지가 등록되었습니다.");
		return "redirect:/";
	}
	
	private Boolean memberValid(Member member) {
		if(member.getMemID()== null || member.getMemID().equals("") ||
		   member.getMemPassword1()== null || member.getMemPassword1().equals("") ||
		   member.getMemPassword2()== null || member.getMemPassword2().equals("") ||	
		   member.getMemName()== null || member.getMemName().equals("") ||	
		   member.getMemAge()== 0 ||
		   member.getMemGender()== null || member.getMemGender().equals("") ||
		   member.getMemEmail()== null || member.getMemEmail().equals("")) {
		   return false;
		}
		return true;
	}
}
