package bkap.controller.customer;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.GenericType;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.BlogsDTO;
import bkap.entities.ConfigsDTO;

@Controller
public class BlogControllerCustomer {
	
	public ConfigsDTO getConfig(Client client, Gson gson) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/configService/getConfig"); 
		String data = webResource.get(String.class); 
		ConfigsDTO config = gson.fromJson(data,ConfigsDTO.class);
		return config;
	}
	
	@RequestMapping(value = "/blog")
	public String listBlogs(Model model, @RequestParam(value = "page", required = false) Integer page) {
		Client client = Client.create();
		Gson gson = new Gson();
		Integer status = 1;
		page = page == null ? 1 : page;
		
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/blogService/getList/" + status + "/" + page);
		String data = webResource.get(String.class);
		GenericType<List<BlogsDTO>> listType = new GenericType<List<BlogsDTO>>() {};
		List<BlogsDTO> listBlogs = gson.fromJson(data, listType.getType());
		
		webResource = client.resource("http://localhost:8080/WebService/rest/blogService/getAll/" + status);
		data = webResource.get(String.class);
		listType = new GenericType<List<BlogsDTO>>() {};
		List<BlogsDTO> listAllBlogs = gson.fromJson(data, listType.getType());
		
		Integer countPage = listAllBlogs.size();
		Integer totalPage = countPage / 6;
        if (countPage % 6 != 0) {
        	totalPage++;
        }
        
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("page", page);
		model.addAttribute("listBlogs", listBlogs);
		model.addAttribute("config", getConfig(client, gson));
		
		return "customer/pages/blogs/blog";
	}
	
	@RequestMapping(value = "/blogDetail")
	public String blogDetail(Model model, @RequestParam("blogId")Integer blogId) {
		Client client = Client.create();
		Gson gson = new Gson();
		
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/blogService/getById/"+blogId);
		String res = webResource.get(String.class);
		BlogsDTO blog = gson.fromJson(res, BlogsDTO.class);
		model.addAttribute("blog", blog);
		
		model.addAttribute("config", getConfig(client, gson));
		
		return "customer/pages/blogs/blogDetail";
	}
}
