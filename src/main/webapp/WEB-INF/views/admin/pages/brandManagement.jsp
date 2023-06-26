<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../layouts/header.jsp" flush="true"></jsp:include>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<div class="page-header col-12">
	<div class="page-block">
		<div class="row align-items-center">
			<div class="col-md-12">
				<div class="page-header-title">
					<h5 class="m-b-10">Eiser</h5>
				</div>
				<ul class="breadcrumb">
					<li class="breadcrumb-item"><a href="dashboard"><i
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
		<div class="col-6">
			<h4>List Brand</h4>
			<table class="table">
				<thead class="thead-dark">
					<tr>
						<th scope="col">BrandId</th>
						<th scope="col">Name</th>
						<th scope="col">ImageUrl</th>
						<th scope="col">Status</th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="list">
						<tr>
							<th scope="row">${list.brandId}</th>
							<td>${list.name}</td>
							<td><img
								src="${pageContext.request.contextPath}/<c:url value="resources"/>/image/${list.imageUrl}"
								alt="brand" class="img-fluid img-thumbnail"></td>
							<td style="color: ${list.status? "green" : "red"}">${list.status? "Show" : "Hidden"}</td>
							<td><a href="initBrand?id=${list.brandId }"><i
									class="fas fa-edit"></i></a> <a
								href="deleteBrand?id=${list.brandId }"><i
									class="fas fa-trash"></i></a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col-6">
			<h4>Add Brand</h4>
			<form:form action="insertBrand" method="post" modelAttribute="Brand"
				enctype="multipart/form-data">

				<label for="exampleInputEmail1">Brand name</label>
				<form:input type="text" class="form-control" path="name" />
				<form:errors path="name" style="color:red"></form:errors>
				<b style="color: red">${uniquename}</b>
				
				<div class="form-group">
					<label for="exampleFormControlFile1"></label> <input
						type="file" name="img" class="form-control-file"
						>
				</div>

				<div class="form-check mt-2">
					<form:radiobutton class="form-check-input" value="true"
						path="status" />
					<label class="form-check-label" for="gridRadios1">Show </label>
				</div>

				<div class="form-check mb-2">
					<form:radiobutton class="form-check-input" value="false"
						path="status" />
					<label class="form-check-label" for="gridRadios1">Hidden </label>
				</div>

				<input class="btn btn-outline-success" type="submit" value="Insert">

			</form:form>


		</div>
	</div>
</div>


<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>