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
<title>Add Your Team</title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/css/newTeam.css" />
<!-- For any Bootstrap that uses JS -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<!-- YOUR own local JavaScript -->
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
	<div class="newTeamContainer">
		<h1>New Team</h1>
		<form:form action="/teams" method="post" modelAttribute="team" class="newTeamForm">
			<p class="formContainer">
				<form:label path="name">Team Name</form:label>
				<form:errors path="name" class="text-danger" />
				<form:input path="name" class="input-group" placeholder="FC Team Name"/>
			</p>
			<p class="formContainer">
				<form:label path="formation">Formation</form:label>
				<form:errors path="formation" class="text-danger" />
				<form:input  path="formation" class="input-group" placeholder="4-3-3"/>
			</p>
			<p class="formContainer">
				<form:label path="gameday">Game Day</form:label>
				<form:errors path="gameday" class="text-danger" />
				<form:input  type="date" path="gameday"  class="input-group"/>
			</p>
			<p class="formContainer"> 
				<form:label path="gameTime">Game Time</form:label>
				<form:errors path="gameTime" class="text-danger" />
				<form:input  type="time" path="gameTime"  class="input-group"/>
			</p>
			<div class="buttonGroup">
			<a href="/teams" class="btn btn-primary">Home</a>
			<input type="submit" value="Submit" class="btn btn-success"/>
			</div>
		</form:form>
	</div>
</body>
</html>