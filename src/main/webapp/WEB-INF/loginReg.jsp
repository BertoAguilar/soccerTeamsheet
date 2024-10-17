<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- For JSTL Forms -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Soccer TeamSheets</title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/css/loginReg.css" />
<!-- For any Bootstrap that uses JS -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<!-- YOUR own local JavaScript -->
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
<div class="container">
	<div class="row">
		<div>
			<div>
				<form:form action="/register/user" method="post" modelAttribute="newUser" class="box">
					<h1>Register</h1>
					<p class="text-muted">Please enter your email and create a password!</p>
					<p>
						<form:errors class="text-danger" path="firstName" />
						<form:input type="text" path="firstName" placeholder="First Name" />
					</p>
					<p>
						<form:errors class="text-danger" path="lastName" />
						<form:input type="text" path="lastName" placeholder="Last Name" />
					</p>
					<p>
						<form:errors class="text-danger" path="email" />
						<form:input type="email" path="email" placeholder="Email" />
					</p>
					<p>
						<form:errors class="text-danger" path="password" />
						<form:input type="password" path="password" placeholder="Password" />
					</p>
					<p>
						<form:errors class="text-danger" path="confirm" />
						<form:input type="password" path="confirm"
							placeholder="Confirm Password" />
					</p>
					<input type="submit" name="" value="Login">
				</form:form>
			</div>
		</div>
	</div>
		<div class="row">
			<div>
				<div>
					<form:form action="/login/user" method="post"
						modelAttribute="newLogin" class="box">
						<h1>Login</h1>
						<p class="text-muted">Please enter your Email and Password!</p>
						<p>
							<form:errors class="text-danger" path="email" />
							<form:input type="email" path="email" placeholder="Email" />
						</p>
						<p>
							<form:errors class="text-danger" path="password" />
							<form:input type="password" path="password"
								placeholder="Password" />
						</p>
						<input type="submit" name="" value="Login">
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>