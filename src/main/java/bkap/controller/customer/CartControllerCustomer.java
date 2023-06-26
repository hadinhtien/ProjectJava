package bkap.controller.customer;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

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

import bkap.entities.CartsDTO;
import bkap.entities.ConfigsDTO;
import bkap.entities.ProductsDTO;

@Controller
public class CartControllerCustomer {
	
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

	public List<CartsDTO> getCartproIdaccId(Client client, Gson gson, Integer accId, Integer proId) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/cartService/check/" + accId + "/" + proId);
		String cart = webResource.get(String.class);
		GenericType<List<CartsDTO>> listtypecart = new GenericType<List<CartsDTO>>() {};
		List<CartsDTO> carts = gson.fromJson(cart, listtypecart.getType());
		return carts;
	}

	public CartsDTO getById(Client client, Gson gson, Integer cartId) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/cartService/getById/" + cartId);
		String data = webResource.get(String.class);
		CartsDTO carts = gson.fromJson(data, CartsDTO.class);
		return carts;
	}

	@RequestMapping(value = "/listCart")
	public String listCart(Model model, HttpSession session) {
		Client client = Client.create();
		Gson gson = new Gson();
		
		if(session.getAttribute("accId") != null) {
			Integer accId = (Integer) session.getAttribute("accId");
			WebResource webResource = client.resource("http://localhost:8080/WebService/rest/productService/getListAll");
			String data = webResource.get(String.class);
			GenericType<List<ProductsDTO>> listtype = new GenericType<List<ProductsDTO>>() {};
			List<ProductsDTO> products = gson.fromJson(data, listtype.getType());

			List<CartsDTO> cartsDTOs = getListCart(client, gson, accId);
            CartsDTO cartDTO = new CartsDTO();
			model.addAttribute("cart", cartDTO);
			model.addAttribute("products", products);
			model.addAttribute("carts", cartsDTOs);
			model.addAttribute("config", getConfig(client, gson));
			return "customer/pages/cart";
		} else {
			return "redirect:/login";
		}
	}

	@RequestMapping(value = "/insertcart")
	public String insertcart(@RequestParam("proId") Integer proId, @RequestParam("quantity") Integer quantitycart,
			RedirectAttributes redirAttrs, Model model, HttpSession session) 
	{
		Client client = Client.create();
		Gson gson = new Gson();
		
		if(session.getAttribute("accId") != null) {
			Integer accId = (Integer) session.getAttribute("accId");
			List<CartsDTO> listCart = getCartproIdaccId(client, gson, accId, proId);
			ProductsDTO dto = getByIdProduct(client, gson, proId);
			if (listCart.size() > 0) {
				Integer cartId = null;
				for (CartsDTO cartsDTO : listCart) {
					cartId = cartsDTO.getCartId();
				}
				CartsDTO cartsDTO = getById(client, gson, cartId);
				if(quantitycart <= 0 || quantitycart + cartsDTO.getQuantity() > dto.getQuantity()) {
					redirAttrs.addFlashAttribute("quantity", "The quantity does not match");
					return "redirect:/productDetail?proId="+proId;
				}							
				quantitycart += cartsDTO.getQuantity(); 			
				CartsDTO cartsDTO2 = new CartsDTO(cartId, accId, proId, quantitycart);
				String data = gson.toJson(cartsDTO2);
				WebResource webResource = client.resource("http://localhost:8080/WebService/rest/cartService/update");
				ClientResponse clientResponse = webResource.type("application/json").put(ClientResponse.class, data);
				String re = clientResponse.getEntity(String.class);
				boolean bt = gson.fromJson(re, boolean.class);
			} else {				
				if(quantitycart <= 0 || quantitycart > dto.getQuantity()) {
					redirAttrs.addFlashAttribute("quantity", "The quantity does not match");
					return "redirect:/productDetail?proId="+proId;
				}
				CartsDTO cartsDTO = new CartsDTO(0, accId, proId, quantitycart);
				String datacart = gson.toJson(cartsDTO);
				WebResource webResource = client.resource("http://localhost:8080/WebService/rest/cartService/insert");
				ClientResponse clientResponse = webResource.type("application/json").post(ClientResponse.class, datacart);
				String re = clientResponse.getEntity(String.class);
				boolean bt = gson.fromJson(re, boolean.class);
			}
		} else {
			return "redirect:/login";
		}
		return "redirect:/listCart";
	}
	@RequestMapping(value = "/updateCart")
	public String updateCart(@RequestParam("cartId") Integer[] cartId,@RequestParam("quantity") Integer[] quantity,RedirectAttributes redirAttrs, Model model) {
		Client client = Client.create();
		Gson gson = new Gson();
		List<Integer> listCartId = new ArrayList<Integer>();
		List<Integer> listCartId1 = new ArrayList<Integer>();
		for (int i = 0; i < cartId.length; i++) {
			for (int j = 0; j < quantity.length; j++) {
				if(i == j){
					CartsDTO cartsDTO = getById(client, gson, cartId[i]);
					ProductsDTO dto = getByIdProduct(client, gson, cartsDTO.getProId());
					if(dto.getStatus() == 3 || dto.getStatus() == 2) {
						listCartId1.add(cartId[i]);
						redirAttrs.addFlashAttribute("statusProduct", "Product does not exist");
					}else if (quantity[j] <= 0) {
						WebResource webResource1 = client.resource("http://localhost:8080/WebService/rest/cartService/delete/"+cartId[i]);
						String data1 = webResource1.type("application/json").delete(String.class);
					}else{												
						if(quantity[j] > dto.getQuantity()) {
							listCartId.add(cartId[i]);
 						    redirAttrs.addFlashAttribute("quantity", "There are only");
						}else {
							CartsDTO cartsDTO2 = new CartsDTO(cartId[i], cartsDTO.getAccId(), cartsDTO.getProId(), quantity[j]);				
						    String data = gson.toJson(cartsDTO2);
						    WebResource webResource = client.resource("http://localhost:8080/WebService/rest/cartService/update");
							ClientResponse clientResponse = webResource.type("application/json").put(ClientResponse.class, data);
							String re = clientResponse.getEntity(String.class);
							boolean bt = gson.fromJson(re, boolean.class);
						}					
					}					
				}
			} 			
		}
		redirAttrs.addFlashAttribute("listCartIds",listCartId);
		redirAttrs.addFlashAttribute("listCartId1",listCartId1);
		return "redirect:/listCart";
	}
	
	@RequestMapping(value = "/deleteCart")
	public String deleteCart(@RequestParam("cartId") Integer cartId,Model model) {
		Client client = new Client();
		Gson gson = new Gson();
		WebResource webResource1 = client.resource("http://localhost:8080/WebService/rest/cartService/delete/"+cartId);
		String data1 = webResource1.type("application/json").delete(String.class);
	    boolean bl = gson.fromJson(data1,boolean.class);
	    return "redirect:/listCart";
	}
}
