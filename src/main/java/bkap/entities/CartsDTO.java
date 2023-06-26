package bkap.entities;

public class CartsDTO {

	private Integer cartId;
	
	private Integer accId;

	private Integer proId;

	private Integer quantity;

	public CartsDTO() {
		// TODO Auto-generated constructor stub
	}

	public CartsDTO(Integer cartId, Integer accId, Integer proId, Integer quantity) {
		super();
		this.cartId = cartId;
		this.accId = accId;
		this.proId = proId;
		this.quantity = quantity;
	}

	public Integer getCartId() {
		return cartId;
	}

	public void setCartId(Integer cartId) {
		this.cartId = cartId;
	}

	public Integer getAccId() {
		return accId;
	}

	public void setAccId(Integer accId) {
		this.accId = accId;
	}

	public Integer getProId() {
		return proId;
	}

	public void setProId(Integer proId) {
		this.proId = proId;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	
}
