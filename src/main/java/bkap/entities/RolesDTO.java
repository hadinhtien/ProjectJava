package bkap.entities;

public class RolesDTO {

	private Integer roleId;

	private String name;

	private boolean status;
	
	public RolesDTO() {
		// TODO Auto-generated constructor stub
	}

	public RolesDTO(Integer roleId, String name, boolean status) {
		super();
		this.roleId = roleId;
		this.name = name;
		this.status = status;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
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

	
}

