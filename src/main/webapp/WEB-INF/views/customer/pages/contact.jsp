<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../layouts/header.jsp" flush="true"></jsp:include>

<jsp:include page="../layouts/menu.jsp" flush="true"></jsp:include>

<!--================Home Banner Area =================-->
<section class="banner_area">
	<div class="banner_inner d-flex align-items-center">
		<div class="container">
			<div
				class="banner_content d-md-flex justify-content-between align-items-center">
				<div class="mb-3 mb-md-0">
					<h2>Contact Us</h2>
					<p>Very us move be blessed multiply night</p>
				</div>
				<div class="page_link">
					<a href="index.html">Home</a> <a href="contact.html">Contact Us</a>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Home Banner Area =================-->

<!-- ================ contact section start ================= -->
<section class="section_gap">
	<div class="container">
		<div class="d-none d-sm-block mb-5 pb-4">
			<iframe
				src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1444.5459888391727!2d105.78361490127799!3d21.04656120131147!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ab3b4220c2bd%3A0x1c9e359e2a4f618c!2sB%C3%A1ch%20Khoa%20Aptech!5e1!3m2!1svi!2s!4v1649178190434!5m2!1svi!2s"
				width="100%" height="450" style="border: 0;" allowfullscreen=""
				loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
		</div>


		<div class="row">
		
			<div class="col-12">
				<h2 class="contact-title">Get in Touch</h2>
			</div>
			<div class="col-lg-8 mb-4 mb-lg-0">
				<form class="form-contact contact_form" action="contactCreate"
					method="post" id="contactForm" novalidate="novalidate" modelAttribute="Contacts">
					<div class="row">
						<div class="col-12">
							<div class="form-group">
									<textarea class="form-control" id="message" name="message" 
									placeholder="Enter your massage for us here. We will get back to you within 2 business days." rows="7"></textarea>
									<form:errors path="name" class="text-danger mt-2 d-block"></form:errors>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<input class="form-control" name="fullName" id="fullName" type="text"
									placeholder="Enter your name">
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<input class="form-control" name="email" id="email" type="email"
									placeholder="Enter email address">
							</div>
						</div>
						
						<div class="col-sm-6">
							<div class="form-group">
								<input class="form-control" name="phone" id="phone" type="text"
									placeholder="Enter Phone">
							</div>
						</div>
					</div>
					<div class="form-group mt-lg-3">
						<button type="submit" class="main_btn">Send Message</button>
					</div>
				</form>
			</div>

			<div class="col-lg-4">
				<div class="media contact-info">
					<span class="contact-info__icon"><i class="ti-home"></i></span>
					<div class="media-body">
						<h3>Buttonwood, California.</h3>
						<p>Rosemead, CA 91770</p>
					</div>
				</div>
				<div class="media contact-info">
					<span class="contact-info__icon"><i class="ti-tablet"></i></span>
					<div class="media-body">
						<h3>
							<a href="tel:454545654">00 (440) 9865 562</a>
						</h3>
						<p>Mon to Fri 9am to 6pm</p>
					</div>
				</div>
				<div class="media contact-info">
					<span class="contact-info__icon"><i class="ti-email"></i></span>
					<div class="media-body">
						<h3>
							<a href="mailto:support@colorlib.com">support@colorlib.com</a>
						</h3>
						<p>Send us your query anytime!</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- ================ contact section end ================= -->

<jsp:include page="../layouts/footer.jsp" flush="true"></jsp:include>