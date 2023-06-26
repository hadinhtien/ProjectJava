<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../../layouts/header.jsp" flush="true"></jsp:include>

<jsp:include page="../../layouts/menu.jsp" flush="true"></jsp:include>

<!--================Home Banner Area =================-->
<section class="banner_area">
	<div class="banner_inner d-flex align-items-center">
		<div class="container">
			<div
				class="banner_content d-md-flex justify-content-between align-items-center">
				<div class="mb-3 mb-md-0">
					<h2>Login</h2>
					<p>Very us move be blessed multiply night</p>
				</div>
				<div class="page_link">
					<a href="home">Home</a> <a href="login">Login</a>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="section_gap">
	<div class="container">
		<div class="text-center mb-4">
			<h2>Login</h2>
			<h6 class="font-weight-light">Welcome to Eiser, fill out the information below to login and start shopping</h6>
		</div>
		<div class="col-12 col-lg-6 m-auto">
			<form name="loginForm" action="<c:url value="j_spring_security_login" />" method="POST">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<c:if test="${not empty login}">
					<div class="alert alert-danger" role="alert">
						<span class="text-dark">${login}</span>
					</div>
				</c:if>
				<c:if test="${not empty loginSuccess}">
					<div class="alert alert-success" role="alert">
						<span class="text-dark">${loginSuccess}</span>
					</div>
				</c:if>
				<div class="form-group">
				    <label>Email address <span class="text-danger">*</span></label>
				    <input class="form-control" type="text" name="Email" placeholder="Enter your email address">
				</div>
				
				<div class="form-group">
				    <label>Password <span class="text-danger">*</span></label>
				    <input class="form-control" type="password" name="Password" placeholder="Enter password">
				</div>

				<div class="d-flex justify-content-center">
					<input class="main_btn px-5" name="submit" type="submit" value="Login"/>
				</div>
				<div class="text-center mt-3">
				    <span>Need an account? </span> <a href="signUp" class="mainColor">Sign up</a>
				</div>
			</form>
		</div>
	</div>
</section>

<!--================End Home Banner Area =================-->

<jsp:include page="../../layouts/footer.jsp" flush="true"></jsp:include>