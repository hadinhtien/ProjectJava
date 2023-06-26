package bkap.controller.customer;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.GenericType;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.AccountsDTO;
import bkap.entities.BlogsDTO;
import bkap.entities.BrandsDTO;
import bkap.entities.ConfigsDTO;
import bkap.entities.ProductsDTO;

@Controller
public class HomeControllerCustomer {
	
	public ConfigsDTO getConfig(Client client, Gson gson) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/configService/getConfig"); 
		String data = webResource.get(String.class); 
		ConfigsDTO config = gson.fromJson(data,ConfigsDTO.class);
		return config;
	}
	
	@RequestMapping(value = {"/", "/home"})
	public String home(Model model, HttpSession session) {
		WebResource webResource;
		Client client = Client.create();
		Gson gson = new Gson();
		Integer status = 1;
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal != null && principal != "anonymousUser") {
			User user = (User) principal;
			String email = user.getUsername();
			
			webResource = client.resource("http://localhost:8080/WebService/rest/accountService/getEmail/" + email);
			String res = webResource.get(String.class);
			AccountsDTO account = gson.fromJson(res, AccountsDTO.class);
			
			session.setAttribute("accId", account.getAccId());
			session.setAttribute("accEmail", account.getEmail());
			session.setAttribute("accFullName", account.getFullName());
			session.setAttribute("accPhone", account.getPhone());
			session.setAttribute("accAddress", account.getAddress());
		}
		
		webResource = client.resource("http://localhost:8080/WebService/rest/brandService/getList");
		String data = webResource.get(String.class);
		GenericType<List<BrandsDTO>> listBrandType = new GenericType<List<BrandsDTO>>() {};
		List<BrandsDTO> listBrands = gson.fromJson(data, listBrandType.getType());
		
		webResource = client.resource("http://localhost:8080/WebService/rest/productService/getListStatus");
		data = webResource.get(String.class);
		GenericType<List<ProductsDTO>> listProductType = new GenericType<List<ProductsDTO>>() {};
		List<ProductsDTO> listProducts = gson.fromJson(data, listProductType.getType());
        
		webResource = client.resource("http://localhost:8080/WebService/rest/blogService/getList/" + status + "/" + 1);
		data = webResource.get(String.class);
		GenericType<List<BlogsDTO>> listType = new GenericType<List<BlogsDTO>>() {};
		List<BlogsDTO> listBlogs = gson.fromJson(data, listType.getType());
		
		model.addAttribute("listBrands", listBrands);
		model.addAttribute("listProducts", listProducts);
		model.addAttribute("listBlogs", listBlogs);
		model.addAttribute("config", getConfig(client, gson));
        
		return "customer/pages/index";
	}
}
