package bkap.entities;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

public class ConfigsDTO {

	private Integer id;
	
	private String logoImage;
	
	private String bannerImage;	
	
	@NotEmpty(message = "Please enter address.")
	private String address;
	
	@NotEmpty(message = "Please enter map.")
	private String map;
	
	@NotEmpty(message = "Please enter email.")
	private String email;
	
	@NotEmpty(message = "Please enter phone.")
	private String phone;
	
	private Date updatedAt;
	
	public ConfigsDTO() {
		super();
	}

	public ConfigsDTO(Integer id, String logoImage, String bannerImage,
			@NotEmpty(message = "Please enter address.") String address,
			@NotEmpty(message = "Please enter map.") String map,
			@NotEmpty(message = "Please enter email.") String email,
			@NotEmpty(message = "Please enter phone.") String phone, Date updatedAt) {
		super();
		this.id = id;
		this.logoImage = logoImage;
		this.bannerImage = bannerImage;
		this.address = address;
		this.map = map;
		this.email = email;
		this.phone = phone;
		this.updatedAt = updatedAt;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLogoImage() {
		return logoImage;
	}

	public void setLogoImage(String logoImage) {
		this.logoImage = logoImage;
	}

	public String getBannerImage() {
		return bannerImage;
	}

	public void setBannerImage(String bannerImage) {
		this.bannerImage = bannerImage;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMap() {
		return map;
	}

	public void setMap(String map) {
		this.map = map;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	
}
