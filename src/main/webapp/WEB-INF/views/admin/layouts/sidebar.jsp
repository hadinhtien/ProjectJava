<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- [ navigation menu ] start -->
<nav class="pcoded-navbar  ">
	<div class="navbar-wrapper  ">
		<div class="navbar-content scroll-div ">
			<div class="main-menu-header">
				<%-- <img class="img-radius"
					src="<c:url value="assets"/>/admin/images/user/avatar-2.jpg"
					alt="User-Profile-Image"> --%>
				<div class="user-details" style="cursor: context-menu;">
					<span>${accFullName}</span>
					<div id="more-details">
						Eiser administrator <!-- <i class="fa fa-chevron-down m-l-5"></i> -->
					</div>
				</div>
			</div>
			<%-- <div class="collapse" id="nav-user-link">
				<ul class="list-unstyled">
					<li class="list-group-item"><a href="user-profile.html"><i
							class="feather icon-user m-r-5"></i>View Profile</a></li>
					<li class="list-group-item">
						<form action="<c:url value='/j_spring_security_logout'/>" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
							<i class="feather icon-log-out m-r-5"></i>
							<input style="background-color: #2C3E50" type="submit" value="Logout"/>
						</form>
					</li>
				</ul>
			</div> --%>

			<ul class="nav pcoded-inner-navbar ">
				<li class="nav-item">
					<a href="dashboard" class="nav-link ">
						<span class="pcoded-micon"><i class="fas fa-home"></i></span>
						<span class="pcoded-mtext">Dashboard</span>
					</a>
				</li>
				
				<!-- Category -->
				<li class="nav-item">
					<a href="categoryManagement" class="nav-link ">
						<span class="pcoded-micon"><i class="fas fa-copyright"></i></span>
						<span class="pcoded-mtext">Category Management</span>
					</a>
				</li>
				
				<!-- Brand -->
				<li class="nav-item">
					<a href="brandManagement" class="nav-link ">
						<span class="pcoded-micon"><i class="fab fa-blogger"></i></span>
						<span class="pcoded-mtext">Brand Management</span>
					</a>
				</li>
				
				<!-- Product -->
				<li class="nav-item pcoded-hasmenu">
                    <a href="#" class="nav-link ">
                    	<span class="pcoded-micon"><i class="fab fa-product-hunt"></i></span>
                    	<span class="pcoded-mtext">Product Management</span>
                    </a>
                    <ul class="pcoded-submenu">
                        <li><a href="listProducts" >List products</a></li>
                        <li><a href="createProduct" >Add product</a></li>
                    </ul>
                </li>
                
                <!-- Blog -->
				<li class="nav-item pcoded-hasmenu">
                    <a href="#!" class="nav-link ">
                    	<span class="pcoded-micon"><i class="fas fa-newspaper"></i></span>
                    	<span class="pcoded-mtext">Blog Management</span>
                    </a>
                    <ul class="pcoded-submenu">
                        <li><a href="listBlogs" >List blogs</a></li>
                        <li><a href="insertBlog" >Add blog</a></li>
                    </ul>
                </li>
				
				<!-- Order -->
				<li class="nav-item">
					<a href="orderManagement" class="nav-link ">
						<span class="pcoded-micon"><i class="fas fa-clipboard-list"></i></span>
						<span class="pcoded-mtext">Order Management</span>
					</a>
				</li>
				
				<!-- Account -->
				<li class="nav-item">
					<a href="accountManagement" class="nav-link ">
						<span class="pcoded-micon"><i class="fas fa-user"></i></span>
						<span class="pcoded-mtext">Account Management</span>
					</a>
				</li>
				
				<!-- Contact -->
				<li class="nav-item">
					<a href="contactManagement" class="nav-link ">
						<span class="pcoded-micon"><i class="fas fa-address-book"></i></span>
						<span class="pcoded-mtext">Contact Management</span>
					</a>
				</li>
				
				<!-- Config -->
				<li class="nav-item">
					<a href="configuration" class="nav-link ">
						<span class="pcoded-micon"><i class="fas fa-cog"></i></span>
						<span class="pcoded-mtext">Configuration</span>
					</a>
				</li>
			</ul>
		</div>
	</div>
</nav>
<!-- [ navigation menu ] end -->