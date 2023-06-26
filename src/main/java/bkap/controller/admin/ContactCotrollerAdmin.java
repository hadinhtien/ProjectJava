package bkap.controller.admin;

import java.util.List;

import javax.ws.rs.core.GenericType;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.ContactsDTO;

@Controller
@RequestMapping(value = {"/admin"})
public class ContactCotrollerAdmin {
	@RequestMapping(value = {"/contactManagement"})
	public String contactManagement(Model model) {
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/contactService/getList");
		String data = webResource.get(String.class);

		Gson son = new Gson();
		GenericType<List<ContactsDTO>> listType = new GenericType<List<ContactsDTO>>() {
		};

		List<ContactsDTO> list = son.fromJson(data, listType.getType());
	
		model.addAttribute("list", list);
		return "admin/pages/contactManagement";
	}
	@RequestMapping("/Delete")
	public String delete(@RequestParam("Id") Integer id,RedirectAttributes redirAttrs , Model model) {
		Client client = Client.create();
		WebResource webResource = client
				.resource("http://localhost:8080/WebService/rest/contactService/delete/"
						+ id);
		String data = webResource.type("application/json").delete(String.class);

		Gson son = new Gson();
		Boolean bl = son.fromJson(data, Boolean.class);
		if (bl) {
			model.addAttribute("success", "Delete successfully!");
			return "redirect:/admin/contactManagement";
		} else {
			model.addAttribute("error", "Delete failed!");
			return "redirect:/admin/contactManagement";
		}
		
	}
	@RequestMapping(value = { "/searchContact" })
	public String searchContact(@RequestParam("FullName") String fullName, Model model) {
		Client client = Client.create();
		Gson gson = new Gson();
		Integer status = 0;

		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/contactService/getByName/" + fullName);
		String data = webResource.get(String.class);
		GenericType<List<ContactsDTO>> listtype = new GenericType<List<ContactsDTO>>() {};
		
		List<ContactsDTO> list = gson.fromJson(data, listtype.getType());
		ContactsDTO ordeDto = new ContactsDTO();
		model.addAttribute("Orders", ordeDto);
		model.addAttribute("list", list);
		return "admin/pages/orderManagement";
	}
}
