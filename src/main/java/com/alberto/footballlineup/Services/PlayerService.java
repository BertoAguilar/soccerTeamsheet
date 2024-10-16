package com.alberto.footballlineup.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alberto.footballlineup.Models.Player;
import com.alberto.footballlineup.Repository.PlayerRepository;



@Service
public class PlayerService {
	@Autowired
	PlayerRepository pRepo;
	
	//Returns all players by position
	public List<Player> getAll() {
		return pRepo.findAllByOrderByPositionAsc();
	}

	// Creates a player
	public void createPlayer(Player player) {
		pRepo.save(player);
	}

	// Returns one specific player
	public Player findPlayer(Long id) {
		Optional<Player> optionalPlayer = pRepo.findById(id);
		if (optionalPlayer.isPresent()) {
			return optionalPlayer.get();
		} else {
			return null;
		}
	}

	// Updates a player
	public Player updatePlayer(Player player) {
		return pRepo.save(player);
	}

	// Deletes a player
	public void destroyPlayer(Long id) {
		pRepo.deleteById(id);
	}

}
