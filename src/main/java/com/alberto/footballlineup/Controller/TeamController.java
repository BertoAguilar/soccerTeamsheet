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

import com.alberto.footballlineup.Models.Player;
import com.alberto.footballlineup.Models.Team;
import com.alberto.footballlineup.Models.User;
import com.alberto.footballlineup.Services.PlayerService;
import com.alberto.footballlineup.Services.TeamService;
import com.alberto.footballlineup.Services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class TeamController {

    @Autowired
    TeamService teams;

    @Autowired
    UserService users;
    
    @Autowired
    PlayerService players;

    // Show all teams
    @GetMapping("/teams")
    public String homepage(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";
        }
        model.addAttribute("user", users.getLoggedInUser(userId));
        List<Team> team = teams.allTeams();
        model.addAttribute("team", team);
        return "homepage.jsp";
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

    // Create a new Team
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
        team.setUser(user);
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
}