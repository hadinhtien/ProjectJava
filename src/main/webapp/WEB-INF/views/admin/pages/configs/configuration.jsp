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
					<li class="breadcrumb-item"><a href="configuration">Configuration</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<div class="container-fluid">
	<h4>Configuration</h4>
	<a href="initUpdateConfig" class="btn btn-success mt-3">Config update</a>
	<c:if test="${not empty alertConfig}">
		<div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
	  		<strong>${alertConfig}</strong>
	  		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
	    		<span aria-hidden="true">&times;</span>
	  		</button>
		</div>
	</c:if>
	<div class="mt-4">
		<h5 class="mb-3">Logo image</h5>
		<div class="col-2">
			<img src="${pageContext.request.contextPath}/<c:url value="resources"/>/image/${config.logoImage}" class="card-img">
		</div>
	</div>
	<div class="mt-4">
		<h5 class="mb-3">Banner image</h5>
		<div>
			<img src="${pageContext.request.contextPath}/<c:url value="resources"/>/image/${config.bannerImage}" class="card-img">
		</div>
	</div>
	<div class="mt-4">
		<span class="font-weight-bold">Address: </span><span>${config.address}</span>
	</div>
	<div class="mt-4">
		<h5 class="mb-3">Map</h5>
		<div>${config.map}</div>
	</div>
	<div class="mt-4">
		<span class="font-weight-bold">Phone: </span><span>${config.phone}</span>
	</div>
	<div class="mt-4">
		<span class="font-weight-bold">Email: </span><span>${config.email}</span>
	</div>
</div>

<jsp:include page="../../layouts/footer.jsp" flush="true"></jsp:include>