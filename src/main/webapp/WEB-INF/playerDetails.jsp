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
<title><c:out value="${player.playerName}"></c:out>'s Details</title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/css/playerDetails.css" />
<!-- For any Bootstrap that uses JS -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<!-- YOUR own local JavaScript -->
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
	<div class="position-absolute top-50 start-50 translate-middle">
		<h1>
			<c:out value="${player.playerName}" />
		</h1>
		<p>
			Added By: Coach
			<c:out value="${player.user.lastName}" />
		</p>
		<p>
			Preferred Position:
			<c:out value="${player.position}" />
		</p>

		<c:if test="${player.team == null}">
		<div class="playerAlert">
		<img class="icon" alt="alert" src="/img/alert.png">
		<p>Player Is Not Registered To A Team</p>
		</div>
		</c:if>

		<c:if test="${player.team != null}">
			<p>
				Current Club:
				<c:out value="${player.team.name}" />
			</p>
		</c:if>
		<div class="buttonGroup">
			<a href="/players/all" class="btn btn-primary">All Players</a>
			<c:if test="${player.user.id == userId}">
				<div class="buttonGroup">
					<a href="/player/edit/${player.id}" class="btn btn-secondary">Edit</a>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>