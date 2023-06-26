package bkap.controller.admin;

import java.util.Date;
import java.util.List;

import javax.websocket.server.PathParam;
import javax.ws.rs.core.GenericType;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.OrderDetailsDTO;
import bkap.entities.OrdersDTO;

@Controller
@RequestMapping(value = {"/admin"})
public class OrderControllerAdmin {
	
	//orderDerail
	
		@RequestMapping(value = { "/orderDerailManagement" })
		public String orderDerailManagement(@PathParam("id") Integer id,Model model , Client client) {
			WebResource webResource = client.resource("http://localhost:8080/WebService/rest/orderDetailService/getListOrderId/" + id);
			String data = webResource.get(String.class);
			
			Gson son = new Gson();
			
			/* OrderDetailsDTO ordeDetaDto = son.fromJson(data, OrderDetailsDTO.class); */
			GenericType<List<OrderDetailsDTO>> listType = new GenericType<List<OrderDetailsDTO>>() {};
			List<OrderDetailsDTO> orderDetail = son.fromJson(data, listType.getType());
			model.addAttribute("orderDetail", orderDetail);
			return "admin/pages/orderDerailManagement";
		}

	//order
		
		
		@RequestMapping(value = { "/orderManagement" })
		public String orderManagement(Model model, @ModelAttribute("a") OrdersDTO a) {
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/WebService/rest/orderService/getList");
			String data = webResource.get(String.class);

			Gson son = new Gson();
			GenericType<List<OrdersDTO>> listType = new GenericType<List<OrdersDTO>>() {
			};

			List<OrdersDTO> list = son.fromJson(data, listType.getType());
			OrdersDTO ordeDto = new OrdersDTO();
			model.addAttribute("Orders", ordeDto);
			model.addAttribute("list", list);
			return "admin/pages/orderManagement";
		}

		@RequestMapping(value = { "/updateStatus" })
		public String up(Model model, @ModelAttribute("a") OrdersDTO a, @RequestParam("id") Integer id) {

			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/WebService/rest/orderService/getById/" + id);
			String data = webResource.get(String.class);
			Gson son = new Gson();
			OrdersDTO order = son.fromJson(data, OrdersDTO.class);
			order.setStatus(a.getStatus());
			order.setUpdatedAt(new Date());
			Gson son2 = new Gson();
			String data2 = son2.toJson(order);
			Client client2 = Client.create();
			WebResource webResource2 = client2.resource("http://localhost:8080/WebService/rest/orderService/update");
			ClientResponse clientResponse2 = webResource2.type("application/json").post(ClientResponse.class, data2);
			String res2 = clientResponse2.getEntity(String.class);
			Boolean bl = son2.fromJson(res2, Boolean.class);
			if (bl) {
				return "redirect:/admin/orderManagement";
			} else {
				model.addAttribute("error", "Insert Failed!");
				model.addAttribute("a", a);
				return "redirect:/admin/orderManagement";
			}
		}

		@RequestMapping(value = { "/searchOrder" })
		public String searchOrder(@RequestParam("FullName") String fullName, Model model) {
			Client client = Client.create();
			Gson gson = new Gson();
			Integer status = 0;

			WebResource webResource = client.resource("http://localhost:8080/WebService/rest/orderService/getByName/" + fullName);
			String data = webResource.get(String.class);
			GenericType<List<OrdersDTO>> listtype = new GenericType<List<OrdersDTO>>() {};
			
			List<OrdersDTO> list = gson.fromJson(data, listtype.getType());
			OrdersDTO ordeDto = new OrdersDTO();
			model.addAttribute("Orders", ordeDto);
			model.addAttribute("list", list);
			return "admin/pages/orderManagement";
		}
}
