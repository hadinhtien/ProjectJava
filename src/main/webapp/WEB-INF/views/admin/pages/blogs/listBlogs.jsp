<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../../layouts/header.jsp" flush="true"></jsp:include>

<div class="page-header col-12">
	<div class="page-block">
		<div class="row align-items-center">
			<div class="col-md-12">
				<div class="page-header-title">
					<h5 class="m-b-10">Esier admin</h5>
				</div>
				<ul class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="dashboard"><i class="feather icon-home"></i></a>
					</li>
					<li class="breadcrumb-item">Blog management</li>
					<li class="breadcrumb-item"><a href="listBlogs">List blogs</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<div class="container-fluid">
	<h4>List blogs</h4>
	<c:if test="${not empty blog}">
		<div class="alert alert-success alert-dismissible fade show" role="alert">
	  		<strong>${blog}</strong>
	  		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
	    		<span aria-hidden="true">&times;</span>
	  		</button>
		</div>
	</c:if>
	<div class="table-responsive">
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<!-- <th width="">Id</th> -->
					<th width="">Name</th>
					<th width="">Title</th>
					<th width="">Main image</th>
					<th width="">Status</th>
					<th width=""></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${listBlogs}" var="blog">
					<tr>
						<%-- <th>${blog.id}</th> --%>
						<c:if test="${blog.name.length() > 50}">
							<td>${blog.name.subSequence(0, 50)} ...</td>
						</c:if>
						<c:if test="${blog.name.length() < 50}">
							<td>${blog.name}</td>
						</c:if>
						
						<c:if test="${blog.title.length() > 50}">
							<td>${blog.title.subSequence(0, 50)} ...</td>
						</c:if>
						<c:if test="${blog.title.length() < 50}">
							<td>${blog.title}</td>
						</c:if>
						<td width="20%"><img src="${pageContext.request.contextPath}/<c:url value="assets"/>/customer/img/blog/${blog.mainImageUrl}" class="card-img"></td>
						<td width="10%" style="color: ${blog.status ? 'green' : 'red'}">${blog.status ? "Show" : "Hidden"}</td>
						<td width="8%">
							<a class="mr-3" href="updateBlog?blogId=${blog.id}"><i class="fas fa-edit"></i></a>
							<a href="deleteBlog?blogId=${blog.id}"><i class="fas fa-trash text-danger"></i></a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
			
		
		<div class="d-flex justify-content-center mt-2">
			<nav aria-label="Page navigation example">
				<ul class="pagination">
					<c:forEach begin="1" end="${totalPage}" var="i">
						<li class="page-item"><a class="page-link" href="listBlogs?page=${i}">${i}</a></li>
					</c:forEach>
				</ul>
			</nav>
		</div>
	</div>
</div>

<jsp:include page="../../layouts/footer.jsp" flush="true"></jsp:include>