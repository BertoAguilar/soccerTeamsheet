package com.alberto.footballlineup.Repository;

import java.util.List;

import org.springframework.data.repository.ListCrudRepository;
import org.springframework.stereotype.Repository;

import com.alberto.footballlineup.Models.Player;



@Repository
public interface PlayerRepository extends ListCrudRepository<Player, Long>{
	List<Player> findAllByOrderByPositionAsc();
}
