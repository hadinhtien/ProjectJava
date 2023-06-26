package bkap.controller.customer;


import java.util.Date;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.AccountsDTO;
import bkap.entities.ConfigsDTO;

@Controller
public class AccountControllerCustomer {
	
	@Autowired
	private PasswordEncoder pe;
	
	public ConfigsDTO getConfig(Client client, Gson gson) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/configService/getConfig"); 
		String res = webResource.get(String.class); 
		ConfigsDTO config = gson.fromJson(res,ConfigsDTO.class);
		return config;
	}
	
	@RequestMapping(value = "/signUp")
	public String initSignUp(Model model, HttpSession session) {
		if (session.getAttribute("accId") != null) {
			return "redirect:/home";
		} else {
			Client client = Client.create();
			Gson gson = new Gson();
			AccountsDTO account = new AccountsDTO();
			
			model.addAttribute("account", account);
			model.addAttribute("config", getConfig(client, gson));
			return "customer/pages/accounts/signUp";
		}
	}

	@RequestMapping(value = "/doSignUp")
	public String signUp(@Valid @ModelAttribute("account") AccountsDTO account, BindingResult result, 
			@RequestParam("confirmPassword") String confirmPassword, Model model, RedirectAttributes redirAttrs) {
		Integer flag = 0;
		Client client = Client.create();
		Gson gson = new Gson();
		WebResource webResource;
		
		if (account.getEmail().length() > 0) {
			webResource = client.resource("http://localhost:8080/WebService/rest/accountService/getEmail/" + account.getEmail());
			String res = webResource.get(String.class);
			AccountsDTO accountsDTO = gson.fromJson(res, AccountsDTO.class);
			
			if (accountsDTO != null) {
				model.addAttribute("emailExist", "This email is already registered.");
				flag++;
			}
		}
		
		if (!account.getPassword().equals(confirmPassword)) {
			model.addAttribute("confirmPassword", "Confirm password does not match password.");
			flag++;
		}

		if (result.hasErrors() == true || flag > 0) {
			model.addAttribute("config", getConfig(client, gson));
			return "customer/pages/accounts/signUp";
		} else {
			account.setPassword(pe.encode(account.getPassword()));
	        account.setStatus(true);
	        account.setCreatedAt(new Date());
	        
	        String jsonAccount = gson.toJson(account);
	        webResource =  client.resource("http://localhost:8080/WebService/rest/accountService/insert");
	        ClientResponse clientResponse = webResource.type("application/json").post(ClientResponse.class, jsonAccount);
	        String data = clientResponse.getEntity(String.class);
	        boolean rs = gson.fromJson(data, boolean.class);
	        
	        model.addAttribute("config", getConfig(client, gson));
	        if (rs) {
	        	model.addAttribute("loginSuccess", "Successful account registration, login to experience our service.");
	        	return "customer/pages/accounts/login";
	        } else { 
	        	return "customer/pages/accounts/signUp";
	        }
		}
	}

	@RequestMapping(value = "/login")
	public String login(@RequestParam(value = "error", required = false) String error, Model model, HttpSession session) {
		if (session.getAttribute("accId") != null) {
			return "redirect:/home";
		} else {
			Client client = Client.create();
			Gson gson = new Gson();
			if (error != null) {
				model.addAttribute("login", "Your email or password is incorrect, please try again.");
			}
			model.addAttribute("config", getConfig(client, gson));
			return "customer/pages/accounts/login";
		}
	}

	@RequestMapping("/logout")
	public String logout(Model model) {
		return "redirect:/home";
	}
	
	@RequestMapping("/myAccount")
	public String myAccount(Model model, HttpSession session) {
		if (session.getAttribute("accId") != null) {
			Client client = Client.create();
			Gson gson = new Gson();
			AccountsDTO account = new AccountsDTO();
			
			model.addAttribute("account", account);
			model.addAttribute("config", getConfig(client, gson));
			return "customer/pages/accounts/myAccount";
		} else {
			return "redirect:/login";
		}
	}
	
	@RequestMapping("/updateAccount")
	public String updateAccount(@Valid @ModelAttribute("account") AccountsDTO account, BindingResult result, Model model, 
			RedirectAttributes redirAttrs, HttpSession session) {
		if (session.getAttribute("accId") != null) {
			Client client = Client.create();
			Gson gson = new Gson();
			WebResource webResource;
			
			if (result.hasErrors() == true) {
				model.addAttribute("config", getConfig(client, gson));
				return "customer/pages/accounts/myAccount";
			} else {
				webResource = client.resource("http://localhost:8080/WebService/rest/accountService/getEmail/" + session.getAttribute("accEmail"));
				String res = webResource.get(String.class);
				AccountsDTO accountsDTO = gson.fromJson(res, AccountsDTO.class);
				
				accountsDTO.setFullName(account.getFullName());
				accountsDTO.setPhone(account.getPhone());
				accountsDTO.setAddress(account.getAddress());
				
				String jsonAccount = gson.toJson(accountsDTO);
		        webResource =  client.resource("http://localhost:8080/WebService/rest/accountService/update");
		        ClientResponse clientResponse = webResource.type("application/json").put(ClientResponse.class, jsonAccount);
		        String data = clientResponse.getEntity(String.class);
		        boolean rs = gson.fromJson(data, boolean.class);
			    
		        if (rs) {
		        	session.setAttribute("accFullName", account.getFullName());
					session.setAttribute("accPhone", account.getPhone());
					session.setAttribute("accAddress", account.getAddress());
		        	redirAttrs.addFlashAttribute("updateAccount", "Profile update successful");
		        } else {
		        	redirAttrs.addFlashAttribute("updateAccount", "Profile update failed");
		        }
		        return "redirect:/myAccount";
			}
		} else {
			return "redirect:/login";
		}
	}
	
	@RequestMapping("/changePassword")
	public String changePassword(Model model, HttpSession session, @RequestParam("currentPassword") String currentPassword, 
			@RequestParam("newPassword") String newPassword, @RequestParam("confirmPassword") String confirmPassword) {
		if (session.getAttribute("accId") != null) {
			Client client = Client.create();
			Gson gson = new Gson();
			WebResource webResource;
			Integer flag = 0;
			
			webResource = client.resource("http://localhost:8080/WebService/rest/accountService/getEmail/" + session.getAttribute("accEmail"));
			String res = webResource.get(String.class);
			AccountsDTO accountsDTO = gson.fromJson(res, AccountsDTO.class);
			
			if (!BCrypt.checkpw(currentPassword, accountsDTO.getPassword())) {
				model.addAttribute("currentPassword", "Current password is wrong.");
				flag++;
			}
			
			if (newPassword.length() == 0) {
				model.addAttribute("newPassword", "Please enter new password.");
				flag++;
			}
			
			if (!newPassword.equals(confirmPassword)) {
				model.addAttribute("confirmPassword", "Confirm password does not match new password.");
				flag++;
			}
			
			if (flag == 0) {
				accountsDTO.setPassword(pe.encode(newPassword));
				String jsonAccount = gson.toJson(accountsDTO);
		        webResource =  client.resource("http://localhost:8080/WebService/rest/accountService/update");
		        ClientResponse clientResponse = webResource.type("application/json").put(ClientResponse.class, jsonAccount);
		        String data = clientResponse.getEntity(String.class);
		        boolean rs = gson.fromJson(data, boolean.class);
		        
		        if (rs) {
		        	session.removeAttribute("accId");
		        	session.removeAttribute("accFullName");
		        }
			} else {
				AccountsDTO account = new AccountsDTO();
				model.addAttribute("account", account);
				return "customer/pages/accounts/myAccount";
			}
		}
		return "redirect:/login";
	}
	
}
