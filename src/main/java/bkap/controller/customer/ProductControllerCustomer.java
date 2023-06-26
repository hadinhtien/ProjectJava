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

import bkap.entities.BrandsDTO;
import bkap.entities.CategoriesDTO;
import bkap.entities.ConfigsDTO;
import bkap.entities.Product_imagesDTO;
import bkap.entities.ProductsDTO;

@Controller
public class ProductControllerCustomer {
	
	public ConfigsDTO getConfig(Client client, Gson gson) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/configService/getConfig"); 
		String data = webResource.get(String.class); 
		ConfigsDTO config = gson.fromJson(data,ConfigsDTO.class);
		return config;
	}
	
	public List<CategoriesDTO> getListCategories(Client client, Gson gson, Integer status) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/categoryService/getList/" + status);
		String data = webResource.get(String.class);
		GenericType<List<CategoriesDTO>> listCategoryType = new GenericType<List<CategoriesDTO>>() {};
		List<CategoriesDTO> listCategories = gson.fromJson(data, listCategoryType.getType());
		return listCategories;
	}

	public List<BrandsDTO> getListBrands(Client client, Gson gson) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/brandService/getList");
		String data = webResource.get(String.class);
		GenericType<List<BrandsDTO>> listBrandType = new GenericType<List<BrandsDTO>>() {};
		List<BrandsDTO> listBrands = gson.fromJson(data, listBrandType.getType());
		return listBrands;
	}
	
	public List<Product_imagesDTO> getListProduct_images(Client client, Gson gson, Integer id) {
		WebResource WebResource = client.resource("http://localhost:8080/WebService/rest/product_imageService/getByProId/" + id);
		String data = WebResource.get(String.class);
		GenericType<List<Product_imagesDTO>> listProduct_imageType = new GenericType<List<Product_imagesDTO>>() {};
		List<Product_imagesDTO> listProduct_images = gson.fromJson(data, listProduct_imageType.getType());
		return listProduct_images;
	}
	
	@RequestMapping(value = "/productDetail")
	public String detailProduct(@RequestParam("proId") Integer id ,Model model) {
		Client client = Client.create();
		Gson gson = new Gson();
		Integer status = 0;
		
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/productService/getById/" + id);
		String data = webResource.get(String.class);
		ProductsDTO product = gson.fromJson(data, ProductsDTO.class);
		
        model.addAttribute("product", product);
        model.addAttribute("categories", getListCategories(client, gson, status));
		model.addAttribute("brands", getListBrands(client, gson));
		model.addAttribute("productimages", getListProduct_images(client, gson, id));
		model.addAttribute("config", getConfig(client, gson));
        
		return "customer/pages/product";
	}
}
