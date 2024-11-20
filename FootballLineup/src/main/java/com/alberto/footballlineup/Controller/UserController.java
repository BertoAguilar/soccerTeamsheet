package com.alberto.footballlineup.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import com.alberto.footballlineup.Models.LoggedInUser;
import com.alberto.footballlineup.Models.User;
import com.alberto.footballlineup.Services.UserService;

@Controller
public class UserController {

    @Autowired
    UserService users;

    // Login page
    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoggedInUser());
        return "loginReg.jsp";
    }

    // checks if you are already registered with email, if not registers you
    @PostMapping("/register/user")
    public String registerUser(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, HttpSession session, Model model) {
        users.register(newUser, result);
        if (result.hasErrors()) {
            model.addAttribute("newLogin", new LoggedInUser());
            return "loginReg.jsp";
        } else {
            session.setAttribute("userId", newUser.getId());
            return "redirect:/teams";
        }
    }

    // checks if you have an account and logs you in
    @PostMapping("/login/user")
    public String loginUser(@Valid @ModelAttribute("newLogin") LoggedInUser newLogin, BindingResult result, HttpSession session, Model model) {
        User user = users.login(newLogin, result);
        if (result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "loginReg.jsp";
        } else {
            session.setAttribute("userId", user.getId());
            return "redirect:/teams";
        }
    }

    // Logout's the User
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    
	// Takes You to an Info page
	@GetMapping("/info")
	public String infopage(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		return "info.jsp";
	}
}
