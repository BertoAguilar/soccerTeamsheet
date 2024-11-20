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
<title>View All Players</title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/css/allPlayers.css" />
<!-- For any Bootstrap that uses JS -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<!-- YOUR own local JavaScript -->
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
<div class="links">
<a href="/teams" class="btn">Home Page</a>
<a href="/players/new" class="btn"> Add A Player</a>
</div>
<div class="allPlayers">
	<div class="goalkeepers">
		<h3>GoalKeepers</h3>
		<ul>
			<c:forEach var="player" items="${players}">
				<c:if test="${player.position == 'GK'}">
					<li>
					<c:out value="${player.position}" /> 
					<a href="/player/details/${player.id}"> <c:out value="${player.playerName}" /> </a> </li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
	<div class="defenders">
		<h3>Defenders</h3>
		<ul>
			<c:forEach var="player" items="${players}">
				<c:if test="${player.position == 'CB' or player.position == 'RB' or player.position == 'LB'}">
					<li>
					<c:out value="${player.position}" /> 
					<a href="/player/details/${player.id}"> <c:out value="${player.playerName}" /> </a> </li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
	<div class="midfield">
		<h3>Midfielders</h3>
		<ul>
			<c:forEach var="player" items="${players}">
				<c:if test="${player.position == 'CM' or player.position == 'CDM' or player.position == 'CAM'}">
					<li>
					<c:out value="${player.position}" /> 
					<a href="/player/details/${player.id}"> <c:out value="${player.playerName}" /> </a> </li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
	<div class="attackers">
		<h3>Forwards</h3>
		<ul>
			<c:forEach var="player" items="${players}">
				<c:if test="${player.position == 'LW' or player.position == 'ST' or player.position == 'RW' or player.position == 'CF'}">
					<li>
					<c:out value="${player.position}" /> 
					 <a href="/player/details/${player.id}"> <c:out value="${player.playerName}" /> </a> </li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div>
</body>
</html>