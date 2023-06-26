package bkap.entities;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

public class ContactsDTO {

	private Integer id;
	
	private Integer accId;
	
	@NotEmpty(message = "Fullname is not null !!")
	private String fullName;
	
	@NotEmpty(message = "Email is not null !!")
	private String email;	
	
	@NotEmpty(message = "Phone is not null !!")
	private String phone;
	
	@NotEmpty(message = "Message is not null !!")
	private String message;
	
	private boolean status;
	
	private Date createdAt;
	
	public ContactsDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ContactsDTO(Integer id, Integer accId, @NotEmpty(message = "Fullname is not null !!") String fullName,
			@NotEmpty(message = "Email is not null !!") String email,
			@NotEmpty(message = "Phone is not null !!") String phone,
			@NotEmpty(message = "Message is not null !!") String message, boolean status, Date createdAt) {
		super();
		this.id = id;
		this.accId = accId;
		this.fullName = fullName;
		this.email = email;
		this.phone = phone;
		this.message = message;
		this.status = status;
		this.createdAt = createdAt;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getAccId() {
		return accId;
	}

	public void setAccId(Integer accId) {
		this.accId = accId;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
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
