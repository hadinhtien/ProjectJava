<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<!-- Favicon icon -->
<link rel="icon" href="<c:url value="assets"/>/admin/images/favicon.ico" type="image/x-icon">

<!-- vendor css -->
<link rel="stylesheet" href="<c:url value="assets"/>/admin/css/style.css">
</head>
<body>
	<!-- [ auth-signin ] start -->
	<div class="auth-wrapper" style="background-image: url('<c:url value="assets"/>/admin/images/auth/img-auth-big.jpg');">
		<div class="auth-content text-center">
			<img src="<c:url value="assets"/>/admin/images/logo.png" alt="" class="img-fluid mb-4">
			<div class="card borderless">
				<div class="row align-items-center ">
					<div class="col-md-12">
						<div class="card-body">
							<h4 class="mb-3 f-w-400">Login</h4>
							<hr>
							<div class="form-group mb-3">
								<input type="text" class="form-control" id="Email"
									placeholder="Email address">
							</div>
							<div class="form-group mb-4">
								<input type="password" class="form-control" id="Password"
									placeholder="Password">
							</div>
							<div class="custom-control custom-checkbox text-left mb-4 mt-2">
								<input type="checkbox" class="custom-control-input"
									id="customCheck1"> <label class="custom-control-label"
									for="customCheck1">Save credentials.</label>
							</div>
							<button class="btn btn-block btn-primary mb-4">Signin</button>
							<hr>
							<!-- <p class="mb-2 text-muted">
								Forgot password? <a href="auth-reset-password.html"
									class="f-w-400">Reset</a>
							</p>
							<p class="mb-0 text-muted">
								Don’t have an account? <a href="auth-signup.html"
									class="f-w-400">Signup</a>
							</p> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- [ auth-signin ] end -->

	<!-- Required Js -->
	<script src="<c:url value="assets"/>/admin/js/vendor-all.min.js"></script>
	<script src="<c:url value="assets"/>/admin/js/plugins/bootstrap.min.js"></script>

	<script src="<c:url value="assets"/>/admin/js/pcoded.js"></script>
</body>
</html>