<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../layouts/header.jsp" flush="true"></jsp:include>

<jsp:include page="../layouts/menu.jsp" flush="true"></jsp:include>

<!--================Home Banner Area =================-->
<section class="home_banner_area mb-40" style="background-image: url('<c:url value="resources"/>/image/${config.bannerImage}')">
	<div class="banner_inner d-flex align-items-center">
		<div class="container">
			<div class="banner_content row">
				<div class="col-lg-12">
					<p class="sub text-uppercase">men Collection</p>
					<h3>
						<span>Show</span> Your <br />Personal <span>Style</span>
					</h3>
					<h4>Fowl saw dry which a above together place.</h4>
					<a class="main_btn mt-40" href="allCategory">Shop now</a>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Home Banner Area =================-->

<!-- Start feature Area -->
<section class="feature-area section_gap_bottom_custom">
	<div class="container">
		<div class="row">
			<c:forEach items="${listBrands}" var="brand">
				<div class="col-lg-3 col-md-6">
					<div class="single-feature p-0">
						<a href="brand?brandId=${brand.brandId}">
							<img class="card-img" src="<c:url value="resources"/>/image/${brand.imageUrl}"/>
						</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</section>
<!-- End feature Area -->

<!--================ Feature Product Area =================-->
<%-- <section class="feature_product_area section_gap_bottom_custom">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-12">
				<div class="main_title">
					<h2>
						<span>Featured product</span>
					</h2>
					<p>Bring called seed first of third give itself now ment</p>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-4 col-md-6">
				<div class="single-product">
					<div class="product-img">
						<img class="img-fluid w-100"
							src="<c:url value="assets"/>/customer/img/product/feature-product/f-p-1.jpg" alt="" />
						<div class="p_icon">
							<a href="#"> <i class="ti-eye"></i>
							</a> <a href="#"> <i class="ti-heart"></i>
							</a> <a href="#"> <i class="ti-shopping-cart"></i>
							</a>
						</div>
					</div>
					<div class="product-btm">
						<a href="#" class="d-block">
							<h4>Latest mena€™s sneaker</h4>
						</a>
						<div class="mt-3">
							<span class="mr-4">$25.00</span>
							<del>$35.00</del>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-4 col-md-6">
				<div class="single-product">
					<div class="product-img">
						<img class="img-fluid w-100"
							src="<c:url value="assets"/>/customer/img/product/feature-product/f-p-2.jpg" alt="" />
						<div class="p_icon">
							<a href="product"> <i class="ti-eye"></i>
							</a> <a href="#"> <i class="ti-heart"></i>
							</a> <a href="#"> <i class="ti-shopping-cart"></i>
							</a>
						</div>
					</div>
					<div class="product-btm">
						<a href="product" class="d-block">
							<h4>Red women purses</h4>
						</a>
						<div class="mt-3">
							<span class="mr-4">$25.00</span>
							<del>$35.00</del>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-4 col-md-6">
				<div class="single-product">
					<div class="product-img">
						<img class="img-fluid w-100"
							src="<c:url value="assets"/>/customer/img/product/feature-product/f-p-3.jpg" alt="" />
						<div class="p_icon">
							<a href="#"> <i class="ti-eye"></i>
							</a> <a href="#"> <i class="ti-heart"></i>
							</a> <a href="#"> <i class="ti-shopping-cart"></i>
							</a>
						</div>
					</div>
					<div class="product-btm">
						<a href="#" class="d-block">
							<h4>Men stylist Smart Watch</h4>
						</a>
						<div class="mt-3">
							<span class="mr-4">$25.00</span>
							<del>$35.00</del>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section> --%>
<!--================ End Feature Product Area =================-->

