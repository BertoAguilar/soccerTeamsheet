package com.alberto.footballlineup.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alberto.footballlineup.Models.Player;
import com.alberto.footballlineup.Models.Team;
import com.alberto.footballlineup.Repository.PlayerRepository;
import com.alberto.footballlineup.Repository.TeamRepository;





@Service
public class TeamService {
	// adding the team repository as a dependency
	@Autowired
	TeamRepository teamRepository;
	@Autowired
	PlayerRepository playerRepository;

	public TeamService(TeamRepository teamRepository) {
		this.teamRepository = teamRepository;
	}

	// returns all the teams
	public List<Team> allTeams() {
		return teamRepository.findAllByOrderByGamedayAsc();
	}

	// creates a team
	public Team createTeam(Team b) {
		return teamRepository.save(b);
	}

	// updates a team
	public Team updateTeam(Team b) {
		return teamRepository.save(b);
	}

	// Deletes a team
	public void deleteTeam(Long id) {
		teamRepository.deleteById(id);
	}

	// retrieves a team
	public Team findTeam(Long id) {
		Optional<Team> optionalTeam = teamRepository.findById(id);
		if (optionalTeam.isPresent()) {
			return optionalTeam.get();
		} else {
			return null;
		}
	}
	

    public String addPlayerToTeam(Long id, Player player) {
        Optional<Team> optionalTeam = teamRepository.findById(id);
        
        if (optionalTeam.isPresent()) {
            Team team = optionalTeam.get();
            if (team.getPlayerCount() >= 11) {
                return "Team has reached the maximum number of players";
            }
            player.setTeam(team);
            playerRepository.save(player);
            return "Player added successfully";
        } else {
            return "Team not found";
        }
    }
}
