package bkap.controller.customer;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.GenericType;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.CartsDTO;
import bkap.entities.ConfigsDTO;
import bkap.entities.OrderDetailsDTO;
import bkap.entities.OrdersDTO;
import bkap.entities.ProductsDTO;

@Controller
public class CheckOutControllerCustomer {
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sf, false));
	}
	
	public ConfigsDTO getConfig(Client client, Gson gson) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/configService/getConfig"); 
		String data = webResource.get(String.class); 
		ConfigsDTO config = gson.fromJson(data,ConfigsDTO.class);
		return config;
	}
	
	public List<CartsDTO> getListCart(Client client, Gson gson, Integer accId) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/cartService/getList/" + accId);
		String cart = webResource.get(String.class);
		GenericType<List<CartsDTO>> listtypecart = new GenericType<List<CartsDTO>>() {};
		List<CartsDTO> carts = gson.fromJson(cart, listtypecart.getType());
		return carts;
	}
	
	public ProductsDTO getByIdProduct(Client client, Gson gson, Integer proId) {
		WebResource webResource2 = client.resource("http://localhost:8080/WebService/rest/productService/getById/" + proId);
		String data = webResource2.get(String.class);
		ProductsDTO productsDTO = gson.fromJson(data, ProductsDTO.class);
		return productsDTO;
	}
	
	@RequestMapping(value = {"checkOut"})
     public String checkout(Model model, HttpSession session, RedirectAttributes redirAttrs) {
		Client client = Client.create();
		Gson gson = new Gson();
		if(session.getAttribute("accId") != null) {
			Integer accId = (Integer) session.getAttribute("accId");
			List<CartsDTO> cartsDTOs = getListCart(client, gson, accId);
			List<Integer> listCartId = new ArrayList<Integer>();
			List<Integer> listCartId1 = new ArrayList<Integer>();
			for (CartsDTO cartsDTO : cartsDTOs) {
				ProductsDTO dto = getByIdProduct(client, gson, cartsDTO.getProId());
				if(cartsDTO.getQuantity() > dto.getQuantity()) {
					listCartId.add(cartsDTO.getCartId());
				}
			}
			
			for (CartsDTO cartsDTO : cartsDTOs) {
				ProductsDTO dto = getByIdProduct(client, gson, cartsDTO.getProId());
				if(dto.getStatus() == 3 || dto.getStatus() == 2) {
					listCartId1.add(cartsDTO.getCartId());
				}
			}
			
			if(listCartId1.size() > 0) {
				redirAttrs.addFlashAttribute("statusProduct", "Product does not exist");
				redirAttrs.addFlashAttribute("listCartId1",listCartId1);
				return "redirect:/listCart";
			}else if (listCartId.size() > 0) {
				redirAttrs.addFlashAttribute("quantity", "There are only");
				redirAttrs.addFlashAttribute("listCartIds",listCartId);
				return "redirect:/listCart";
			}
			else {
				
				WebResource webResource = client.resource("http://localhost:8080/WebService/rest/productService/getList");
				String data = webResource.get(String.class);
				GenericType<List<ProductsDTO>> listtype = new GenericType<List<ProductsDTO>>() {};
				List<ProductsDTO> products = gson.fromJson(data, listtype.getType());
				model.addAttribute("products", products);
				
				model.addAttribute("carts", cartsDTOs);
				
				OrdersDTO ordersDTO = new OrdersDTO();
				model.addAttribute("order", ordersDTO);
			
				Double Total = (double) 0;
				
				for (CartsDTO cartsDTO : cartsDTOs) {
					Double TotalPrice = (double) (getByIdProduct(client, gson, cartsDTO.getProId()).getPrice() - getByIdProduct(client, gson, cartsDTO.getProId()).getDiscount()) * cartsDTO.getQuantity();
					Total = (double) Total + TotalPrice; 
				}		
				model.addAttribute("total", Total);
				model.addAttribute("config", getConfig(client, gson));
				
				return "customer/pages/checkOut";
			}
			
		} else {
			return "redirect:/login";
		}	
	}
	
	@RequestMapping(value = { "/doCheckOut" })
	public String insertProduct(@Valid @ModelAttribute("order") OrdersDTO ordersDTO, BindingResult result, RedirectAttributes redirAttrs, Model model, HttpSession session) {
		Client client = Client.create();
		Gson gson = new Gson();
		
		if(session.getAttribute("accId") != null) {
			Integer accId = (Integer) session.getAttribute("accId");
			if(result.hasErrors()) {
				WebResource webResource = client.resource("http://localhost:8080/WebService/rest/productService/getList");
				String data = webResource.get(String.class);
				GenericType<List<ProductsDTO>> listtype = new GenericType<List<ProductsDTO>>() {};
				List<ProductsDTO> products = gson.fromJson(data, listtype.getType());
				model.addAttribute("products", products);
				
				List<CartsDTO> cartsDTOs = getListCart(client, gson, accId);
				model.addAttribute("carts", cartsDTOs);
				model.addAttribute("order", ordersDTO);
			
				Double Total = (double) 0;
				for (CartsDTO cartsDTO : cartsDTOs) {
					Double TotalPrice = (double) (getByIdProduct(client, gson, cartsDTO.getProId()).getPrice()
							- getByIdProduct(client, gson, cartsDTO.getProId()).getDiscount()) * cartsDTO.getQuantity();
					Total   =  (double) Total + TotalPrice; 
				}		
				model.addAttribute("total", Total);
				model.addAttribute("config", getConfig(client, gson));
				
				return "customer/pages/checkOut";	
			} else { 				
				List<CartsDTO> cartsDTOs = getListCart(client, gson, accId);
				List<Integer> listCartId = new ArrayList<Integer>();
				
					Double Total = (double) 0;
					for (CartsDTO cartsDTO : cartsDTOs) {
						Double TotalPrice = (double) (getByIdProduct(client, gson, cartsDTO.getProId()).getPrice()
								- getByIdProduct(client, gson, cartsDTO.getProId()).getDiscount()) * cartsDTO.getQuantity();
						Total   =  (double) Total + TotalPrice; 
					}
					OrdersDTO Order = new OrdersDTO(0, accId, ordersDTO.getFullName(), ordersDTO.getAddress(), ordersDTO.getPhone(), ordersDTO.getNote(),Total, 1, new Date(), null);
					String data = gson.toJson(Order);
					WebResource webResource = client.resource("http://localhost:8080/WebService/rest/orderService/insert");
					ClientResponse clientResponse = webResource.type("application/json").post(ClientResponse.class, data);
					String re = clientResponse.getEntity(String.class);
					OrdersDTO dto = gson.fromJson(re, OrdersDTO.class);
					if(dto != null) {
						for (CartsDTO cartsDTO : cartsDTOs) {
							Double Price = (double) (getByIdProduct(client, gson, cartsDTO.getProId()).getPrice()
									- getByIdProduct(client, gson, cartsDTO.getProId()).getDiscount()) * cartsDTO.getQuantity();
							OrderDetailsDTO orderDetailsDTO = new OrderDetailsDTO(0, dto.getOrderId(), cartsDTO.getProId(), cartsDTO.getQuantity(), Price);
							data = gson.toJson(orderDetailsDTO);
							webResource = client.resource("http://localhost:8080/WebService/rest/orderDetailService/insert");
							clientResponse = webResource.type("application/json").post(ClientResponse.class, data);	
							
							ProductsDTO product = getByIdProduct(client, gson, cartsDTO.getProId());
							Integer quantity = product.getQuantity() - orderDetailsDTO.getQuantity();						 
							product.setQuantity(quantity);
							data = gson.toJson(product);
							webResource = client.resource("http://localhost:8080/WebService/rest/productService/update");
							clientResponse = webResource.type("application/json").put(ClientResponse.class, data);						
						}				
						for (CartsDTO cartsDTO : cartsDTOs) {
							WebResource webResource1 = client.resource("http://localhost:8080/WebService/rest/cartService/delete/"+cartsDTO.getCartId());
							String data1 = webResource1.type("application/json").delete(String.class);
						}					
					}
				return "redirect:/theOrder";		
			}		
		} else {
			return "redirect:/login";
		}
	}
}
