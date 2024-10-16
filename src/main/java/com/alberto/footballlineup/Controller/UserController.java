package com.alberto.footballlineup.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alberto.footballlineup.Models.LoggedInUser;
import com.alberto.footballlineup.Models.Player;
import com.alberto.footballlineup.Models.Team;
import com.alberto.footballlineup.Models.User;
import com.alberto.footballlineup.Services.PlayerService;
import com.alberto.footballlineup.Services.TeamService;
import com.alberto.footballlineup.Services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {
	@Autowired
	UserService users;

	@Autowired
	TeamService teams;

	@Autowired
	PlayerService players;

	// takes you to login page
	@GetMapping("/")
	public String index(Model model) {

		// Bind empty User and LoginUser objects to the JSP
		// to capture the form input
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoggedInUser());
		return "index.jsp";
	}

	// checks if you are already registered with email, if not registers you
	@PostMapping("/register/user")
	public String registerUser(@Valid @ModelAttribute("newUser") User newUser, BindingResult result,
			HttpSession session, Model model) {
		users.register(newUser, result);
		if (result.hasErrors()) {
			model.addAttribute("newLogin", new LoggedInUser());
			return "index.jsp";
		} else {
			session.setAttribute("userId", newUser.getId());
			return "redirect:/teams";
		}
	}

	// checks if you have an account and logs you in
	@PostMapping("/login/user")
	public String loginUser(@Valid @ModelAttribute("newLogin") LoggedInUser newLogin, BindingResult result,
			HttpSession session, Model model) {
		User user = users.login(newLogin, result);
		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "index.jsp";
		} else {
			session.setAttribute("userId", user.getId());
			return "redirect:/teams";
		}

	}

	// Makes sure you log in, and takes you to home page

	@GetMapping("/teams")
	public String homepage(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		} else {
	        model.addAttribute("user", users.getLoggedInUser(userId));
	        List<Team> team = teams.allTeams();
	        model.addAttribute("team", team);
		}
		return "homepage.jsp";
	}

	// Takes You to an Info page
	@GetMapping("/info")
	public String infopage(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		} else {
	        model.addAttribute("user", users.getLoggedInUser(userId));
	        List<Team> team = teams.allTeams();
	        model.addAttribute("team", team);
		}
		return "info.jsp";
	}

	//Shows you all the details of a team
	@GetMapping("/teams/details/{teamId}")
	public String showTeamDetails(@PathVariable("teamId") Long teamId, HttpSession session, Model model, @ModelAttribute("player") Player player) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}

		Team team = teams.findTeam(teamId);
		if (team == null) {
			return "redirect:/teams";
		}

		model.addAttribute("team", team);
		model.addAttribute("userId", userId);
		model.addAttribute("playerCount", team.getPlayerCount());
        List<Player> playerList = players.getAll();
        model.addAttribute("playerList", playerList);

		return "teamDetails.jsp";
	}

	// Takes you to a form to create a new team

	@GetMapping("/teams/new")
	public String newTeam(@ModelAttribute("team") Team team, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		return "newTeam.jsp";
	}

	// Creates a new team

	@PostMapping("/teams")
	public String createTeam(@Valid @ModelAttribute("team") Team team, BindingResult result, HttpSession session) {
		if (result.hasErrors()) {
			return "newTeam.jsp";
		}
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		User user = users.getLoggedInUser(userId);
		team.setUser(user); // Set the user on the team
		teams.createTeam(team);
		return "redirect:/teams";
	}

	// Takes you to update team form where you can make changes

	@GetMapping("/teams/edit/{id}")
	public String editTeam(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		Team team = teams.findTeam(id);
		model.addAttribute("team", team);
		return "editTeam.jsp";
	}

	// Updates the Team

	@PutMapping("/teams/{id}")
	public String updateTeam(@Valid @ModelAttribute("team") Team team, BindingResult result, Model model,
			HttpSession session) {
		if (result.hasErrors()) {
			model.addAttribute("team", team);
			return "editTeam.jsp";
		}
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		} else {
			User user = users.getLoggedInUser(userId);
			team.setUser(user);
			teams.updateTeam(team);
			return "redirect:/teams";
		}
	}

	// Delete a team by id

	@DeleteMapping("/teams/destroy/{id}")
	public String destroyTeam(@PathVariable("id") Long id) {
		teams.deleteTeam(id);
		return "redirect:/teams";
	}

	// Log out user

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	

	// Adds Players to a team

	@PostMapping("/create/player/{teamId}")
	public String createPlayer(@Valid @ModelAttribute("player") Player player, BindingResult result,
			HttpSession session, @PathVariable("teamId") Long teamId, Model model, RedirectAttributes redirectAttributes) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		if (result.hasErrors()) {
			redirectAttributes.addFlashAttribute("error", "Cannot Be Blank");
			model.addAttribute("team", teams.findTeam(teamId));
			return "redirect:/teams/details/"+teamId;
		} else {
			Team oneTeam = teams.findTeam(teamId);
			User loggedInUser = users.getLoggedInUser(userId);

			List<Player> playerList = oneTeam.getPlayer();
			playerList.add(player);

			player.setTeam(oneTeam);
			player.setUser(loggedInUser);
			players.createPlayer(player);
			return "redirect:/teams";
		}
	}
	
	// Takes you to a form to create a new Player

	@GetMapping("/players/new")
	public String newPlayer(@ModelAttribute("player") Player player, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		return "newPlayer.jsp";
	}

	// Creates a new player

	@PostMapping("/players")
	public String createPlayer(@Valid @ModelAttribute("player") Player player, BindingResult result, HttpSession session) {
		if (result.hasErrors()) {
			return "newPlayer.jsp";
		}
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		User user = users.getLoggedInUser(userId);
		player.setUser(user);
		players.createPlayer(player);
		return "redirect:/players/all";
	}
	
	
	//Shows you all the details of a player
	@GetMapping("/player/details/{playerId}")
	public String showPlayerDetails(@PathVariable("playerId") Long playerId, HttpSession session, Model model, @ModelAttribute("player") Player player) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}

		Player player1 = players.findPlayer(playerId);
		if (player1 == null) {
			return "redirect:/teams";
		}

		model.addAttribute("player", player1);
		model.addAttribute("userId", userId);

		return "playerDetails.jsp";
	}
	
	
	// Shows you all of the created players
	
	@GetMapping("/players/all")
	public String showTeamDetails(HttpSession session, Model model, @ModelAttribute("player") Player player) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		model.addAttribute("userId", userId);
        List<Player> playerList = players.getAll();
        model.addAttribute("players", playerList);

		return "allPlayers.jsp";
	}
	
	// Takes you to update Player form where you can make changes

	@GetMapping("/player/edit/{id}")
	public String editPlayer(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		Player player = players.findPlayer(id);
		model.addAttribute("player", player);
		return "editPlayer.jsp";
	}
	
	
	// Updates a Player
	@PutMapping("/player/{id}")
	public String updatePlayer(@Valid @ModelAttribute("player") Player player, BindingResult result, Model model,
			HttpSession session) {
		if (result.hasErrors()) {
			model.addAttribute("player", player);
			return "editPlayer.jsp";
		}
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		} else {
			User user = users.getLoggedInUser(userId);
			player.setUser(user);
			players.updatePlayer(player);
			return "redirect:/players/all";
		}
	}
	
	// Delete a Player by id

	@DeleteMapping("/player/destroy/{id}")
	public String destroyPlayer(@PathVariable("id") Long id) {
		players.destroyPlayer(id);
		return "redirect:/players/all";
	}
}
