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
					<li class="breadcrumb-item"><a href="categoryManagement">Order
							management</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<h4>List order</h4>
<table class="table">
	<thead class="thead-dark">
		<tr>
			<th scope="col">OderId</th>
			<th scope="col">accId</th>
			<th scope="col">fullName</th>
			<th scope="col">address</th>
			<th scope="col">phone</th>
			<th scope="col">note</th>
			<th scope="col">totalPrice</th>
			<th scope="col">status</th>
			<th scope="col">createdAt</th>
			<th scope="col">Update</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list}" var="list">
			<form:form method="POST" action="updateStatus?id=${list.accId}"
				modelAttribute="a">
				<tr>
					<th scope="row">${list.orderId}</th>
					<td>${list.accId}</td>
					<td>${list.fullName}</td>
					<td>${list.address}</td>
					<td>${list.phone}</td>
					<td>${list.note}</td>
					<td>${list.totalPrice}</td>
					<td><form:select path="status">
							<c:if test="${list.status==0}">
								<option <c:if test="${list.status==0}">selected</c:if> value="0">Canceled</option>
							</c:if>
							<c:if test="${list.status<=1}">
								<option <c:if test="${list.status==1}">selected</c:if> value="1">Unconfirmed</option>
							</c:if>
							<c:if test="${list.status<=2}">
								<option <c:if test="${list.status==2}">selected</c:if> value="2">Being
									shipped</option>
							</c:if>
							<c:if test="${list.status<=3}">
								<option <c:if test="${list.status==3}">selected</c:if> value="3">Delivered</option>
							</c:if>
						</form:select></td>
					<td>${list.createdAt}</td>
					<td><input type="submit" value="update"></td>
					<td><a href="orderDerailManagement?id=${list.orderId}">Derail</a></td>
				</tr>
			</form:form>
		</c:forEach>
	</tbody>
</table>
<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>