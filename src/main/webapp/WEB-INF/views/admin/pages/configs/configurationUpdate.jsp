<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../../layouts/header.jsp" flush="true"></jsp:include>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
					<li class="breadcrumb-item"><a href="configuration">Configuration</a></li>
					<li class="breadcrumb-item"><a href="initUpdateConfig">UpdateConfig</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<div class="container-fluid">
	<h4>Update Config</h4>
	<form:form method="post" action="updateConfig" modelAttribute="config" class="main-form full" enctype="multipart/form-data">
		<form:hidden path="id"/>
		
		<div class="mt-4">
			<h5 class="mb-3">Logo image</h5>
			<input type="file" class="form-control-file" name="logoImagePath">
	    	<form:hidden path="logoImage"/>
	    	<div class="col-2 mt-3">
				<img src="${pageContext.request.contextPath}/<c:url value="resources"/>/image/${config.logoImage}" class="card-img">
			</div>
		</div>
		
		<div class="mt-4">
			<h5 class="mb-3">Banner image</h5>
			<input type="file" class="form-control-file" name="bannerImagePath">
	    	<form:hidden path="bannerImage"/>
			<img src="${pageContext.request.contextPath}/<c:url value="resources"/>/image/${config.bannerImage}" class="card-img mt-3">
		</div>
		
		<div class="form-group mt-4">
		    <label>Address <span class="text-danger">*</span></label>
		    <form:input class="form-control" autocomplete="off" path="address" placeholder="enter address"/>
		    <form:errors class="text-danger mt-2 d-block" path="address"></form:errors>
		</div>
		
		<div class="form-group">
		    <label>Map <span class="text-danger">*</span></label>
		    <form:textarea class="form-control" autocomplete="off" path="map" rows="4"/>
		    <form:errors class="text-danger mt-2 d-block" path="map"></form:errors>
		    <div class="mt-2">${config.map}</div>
		</div>
		
		<div class="form-group">
		    <label>Phone <span class="text-danger">*</span></label>
		    <form:input class="form-control" autocomplete="off" path="phone" placeholder="enter phone"/>
		    <form:errors class="text-danger mt-2 d-block" path="phone"></form:errors>
		</div>
		
		<div class="form-group">
		    <label>Email <span class="text-danger">*</span></label>
		    <form:input class="form-control" autocomplete="off" path="email" placeholder="enter email"/>
		    <form:errors class="text-danger mt-2 d-block" path="email"></form:errors>
		</div>
		<input class="btn btn-success" type="submit" value="Update">
	</form:form>
</div>

<jsp:include page="../../layouts/footer.jsp" flush="true"></jsp:include>