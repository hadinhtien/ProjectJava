<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="../layouts/header.jsp" flush="true"></jsp:include>

<jsp:include page="../layouts/menu.jsp" flush="true"></jsp:include>

<!--================Home Banner Area =================-->
<section class="banner_area">
	<div class="banner_inner d-flex align-items-center">
		<div class="container">
			<div
				class="banner_content d-md-flex justify-content-between align-items-center">
				<div class="mb-3 mb-md-0">
					<h2>Checkout</h2>
					<p>Very us move be blessed multiply night</p>
				</div>
				<div class="page_link">
					<a href="home">Home</a> <a href="checkOut">Checkout</a>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Home Banner Area =================-->

<!--================Checkout Area =================-->
<section class="checkout_area section_gap">
	<div class="container">

		<div class="billing_details">
			<form:form method="post" action="doCheckOut"
				modelAttribute="order">
				<div class="row">
					<div class="col-lg-8">
						<h3>Billing Details</h3>
						<div class="row contact_form">
							<div class="col-md-12 form-group">
								<h5>Full name <span class="text-danger">*</span></h5>
								<form:input type="text" class="form-control" path="fullName"
									placeholder="enter full name" autocomplete="off" value="${accFullName}"/>
									<form:errors path="fullName" class="text-danger mt-2 d-block"></form:errors>
							</div>

							<div class="col-md-12 form-group p_star">
								<h5>Address <span class="text-danger">*</span></h5>
								<form:input type="text" class="form-control" path="address"
									placeholder="enter your address" autocomplete="off" value="${accAddress}"/>
									<form:errors path="address" class="text-danger mt-2 d-block"></form:errors>
							</div>

							<div class="col-md-12 form-group p_star">
								<h5>Phone number <span class="text-danger">*</span></h5>
								<form:input type="text" class="form-control" path="phone"
									placeholder="enter your phone number" autocomplete="off" value="${accPhone}"/>
									<form:errors path="phone" class="text-danger mt-2 d-block"></form:errors>
							</div>

							<div class="col-md-12 form-group">
								<h5>Note</h5>
								<form:textarea class="form-control" placeholder="Order notes"
									path="note" />
									<form:errors path="note" class="text-danger mt-2 d-block"></form:errors>
							</div>
						</div>

					</div>
					<div class="col-lg-4">
						<div class="order_box">
							<h2>Your Order</h2>
							<ul class="list">
								<li>
									<a style="cursor: context-menu;" href="#">Product <span>Total</span></a>
								</li>
								<c:forEach items="${carts}" var="cart">
									<li><c:forEach items="${products}" var="product">
											<c:if test="${product.proId == cart.proId}">
												<a class="font-weight-light" style="cursor: context-menu;" href="#">${product.name}
													<span class="middle">x ${cart.quantity}</span> 
													<span class="last">$${(product.price - product.discount) * cart.quantity}</span>
												</a>
											</c:if>
										</c:forEach></li>
								</c:forEach>
							</ul>
							<ul class="list list_2">
								<li>
									<a style="cursor: context-menu;" href="#">Total <span>$${total}</span></a>
								</li>
							</ul>
							<div class="d-flex justify-content-center mt-3">
								<input class="main_btn px-5" type="submit" value="place order">
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</div>
</section>
<!--================End Checkout Area =================-->

<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>