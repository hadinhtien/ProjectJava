<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../layouts/header.jsp" flush="true"></jsp:include>

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
					<li class="breadcrumb-item"><a href="accountManagement">Account management</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<div class="container-fluid">
	<h4>List accounts</h4>
	<c:if test="${not empty account}">
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
				<th width="">Full name</th>
				<th width="">Email</th>
				<th width="">Phone</th>
				<th width="">Address</th>
				<!-- <th>Administrator role</th> -->
				<th width="">Status</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${listAccounts}" var="account">
				<tr>
					<%-- <th>${blog.id}</th> --%>
					<td>${account.fullName}</td>
					<td width="">${account.email}</td>
					<td width="">${account.phone}</td>
					<td >${account.address}</td>
					<%-- <c:forEach items="${listAccount_Roles}" var="account_role">
						<c:if test="${account.accId == account_role.accId && account_role.roleId == 1}">
							<td width=""><a class="btn btn-info btn-sm" href="">Admin</a></td>
						</c:if>
						<c:if test="${account.accId == account_role.accId && account_role.roleId == 2}">
							<td width=""><a class="btn btn-info btn-sm" href="">Customer</a></td>
						</c:if>
					</c:forEach> --%>
					<c:if test="${account.status}">
						<td width="" class="text-success"><span class="btn btn-success btn-sm active">Active</span></td>
						<td width=""><a class="btn btn-danger btn-sm" href="accountStatus?accId=${account.accId}&status=false">Ban</a></td>
					</c:if>
					<c:if test="${!account.status}">
						<td width="" class="text-success"><span class="btn btn-danger btn-sm">Inactive</span></td>
						<td width=""><a class="btn btn-success btn-sm" href="accountStatus?accId=${account.accId}&status=true">Open ban</a></td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
</div>

<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>