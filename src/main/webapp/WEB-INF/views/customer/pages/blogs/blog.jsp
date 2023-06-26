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
					<h2>Blog</h2>
					<p>Very us move be blessed multiply night</p>
				</div>
				<div class="page_link">
					<a href="home">Home</a> <a href="blog">Blog </a>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Home Banner Area =================-->

<!--================Blog Area =================-->
<section class="blog_area section_gap">
	<div class="container">
		<div class="row">
			<c:forEach items="${listBlogs}" var="blog">
			<div class="col-lg-4 mb-5 mb-lg-0">
				<div class="blog_left_sidebar">
					<article class="blog_item">
						<div class="blog_item_img">
							<a href="blogDetail?blogId=${blog.id}">
								<img class="card-img rounded-0" src="<c:url value="assets"/>/customer/img/blog/${blog.mainImageUrl}" alt=""> 
							</a>
							<!-- <a href="#" class="blog_item_date">
								<h3>15</h3>
								<p>Jan</p>
							</a> -->
						</div>
						<div class="blog_details">
							<c:if test="${blog.name.length() > 60}">
								<a class="d-inline-block textDrop" href="blogDetail?blogId=${blog.id}"><h2>${blog.name.subSequence(0, 60)} ...</h2></a>
							</c:if>
							<c:if test="${blog.name.length() < 60}">
								<a class="d-inline-block textDrop" href="blogDetail?blogId=${blog.id}"><h2>${blog.name}</h2></a>
							</c:if>
							
							<c:if test="${blog.title.length() > 150}">
								<p>${blog.title.subSequence(0, 150)} ...</p>
							</c:if>
							<c:if test="${blog.title.length() < 150}">
								<p>${blog.title}</p>
							</c:if>
							
							<ul class="blog-info-link">
								<!-- <li><a href="#"><i class="ti-user"></i> Travel, Lifestyle</a></li>
								<li><a href="#"><i class="ti-comments"></i> 03 Comments</a></li> -->
								<li class="mainColor">${blog.createdAt}</li>
							</ul>
						</div>
					</article>
				</div>
			</div>
			</c:forEach>
		</div>
		<nav class="blog-pagination justify-content-center d-flex mt-0">
			<ul class="pagination">
				<c:forEach begin="1" end="${totalPage}" var="i">
					<li class="page-item"><a href="blog?page=${i}" class="page-link">${i}</a></li>
				</c:forEach>
			</ul>
		</nav>
	</div>
</section>
<!--================Blog Area =================-->

<jsp:include page="../../layouts/footer.jsp" flush="true"></jsp:include>