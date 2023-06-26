package bkap.entities;

public class Product_imagesDTO {

	private Integer id;
	
	private Integer proId;

	private String imageUrl;	
	
	public Product_imagesDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Product_imagesDTO(Integer id, Integer proId, String imageUrl) {
		super();
		this.id = id;
		this.proId = proId;
		this.imageUrl = imageUrl;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getProId() {
		return proId;
	}

	public void setProId(Integer proId) {
		this.proId = proId;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	
}
