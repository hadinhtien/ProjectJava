<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="../../layouts/header.jsp" flush="true"></jsp:include>

<jsp:include page="../../layouts/menu.jsp" flush="true"></jsp:include>

<!--================Home Banner Area =================-->
<section class="banner_area">
	<div class="banner_inner d-flex align-items-center">
		<div class="container">
			<div
				class="banner_content d-md-flex justify-content-between align-items-center">
				<div class="mb-3 mb-md-0">
					<h2>Sign up</h2>
					<p>Very us move be blessed multiply night</p>
				</div>
				<div class="page_link">
					<a href="home">Home</a> <a href="signUp">Sign up</a>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Home Banner Area =================-->

<section class="section_gap">
	<div class="container">
		<div class="text-center mb-5">
			<h2>Sign up</h2>
			<h6 class="font-weight-light">Welcome to Eiser, fill out the information below to sign up an account and start shopping</h6>
		</div>
		<div class="col-12 col-lg-7 m-auto">
			<form:form action="doSignUp" modelAttribute="account" method="post">
				<div class="form-group">
				    <label>Email <span class="text-danger">*</span></label>
				    <form:input type="email" class="form-control" autocomplete="off" path="email" placeholder="enter your email"/>
				    <form:errors class="text-danger mt-1 d-block" path="email"></form:errors>
				    <c:if test="${not empty emailExist}">
						<span class="text-danger mt-1 d-block">${emailExist}</span>
					</c:if>
				</div>
			
				<div class="form-group">
				    <label>Full name <span class="text-danger">*</span></label>
				    <form:input class="form-control" autocomplete="off" path="fullName" placeholder="enter full name"/>
				    <form:errors class="text-danger mt-1 d-block" path="fullName"></form:errors>
				</div>
				
				<div class="form-group">
				    <label>Phone number <span class="text-danger">*</span></label>
				    <form:input class="form-control" autocomplete="off" type="number" min="0" path="phone" placeholder="enter your phone number"/>
				    <form:errors class="text-danger mt-1 d-block" path="phone"></form:errors>
				</div>
				
				<div class="form-group">
				    <label>Address <span class="text-danger">*</span></label>
				    <form:input class="form-control" autocomplete="off" path="address" placeholder="enter your address"/>
				    <form:errors class="text-danger mt-1 d-block" path="address"></form:errors>
				</div>
				
				<div class="form-group">
				    <label>Password <span class="text-danger">*</span></label>
				    <form:input class="form-control" autocomplete="off" type="password" path="password" placeholder="enter password"/>
				    <form:errors class="text-danger mt-1 d-block" path="password"></form:errors>
				</div>
				
				<div class="form-group">
				    <label>Confirm password <span class="text-danger">*</span></label>
				    <input type="password" class="form-control" autocomplete="off" name="confirmPassword" placeholder="enter confirm password"/>
					<c:if test="${not empty confirmPassword}">
						<span class="text-danger mt-1 d-block">${confirmPassword}</span>
					</c:if>
				</div>
				
				<div class="d-flex justify-content-center">
					<input class="main_btn px-5" type="submit" value="Sign up">
				</div>
				<div class="text-center mt-3">
	                <span>Already have an account? </span> <a href="login" class="mainColor">Login</a>
	            </div>
			</form:form>
		</div>
	</div>
</section>

<jsp:include page="../../layouts/footer.jsp" flush="true"></jsp:include>