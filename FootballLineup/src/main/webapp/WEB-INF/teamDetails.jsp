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
<title><c:out value="${team.name}" /></title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/css/teamDetails.css" />
<!-- For any Bootstrap that uses JS -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<!-- YOUR own local JavaScript -->
<script type="text/javascript" src="/js/app.js"></script>

</head>
<body>
	<div class="teamDetailContainer position-absolute top-50 start-50 translate-middle">
			<div class="buttonGroup">
			<a href="/teams" class="homeBtn btn">Home Page</a>
			<c:if test="${team.user.id == userId}">
				<div class="buttonGroup">
					<a href="/teams/edit/${team.id}" class="editBtn btn">Edit</a>
					<form action="/teams/destroy/${team.id}" method="post">
					<input type="hidden" name="_method" value="delete"> 
					<input type="submit" value="Delete" class="deleteBtn btn">
					</form>
				</div>
			</c:if>
		</div>
		<h1>
			<c:out value="${team.name}" />
		</h1>
		<p>
			Added By: Coach
			<c:out value="${team.user.lastName}" />
		</p>
		<p>
			Formation:
			<c:out value="${team.formation}" />
		</p>
		<p> Game Day: <fmt:formatDate value="${team.gameday}" pattern="MMM dd yyyy" /></p>
		<c:if test="${team.gameTime == ''}">
			<p>Kick Off Time is Not Set</p>
		</c:if>
		<c:if test="${team.gameTime != ''}">
			<p>Kick Off Time: <c:out value="${team.gameTime}" /></p>
		</c:if>
		<div class="playerContainer">
			<h2>
				<c:out value="${error}"></c:out>
			</h2>
			<c:if test="${playerCount < 16}">
				<form:form class="addPlayerForm" action="/create/player/${team.id}" method="post"
					modelAttribute="player">
					<div>
						<div>
							<div class="selectPlayerOption">
							<label for="player">Add A Player</label> 
							<select name="player" id="player">
								<option selected disabled>Choose Player</option>
								<c:forEach var="player" items="${playerList}">
									<option value="${player.id}"><c:out value="${player.playerName}" /></option>
								</c:forEach>
							</select>
							</div>
							<div class="startBenchOption">
								<form:label path="playerName">Starter?</form:label>
								<form:radiobutton value="True" label="Yes" path="isStarter" />
								<form:radiobutton value="False" label="No" path="isStarter" />
								<form:errors class="text-danger" path="isStarter" />
								<c:out value="${error}"></c:out>
								<button class="btn btn-primary">Add Player</button>
							</div>
						</div>
					</div>
				</form:form>
			</c:if>

			<!-- 	********************************************************  -->
			<c:if test="${playerCount >= 16}">
				<div class="fullAlert card">
				<h2>Team is Full</h2>
				<p>This team has met the maximum requirement of players</p>
				</div>
			</c:if>
			<div>
				<h3>Current Players</h3>
				<h4>
					Player Count:
					<c:out value="${playerCount}" />
				</h4>
				<div class="starterBenchList">
					<div class="starters">
						<h3>Starting 11</h3>
						<ol>
							<c:forEach var="player" items="${team.player}">
							<c:if test="${player.isStarter}">
								<li>
								<c:out value="${player.position}" /> 
								<c:out value="${player.playerName}" />
								</li>
							</c:if>
							</c:forEach>
						</ol>
					</div>
					<div class="bench">
						<h3>Substitutes</h3>
						<ul>
							<c:forEach var="player" items="${team.player}">
							<c:if test="${!player.isStarter}">
								<li>
								<c:out value="${player.position}" /> 
								<c:out value="${player.playerName}" />
								</li>
							</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>