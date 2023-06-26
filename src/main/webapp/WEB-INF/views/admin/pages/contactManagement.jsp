<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../layouts/header.jsp" flush="true"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<div class="page-header col-12">
	<div class="page-block">
		<div class="row align-items-center">
			<div class="col-md-12">
				<div class="page-header-title">
					<h5 class="m-b-10">Form Elements</h5>
				</div>
				<ul class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="admin"><i class="feather icon-home"></i></a>
					</li>
					<li class="breadcrumb-item"><a href="categoryManagement">Contact management</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<form method="get" action="searchContact">
	<div class="row mb-4">
		<div class="col-6">
			<input type="text" class="form-control" name="fullName">
		</div>
		<div class="col-3">
			<button type="submit" class="btn btn-primary">
				<i class="fas fa-search"></i>
			</button>
		</div>
	</div>
</form>
<h4>List order</h4>
<table class="table">
	<thead class="thead-dark">
		<tr>
			<th scope="col">Id</th>
			<th scope="col">fullName</th>
			<th scope="col">email</th>
			<th scope="col">phone</th>
			<th scope="col">message</th>
			<th scope="col">status</th>
			<th scope="col">createdAt</th>
			<th>delete</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list}" var="list">
			<tr>
				<th scope="row">${list.id}</th>
				<td>${list.fullName}</td>
				<td>${list.email}</td>
				<td>${list.phone}</td>
				<td >${list.message}</td>
				<td>${list.status}</td>
				<td>${list.createdAt}</td>
				<td><a href="Delete?Id=${list.id}" onclick="return confirm('sure?')"><i class="icon feather icon-trash"></i></a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>