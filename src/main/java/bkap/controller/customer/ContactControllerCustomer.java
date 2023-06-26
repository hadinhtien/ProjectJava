package bkap.controller.customer;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.ConfigsDTO;
import bkap.entities.ContactsDTO;

@Controller
public class ContactControllerCustomer {
	
	@RequestMapping(value = "/contact")
	public String contact(Model model) {
		Client client = Client.create();
		Gson gson = new Gson();	
		
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/configService/getConfig");
		String data = webResource.get(String.class);
		ConfigsDTO config = gson.fromJson(data, ConfigsDTO.class);
		model.addAttribute("config", config);
		return "customer/pages/contact";
	}
	
	@RequestMapping(value = "/contactCreate")
	public String contactCreat(Model model,@Valid @ModelAttribute("Contacts") ContactsDTO c, BindingResult result) {
		Gson son = new Gson();
		String data = son.toJson(c);
		
	
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/contactService/insert");
		ClientResponse clientResponse = webResource.type("application/json").post(ClientResponse.class,data);
		
		String result1 = clientResponse.getEntity(String.class);
		Boolean bl = son.fromJson(result1, Boolean.class);
		if (bl) {
			model.addAttribute("success", "Create contact successfully");
			return "redirect:/contact";
		} else {
			model.addAttribute("error", "Insert Failed!");
			return "redirect:/contact";
		}
	}
}
