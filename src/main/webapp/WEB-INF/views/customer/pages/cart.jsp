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
					<h2>Cart</h2>
					<p>Very us move be blessed multiply night</p>
				</div>
				<div class="page_link">
					<a href="home">Home</a> <a href="listCart">Cart</a>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Home Banner Area =================-->

<!--================Cart Area =================-->
<c:if test="${empty carts}">
	<section class="cart_area">
		<div class="container">
			<div class="cart_inner">
				<img src="<c:url value="assets"/>/customer/img/empty-cart.png"
					class="card-img">
				<h4 class="d-flex justify-content-center mb-5">There are no
					products in the cart</h4>
				<div class="continue d-flex justify-content-center">
					<a class="main_btn" href="allCategory">Continue shopping</a>
				</div>
			</div>
		</div>
	</section>
</c:if>

<c:if test="${not empty carts}">
	<section class="cart_area">
		<div class="container">
			<div class="cart_inner">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">Product</th>
								<th scope="col">Price</th>
								<th scope="col">Quantity</th>
								<th scope="col">Total</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<form method="post" action="updateCart">
								<c:forEach items="${carts}" var="cart">

									<input type="hidden" name="cartId" value="${cart.cartId}" />
									<tr>
										<td><c:forEach items="${products}" var="product">
												<c:if test="${product.proId == cart.proId}">
													<div class="media">
														<div class="col-5">
															<a href="productDetail?proId=${cart.proId}"><img
																width="85%"
																src="<c:url value="resources"/>/image/${product.imageUrl}" /></a>
														</div>
														<div class="media-body">
															<a class="text-secondary"
																href="productDetail?proId=${cart.proId}">${product.name}</a>
														</div>
													</div>
												</c:if>
											</c:forEach></td>
										<c:forEach items="${products}" var="product">
											<c:if test="${product.proId == cart.proId}">
												<td><h5 class="mr-5">$${product.price -
														product.discount}</h5></td>
											</c:if>
										</c:forEach>
										<td>
											<div class="product_count mr-5">
												<input type="text" name="quantity" id="sst${cart.cartId}"
													maxlength="12" value="${cart.quantity}" title="Quantity:"
													class="input-text qty" />
												<button
													onclick="var result = document.getElementById('sst${cart.cartId}'); var sst${cart.cartId} = result.value; if( !isNaN( sst${cart.cartId} )) result.value++;return false;"
													class="increase items-count" type="button">
													<i class="lnr lnr-chevron-up"></i>
												</button>
												<button
													onclick="var result = document.getElementById('sst${cart.cartId}'); var sst${cart.cartId} = result.value; if( !isNaN( sst${cart.cartId} ) &amp;&amp; sst${cart.cartId} > 0 ) result.value--;return false;"
													class="reduced items-count" type="button">
													<i class="lnr lnr-chevron-down"></i>
												</button>
											</div> <c:forEach items="${listCartIds}" var="listCartId">
												<c:if test="${listCartId == cart.cartId}">
													<c:forEach items="${products}" var="product">
														<c:if test="${product.proId == cart.proId}">
															<div class="text-danger mt-1">${quantity}
																${product.quantity} quantity remaining for this item</div>
														</c:if>
													</c:forEach>
												</c:if>
											</c:forEach> <c:forEach items="${listCartId1}" var="listCartId">
												<c:if test="${listCartId == cart.cartId}">
													<c:forEach items="${products}" var="product">
														<c:if test="${product.proId == cart.proId}">
															<div class="text-danger mt-1">${statusProduct}</div>
														</c:if>
													</c:forEach>
												</c:if>
											</c:forEach>
										</td>
										<c:forEach items="${products}" var="product">
											<c:if test="${product.proId == cart.proId}">
												<td>
													<div class="d-flex">
														<h5 class="pt-2 mr-5">$${(product.price -
															product.discount) * cart.quantity}</h5>
														<a class="text-secondary"
															href="deleteCart?cartId=${cart.cartId}"> <i
															style="font-size: 24px" class="fa fa-times ml-3 pt-1"
															aria-hidden="true"></i>
														</a>
													</div>
												</td>
											</c:if>
										</c:forEach>
									</tr>
								</c:forEach>
								<tr>
									<td><a class="gray_btn main_btn ml-3" href="category">Continue
											Shopping</a></td>
									<td colspan="2"></td>
									<td><input class="gray_btn main_btn" type="submit"
										value="Update Cart"></td>
								</tr>
								<tr>
									<td colspan="2"></td>
									<td colspan="2" class="text-right"><a href="checkOut"
										class="main_btn">Proceed to checkout</a></td>
								</tr>
							</form>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</section>
</c:if>
<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>