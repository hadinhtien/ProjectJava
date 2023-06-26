package bkap.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardOpenOption;
import java.text.SimpleDateFormat;
import java.util.Date;

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
import com.sun.jersey.api.client.WebResource;

import bkap.entities.ConfigsDTO;

@Controller
@RequestMapping(value = {"/admin"})
public class ConfigurationController {
	
	@InitBinder
	public void initBinder(WebDataBinder data) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		data.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}
	
	@RequestMapping(value = {"/configuration"})
	public String configuration(Model model) {
		Client client = Client.create();
		Gson gson = new Gson();
		
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/configService/getConfig");
		String data = webResource.get(String.class);
		ConfigsDTO config = gson.fromJson(data, ConfigsDTO.class);

		model.addAttribute("config", config);
		return "admin/pages/configs/configuration";
	}
	
	@RequestMapping(value = { "initUpdateConfig" })
	public String initUpdateConfig(Model model) {
		Client client = Client.create();
		Gson gson = new Gson();
		
		WebResource webResource = client.resource("http://localhost:8080/WebService/rest/configService/getConfig");
		String data = webResource.get(String.class);
		ConfigsDTO config = gson.fromJson(data, ConfigsDTO.class);

		model.addAttribute("config", config);
		return "admin/pages/configs/configurationUpdate";
	}

	@RequestMapping(value = { "/updateConfig" })
	public String updateConfig(@Valid @ModelAttribute("config") ConfigsDTO config, BindingResult result, 
			RedirectAttributes redirAttrs, @RequestParam("logoImagePath") MultipartFile logoImagePath,
			@RequestParam("bannerImagePath") MultipartFile bannerImagePath, HttpServletRequest request, Model model) 
	{
		String path = request.getServletContext().getRealPath("resources/image");
		File f = new File(path);

		if (result.hasErrors()) {
			return "admin/pages/configs/configurationUpdate";
		} else {
			if (logoImagePath.getOriginalFilename().length() > 0) {
				File logoImage = new File(f.getAbsolutePath() + "/" + logoImagePath.getOriginalFilename());
				if (!logoImage.exists()) {
					try {
						Files.write(logoImage.toPath(), logoImagePath.getBytes(), StandardOpenOption.CREATE);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				config.setLogoImage(logoImagePath.getOriginalFilename());
			} else {
				config.setLogoImage(config.getLogoImage());
			}
			
			if (bannerImagePath.getOriginalFilename().length() > 0) {
				File bannerImage = new File(f.getAbsolutePath() + "/" + bannerImagePath.getOriginalFilename());
				if (!bannerImage.exists()) {
					try {
						Files.write(bannerImage.toPath(), bannerImagePath.getBytes(), StandardOpenOption.CREATE);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				config.setBannerImage(bannerImagePath.getOriginalFilename());
			} else {
				config.setBannerImage(config.getBannerImage());
			}
			
			config.setUpdatedAt(new Date());
			
			Gson gson = new Gson();
			Client client = Client.create();

			String jsonConfig = gson.toJson(config);
			WebResource webResource = client.resource("http://localhost:8080/WebService/rest/configService/update");
			ClientResponse clientResponse = webResource.type("application/json").put(ClientResponse.class, jsonConfig);
			String res = clientResponse.getEntity(String.class);
			boolean rs = gson.fromJson(res, boolean.class);
			
			if (rs) {
				redirAttrs.addFlashAttribute("alertConfig", "Update Successfully");
			} else {
				redirAttrs.addFlashAttribute("alertConfig", "Update failed");
			}
			return "redirect:/admin/configuration";
		}
	}
}