<!--================ New Product Area =================-->
<%-- <section
	class="new_product_area section_gap_top section_gap_bottom_custom">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-12">
				<div class="main_title">
					<h2>
						<span>new products</span>
					</h2>
					<p>Bring called seed first of third give itself now ment</p>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-6">
				<div class="new_product">
					<h5 class="text-uppercase">collection of 2019</h5>
					<h3 class="text-uppercase">Menâ€™s summer t-shirt</h3>
					<div class="product-img">
						<img class="img-fluid"
							src="<c:url value="assets"/>/customer/img/product/new-product/new-product1.png" alt="" />
					</div>
					<h4>$120.70</h4>
					<a href="#" class="main_btn">Add to cart</a>
				</div>
			</div>

			<div class="col-lg-6 mt-5 mt-lg-0">
				<div class="row">
					<div class="col-lg-6 col-md-6">
						<div class="single-product">
							<div class="product-img">
								<img class="img-fluid w-100"
									src="<c:url value="assets"/>/customer/img/product/new-product/n1.jpg" alt="" />
								<div class="p_icon">
									<a href="#"> <i class="ti-eye"></i>
									</a> <a href="#"> <i class="ti-heart"></i>
									</a> <a href="#"> <i class="ti-shopping-cart"></i>
									</a>
								</div>
							</div>
							<div class="product-btm">
								<a href="#" class="d-block">
									<h4>Nike latest sneaker</h4>
								</a>
								<div class="mt-3">
									<span class="mr-4">$25.00</span>
									<del>$35.00</del>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-6 col-md-6">
						<div class="single-product">
							<div class="product-img">
								<img class="img-fluid w-100"
									src="<c:url value="assets"/>/customer/img/product/new-product/n2.jpg" alt="" />
								<div class="p_icon">
									<a href="#"> <i class="ti-eye"></i>
									</a> <a href="#"> <i class="ti-heart"></i>
									</a> <a href="#"> <i class="ti-shopping-cart"></i>
									</a>
								</div>
							</div>
							<div class="product-btm">
								<a href="#" class="d-block">
									<h4>Menâ€™s denim jeans</h4>
								</a>
								<div class="mt-3">
									<span class="mr-4">$25.00</span>
									<del>$35.00</del>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-6 col-md-6">
						<div class="single-product">
							<div class="product-img">
								<img class="img-fluid w-100"
									src="<c:url value="assets"/>/customer/img/product/new-product/n3.jpg" alt="" />
								<div class="p_icon">
									<a href="#"> <i class="ti-eye"></i>
									</a> <a href="#"> <i class="ti-heart"></i>
									</a> <a href="#"> <i class="ti-shopping-cart"></i>
									</a>
								</div>
							</div>
							<div class="product-btm">
								<a href="#" class="d-block">
									<h4>quartz hand watch</h4>
								</a>
								<div class="mt-3">
									<span class="mr-4">$25.00</span>
									<del>$35.00</del>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-6 col-md-6">
						<div class="single-product">
							<div class="product-img">
								<img class="img-fluid w-100"
									src="<c:url value="assets"/>/customer/img/product/new-product/n4.jpg" alt="" />
								<div class="p_icon">
									<a href="#"> <i class="ti-eye"></i>
									</a> <a href="#"> <i class="ti-heart"></i>
									</a> <a href="#"> <i class="ti-shopping-cart"></i>
									</a>
								</div>
							</div>
							<div class="product-btm">
								<a href="#" class="d-block">
									<h4>adidas sport shoe</h4>
								</a>
								<div class="mt-3">
									<span class="mr-4">$25.00</span>
									<del>$35.00</del>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section> --%>
<!--================ End New Product Area =================-->

<!--================ Inspired Product Area =================-->
<section class="inspired_product_area section_gap_bottom_custom">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-12">
				<div class="main_title">
					<h2>
						<span>Hot products</span>
					</h2>
					<p>Bring called seed first of third give itself now ment</p>
				</div>
			</div>
		</div>
		
		<div class="row">
			<c:forEach items="${listProducts}" var="product">
			<div class="col-lg-3 col-md-6">
				<div class="single-product">
					<div class="product-img">
						<img class="img-fluid w-100" src="<c:url value="resources"/>/image/${product.imageUrl}"/>
					<!-- 	<div class="p_icon"> -->
							<%-- <a href="productDetail?proId=${product.proId}"><i class="ti-eye"></i></a>  --%>
							<!-- <a href="#"><i class="ti-heart"></i></a> -->
							<%-- <a href="insertcart?proId=${product.proId}&quantity=1"><i class="ti-shopping-cart"></i></a> --%>
						<!-- </div> -->
					</div>
					<div class="product-btm">
						<a href="productDetail?proId=${product.proId}" class="d-block"><h4>${product.name}</h4></a>
						<div class="mt-3">
						    <c:if test="${product.discount > 0}">
						    	<span class="mr-4">$ ${product.price - product.discount}</span><del>$ ${product.price}</del>
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
</section>
<!--================ End Inspired Product Area =================-->

<!--================ Start Blog Area =================-->
<section class="blog-area section-gap">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-12">
				<div class="main_title">
					<h2>
						<span>latest blog</span>
					</h2>
					<p>Bring called seed first of third give itself now ment</p>
				</div>
			</div>
		</div>

		<div class="row">
		<c:forEach items="${listBlogs}" var="blog">
			<div class="col-lg-4 col-md-6">
				<div class="single-blog">
					<div class="thumb">
						<img class="img-fluid" src="<c:url value="assets"/>/customer/img/blog/${blog.mainImageUrl}" alt="">
					</div>
					<div class="short_details">
						<div class="meta-top d-flex">
							<span>${blog.createdAt}</span>
						</div>
						<c:if test="${blog.name.length() > 60}">
							<a class="d-block" href="blogDetail?blogId=${blog.id}">
								<h4>${blog.name.subSequence(0, 60)} ...</h4>
							</a>
						</c:if>
						<c:if test="${blog.name.length() < 60}">
							<a class="d-block" href="blogDetail?blogId=${blog.id}">
								<h4>${blog.name}</h4>
							</a>
						</c:if>
						
						<c:if test="${blog.name.length() > 150}">
							<div class="text-wrap">
								<p>${blog.title.subSequence(0, 150)} ...</p>
							</div>
						</c:if>
						<c:if test="${blog.name.length() < 150}">
							<div class="text-wrap">
								<p>${blog.title}</p>
							</div>
						</c:if>
						
						<a href="blogDetail?blogId=${blog.id}" class="blog_btn">Learn More <span
							class="ml-2 ti-arrow-right"></span></a>
					</div>
				</div>
			</div>
		</c:forEach>
		</div>
	</div>
</section>
<!--================ End Blog Area =================-->

<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>