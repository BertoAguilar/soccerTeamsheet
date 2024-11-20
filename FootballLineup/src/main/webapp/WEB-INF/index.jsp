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
<title>Football Lineup</title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/css/login.css" />
<!-- For any Bootstrap that uses JS -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<!-- YOUR own local JavaScript -->
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
	<div class="registration-container">
		<h1>Register</h1>
		<form:form action="/register/user" method="post"
			modelAttribute="newUser" class="registration-form">
			<p>
				<form:label path="firstName">First Name</form:label>
				<form:errors class="text-danger" path="firstName" />
				<form:input path="firstName" class="input-group" />
			</p>
			<p>
				<form:label path="lastName">Last Name</form:label>
				<form:errors class="text-danger" path="lastName" />
				<form:input path="lastName" class="input-group" />
			</p>
			<p>
				<form:label path="email">Email</form:label>
				<form:errors class="text-danger" path="email" />
				<form:input type="text" path="email" class="input-group" />
			</p>
			<p>
				<form:label path="password">Password</form:label>
				<form:errors class="text-danger" path="password" />
				<form:input type="password" path="password" class="input-group" />
			</p>
			<p>
				<form:label path="confirm">Confirm Password</form:label>
				<form:errors class="text-danger" path="confirm" />
				<form:input type="password" path="confirm" class="input-group" />
			</p>
			<div class="createLinks">
				<input type="submit" value="Submit" class="btn btn-primary" />
			</div>
		</form:form>
	</div>
	<div class="login-container">
		<h1>Login</h1>
		<form:form action="/login/user" method="post"
			modelAttribute="newLogin" class="login-form">
			<p>
				<form:label path="email">Email</form:label>
				<form:errors class="text-danger" path="email" />
				<form:input type="email" path="email" class="input-group" />
			</p>
			<p>
				<form:label path="password">Password</form:label>
				<form:errors class="text-danger" path="password" />
				<form:input type="password" path="password" class="input-group" />
			</p>
			<div class="createLinks">
				<input type="submit" value="Login" class="btn btn-primary" />
			</div>
		</form:form>
	</div>
</body>
</html>