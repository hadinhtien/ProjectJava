package bkap.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.GenericType;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.CategoriesDTO;
import bkap.entities.ProductsDTO;

@Controller
@RequestMapping(value = "/admin")
public class CategoryControllerAdmin {
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sf, false));
	}
	
	public List<CategoriesDTO> getCategories(Client client, Gson gson, Integer status){
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/categoryService/getList/" + status);
		String data = webResource.get(String.class);	
		GenericType<List<CategoriesDTO>> listtype = new GenericType<List<CategoriesDTO>>() {};
		List<CategoriesDTO> list = gson.fromJson(data, listtype.getType());
		return list;
	}
	
	@RequestMapping("/categoryManagement")
	public String categoryManagement(Model model) {
		Client client = Client.create();
		Gson gson = new Gson();
		Integer status = 0;
		
		CategoriesDTO category = new CategoriesDTO();

		model.addAttribute("category", category);
		model.addAttribute("list", getCategories(client, gson, status));
		return "admin/pages/category/categoryManagement";
	}

	@RequestMapping("/createCategory")
	private String createCategory(@Valid @ModelAttribute("category") CategoriesDTO categoriesDTO, BindingResult result, RedirectAttributes redirAttrs, Model model) {
		Client client = Client.create();
		Gson gson = new Gson();
		Integer status = 0;
		
		if (result.hasErrors()) {			
			model.addAttribute("list", getCategories(client, gson, status));
			return "admin/pages/category/categoryManagement";
		} else {			
			boolean checkname = true;
			List<CategoriesDTO> categoriesDTOs = getCategories(client, gson, status);
			for (CategoriesDTO categoriesDTO2 : categoriesDTOs) {			
				if(categoriesDTO2.getName().equals(categoriesDTO.getName())) {
					checkname = false;
				}
			}
			if(checkname) {				
				categoriesDTO.setCreatedAt(new Date());
				String data2 = gson.toJson(categoriesDTO);
				WebResource webResource2 = client.resource("http://localhost:8080/WebService/rest/categoryService/insert");
				ClientResponse clientResponse = webResource2.type("application/json").post(ClientResponse.class, data2);
				String re = clientResponse.getEntity(String.class);
				boolean bt = gson.fromJson(re, boolean.class);
				if (bt) {
					redirAttrs.addFlashAttribute("success", "Successfully added new");
					return "redirect:/admin/categoryManagement";					
				} else {
					redirAttrs.addFlashAttribute("errors", "Add failed");
					return "redirect:/admin/categoryManagement";
				}
			}else {
				redirAttrs.addFlashAttribute("uniquename", "Name category already exists");
				return "redirect:/admin/categoryManagement";
			}
		}
	}
	
	@RequestMapping("/getByIdCategory")
	public String getByIdCategory(@RequestParam("CateId") Integer id, Model model) {
		Client client = new Client();
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/categoryService/getById/"+id);
		String data = webResource.get(String.class);
		Gson gson = new Gson();
	    CategoriesDTO category = gson.fromJson(data, CategoriesDTO.class);
	    model.addAttribute("category", category);
	    model.addAttribute("name1", category.getName());
	    return "admin/pages/category/updateCategory";
	}
	
	@RequestMapping("/updateCategory")
	private String updateCategory(@Valid @ModelAttribute("category") CategoriesDTO categoriesDTO, BindingResult result,@RequestParam("name1") String name1,
			RedirectAttributes redirAttrs ,Model model) {
		Gson gson = new Gson();
		Client client = Client.create();
		if (result.hasErrors()) {
		    model.addAttribute("category", categoriesDTO);
			return "admin/pages/category/updateCategory";
		} else {
			if(categoriesDTO.getName().equals(name1)) {				
				String data = gson.toJson(categoriesDTO);
				WebResource webResource = client.resource("http://localhost:8080/WebService/rest/categoryService/update");
				ClientResponse clientResponse = webResource.type("application/json").put(ClientResponse.class, data);
				String re = clientResponse.getEntity(String.class);
				boolean bt = gson.fromJson(re, boolean.class);
				if (bt) {
					redirAttrs.addFlashAttribute("success", "Update Successfully");
					return "redirect:/admin/categoryManagement";
				} else {
					redirAttrs.addFlashAttribute("errors", "Update failed");
					return "redirect:/admin/categoryManagement";
				}
			}else {
				boolean checkname = true;
				Integer status = 0;
				List<CategoriesDTO> categoriesDTOs = getCategories(client, gson, status);
				for (CategoriesDTO categoriesDTO2 : categoriesDTOs) {
					if(categoriesDTO2.getName().equals(categoriesDTO.getName())) {
						checkname = false;
					}
				}
				if(checkname) {
					String data = gson.toJson(categoriesDTO);					
					WebResource webResource = client.resource("http://localhost:8080/WebService/rest/categoryService/update");
					ClientResponse clientResponse = webResource.type("application/json").put(ClientResponse.class, data);
					String re = clientResponse.getEntity(String.class);
					boolean bt = gson.fromJson(re, boolean.class);
					if (bt) {
						redirAttrs.addFlashAttribute("success", "Update Successfully");
						return "redirect:/admin/categoryManagement";
					} else {
						redirAttrs.addFlashAttribute("errors", "Update failed");
						return "redirect:/admin/categoryManagement";											
					}
				}else {
					model.addAttribute("category", categoriesDTO);
					model.addAttribute("uniquename", "Name category already exists");
					model.addAttribute("name1", name1);
					return "admin/pages/category/updateCategory";
				}				
			}			
		}
	}
	
	@RequestMapping("/deleteCategory")
	public String deleteCategory(@RequestParam("CateId") Integer id,RedirectAttributes redirAttrs , Model model) {
		Client client = new Client();
		Gson gson = new Gson();		
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/categoryService/getByProduct/"+id);
		String data = webResource.get(String.class);			
		GenericType<List<ProductsDTO>> listtype = new GenericType<List<ProductsDTO>>() {};
		List<ProductsDTO> list = gson.fromJson(data, listtype.getType());
		if(list.size() == 0) {				
			WebResource webResource1 = client.resource("http://localhost:8080/WebService/rest/categoryService/delete/"+id);
			String data1 = webResource1.type("application/json").delete(String.class);
		    boolean bl = gson.fromJson(data1,boolean.class);
		    if(bl) {
				redirAttrs.addFlashAttribute("success", "Delete successful");
				return "redirect:/admin/categoryManagement";
		    }else {
				redirAttrs.addFlashAttribute("errors", "Deletion failed");
				return "redirect:/admin/categoryManagement";
		    }
		}else {			
			redirAttrs.addFlashAttribute("errors", "There are products in the catalog");
			return "redirect:/admin/categoryManagement";
		}   
	}
}
