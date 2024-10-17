<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Format Date -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- For JSTL Forms -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome Coach <c:out value="${ user.lastName}" /></title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/css/homepage.css" />
<link rel="image_src" href="/img/info.png" />
<!-- For any Bootstrap that uses JS -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<!-- YOUR own local JavaScript -->
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
	<div class="container">
		<div class="header">
			<div>
				<h1>
					Welcome, Coach
					<c:out value="${ user.lastName}" />
				</h1>
				<h2>Everyone's Team Sheets</h2>
			</div>
			<div class="toplinks">
				<a href="/info"><img class="icon" alt="?" src="/img/info2.png"></a>
				<a href="/logout" class="logout btn"> Logout</a>
			</div>
		</div>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Formation</th>
					<th scope="col">Players</th>
					<th scope="col">Game Day</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="team" items="${team}">
					<tr>
						<td><a href="/teams/details/${team.id}"><c:out value="${team.name}" /></a></td>
						<td><c:out value="${team.formation}" /></td>
						<td><c:out value="${team.playerCount}"/> / 16</td>
						<td><fmt:formatDate value="${team.gameday}" pattern="MMM dd yyyy" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="links">
			<a href="/teams/new" class="btn"> New Team</a>
			<a href="/players/new" class="btn"> Add Player</a>
			<a href="/players/all" class="btn"> View All Players</a>
		</div>
	</div>
</body>
</html>