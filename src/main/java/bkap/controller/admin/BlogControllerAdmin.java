package bkap.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardOpenOption;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.GenericType;
import com.sun.jersey.api.client.WebResource;

import bkap.entities.BlogsDTO;

@Controller
@RequestMapping(value = {"/admin"})
public class BlogControllerAdmin {
	
	@InitBinder
	public void initBinder(WebDataBinder data) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		data.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}
	
	@RequestMapping(value = "/listBlogs")
	public String listBlogs(Model model, @RequestParam(value = "page", required = false) Integer page) {
		Gson gson = new Gson();
		Client client = Client.create();
		Integer status = 0;
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
		return "admin/pages/blogs/listBlogs";
	}

	@RequestMapping(value = "/insertBlog")
	public String insertBlog(Model model) {
		BlogsDTO blog = new BlogsDTO();
		model.addAttribute("blog", blog);
		return "admin/pages/blogs/insertBlog";
	}

	@RequestMapping(value = "/doInsertBlog")
	public String doInsertBlog(@Valid @ModelAttribute("blog") BlogsDTO blog, BindingResult result, RedirectAttributes redirAttrs,
			@RequestParam("mainImagePath") MultipartFile mainImagePath,
			@RequestParam("secondImagePath") MultipartFile secondImagePath,
			@RequestParam("thirdImagePath") MultipartFile thirdImagePath, Model model, HttpServletRequest request) 
	{
		String path = request.getServletContext().getRealPath("assets/customer/img/blog");
		File f = new File(path);
		
		int flag = 0;
		if(mainImagePath.getOriginalFilename().length() == 0) {
			model.addAttribute("notMainImage", "Please choose main image.");
			flag++;
		}
		if(secondImagePath.getOriginalFilename().length() == 0) {
			model.addAttribute("notSecondImage", "Please choose second image.");
			flag++;
		}
		if (result.hasErrors()) {
			return "admin/pages/blogs/insertBlog";
		} else {
			if(flag != 0) {
				return "admin/pages/blogs/insertBlog";
			} else {
				File fileMain = new File(f.getAbsolutePath() + "/" + mainImagePath.getOriginalFilename());
				if (!fileMain.exists()) {
					try {
						Files.write(fileMain.toPath(), mainImagePath.getBytes(), StandardOpenOption.CREATE);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				blog.setMainImageUrl(mainImagePath.getOriginalFilename());
				
				File fileSecond = new File(f.getAbsolutePath() + "/" + secondImagePath.getOriginalFilename());
				if (!fileSecond.exists()) {
					try {
						Files.write(fileSecond.toPath(), secondImagePath.getBytes(), StandardOpenOption.CREATE);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				blog.setSecondImageUrl(secondImagePath.getOriginalFilename());
	
				if (thirdImagePath.getOriginalFilename().length() > 0) {
					File fileThird = new File(f.getAbsolutePath() + "/" + thirdImagePath.getOriginalFilename());
					if (!fileThird.exists()) {
						try {
							Files.write(fileThird.toPath(), thirdImagePath.getBytes(), StandardOpenOption.CREATE);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					blog.setThirdImageUrl(thirdImagePath.getOriginalFilename());
				}
	
				blog.setCreatedAt(new Date());
	
				Gson gson = new Gson();
				Client client = Client.create();
	
				String jsonBlog = gson.toJson(blog);
				WebResource webResource = client.resource("http://localhost:8080/WebService/rest/blogService/insert");
				ClientResponse clientResponse = webResource.type("application/json").post(ClientResponse.class, jsonBlog);
				String res = clientResponse.getEntity(String.class);
				boolean rs = gson.fromJson(res, boolean.class);
				
				if (rs) {
					redirAttrs.addFlashAttribute("blog", "Successfully added new");
				} else {
					redirAttrs.addFlashAttribute("blog", "Add failed");
				}
				return "redirect:/admin/listBlogs";
			}
		}
	}
	
	@RequestMapping(value = "/updateBlog")
	public String updateBlog(Model model, @RequestParam("blogId")Integer blogId) {
		Gson gson = new Gson();
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/blogService/getById/" + blogId);
		String res = webResource.get(String.class);
		BlogsDTO blog = gson.fromJson(res, BlogsDTO.class);
		model.addAttribute("blog", blog);
		return "admin/pages/blogs/updateBlog";
	}
	
	@RequestMapping(value = "/doUpdateBlog")
	public String doUpdateBlog(@Valid @ModelAttribute("blog") BlogsDTO blog, BindingResult result, RedirectAttributes redirAttrs,
			@RequestParam("mainImagePath") MultipartFile mainImagePath,
			@RequestParam("secondImagePath") MultipartFile secondImagePath,
			@RequestParam("thirdImagePath") MultipartFile thirdImagePath, Model model, HttpServletRequest request) {
		String path = request.getServletContext().getRealPath("assets/customer/img/blog");
		File f = new File(path);

		if (result.hasErrors()) {
			return "admin/pages/blogs/updateBlog";
		} else {
			if(mainImagePath.getOriginalFilename().length() > 0) {
				File fileMain = new File(f.getAbsolutePath() + "/" + mainImagePath.getOriginalFilename());
				if (!fileMain.exists()) {
					try {
						Files.write(fileMain.toPath(), mainImagePath.getBytes(), StandardOpenOption.CREATE);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				blog.setMainImageUrl(mainImagePath.getOriginalFilename());
			} else {
				blog.setMainImageUrl(blog.getMainImageUrl());
			}
			
			if(secondImagePath.getOriginalFilename().length() > 0) {
				File fileSecond = new File(f.getAbsolutePath() + "/" + secondImagePath.getOriginalFilename());
				if (!fileSecond.exists()) {
					try {
						Files.write(fileSecond.toPath(), secondImagePath.getBytes(), StandardOpenOption.CREATE);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				blog.setSecondImageUrl(secondImagePath.getOriginalFilename());
			} else {
				blog.setSecondImageUrl(blog.getSecondImageUrl());
			}

			if(blog.getThirdImageUrl() == null) {
				if (thirdImagePath.getOriginalFilename().length() > 0) {
					File fileThird = new File(f.getAbsolutePath() + "/" + thirdImagePath.getOriginalFilename());
					if (!fileThird.exists()) {
						try {
							Files.write(fileThird.toPath(), thirdImagePath.getBytes(), StandardOpenOption.CREATE);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					blog.setThirdImageUrl(thirdImagePath.getOriginalFilename());
				}
			} else {
				if (thirdImagePath.getOriginalFilename().length() > 0) {
					File fileThird = new File(f.getAbsolutePath() + "/" + thirdImagePath.getOriginalFilename());
					if (!fileThird.exists()) {
						try {
							Files.write(fileThird.toPath(), thirdImagePath.getBytes(), StandardOpenOption.CREATE);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					blog.setThirdImageUrl(thirdImagePath.getOriginalFilename());
				} else {
					blog.setThirdImageUrl(blog.getThirdImageUrl());
				}
			}
			
			blog.setCreatedAt(new Date());

			Gson gson = new Gson();
			Client client = Client.create();

			String jsonBlog = gson.toJson(blog);
			WebResource webResource = client.resource("http://localhost:8080/WebService/rest/blogService/update");
			ClientResponse clientResponse = webResource.type("application/json").put(ClientResponse.class, jsonBlog);
			String res = clientResponse.getEntity(String.class);
			boolean rs = gson.fromJson(res, boolean.class);

			if (rs) {
				redirAttrs.addFlashAttribute("blog", "Update Successfully");
			} else {
				redirAttrs.addFlashAttribute("blog", "Update failed");
			}
			return "redirect:/admin/listBlogs";
		}
	}
	
	@RequestMapping(value = "/deleteBlog")
	public String deleteBlog(Model model, RedirectAttributes redirAttrs, @RequestParam("blogId")Integer blogId) {
		Gson gson = new Gson();
		Client client = Client.create();
		
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/blogService/delete/"+blogId);
		String res = webResource.type("application/json").delete(String.class);
		boolean rs = gson.fromJson(res, boolean.class);
		
		if (rs) {
			redirAttrs.addFlashAttribute("blog", "Delete successful");
		} else {
			redirAttrs.addFlashAttribute("blog", "Deletion failed");
		}
		return "redirect:/admin/listBlogs";
	}
}
