package bkap.entities;

import java.util.Date;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import org.springframework.format.annotation.DateTimeFormat;

public class ProductsDTO {

	private Integer proId;

	@NotEmpty(message = "Proudct name is not null !!")
	private String name;

	private String imageUrl;

	@NotNull(message = "Price is not null !!")
	private Double price;

	private Double discount;

	@NotNull(message = "Category is not null !!")
	private Integer cateId;

	@NotNull(message = "Brand is not null !!")
	private Integer brandId;

	@NotEmpty(message = "Short description is not null !!")
	private String shortDescription;

	@NotEmpty(message = "Description is not null !!")
	private String description;

	@NotNull(message = "Quantity is not null !!")
	private Integer quantity;

	private Integer status;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createdAt;

	public ProductsDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductsDTO(Integer proId, @NotEmpty(message = "Proudct name is not null !!") String name, String imageUrl,
			@NotNull(message = "Price is not null !!") Double price, Double discount,
			@NotNull(message = "Category is not null !!") Integer cateId,
			@NotNull(message = "Brand is not null !!") Integer brandId,
			@NotEmpty(message = "Short description is not null !!") String shortDescription,
			@NotEmpty(message = "Description is not null !!") String description,
			@NotNull(message = "Quantity is not null !!") Integer quantity, Integer status, Date createdAt) {
		super();
		this.proId = proId;
		this.name = name;
		this.imageUrl = imageUrl;
		this.price = price;
		this.discount = discount;
		this.cateId = cateId;
		this.brandId = brandId;
		this.shortDescription = shortDescription;
		this.description = description;
		this.quantity = quantity;
		this.status = status;
		this.createdAt = createdAt;
	}

	public Integer getProId() {
		return proId;
	}

	public void setProId(Integer proId) {
		this.proId = proId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Double getDiscount() {
		return discount;
	}

	public void setDiscount(Double discount) {
		this.discount = discount;
	}

	public Integer getCateId() {
		return cateId;
	}

	public void setCateId(Integer cateId) {
		this.cateId = cateId;
	}

	public Integer getBrandId() {
		return brandId;
	}

	public void setBrandId(Integer brandId) {
		this.brandId = brandId;
	}

	public String getShortDescription() {
		return shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	
}
