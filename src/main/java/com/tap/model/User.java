package com.tap.model;

public class User {
	
	private int userId;
	private String userName;
	private String password;
	private String email;
	private String phone;
	private String address;
	private String role;
	
	public User() {
		
	}
	
	public User(String userName,String password,String email,String phone,String address,String role)
	{
		this.userName=userName;
		this.password=password;
		this.email=email;
		this.phone=phone;
		this.address=address;
		this.role=role;
	}
	
	public User(int userId,String userName,String password,String email,String phone,String address,String role)
	{
		this.userId=userId;
		this.userName=userName;
		this.password=password;
		this.email=email;
		this.phone=phone;
		this.address=address;
		this.role=role;
	}
	
	
	public void setUserId(int userId)
	{
		this.userId=userId;
	}
	
	public int getUserId()
	{
		return userId;
	}
	
	
	public void setUserName(String userName)
	{
		this.userName=userName;
	}
	
	public String getUserName()
	{
		return userName;
	}
	
	public void setPassword(String password)
	{
		this.password=password;
	}
	
	public String getPassword()
	{
		return password;
	}
	
	public void setEmail(String email)
	{
		this.email=email;
	}
	public String getEmail()
	{
		return email;
	}
	
	public void setPhone(String phone)
	{
		this.phone=phone;
	}
	
	public String getPhone()
	{
		return phone;
	}
	
	public void setAddress(String address)
	{
		this.address=address;
	}
	
	public String getAddress()
	{
		return address;
	}
	
	public void setRole(String role)
	{
		this.role=role;
	}
	
	public String getRole()
	{
		return role;
	}
	
	@Override
	public String toString() {
		return "User [userId=" +userId + ", userName=" + userName+ ", Email="+email+", Phone="+phone+", address="+ address+ ", role="+role+"]";
	}
}