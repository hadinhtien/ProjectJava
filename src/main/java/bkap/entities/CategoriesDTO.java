package bkap.entities;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

public class CategoriesDTO {

	private Integer cateId;
	
	@NotEmpty(message = "Category name is not null !!")
	private String name;
	
	private boolean status;
	
	private Date createdAt;
	
	public CategoriesDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CategoriesDTO(Integer cateId, @NotEmpty(message = "Category name is not null !!") String name,
			boolean status, Date createdAt) {
		super();
		this.cateId = cateId;
		this.name = name;
		this.status = status;
		this.createdAt = createdAt;
	}

	public Integer getCateId() {
		return cateId;
	}

	public void setCateId(Integer cateId) {
		this.cateId = cateId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	
}
