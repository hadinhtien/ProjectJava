<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../layouts/header.jsp" flush="true"></jsp:include>

<jsp:include page="../layouts/menu.jsp" flush="true"></jsp:include>

<section class="banner_area">
	<div class="banner_inner d-flex align-items-center">
		<div class="container">
			<div
				class="banner_content d-md-flex justify-content-between align-items-center">
				<div class="mb-3 mb-md-0">
					<h2>The order</h2>
					<p>Very us move be blessed multiply night</p>
				</div>
				<div class="page_link">
					<a href="home">Home</a> <a href="theOrder">The order</a>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Home Banner Area =================-->

<!--================Single Product Area =================-->

<!--================Product Description Area =================-->
<section class="product_description_area">
	<div class="container">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item"><a class="nav-link active" id="home-tab"
				data-toggle="tab" href="#home" role="tab" aria-controls="home"
				aria-selected="true">Wait for confirmation</a></li>
			<li class="nav-item"><a class="nav-link" id="profile-tab"
				data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
				aria-selected="false">Being shipped</a></li>
			<li class="nav-item"><a class="nav-link" id="contact-tab"
				data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
				aria-selected="false">Delivered</a></li>
			<li class="nav-item"><a class="nav-link " id="review-tab"
				data-toggle="tab" href="#review" role="tab" aria-controls="review"
				aria-selected="false">Canceled</a></li>
		</ul>
		<div class="tab-content " id="myTabContent">
			<div class="tab-pane fade show active " id="home" role="tabpanel"
				aria-labelledby="home-tab">

				<c:forEach items="${ordersDTO_1}" var="order">
					<div class="row m-4">
						<div class="col-2">
							<h4>Order ID: ${order.orderId}</h4>
						</div>
						<div class="col-3">
							<samp style="color: #111111">
								Order date:
								<fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd" />
							</samp>
							<br>
							<samp style="color: #111111">Phone: ${order.phone}</samp>
						</div>
						<div class="col-7">
							<samp style="color: #111111">Address: ${order.address}</samp>
							<br>
							<samp style="color: #111111">Note: ${order.note}</samp>
						</div>
						<!-- <div class="col-12"
							style="height: 10px; border-bottom: 1px solid #111111;"></div> -->
					</div>
					<c:forEach items="${OrderDetailStatus_1}" var="orderDetail">
						<c:if test="${order.orderId == orderDetail.orderId}">
							<c:forEach items="${products}" var="product">
								<c:if test="${product.proId == orderDetail.proId}">
									<div style="background: #fffefb;" class="row mt-3 p-2">
										<div class="col-2">
											<img alt=""
												src="<c:url value="resources"/>/image/${product.imageUrl}"
												width="80%" />
										</div>
										<div class="col-8 mt-2">
											<samp class="mb-4 text-body" style="size: 30px">${product.name}</samp>
											<br>
											<samp class="mt-4">$ ${product.price - product.discount} x ${orderDetail.quantity}</samp>
										</div>
										<div class="col-2 mt-4">
											<samp style="color: rgba(0, 0, 0, .8);">$${orderDetail.price}</samp>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<div
								style="height: 10px; border-bottom: 1px solid rgba(0, 0, 0, .09);"></div>
						</c:if>
					</c:forEach>
					<div class="row mt-4 mb-4">
						<div class="col-9">
						    <a href="CancelOrder?id=${order.orderId}" class="btn btn-danger">Cancel</a>
						</div>
						<div class="col-3 mt-4 mb-4 ">
							<b style="color: rgba(0, 0, 0, .8)">Total money: $${order.totalPrice}</b>
						</div>
					</div>
					<div style="height: 10px; border-bottom: 1px solid #363636;"></div>
				</c:forEach>
			</div>

			<div class="tab-pane fade" id="profile" role="tabpanel"
				aria-labelledby="profile-tab">
				<c:forEach items="${ordersDTO_2}" var="order">
					<div class="row m-4">
						<div class="col-2">
							<h4>Order ID: ${order.orderId}</h4>
						</div>
						<div class="col-3">
							<samp style="color: #111111">
								Order date:
								<fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd" />
							</samp>
							<br>
							<samp style="color: #111111">Phone: ${order.phone}</samp>
						</div>
						<div class="col-7">
							<samp style="color: #111111">Address: ${order.address}</samp>
							<br>
							<samp style="color: #111111">Note: ${order.note}</samp>
						</div>
						<!-- <div class="col-12"
							style="height: 10px; border-bottom: 1px solid #111111;"></div> -->
					</div>
					<c:forEach items="${OrderDetailStatus_2}" var="orderDetail">
						<c:if test="${order.orderId == orderDetail.orderId}">
							<c:forEach items="${products}" var="product">
								<c:if test="${product.proId == orderDetail.proId}">
									<div style="background: #fffefb;" class="row mt-3 p-2">
										<div class="col-2">
											<img alt=""
												src="<c:url value="resources"/>/image/${product.imageUrl}"
												width="80%" />
										</div>
										<div class="col-8 mt-2">
											<samp class="mb-4 text-body" style="size: 30px">${product.name}</samp>
											<br>
											<samp class="mt-4">$ ${product.price - product.discount} x ${orderDetail.quantity}</samp>
										</div>
										<div class="col-2 mt-4">
											<samp style="color: rgba(0, 0, 0, .8);">$${orderDetail.price}</samp>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<div
								style="height: 10px; border-bottom: 1px solid rgba(0, 0, 0, .09);"></div>
						</c:if>
					</c:forEach>
					<div class="row mt-4 mb-4">
						<div class="col-9"></div>
						<div class="col-3 mt-4 mb-4 ">
							<b style="color: rgba(0, 0, 0, .8)">Total money:
								$${order.totalPrice}</b>
						</div>
					</div>
					<div style="height: 10px; border-bottom: 1px solid #363636;"></div>
				</c:forEach>
			</div>

			<div class="tab-pane fade" id="contact" role="tabpanel"
				aria-labelledby="contact-tab">
				<c:forEach items="${ordersDTO_3}" var="order">
					<div class="row m-4">
						<div class="col-2">
							<h4>Order ID: ${order.orderId}</h4>
						</div>
						<div class="col-3">
							<samp style="color: #111111">
								Order date:
								<fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd" />
							</samp>
							<br>
							<samp style="color: #111111">Phone: ${order.phone}</samp>
						</div>
						<div class="col-7">
							<samp style="color: #111111">Address: ${order.address}</samp>
							<br>
							<samp style="color: #111111">Note: ${order.note}</samp>
						</div>
						<!-- <div class="col-12"
							style="height: 10px; border-bottom: 1px solid #111111;"></div> -->
					</div>
					<c:forEach items="${OrderDetailStatus_3}" var="orderDetail">
						<c:if test="${order.orderId == orderDetail.orderId}">
							<c:forEach items="${products}" var="product">
								<c:if test="${product.proId == orderDetail.proId}">
									<div style="background: #fffefb;" class="row mt-3 p-2">
										<div class="col-2">
											<img alt=""
												src="<c:url value="resources"/>/image/${product.imageUrl}"
												width="80%" />
										</div>
										<div class="col-8 mt-2">
											<samp class="mb-4 text-body" style="size: 30px">${product.name}</samp>
											<br>
											<samp class="mt-4">$ ${product.price - product.discount} x ${orderDetail.quantity}</samp>
										</div>
										<div class="col-2 mt-4">
											<samp style="color: rgba(0, 0, 0, .8);">$${orderDetail.price}</samp>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<div
								style="height: 10px; border-bottom: 1px solid rgba(0, 0, 0, .09);"></div>
						</c:if>
					</c:forEach>
					<div class="row mt-4 mb-4">
						<div class="col-9"></div>
						<div class="col-3 mt-4 mb-4 ">
							<b style="color: rgba(0, 0, 0, .8)">Total money:
								$${order.totalPrice}</b>
						</div>

					</div>
					<div style="height: 10px; border-bottom: 1px solid #363636;"></div>
				</c:forEach>
			</div>

			<div class="tab-pane fade " id="review" role="tabpanel"
				aria-labelledby="review-tab">
				<c:forEach items="${ordersDTO_0}" var="order">
					<div class="row m-4">
						<div class="col-2">
							<h4>Order ID: ${order.orderId}</h4>
						</div>
						<div class="col-3">
							<samp style="color: #111111">
								Order date:
								<fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd" />
							</samp>
							<br>
							<samp style="color: #111111">Phone: ${order.phone}</samp>
						</div>
						<div class="col-7">
							<samp style="color: #111111">Address: ${order.address}</samp>
							<br>
							<samp style="color: #111111">Note: ${order.note}</samp>
						</div>
						<!-- <div class="col-12"
							style="height: 10px; border-bottom: 1px solid #111111;"></div> -->
					</div>
					<c:forEach items="${OrderDetailStatus_0}" var="orderDetail">
						<c:if test="${order.orderId == orderDetail.orderId}">
							<c:forEach items="${products}" var="product">
								<c:if test="${product.proId == orderDetail.proId}">
									<div style="background: #fffefb;" class="row mt-3 p-2">
										<div class="col-2">
											<img alt=""
												src="<c:url value="resources"/>/image/${product.imageUrl}"
												width="80%" />
										</div>
										<div class="col-8 mt-2">
											<samp class="mb-4 text-body" style="size: 30px">${product.name}</samp>
											<br>
											<samp class="mt-4">$ ${product.price - product.discount} x ${orderDetail.quantity}</samp>
										</div>
										<div class="col-2 mt-4">
											<samp style="color: rgba(0, 0, 0, .8);">$${orderDetail.price}</samp>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<div
								style="height: 10px; border-bottom: 1px solid rgba(0, 0, 0, .09);"></div>
						</c:if>
					</c:forEach>
					<div class="row mt-4 mb-4">
						<div class="col-9"></div>
						<div class="col-3 mt-4 mb-4 ">
							<b style="color: rgba(0, 0, 0, .8)">Total money:
								$${order.totalPrice}</b>
						</div>

					</div>
					<div style="height: 10px; border-bottom: 1px solid #363636;"></div>
				</c:forEach>
			</div>
		</div>
	</div>
</section>
<!--================End Product Description Area =================-->

<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>