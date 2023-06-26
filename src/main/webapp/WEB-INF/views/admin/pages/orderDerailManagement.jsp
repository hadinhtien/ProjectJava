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
			<th scope="col">Id</th>
			<th scope="col">OrderId</th>
			<th scope="col">ProId</th>
			<th scope="col">Quantity</th>
			<th scope="col">Price</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${orderDetail}" var="orderDetail">
				<tr>
					<th scope="row">${orderDetail.id}</th>
					<td>${orderDetail.orderId}</td>
					<td>${orderDetail.proId}</td>
					<td>${orderDetail.quantity}</td>
					<td>${orderDetail.price}</td>
					
				</tr>
		</c:forEach>
	</tbody>
</table>
<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>