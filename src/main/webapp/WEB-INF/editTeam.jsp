<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- For JSTL Forms -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Your Team</title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/css/editTeam.css" />
<!-- For any Bootstrap that uses JS -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<!-- YOUR own local JavaScript -->
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
	<div class="editContainter">
		<h1>Edit Your Team</h1>
		<form:form action="/teams/${team.id}" method="post"
			modelAttribute="team" class="editForm">
			<input type="hidden" name="_method" value="put">
			<div>
				<form:label path="name">Name</form:label>
				<form:errors class="text-danger" path="name" />
				<form:input path="name" class="input-group" />
			</div>
			<div>
				<form:label path="formation">Formation</form:label>
				<form:errors class="text-danger" path="formation" />
				<form:input path="formation" class="input-group" />
			</div>
			<div>
				<form:label path="gameday">Game Day</form:label>
				<form:errors class="text-danger" path="gameday" />
				<form:input type="date" path="gameday" class="input-group" />
			</div>
			<div>
				<form:label path="gameTime">Game Time</form:label>
				<form:errors class="text-danger" path="gameTime" />
				<form:input type="time" path="gameTime" class="input-group" />
			</div>
			<div class="buttonGroup">
				<a href="/teams" class="btn btn-primary">Home</a> 
				<input type="submit" value="Submit" class="btn btn-success" />
			</div>
		</form:form>
	</div>
</body>
</html>