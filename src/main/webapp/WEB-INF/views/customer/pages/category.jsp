<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../layouts/header.jsp" flush="true"></jsp:include>

<jsp:include page="../layouts/menu.jsp" flush="true"></jsp:include>

<!--================Home Banner Area =================-->
<section class="banner_area">
	<div class="banner_inner d-flex align-items-center">
		<div class="container">
			<div
				class="banner_content d-md-flex justify-content-between align-items-center">
				<div class="mb-3 mb-md-0">
					<h2>Shop Category</h2>
					<p>Very us move be blessed multiply night</p>
				</div>
				<div class="page_link">
					<a href="home">Home</a> <a href="category">Shop</a>
					<!-- <a href="category.html">Women Fashion</a> -->
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Home Banner Area =================-->

<!--================Category Product Area =================-->
<section class="cat_product_area section_gap">
	<div class="container">
		<div class="row flex-row-reverse">
			<div class="col-lg-9">
				<div class="product_top_bar flex-row-reverse">
					<form action="searchProductCustomer" method="get">
						<div class="row">		
							<div class="col-10 pr-0">
								<input type="text" name="name" class="form-control" placeholder="Search product">
							</div>
							<div class="col-2 pl-1 pr-4"> 
								<button type="submit" class="btn btn-secondary"><i class="fa fa-search" aria-hidden="true"></i></button>
							</div>
						</div>
					</form>
				</div>

				<div class="latest_product_inner">
					<div class="row">
						<c:forEach items="${listProducts}" var="product">
							<div class="col-lg-4 col-md-6">
								<div class="single-product">
									<div class="product-img">
										<img class="img-fluid w-100"
											src="<c:url value="resources"/>/image/${product.imageUrl}" />
										<%-- <div class="p_icon">
											<a href="productDetail?proId=${product.proId}"><i class="ti-eye"></i></a> 
											 <a href="#"><i class="ti-heart"></i></a>
											<a href="insertcart?proId=${product.proId}&quantity=1"><i class="ti-shopping-cart"></i></a>
										</div> --%>
									</div>
									<div class="product-btm">
										<a href="productDetail?proId=${product.proId}" class="d-block"><h4>${product.name}</h4></a>
										<div class="mt-3">
											<c:if test="${product.discount > 0}">
												<span class="mr-4">$ ${product.price - product.discount}</span>
												<del>$ ${product.price}0</del>
											</c:if>
											<c:if test="${product.discount == 0}">
												<span class="mr-4">$ ${product.price}</span>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>

			<div class="col-lg-3">
				<div class="left_sidebar_area">
					<aside class="left_widgets p_filter_widgets">
						<div class="l_w_title">
							<h3>Categories</h3>
						</div>
						<div class="widgets_inner">
							<ul class="list">
								<c:forEach items="${listCategories}" var="category">
									<li><a href="category?cateId=${category.cateId}">${category.name}</a></li>
								</c:forEach>
							</ul>
						</div>
					</aside>

					<aside class="left_widgets p_filter_widgets">
						<div class="l_w_title">
							<h3>Brands</h3>
						</div>
						<div class="widgets_inner">
							<ul class="list">
								<c:forEach items="${listBrands}" var="brand">
									<li><a href="brand?brandId=${brand.brandId}">${brand.name}</a></li>
								</c:forEach>
							</ul>
						</div>
					</aside>

					<!-- <aside class="left_widgets p_filter_widgets">
						<div class="l_w_title">
							<h3>Color Filter</h3>
						</div>
						<div class="widgets_inner">
							<ul class="list">
								<li><a href="#">Black</a></li>
								<li><a href="#">Black Leather</a></li>
								<li class="active"><a href="#">Black with red</a></li>
								<li><a href="#">Gold</a></li>
								<li><a href="#">Spacegrey</a></li>
							</ul>
						</div>
					</aside> -->

					<!-- 					<aside class="left_widgets p_filter_widgets">
						<div class="l_w_title">
							<h3>Price Filter</h3>
						</div>
						<div class="widgets_inner">
							<div class="range_item">
								<div id="slider-range"></div>
								<div class="">
									<label for="amount">Price : </label> <input type="text"
										id="amount" readonly />
								</div>
							</div>
						</div>
					</aside> -->
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Category Product Area =================-->

<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>