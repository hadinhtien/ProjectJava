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
					<h2>My account</h2>
					<p>Very us move be blessed multiply night</p>
				</div>
				<div class="page_link">
					<a href="home">Home</a> <a href="myAccount">My account</a>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Home Banner Area =================-->

<section class="section_gap">
	<div class="container">
		<div class="row">
			<div class="col-6">
				<h4>My account</h4>
				<p>Manage profile information for account security</p>
				<hr>
				<c:if test="${not empty updateAccount}">
					<div class="alert alert-success alert-dismissible fade show" role="alert">
				  		<span>${updateAccount}</span>
				  		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				    		<span aria-hidden="true">&times;</span>
				  		</button>
					</div>
				</c:if>
				<form:form modelAttribute="account" method="post" action="updateAccount">
					<div class="form-group">
					    <label class="">Email</label>
					    <input class="form-control" value="${accEmail}" readonly/>
					</div>
				    <form:hidden path="password" value="0"/>
					
					<div class="form-group">
					    <label class="">Full name</label>
					    <form:input class="form-control" autocomplete="off" path="fullName" value="${accFullName}" placeholder="enter full name"/>
					    <form:errors class="text-danger mt-1 d-block" path="fullName"></form:errors>
					</div>
					
					<div class="form-group">
					    <label class="">Phone number </label>
					    <form:input class="form-control" autocomplete="off" type="number" value="${accPhone}" min="0" path="phone" placeholder="enter your phone number"/>
					    <form:errors class="text-danger mt-1 d-block" path="phone"></form:errors>
					</div>
					
					<div class="form-group">
					    <label class="">Address </label>
					    <form:input class="form-control" autocomplete="off" path="address" value="${accAddress}" placeholder="enter your address"/>
					    <form:errors class="text-danger mt-1 d-block" path="address"></form:errors>
					</div>
					<div class="">
						<input class="main_btn " type="submit" value="Save">
					</div>
				</form:form>
			</div>
			<div class="col-6">
				<h4>Change password</h4>
				<p>For account security, please do not share your password with others</p>
				<hr>
				<form action="changePassword" method="post">
					<div class="form-group">
					    <label class="">Current password</label>
					    <input class="form-control" type="password" autocomplete="off" name="currentPassword" placeholder="enter current password"/>
					    <c:if test="${not empty currentPassword}">
							<span class="text-danger mt-1 d-block">${currentPassword}</span>
						</c:if>
					</div>
					
					<div class="form-group">
					    <label class="">A new password</label>
					    <input class="form-control" type="password" autocomplete="off" name="newPassword" placeholder="enter new password"/>
					    <c:if test="${not empty newPassword}">
							<span class="text-danger mt-1 d-block">${newPassword}</span>
						</c:if>
					</div>
					
					<div class="form-group">
					    <label class="">Confirm password</label>
					    <input class="form-control" type="password" autocomplete="off" name="confirmPassword" placeholder="enter confirm password"/>
					    <c:if test="${not empty confirmPassword}">
							<span class="text-danger mt-1 d-block">${confirmPassword}</span>
						</c:if>
					</div>
					<div class="">
						<input class="main_btn" type="submit" value="Change">
					</div>
				</form>
			</div>
		</div>
	</div>
</section>

<jsp:include page="../../layouts/footer.jsp" flush="true"></jsp:include>