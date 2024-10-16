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

import com.alberto.footballlineup.Models.Player;
import com.alberto.footballlineup.Models.Team;
import com.alberto.footballlineup.Models.User;
import com.alberto.footballlineup.Services.PlayerService;
import com.alberto.footballlineup.Services.TeamService;
import com.alberto.footballlineup.Services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class PlayerController {

    @Autowired
    PlayerService players;

    @Autowired
    UserService users;
    
    @Autowired
    TeamService teams;
    
	// Players

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

    // Create a new Player
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

    // Show details of a player
    @GetMapping("/player/details/{playerId}")
    public String showPlayerDetails(@PathVariable("playerId") Long playerId, HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";
        }
        Player player = players.findPlayer(playerId);
        if (player == null) {
            return "redirect:/teams";
        }
        model.addAttribute("player", player);
        model.addAttribute("userId", userId);
        return "playerDetails.jsp";
    }

    // Show all players
    @GetMapping("/players/all")
    public String showAllPlayers(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";
        }
        model.addAttribute("userId", userId);
        List<Player> playerList = players.getAll();
        model.addAttribute("players", playerList);
        return "allPlayers.jsp";
    }

    // Show form to edit a Player
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
    public String updatePlayer(@Valid @ModelAttribute("player") Player player, BindingResult result, Model model, HttpSession session) {
        if (result.hasErrors()) {
            model.addAttribute("player", player);
            return "editPlayer.jsp";
        }
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";
        }
        User user = users.getLoggedInUser(userId);
        player.setUser(user);
        players.updatePlayer(player);
        return "redirect:/players/all";
    }

    // Delete a Player
    @DeleteMapping("/player/destroy/{id}")
    public String destroyPlayer(@PathVariable("id") Long id) {
        players.destroyPlayer(id);
        return "redirect:/players/all";
    }
}

