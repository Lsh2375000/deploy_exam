package com.example.dao;

import java.util.ArrayList;

import com.example.dto.Product;

public class ProductRepository {
	private ArrayList<Product> products = new ArrayList<>();
	
	public ProductRepository() {
		Product phone = new Product("P1234", "iPhone 6s", 800000);
		phone.setDescription("4.7-inch, 1334X750 Renina HD display, 8-megapixel iSight Camera");
		phone.setCategory("Smart Phone");
		phone.setManufacturer("Apple");
		phone.setUnitsInStock(1000);
		phone.setCondition("New");
		phone.setFileName("P1234.png");

		Product notebook = new Product("P1235", "LG PC 그램", 1500000);
		notebook.setDescription("13.3-inch, IPS LED display, 5rd Generation Intel Core processors");
		notebook.setCategory("Notebook");
		notebook.setManufacturer("LG");
		notebook.setUnitsInStock(1000);
		notebook.setCondition("Refurbished");
		notebook.setFileName("P1235.png");
		
		Product tablet = new Product("P1236", "Galaxy Tab S", 900000);
		tablet.setDescription("212.8*125.6*6.6mm,  Super AMOLED display, Octa-Core processor");
		tablet.setCategory("Tablet");
		tablet.setManufacturer("Samsung");
		tablet.setUnitsInStock(1000);
		tablet.setCondition("Old");
		tablet.setFileName("P1236.png");

		products.add(phone);
		products.add(notebook);
		products.add(tablet);
	}
	
	public ArrayList<Product> getAllProducts() {
		return products;
	}
//	상품 상세 정보를 가져오는 메소드 만들기
	public Product getProductById(String productId) {
		Product product = null;
		
		for (Product p : products) {
			if(p.getProductId().equals(productId)) {
				// 매개 변수와 객체의 Id가 같으면
				product = p;
				break;
			}
		}
		return product;
		
	}
	// 신규상품 저장 메소드
	// 객체에 저장하는 방식이라 인스턴스가 달라지면 추가된 상품을 볼 수 없음
	// 동일한 인스턴스를 반환하는 기능을 추가
	private static ProductRepository instance = new ProductRepository();
	
	public static ProductRepository getInstance() {
		return instance;
	}
	
	public void addProduct(Product product) {
		products.add(product);
	}
	
}
