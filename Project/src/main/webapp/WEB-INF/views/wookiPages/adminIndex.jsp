<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>어드민 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- jquery, fontawesome -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/07b67006ce.js"></script>

<!-- css파일 및 js파일 -->
<link rel="stylesheet" href="resources/wooki/css/common.css">
<script src="resources/wooki/js/common.js"></script>
<script>
	$(document).ready(function() {
		//fn_adminCheck(${loginUser.user_separator});
		fn_selectBtn();
		fn_main();
		fn_openChangeEmailModal();
		fn_changeEmailIsPossible();
		fn_changeEmail();
		fn_closeChangeEmailModal();
		fn_sendTempPass();
		fn_updateNormalUser();
		fn_checkUser();
		fn_updateAdminUser();
		fn_deleteUser();
		fn_addTrainerSendEamil();
		fn_closeAddTrainerModal();
		fn_boardFilterAdd();
		fn_boardsOnHideToggle();
		fn_boardDelete();
		fn_commentFilterAdd();
		fn_commentsOnHideToggle();
		$('.comment').click(function() {
			fn_commentsPage();
		});
		$('.board').click(function() {
			fn_boardsPage();
		});
		$('.admin').click(function() {
			fn_addAdminPage();
		});
		$('.user').click(function() {
			fn_user(1);
		});
		$('.trainer').click(function() {
			fn_trainerUser(1);
		});
		$('.main').click(function() {
			fn_main();
		});
	});
</script>
</head>
<body>
	<div class="container">
		<div class="top-container space-between w1000">
			<div>LetsSports</div>
			<div>
				<input type="button" value="로그아웃" onclick="fn_logout()" />
			</div>
		</div>
		<div class="nav-container flex w1000">
			<div class="nav-btn main" id="select-nav">메인페이지</div>
			<div class="nav-btn user">회원관리</div>
			<div class="nav-btn admin">관리자등록</div>
			<div class="nav-btn trainer">트레이너관리</div>
			<div class="nav-btn board">게시글관리</div>
			<div class="nav-btn comment">댓글관리</div>
			<div class="nav-btn review">리뷰관리</div>
			<div class="nav-btn trainer_qna">트레이너Q&amp;A</div>
			<div class="nav-btn photo">사진관리</div>
		</div>
		<div class="content-container w1000 scroll"></div>
	</div>

	<div class="black-background hide" id="change-email-modal">
		<div class="white-background">
			<table style="width: 100%;">
				<tbody>
					<tr>
						<td colspan="2">
							<h1>이메일변경</h1>
						</td>
					</tr>
					<tr>
						<td><span>기존이메일주소</span></td>
						<td><input type="text" name="current_email"
							id="current_email" readonly /></td>
					</tr>
					<tr>
						<td><span>변경이메일주소</span></td>
						<td><input type="text" name="change_email" id="change_email" />
							<div id="change_mail_is_possible"></div></td>
					</tr>
					<tr>
						<td colspan="2"><input type="hidden" name="change_user_no"
							id="change_user_no" /> <input type="button"
							id="change_email_submit" value="이메일변경하기" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div class="black-background hide" id="add-trainer-modal">
		<div class="white-background">
			<table style="width: 100%;">
				<tbody>
					<tr>
						<td colspan="2">
							<h1>트레이너 가입메일 발송하기</h1>
						</td>
					</tr>
					<tr>
						<td><span>유저번호</span></td>
						<td><input type="text" name="trainer_target_user_no"
							id="trainer_target_user_no" /></td>
					</tr>
					<tr>
						<td><span>유저닉네임</span></td>
						<td>
							<div id="trainer_target_user_nickname"></div>
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type="button"
							id="send-add-trainer-email" value="회원가입메일발송" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>