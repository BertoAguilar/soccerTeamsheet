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
<title>Add The New Player</title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/css/newPlayer.css" />
<!-- For any Bootstrap that uses JS -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<!-- YOUR own local JavaScript -->
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
	<h2>
		<c:out value="${error}"></c:out>
	</h2>
	<div class="newPlayerContainter">
		<h1>New Player</h1>
		<form:form action="/players" method="post" modelAttribute="player"
			class="newPlayerForm">
			<p>
				<form:label path="playerName">Name</form:label>
				<form:errors path="playerName" class="text-danger" />
				<form:input path="playerName" class="input-group" />
			</p>
			<p>
				<form:label path="position">Position</form:label>
				<form:errors path="position" class="text-danger" />
				<select name="position" id="position" class="input-group">
				<option selected disabled>Select A Position</option>
				<option>GK</option>
				<option>LB</option>
				<option>CB</option>
				<option>RB</option>
				<option>CDM</option>
				<option>CM</option>
				<option>CAM</option>
				<option>CF</option>
				<option>LW</option>
				<option>ST</option>
				<option>RW</option>
				</select>
			</p>
			<div class="starterSelectOption">
				<form:label path="playerName">Starter?</form:label>
				<div class="radioGroup">
				<form:radiobutton value="True" label="Yes" path="isStarter" />
				</div>
				<div class="radioGroup">
				<form:radiobutton value="False" label="No" path="isStarter" />
				</div>
				<form:errors class="text-danger" path="isStarter" />
				<c:out value="${error}"></c:out>
			</div>
			<div class="buttonGroup">
				<a href="/teams" class="btn btn-primary">Home</a> <input
					type="submit" value="Submit" class="btn btn-success" />
			</div>
		</form:form>
	</div>
</body>
</html>