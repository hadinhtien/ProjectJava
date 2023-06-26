package bkap.controller.customer;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.ws.rs.PathParam;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.GenericType;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.ConfigsDTO;
import bkap.entities.OrderDetailsDTO;
import bkap.entities.OrdersDTO;
import bkap.entities.ProductsDTO;

@Controller
public class PurchaseControllerCustomer {
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sf, false));
	}
	
	public ConfigsDTO getConfig(Client client, Gson gson) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/configService/getConfig"); 
		String res = webResource.get(String.class); 
		ConfigsDTO config = gson.fromJson(res,ConfigsDTO.class);
		return config;
	}
	
	public List<OrderDetailsDTO> getOrderDetail(Client client, Gson gson,Integer accId,Integer status) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/orderDetailService/getList/"+ accId + "/" + status);
		String orderDetail = webResource.get(String.class);
		GenericType<List<OrderDetailsDTO>> listtype = new GenericType<List<OrderDetailsDTO>>() {};
		List<OrderDetailsDTO> orderDetails = gson.fromJson(orderDetail, listtype.getType());
		return orderDetails;
	}
	
	public ProductsDTO getByIdProduct(Client client, Gson gson, Integer proId) {
		WebResource webResource2 = client.resource("http://localhost:8080/WebService/rest/productService/getById/" + proId);
		String data = webResource2.get(String.class);
		ProductsDTO productsDTO = gson.fromJson(data, ProductsDTO.class);
		return productsDTO;
	}
	
	public OrdersDTO getByIdOrder(Client client, Gson gson, Integer orderId) {
		WebResource webResource2 = client.resource("http://localhost:8080/WebService/rest/orderService/getById/" + orderId);
		String data = webResource2.get(String.class);
		OrdersDTO ordersDTO = gson.fromJson(data, OrdersDTO.class);
		return ordersDTO;
	}
	
	public List<OrderDetailsDTO> getListOrderId(Client client, Gson gson,Integer orderId) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/orderDetailService/getListOrderId/"+ orderId);
		String orderDetail = webResource.get(String.class);
		GenericType<List<OrderDetailsDTO>> listtype = new GenericType<List<OrderDetailsDTO>>() {};
		List<OrderDetailsDTO> orderDetails = gson.fromJson(orderDetail, listtype.getType());
		return orderDetails;
	}
	
	public List<ProductsDTO> getProducts(Client client, Gson gson) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/productService/getListAll");
		String data = webResource.get(String.class);
		GenericType<List<ProductsDTO>> listtype = new GenericType<List<ProductsDTO>>() {};
		List<ProductsDTO> products = gson.fromJson(data, listtype.getType());
		return products;
	}
	
	public List<OrdersDTO> getOrder(Client client, Gson gson,Integer accId,Integer status) {
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/orderService/getList/"+ accId + "/" + status);
		String orderDetail = webResource.get(String.class);
		GenericType<List<OrdersDTO>> listtype = new GenericType<List<OrdersDTO>>() {};
		List<OrdersDTO> orderDetails = gson.fromJson(orderDetail, listtype.getType());
		return orderDetails;
	}
	
	@RequestMapping(value = "/theOrder")
	public String purchase(Model model,HttpSession session) {
		Client client = Client.create();
		Gson gson = new Gson();
		if(session.getAttribute("accId") != null) {
			Integer accId = (Integer) session.getAttribute("accId");
			
			List<OrdersDTO> ordersDTO_1 = getOrder(client, gson, accId, 1);
			List<OrdersDTO> ordersDTO_2 = getOrder(client, gson, accId, 2);
			List<OrdersDTO> ordersDTO_3 = getOrder(client, gson, accId, 3);
			List<OrdersDTO> ordersDTO_0 = getOrder(client, gson, accId, 0);
			
			List<OrderDetailsDTO> OrderDetailStatus_1  = getOrderDetail(client, gson, accId, 1);
			List<OrderDetailsDTO> OrderDetailStatus_2  = getOrderDetail(client, gson, accId, 2);
			List<OrderDetailsDTO> OrderDetailStatus_3  = getOrderDetail(client, gson, accId, 3);
			List<OrderDetailsDTO> OrderDetailStatus_0  = getOrderDetail(client, gson, accId, 0);
			List<ProductsDTO> productsDTOs = getProducts(client, gson);
			
			model.addAttribute("ordersDTO_1", ordersDTO_1);
			model.addAttribute("ordersDTO_2", ordersDTO_2);
			model.addAttribute("ordersDTO_3", ordersDTO_3);
			model.addAttribute("ordersDTO_0", ordersDTO_0);
			model.addAttribute("OrderDetailStatus_1", OrderDetailStatus_1);
			model.addAttribute("OrderDetailStatus_2", OrderDetailStatus_2);
			model.addAttribute("OrderDetailStatus_3", OrderDetailStatus_3);
			model.addAttribute("OrderDetailStatus_0", OrderDetailStatus_0);
			model.addAttribute("products", productsDTOs);
			model.addAttribute("config", getConfig(client, gson));
			return "customer/pages/theOrder";			
		}else {
			return "redirect:/login";
		}
	}
	
	@RequestMapping(value = "/CancelOrder")
	public String CancelOrder(@PathParam("id") Integer id, Model model,HttpSession session) {
		Client client = Client.create();
		Gson gson = new Gson();
		if(session.getAttribute("accId") != null) {
			Integer accId = (Integer) session.getAttribute("accId");
			List<OrderDetailsDTO> detailsDTOs = getListOrderId(client, gson, id);
		    for (OrderDetailsDTO orderDetailsDTO : detailsDTOs) {
				 ProductsDTO dto = getByIdProduct(client, gson, orderDetailsDTO.getProId());
				 Integer quantity = dto.getQuantity() + orderDetailsDTO.getQuantity();						 
				 dto.setQuantity(quantity);
				 String data = gson.toJson(dto);
					WebResource webResource = client.resource("http://localhost:8080/WebService/rest/productService/update");
					ClientResponse clientResponse = webResource.type("application/json").put(ClientResponse.class, data);
					String re = clientResponse.getEntity(String.class);
					boolean bt = gson.fromJson(re, boolean.class);
			}		    
		    OrdersDTO ordersDTO = getByIdOrder(client, gson, id);	    
		    ordersDTO.setStatus(0);
		    ordersDTO.setUpdatedAt(new Date());
		    String data = gson.toJson(ordersDTO);
			WebResource webResource = client.resource("http://localhost:8080/WebService/rest/orderService/update");
			ClientResponse clientResponse = webResource.type("application/json").put(ClientResponse.class, data);
			String re = clientResponse.getEntity(String.class);
			boolean bt = gson.fromJson(re, boolean.class);		    
			return "redirect:/theOrder";		
		}else {
			return "redirect:/login";
		}
	}
}
