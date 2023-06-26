package bkap.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.GenericType;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.AccountsDTO;
import bkap.entities.BrandsDTO;
import bkap.entities.CategoriesDTO;
import bkap.entities.OrderDetailsDTO;
import bkap.entities.ProductsDTO;

@Controller
@RequestMapping(value = {"/admin"})
public class AdminController {	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sf, false));
	}
	
	public List<CategoriesDTO> getListCategories(Client client, Gson gson, Integer status) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/categoryService/getList/" + status);
		String category = webResource.get(String.class);
		GenericType<List<CategoriesDTO>> listtypecategory = new GenericType<List<CategoriesDTO>>() {};
		List<CategoriesDTO> categories = gson.fromJson(category, listtypecategory.getType());
		return categories;
	}

	public List<BrandsDTO> getListBrands(Client client, Gson gson) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/brandService/getList");
		String data = webResource.get(String.class);
		Gson son = new Gson();
		GenericType<List<BrandsDTO>> listType = new GenericType<List<BrandsDTO>>() {
		};
		List<BrandsDTO> brands = son.fromJson(data, listType.getType());
		return brands;
	}
	
	public List<ProductsDTO> getListProucts(Client client, Gson gson) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/productService/getListStatus");
		String data = webResource.get(String.class);
		GenericType<List<ProductsDTO>> listProductType = new GenericType<List<ProductsDTO>>() {};
		List<ProductsDTO> listProducts = gson.fromJson(data, listProductType.getType());
		return listProducts;
	}
	
	public List<ProductsDTO> getListAllProduct(Client client, Gson gson) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/productService/getList");
		String data = webResource.get(String.class);
		GenericType<List<ProductsDTO>> listProductType = new GenericType<List<ProductsDTO>>() {};
		List<ProductsDTO> listProducts = gson.fromJson(data, listProductType.getType());
		return listProducts;
	}
	
	public List<OrderDetailsDTO> getOrderDetail(Client client, Gson gson,Integer status) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/orderDetailService/getListStatus/" + status);
		String orderDetail = webResource.get(String.class);
		GenericType<List<OrderDetailsDTO>> listtype = new GenericType<List<OrderDetailsDTO>>() {};
		List<OrderDetailsDTO> orderDetails = gson.fromJson(orderDetail, listtype.getType());
		return orderDetails;
	}
	
	public List<OrderDetailsDTO> getOrderDetailCreatedAt(Client client, Gson gson,Date createdAt) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/orderDetailService/getListCreatedAt/" + createdAt);
		String orderDetail = webResource.get(String.class);
		GenericType<List<OrderDetailsDTO>> listtype = new GenericType<List<OrderDetailsDTO>>() {};
		List<OrderDetailsDTO> orderDetails = gson.fromJson(orderDetail, listtype.getType());
		return orderDetails;
	}
	
	public List<AccountsDTO> getAcconunts(Client client, Gson gson){
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/accountService/getList");
		String accounts = webResource.get(String.class);
		GenericType<List<AccountsDTO>> listtype = new GenericType<List<AccountsDTO>>() {};
		List<AccountsDTO> orderDetails = gson.fromJson(accounts, listtype.getType());
		return orderDetails;
	}
		
	@RequestMapping(value = {"/dashboard"})
	public String admin(Model model, HttpSession session) {
		Client client = Client.create();
		Gson gson = new Gson();
        model.addAttribute("listProducts", getListProucts(client, gson).size());
        model.addAttribute("listCategorys", getListCategories(client, gson,0).size());
        model.addAttribute("listBrands", getListBrands(client, gson).size());
        model.addAttribute("listOrderDetails", getOrderDetail(client, gson, 1).size());
        model.addAttribute("Products", getListAllProduct(client, gson));
        model.addAttribute("accounts", getAcconunts(client, gson).size());
        
        long millis=System.currentTimeMillis();  
        java.sql.Date date=new java.sql.Date(millis);  
       
        model.addAttribute("getOrderDetailStatus_1", getOrderDetailCreatedAt(client, gson,date));
		return "admin/pages/index";
	}
	
}
