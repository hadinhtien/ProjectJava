package bkap.controller.admin;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.StandardOpenOption;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.websocket.server.PathParam;
import javax.ws.rs.core.GenericType;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.BrandsDTO;

@Controller
@RequestMapping(value = {"/admin"})
public class BrandControllerAdmin {
	@RequestMapping(value = { "/brandManagement" })
	public String brandManagement(Model model) {
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/brandService/getList");
		String data = webResource.get(String.class);

		Gson son = new Gson();
		GenericType<List<BrandsDTO>> listType = new GenericType<List<BrandsDTO>>() {
		};

		List<BrandsDTO> list = son.fromJson(data, listType.getType());
		BrandsDTO brandDto = new BrandsDTO();
		model.addAttribute("Brand", brandDto);
		model.addAttribute("list", list);
		return "admin/pages/brandManagement";
	}

	@RequestMapping(value = { "/insertBrand" })
	public String insertBrand(@Valid @ModelAttribute("Brand") BrandsDTO b, BindingResult result,
			@RequestParam("img") MultipartFile multipartFile, Model model, HttpServletRequest request) throws UnsupportedEncodingException {
		Gson gson = new Gson();
		Client client = Client.create();
		if (result.hasErrors()) {
			WebResource webResource = client.resource("http://localhost:8080/WebService/rest/brandService/getList");
			String data = webResource.get(String.class);
			GenericType<List<BrandsDTO>> listtype = new GenericType<List<BrandsDTO>>() {};
			List<BrandsDTO> list = gson.fromJson(data, listtype.getType());
			model.addAttribute("list", list);
			return "admin/pages/brandManagement";
		} else {
			Client client1 = new Client();
			String name = b.getName();
			WebResource webResource1 = client1.resource("http://localhost:8080/WebService/rest/brandService/checkUnique/"+ URLEncoder.encode(name,"UTF-8"));
			String data1 = webResource1.get(String.class);
			GenericType<List<BrandsDTO>> listtype1 = new GenericType<List<BrandsDTO>>() {
			};
			List<BrandsDTO> list1 = gson.fromJson(data1, listtype1.getType());

			if (list1.size() == 0) {
				Date date = new Date();
				b.setCreatedAt(date);
				
				String path = request.getServletContext().getRealPath("resources/image");
				File f = new File(path);
				File dest = new File(f.getAbsolutePath() + "/" + multipartFile.getOriginalFilename());
				if (!dest.exists()) {
					try {
						Files.write(dest.toPath(), multipartFile.getBytes(), StandardOpenOption.CREATE);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				
				b.setImageUrl(multipartFile.getOriginalFilename());
				String data2 = gson.toJson(b);
				WebResource webResource2 = client
						.resource("http://localhost:8080/WebService/rest/brandService/insert");
				ClientResponse clientResponse = webResource2.type("application/json").post(ClientResponse.class, data2);
				String re = clientResponse.getEntity(String.class);
				boolean bt = gson.fromJson(re, boolean.class);
				if (bt) {
					model.addAttribute("success", "Create brand successfully");
					return "redirect:/admin/brandManagement";
				} else {
					model.addAttribute("errors", "Create brand failed");
					return "redirect:/admin/brandManagement";
				}
			} else {
				WebResource webResource = client.resource("http://localhost:8080/WebService/rest/brandService/getList");
				String data = webResource.get(String.class);
				GenericType<List<BrandsDTO>> listtype = new GenericType<List<BrandsDTO>>() {};
				List<BrandsDTO> list = gson.fromJson(data, listtype.getType());
				model.addAttribute("list", list);
				model.addAttribute("uniquename", "Name category already exists");
				return "redirect:/admin/brandManagement";
			}

		}

	}

	@RequestMapping(value = { "/initBrand" })
	public String initBrand(@PathParam("id") Integer id, Model model) {
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/brandService/getById/" + id);
		String data = webResource.get(String.class);

		Gson son = new Gson();
		BrandsDTO brand = son.fromJson(data, BrandsDTO.class);
		model.addAttribute("brand", brand);
		model.addAttribute("name1", brand.getName());
		return "admin/pages/brandUpdateManagement";
	}

	@RequestMapping(value = { "/brandUpdateManagement" })
	public String brandUpdateManagement(@Valid @ModelAttribute("Brands") BrandsDTO brandsDTO, BindingResult result,
			@RequestParam("img") MultipartFile multipartFile, @RequestParam("name1") String name1,
			HttpServletRequest request, Model model) throws UnsupportedEncodingException {
		String a = multipartFile.getOriginalFilename();
		Gson son = new Gson();
		if (result.hasErrors()) {
			model.addAttribute("Brands", brandsDTO);
			return "redirect:/admin/brandUpdateManagement";
		} else {
			String path = request.getServletContext().getRealPath("resources/image/");
			File f = new File(path);
			if (!f.exists()) {
				f.mkdir();
			}
			File dest = new File(f.getAbsolutePath() + "/" + multipartFile.getOriginalFilename());
			if (!dest.exists()) {
				try {
					Files.write(dest.toPath(), multipartFile.getBytes(), StandardOpenOption.CREATE);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (a.length() > 0) {
				brandsDTO.setImageUrl(multipartFile.getOriginalFilename());
			}
			 
			
			if (brandsDTO.getName().equals(name1)) {
				String data = son.toJson(brandsDTO);

				Client client = Client.create();
				WebResource resource = client.resource("http://localhost:8080/WebService/rest/brandService/update");
				ClientResponse clientResponse = resource.type("application/json").put(ClientResponse.class, data);
				String res = clientResponse.getEntity(String.class);
				Boolean check = son.fromJson(res, Boolean.class);

				if (check) {
					model.addAttribute("success", "Update success");
					return "redirect:/admin/brandManagement";
				} else {
					model.addAttribute("error", "Update False !");
					model.addAttribute("b", brandsDTO);
					return "redirect:/admin/brandUpdateManagement";
				}
			} else {				
				String data0 = son.toJson(brandsDTO);
				String name = brandsDTO.getName();
				Client client1 = Client.create();
				name = URLEncoder.encode(name,"UTF-8");
				WebResource webResource1 = client1
						.resource("http://localhost:8080/WebService/rest/brandService/checkUnique/"+name );
				String data1 = webResource1.get(String.class);
				GenericType<List<BrandsDTO>> listtype1 = new GenericType<List<BrandsDTO>>() {};
				List<BrandsDTO> list1 = son.fromJson(data1, listtype1.getType());
				//ClientResponse clientResponse = webResource1.type("application/json").put(ClientResponse.class, data0);
				
				brandsDTO.setImageUrl(multipartFile.getOriginalFilename());
				
				if (list1==null || list1.size() == 0  ) {
					String data2 = son.toJson(brandsDTO);
					Client client = Client.create();
					WebResource resource = client.resource("http://localhost:8080/WebService2/rest/brandService/update");
					ClientResponse clientResponse1 = resource.type("application/json").put(ClientResponse.class, data2);
					String res = clientResponse1.getEntity(String.class);
					Boolean check = son.fromJson(res, Boolean.class);

					if (check) {
						model.addAttribute("success", "Update success");
						return "redirect:/admin/brandManagement";
					} else {
						model.addAttribute("error", "Update False !");
						model.addAttribute("b", brandsDTO);
						model.addAttribute("uniquename", "Name brand already exists");
						model.addAttribute("name1", name1);
						return "redirect:/admin/brandUpdateManagement";
					}
				} else {					
					String data = son.toJson(brandsDTO);

					Client client = Client.create();
					WebResource resource = client.resource("http://localhost:8080/WebService/rest/brandService/update");
					ClientResponse clientResponse2 = resource.type("application/json").put(ClientResponse.class, data);
					String res = clientResponse2.getEntity(String.class);
					Boolean check = son.fromJson(res, Boolean.class);

					if (check) {
						model.addAttribute("success", "Update success");
						return "redirect:/admin/brandManagement";
					} else {
						model.addAttribute("error", "Update False !");
						model.addAttribute("b", brandsDTO);
						model.addAttribute("uniquename", "Name brand already exists");
						model.addAttribute("name1", name1);
						return "redirect:/admin/brandUpdateManagement";
					}
				}
			}
		}

	}

	@RequestMapping(value = { "/deleteBrand" })
	public String deleteBrand(@RequestParam("id") Integer id, Model model) {
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/brandService/delete/" + id);
		String data = webResource.type("application/json").delete(String.class);

		Gson son = new Gson();
		Boolean bl = son.fromJson(data, Boolean.class);
		if (bl) {
			model.addAttribute("success", "Delete successfully!");
			return "redirect:/admin/brandManagement";
		} else {
			return "redirect:/admin/brandManagement";
		}

	}
}
