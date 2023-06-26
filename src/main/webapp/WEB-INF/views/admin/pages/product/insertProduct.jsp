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
					<li class="breadcrumb-item"><a href="dashboard"><i
							class="feather icon-home"></i></a></li>
					<li class="breadcrumb-item">Product management</li>
					<li class="breadcrumb-item"><a href="createProduct">Add
							product</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<div class="container-fluid">
	<h4>Add Product</h4>
	<form:form action="insertProduct" method="post" modelAttribute="product" enctype="multipart/form-data">
		<div class="row mt-3">
			<div class="col-2">
				<span class="pt-2 d-block">Name <span class="text-danger">*</span></span>
			</div>
			<div class="col-10">
				<form:input type="text" placeholder="Product name"
					class="form-control" path="name" />
				<form:errors path="name" class="text-danger mt-2 d-block"></form:errors>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col-2">
				<span class="pt-2 d-block">Price <span class="text-danger">*</span></span>
			</div>
			<div class="col-10">
				<form:input type="number" min="0" placeholder="Product price"
					class="form-control" path="price" />
				<form:errors path="price" class="text-danger mt-2 d-block"></form:errors>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col-2">
				<span class="pt-2 d-block">Discount</span>
			</div>
			<div class="col-10">
				<form:input type="number" min="0" placeholder="Product discount"
					class="form-control" path="discount"/>
				<span class="text-danger mt-2 d-block">${discount}</span>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col-2">
				<span class="pt-2 d-block">Image <span class="text-danger">*</span></span>
			</div>
			<div class="col-10">
				<input type="file" class="form-control-file" 
					name="image" id="exampleFormControlFile1">
					<span class="text-danger mt-2 d-block">${ImageNull}</span>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col-2">
				<span class="pt-2 d-block">Related photos</span>
			</div>
			<div class="col-10">
				<input type="file" class="form-control-file" 
					name="images" id="exampleFormControlFile1" multiple>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col-2">
				<span class="pt-2 d-block">Category</span>
			</div>
			<div class="col-10">
				<form:select class="custom-select mr-sm-2" path="cateId">
					<!-- <option selected>Choose...</option> -->
					<c:forEach items="${category}" var="list">
						<option value="${list.cateId}">${list.name}</option>
					</c:forEach>
				</form:select>
				<form:errors path="cateId" class="text-danger mt-2 d-block"></form:errors>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col-2">
				<span class="pt-2 d-block">Brand</span>
			</div>
			<div class="col-10">
				<form:select class="custom-select mr-sm-2" path="brandId">
					<!-- <option selected>Choose...</option> -->
					<c:forEach items="${brand}" var="list">
						<option value="${list.brandId}">${list.name}</option>
					</c:forEach>
				</form:select>
				<form:errors path="brandId" class="text-danger mt-2 d-block"></form:errors>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col-2">
				<span class="">Short description <span class="text-danger">*</span></span>
			</div>
			<div class="col-10">
				<form:textarea path="shortDescription" />
				<form:errors path="shortDescription" class="text-danger mt-2 d-block"></form:errors>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col-2">
				<span class="">Description <span class="text-danger">*</span></span>
			</div>
			<div class="col-10">
				<form:textarea path="description" />
				<form:errors path="description" class="text-danger mt-2 d-block"></form:errors>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col-2">
				<span class="pt-2 d-block">Quantity <span class="text-danger">*</span></span>
			</div>
			<div class="col-10">
				<form:input type="number" min="1" placeholder="Product quantity" class="form-control" path="quantity" autocomplete="off"/>
				<form:errors path="quantity" class="text-danger mt-2 d-block"></form:errors>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col-2">
				<span class="">Status </span>
			</div>
			<div class="col-1">
				<div class="form-check">
					<form:radiobutton class="form-check-input" value="1" path="status"/>
					<label class="form-check-label" for="gridRadios1">Show </label>
				</div>
			</div>
			<div class="col-1">
				<div class="form-check">
					<form:radiobutton class="form-check-input" value="2" path="status" checked="checked"/>
					<label class="form-check-label" for="gridRadios1">Hidden </label>
				</div>
			</div>
		</div>

		<div class="d-flex justify-content-end">
			<input class="btn btn-success px-5" type="submit" value="Add">
		</div>
	</form:form>
</div>

<jsp:include page="../../layouts/footer.jsp" flush="true"></jsp:include>