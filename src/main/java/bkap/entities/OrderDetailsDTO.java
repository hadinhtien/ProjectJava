package bkap.entities;

public class OrderDetailsDTO {

	private Integer id;
	
	private Integer orderId;
	
	private Integer proId;
	
	private Integer quantity;
	
	private Double price;

	public OrderDetailsDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OrderDetailsDTO(Integer id, Integer orderId, Integer proId, Integer quantity, Double price) {
		super();
		this.id = id;
		this.orderId = orderId;
		this.proId = proId;
		this.quantity = quantity;
		this.price = price;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
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

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	
}
