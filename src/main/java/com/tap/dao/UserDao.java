package com.tap.dao;

import java.util.List;

import com.tap.model.User;

public interface UserDao {
	int addUser(User user);
	User getUser(int userId);
	int updateUser(User user);
	int deleteUser(int userId);
	List<User> getAllUsers();
	User getUserByEmail(String userEmail);

}
