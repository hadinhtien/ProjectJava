<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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
					<li class="breadcrumb-item"><a href="#">Update blog</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<div class="container-fluid">
	<h4>Add blog</h4>
	<form:form action="doUpdateBlog" modelAttribute="blog" method="post" enctype="multipart/form-data">
		<form:hidden path="id"/>
		
		<div class="form-group">
		    <label>Blog name <span class="text-danger">*</span></label>
		    <form:input class="form-control" autocomplete="off" path="name" placeholder="enter blog name"/>
		    <form:errors class="text-danger mt-2 d-block" path="name"></form:errors>
		</div>
		
		<div class="form-group">
		    <label>Title <span class="text-danger">*</span></label>
		    <form:input class="form-control" autocomplete="off" path="title" placeholder="enter title"/>
		    <form:errors class="text-danger mt-2 d-block" path="title"></form:errors>
		</div>
		<hr>
		<div class="row">
			<div class="form-group col-3">
			    <label>Main image</label>
			    <input type="file" class="form-control-file" name="mainImagePath">
			    <form:hidden path="mainImageUrl"/>
			    <img src="${pageContext.request.contextPath}/<c:url value="assets"/>/customer/img/blog/${blog.mainImageUrl}" class="card-img mt-3">
			</div>
			<div class="form-group col-9">
			    <label>First content <span class="text-danger">*</span></label>
			    <form:textarea path="content_1"/>
			    <form:errors class="text-danger mt-2 d-block" path="content_1"></form:errors>
			</div>
		</div>
		<hr>
		<div class="row">
			<div class="form-group col-3">
			    <label>Second image</label>
		    	<input type="file" class="form-control-file" name="secondImagePath">
		    	<form:hidden path="secondImageUrl"/>
		    	<img src="${pageContext.request.contextPath}/<c:url value="assets"/>/customer/img/blog/${blog.secondImageUrl}" class="card-img mt-3">
			</div>
			<div class="form-group col-9">
			    <label>Second content <span class="text-danger">*</span></label>
			    <form:textarea path="content_2"/>
			    <form:errors class="text-danger mt-2 d-block" path="content_2"></form:errors>
			</div>
		</div>
		<hr>
		<div class="row">
			<div class="form-group col-3">
			    <label>Third image</label>
		    	<input type="file" class="form-control-file" name="thirdImagePath">
		    	<c:if test="${not empty blog.thirdImageUrl}">
			    	<form:hidden path="thirdImageUrl"/>
			    	<img src="${pageContext.request.contextPath}/<c:url value="assets"/>/customer/img/blog/${blog.thirdImageUrl}" class="card-img mt-3">
		    	</c:if>
			</div>
			<div class="form-group col-9">
			    <label>Third content</label>
		    	<form:textarea path="content_3"/>
			</div>
		</div>
		<div class="form-check">
		  	<form:radiobutton class="form-check-input" path="status" value="true" id="statusTrue"/>
		  	<label class="form-check-label" for="statusTrue">Show</label>
		</div>
		<div class="form-check">
		  	<form:radiobutton class="form-check-input" path="status" value="false" id="statusFalse"/>
		  	<label class="form-check-label" for="statusFalse">Hidden</label>
		</div>
		<div class="d-flex justify-content-end">
			<input class="btn btn-success px-5" type="submit" value="Update">
		</div>
	</form:form>
</div>

<jsp:include page="../../layouts/footer.jsp" flush="true"></jsp:include>