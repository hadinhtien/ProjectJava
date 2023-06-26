<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../layouts/header.jsp" flush="true"></jsp:include>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<div class="page-header col-12">
	<div class="page-block">
		<div class="row align-items-center">
			<div class="col-md-12">
				<div class="page-header-title">
					<h5 class="m-b-10">Form Elements</h5>
				</div>
				<ul class="breadcrumb">
					<li class="breadcrumb-item"><a href="admin"><i
							class="feather icon-home"></i></a></li>
					<li class="breadcrumb-item"><a href="brandManagement">Brand
							management</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<div class="container-fluid">
	<div class="row">
		<h3>Update Brand</h3>
		<h3 style="color: red">${error}</h3>
		<div class="card-body">
			<form:form method="post" action="brandUpdateManagement" modelAttribute="brand"
				class="main-form full" enctype="multipart/form-data">
				<form:input path="brandId" type="hidden" readonly="readonly" />

				<div class="row">
					<div class="col-12">
						<div class="input-box form-group required">
							<div class="row">
								<input type="hidden" name="name1" value="${name1}">
								<label for="p-name" class="col-md-3 control-label">Brand
									Name</label>
								<div class="col-md-9">
									<form:input type="text" class="form-control"
										placeholder="Brand Name" path="name" />
									<form:errors path="name" style="color:red"></form:errors>
								<b style="color:red">${uniquename}</b>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12">
						<div class="input-box form-group">
							<div class="row">
								<label for="product-tags" class="col-md-3 control-label">ImageUrl
									</label>
								<div class="col-md-9">
									<input type="file" name="img" class="form-control-file"
										id="exampleFormControlFile1"><img
								src="<c:url value="http://localhost:8080/Do-an-ky-2/resources"/>/image/${brand.imageUrl}"
								alt="brand" class="img-fluid img-thumbnail"> 
									<form:input path="imageUrl" type="hidden" />
								</div>

							</div>
						</div>
					</div>
					<div class="col-12">
						<div class="input-box form-group">
							<div class="row">
								<label for="requires-shipp" class="col-md-3 control-label">Status
									</label>
								<div class="col-md-9">
									<label class="form-radio-label control-label"> <form:radiobutton
											path="status" value="true" checked="checked" /> Show
									</label> <label class="form-radio-label control-label"> <form:radiobutton
											path="status" value="false" /> Hidden
									</label>
								</div>
							</div>
						</div>
					</div>
					
					<input type="submit" value="update">
				</div>
			</form:form>
		</div>
	</div>
</div>

<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>