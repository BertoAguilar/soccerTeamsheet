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
<title>Edit Player</title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/css/editPlayer.css"/>
<!-- For any Bootstrap that uses JS -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<!-- YOUR own local JavaScript -->
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
	<div class="editContainer">
			<div>
				<h1>Edit Player</h1>
				<form:form action="/player/${player.id}" method="post"
					modelAttribute="player" class="editForm">
					<input type="hidden" name="_method" value="put">
					<div class="formContainer">
						<form:label path="playerName">Player's Name</form:label>
						<form:errors class="text-danger" path="playerName" />
						<form:input path="playerName" class="input-group" />
					</div>
					<div class="formContainer">
						<form:label path="position">Position</form:label>
						<form:errors class="text-danger" path="position" />
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
					</div>
						<div class="startBenchOption">
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
							<a href="/players/all" class="homeBtn btn ">All Players</a>
							<input type="submit" value="Submit" class="submitBtn btn" />
					</div>
				</form:form>
			</div>
			<div class="deleteButton">
				<form action="/player/destroy/${player.id}" method="post">
					<input type="hidden" name="_method" value="delete"> 
					<input type="submit" value="Delete" class="deleteBtn btn" style="width: 205px">
				</form>
			</div>
	</div>
</body>
</html>