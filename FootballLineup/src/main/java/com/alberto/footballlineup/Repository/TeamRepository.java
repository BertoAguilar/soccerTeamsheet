package com.alberto.footballlineup.Repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.alberto.footballlineup.Models.Team;





@Repository
public interface TeamRepository extends CrudRepository<Team, Long>{
    // this method retrieves all the teams from the database
	List<Team> findAllByOrderByGamedayAsc();
}
