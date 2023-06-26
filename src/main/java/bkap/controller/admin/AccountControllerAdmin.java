package bkap.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.GenericType;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.Account_RolesDTO;
import bkap.entities.AccountsDTO;

@Controller
@RequestMapping(value = {"/admin"})
public class AccountControllerAdmin {
	
	@RequestMapping(value = {"/accountManagement"})
	public String accountManagement(Model model) {
		Gson gson = new Gson();
		Client client = Client.create();

		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/accountService/getList");
		String data = webResource.get(String.class);
		GenericType<List<AccountsDTO>> listAccountType = new GenericType<List<AccountsDTO>>() {};
		List<AccountsDTO> listAccounts = gson.fromJson(data, listAccountType.getType());
		model.addAttribute("listAccounts", listAccounts);
		
		webResource = client.resource("http://localhost:8080/WebService/rest/account_roleService/getList");
		data = webResource.get(String.class);
		GenericType<List<Account_RolesDTO>> listAccount_RoleType = new GenericType<List<Account_RolesDTO>>() {};
		List<AccountsDTO> listAccount_Roles = gson.fromJson(data, listAccount_RoleType.getType());
		model.addAttribute("listAccount_Roles", listAccount_Roles);
		
		return "admin/pages/accountManagement";
	}
	
	@RequestMapping(value = {"/accountStatus"})
	public String accountStatus(@RequestParam("accId")Integer accId, @RequestParam("status")boolean status, 
			RedirectAttributes redirAttrs, Model model) {
		Gson gson = new Gson();
		Client client = Client.create();
		
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/accountService/getById/" + accId);
		String res = webResource.get(String.class);
		AccountsDTO account = gson.fromJson(res, AccountsDTO.class);
		
		account.setStatus(status);
		
		String jsonAccount = gson.toJson(account);
		webResource = client.resource("http://localhost:8080/WebService/rest/accountService/update");
		ClientResponse clientResponse = webResource.type("application/json").put(ClientResponse.class, jsonAccount);
		res = clientResponse.getEntity(String.class);
		boolean rs = gson.fromJson(res, boolean.class);

		return "redirect:/admin/accountManagement";
	}
}
