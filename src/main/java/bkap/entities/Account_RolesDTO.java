package bkap.entities;

public class Account_RolesDTO {
    
	private Integer id;
	
	private Integer accId;
	
	private Integer roleId;
	
	public Account_RolesDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Account_RolesDTO(Integer id, Integer accId, Integer roleId) {
		super();
		this.id = id;
		this.accId = accId;
		this.roleId = roleId;
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
	
	public Integer getRoleId() {
		return roleId;
	}
	
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	

	
}
