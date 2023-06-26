<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="../layouts/header.jsp" flush="true"></jsp:include>

<jsp:include page="../layouts/menu.jsp" flush="true"></jsp:include>

<section class="banner_area">
	<div class="banner_inner d-flex align-items-center">
		<div class="container">
			<div
				class="banner_content d-md-flex justify-content-between align-items-center">
				<div class="mb-3 mb-md-0">
					<h2>Product Details</h2>
					<p>Very us move be blessed multiply night</p>
				</div>
				<div class="page_link">
					<a href="index.html">Home</a> <a href="productDetail?proId=${product.proId}">Product
						Details</a>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Home Banner Area =================-->

<!--================Single Product Area =================-->
<div class="product_image_area">
	<div class="container">
		<div class="row s_product_inner">
			<div class="col-lg-6">
				<div class="s_product_img">
					<div id="carouselExampleIndicators" class="carousel slide"
						data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#carouselExampleIndicators" data-slide-to="0"
								class="active"><img
								src="<c:url value="http://localhost:8080/Do-an-ky-2/resources"/>/image/${product.imageUrl}"
								alt="" width="100%" /></li>
							<c:forEach items="${productimages}" var="productImage">
								<li data-target="#carouselExampleIndicators" data-slide-to="${productImage.imageUrl}">
									<img
									src="<c:url value="http://localhost:8080/Do-an-ky-2/resources"/>/image/${productImage.imageUrl}"
									alt="" width="100%" />
								</li>
							</c:forEach>
						</ol>
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img class="d-block w-100"
									src="<c:url value="http://localhost:8080/Do-an-ky-2/resources"/>/image/${product.imageUrl}"
									alt="First slide" />
							</div>
							<c:forEach items="${productimages}" var="productImage">
								<div class="carousel-item">
									<img class="d-block w-100"
										src="<c:url value="http://localhost:8080/Do-an-ky-2/resources"/>/image/${productImage.imageUrl}"
										alt="Second slide" />
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-5 offset-lg-1">
				<div class="s_product_text">
					<h3>${product.name}</h3>
					<h2>$ ${product.price - product.discount}</h2>
					<ul class="list">
						<li><a class="active" href="#"> <span>Category</span> : <c:forEach
									items="${categories}" var="category">
									<c:if test="${product.cateId == category.cateId}">
										<td>${category.name}</td>
									</c:if>
								</c:forEach>
						</a></li>

						<li><a class="active" href="#"> <span>Brand</span> : <c:forEach
									items="${brands}" var="brand">
									<c:if test="${product.brandId == brand.brandId}">
										<td>${brand.name}</td>
									</c:if>
								</c:forEach>
						</a></li>
					</ul>
					${product.shortDescription}
					<form:form method="get" action="insertcart">
						<div class="product_count" style="margin-bottom: 5px">
							<input name="proId" value="${product.proId}" type="hidden"> 
							<label for="qty">Quantity:</label>
							<input type="text" name="quantity" id="sst" maxlength="12"
								value="1" title="Quantity:" class="input-text qty" />
							<button
								onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst )) result.value++;return false;"
								class="increase items-count" type="button">
								<i class="lnr lnr-chevron-up"></i>
							</button>
							<button
								onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst ) &amp;&amp; sst > 0 ) result.value--;return false;"
								class="reduced items-count" type="button">
								<i class="lnr lnr-chevron-down"></i>
							</button>
						</div>				
						<span class="ml-3"> ${product.quantity} products available</span>
						
						<div class="text-danger">${quantity}</div>
						<div class="card_area">
							<button class="main_btn mt-2" type="submit">Add to Cart</button>
							<!-- <a class="icon_btn" href="#"> <i class="lnr lnr lnr-diamond"></i>
							</a> <a class="icon_btn" href="#"> <i class="lnr lnr lnr-heart"></i>
							</a> -->
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>
<!--================End Single Product Area =================-->

<!--================Product Description Area =================-->
<section class="product_description_area">
	<div class="container">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item"><a class="nav-link active" id="home-tab"
				data-toggle="tab" href="#home" role="tab" aria-controls="home"
				aria-selected="true">Description</a></li>
		</ul>
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade active show" id="home" role="tabpanel"
				aria-labelledby="home-tab">${product.description}</div>
		</div>
	</div>
</section>
<!--================End Product Description Area =================-->

<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>