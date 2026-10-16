package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.UserDao;
import com.tap.model.User;
import com.tap.utility.DBConnection;

public class UserDaoImpl implements UserDao{
	
	private static final String INSERT_USER="insert into user(userName,password,email,phone,address,role) values(?,?,?,?,?,?)";
	private static final String GET_USER="select * from user where userId=?";
	private static final String GET_USER_By_Email="select * from user where email=?";
	private static final String UPDATE_USER="update user set userName=?,password=?,email=?,"
			+"phone=?,address=?,role=? where userId=?";
	private static final String DELETE_USER="delete from user where userId=?";
	private static final String GET_ALL_USERS="select* from user";
	
	@Override
	public int addUser(User user) {
		int status=0;
		try(Connection connection=DBConnection.getConnection();
				PreparedStatement pstmt=connection.prepareStatement(INSERT_USER)){
					pstmt.setString(1, user.getUserName());
					pstmt.setString(2, user.getPassword());
					pstmt.setString(3, user.getEmail());
					pstmt.setString(4, user.getPhone());
					pstmt.setString(5, user.getAddress());
					pstmt.setString(6, user.getRole());
					
					status=pstmt.executeUpdate();
					
				}
				
				catch(SQLException e)
				{
					e.printStackTrace();
				}
				return status;		
	}
	
	

	@Override
	public User getUser(int userId) {
		User user=null;
		try(Connection connection=DBConnection.getConnection();
				PreparedStatement pstmt=connection.prepareStatement(GET_USER))
				{
			pstmt.setInt(1, userId);
			try(ResultSet resultSet=pstmt.executeQuery()){
				if(resultSet.next()) {
					user=extractUserFromResultSet(resultSet);
				}
			}
					
				}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return user;
	}
	
	
	
	@Override
	public User getUserByEmail(String userEmail) {
		User user=null;
		try(Connection connection=DBConnection.getConnection();
				PreparedStatement pstmt=connection.prepareStatement(GET_USER_By_Email))
				{
			pstmt.setString(1, userEmail);
			try(ResultSet resultSet=pstmt.executeQuery()){
				if(resultSet.next()) {
					user=extractUserFromResultSet(resultSet);
				}
			}
					
				}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return user;
	}
	
	

	@Override
	public int updateUser(User user) {
		int status=0;
		try(Connection connection=DBConnection.getConnection();
				PreparedStatement pstmt=connection.prepareStatement(UPDATE_USER)){
					pstmt.setString(1, user.getUserName());
					pstmt.setString(2, user.getPassword());
					pstmt.setString(3, user.getEmail());
					pstmt.setString(4, user.getPhone());
					pstmt.setString(5, user.getAddress());
					pstmt.setString(6, user.getRole());
					pstmt.setInt(7, user.getUserId());
					
					
					status=pstmt.executeUpdate();
					
				}
				
				catch(SQLException e)
				{
					e.printStackTrace();
				}
				return status;	
	}

	@Override
	public int deleteUser(int userId) {
		int status=0;
		try(Connection connection=DBConnection.getConnection();
				PreparedStatement pstmt=connection.prepareStatement(DELETE_USER))
				{
			pstmt.setInt(1, userId);
			status=pstmt.executeUpdate();
				}catch(SQLException e){
			e.printStackTrace();
		}
		return status;
	}
	
	

	@Override
	public List<User> getAllUsers() {
		List<User> userList=new ArrayList<>();
		try(Connection connection=DBConnection.getConnection();
				PreparedStatement pstmt=connection.prepareStatement(GET_ALL_USERS);
				ResultSet resultSet=pstmt.executeQuery()){
			while(resultSet.next()) {
				userList.add(extractUserFromResultSet(resultSet));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return userList;
	}

	
	
	
	
	
	
	
	
	private User extractUserFromResultSet(ResultSet resultSet) throws SQLException{
		return new User(
				resultSet.getInt("userId"),
				resultSet.getString("userName"),
				resultSet.getString("password"),
				resultSet.getString("email"),
				resultSet.getString("phone"),
				resultSet.getString("address"),
				resultSet.getString("role")
				);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
