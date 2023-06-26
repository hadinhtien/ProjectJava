<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="../layouts/header.jsp" flush="true"></jsp:include>

<div class="page-header col-12">
	<div class="page-block">
		<div class="row align-items-center">
			<div class="col-md-12">
				<div class="page-header-title">
					<h5 class="m-b-10">Esier admin</h5>
				</div>
				<ul class="breadcrumb">
					<li class="breadcrumb-item"><a href="dashboard"><i
							class="feather icon-home"></i></a></li>
					<li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<div class="col-md-12 col-xl-3">
	<!-- widget primary card start -->
	<div class="card flat-card widget-primary-card">
		<div class="row-table">
			<div class="col-sm-3 card-body">
				<i class="feather icon-star-on"></i>
			</div>
			<div class="col-sm-9">
				<h4>${listCategorys}</h4>
				<h6>Category</h6>
			</div>
		</div>
	</div>
</div>

<div class="col-md-12 col-xl-3">
	<!-- widget primary card start -->
	<div class="card flat-card widget-purple-card">
		<div class="row-table">
			<div class="col-sm-3 card-body">
				<i class="fas fa-trophy"></i>
			</div>
			<div class="col-sm-9">
				<h4>${listBrands}</h4>
				<h6>Brand</h6>
			</div>
		</div>
	</div>
</div>

<div class="col-md-12 col-xl-3">
	<!-- widget primary card start -->
	<div class="card flat-card widget-primary-card">
		<div class="row-table">
			<div class="col-sm-3 card-body">
				<i class="feather icon-star-on"></i>
			</div>
			<div class="col-sm-9">
				<h4>${listProducts}</h4>
				<h6>Product</h6>
			</div>
		</div>
	</div>
</div>

<div class="col-md-12 col-xl-3">
	<!-- widget-success-card start -->
	<div class="card flat-card widget-purple-card">
		<div class="row-table">
			<div class="col-sm-3 card-body">
				<i class="fas fa-trophy"></i>
			</div>
			<div class="col-sm-9">
				<h4>${listOrderDetails}</h4>
				<h6>Order</h6>
			</div>
		</div>
	</div>
	<!-- widget-success-card end -->
</div>
<!-- table card-2 end -->
<div class="col-xl-8 col-md-8">
	<div class="card table-card">
		<div class="card-header">
			<h5>Products purchased today</h5>
		</div>
		<div class="card-body p-0">
			<div class="table-responsive">
				<table class="table table-hover mb-0">
					<thead>
						<tr>
							<th>Name</th>
							<th>Quantity</th>
							<th class="text-right">Price</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${getOrderDetailStatus_1}" var="OrderDetail">
							<c:forEach items="${Products}" var="product">
								<tr>
									<c:if test="${OrderDetail.proId == product.proId}">
										<td>
											<div class="d-inline-block align-middle">
												<img
													src="${pageContext.request.contextPath}/<c:url value="resources"/>/image/${product.imageUrl}"
													alt="user image" class=" wid-40 align-top m-r-15">
												<div class="d-inline-block">
													<h6>${product.name}</h6>
													
												</div>
											</div>
										</td>
										<td>x ${OrderDetail.quantity}</td>
										<td class="text-right">$${OrderDetail.price}</td>
									</c:if>
								</tr>
							</c:forEach>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

	</div>
</div>
<div class="col-xl-4 col-md-4">
	
		<div class="card flat-card widget-primary-card">
		<div class="row-table">
			<div class="col-sm-3 card-body">
				<i class="feather icon-star-on"></i>
			</div>
			<div class="col-sm-9">
				<h4>${accounts}</h4>
				<h6>Accounts</h6>
			</div>
		</div>
	</div>
</div>
<!-- prject ,team member start -->

<!-- <div class="col-xl-4 col-md-12">
	<div class="card">
		<div class="card-body">
			<div class="row align-items-center">
				<div class="col-6">
					<h3>$16,756</h3>
					<h6 class="text-muted m-b-0">
						Visits<i class="fa fa-caret-down text-c-red m-l-10"></i>
					</h6>
				</div>
				<div class="col-6">
					<div id="seo-chart1" class="d-flex align-items-end"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="col-xl-4 col-md-6">
	<div class="card">
		<div class="card-body">
			<div class="row align-items-center">
				<div class="col-6">
					<h3>49.54%</h3>
					<h6 class="text-muted m-b-0">
						Bounce Rate<i class="fa fa-caret-up text-c-green m-l-10"></i>
					</h6>
				</div>
				<div class="col-6">
					<div id="seo-chart2" class="d-flex align-items-end"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="col-xl-4 col-md-6">
	<div class="card">
		<div class="card-body">
			<div class="row align-items-center">
				<div class="col-6">
					<h3>1,62,564</h3>
					<h6 class="text-muted m-b-0">
						Products<i class="fa fa-caret-down text-c-red m-l-10"></i>
					</h6>
				</div>
				<div class="col-6">
					<div id="seo-chart3" class="d-flex align-items-end"></div>
				</div>
			</div>
		</div>
	</div>
</div> -->
<!-- seo end -->

<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>