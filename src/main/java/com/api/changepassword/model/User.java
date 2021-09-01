package com.api.changepassword.model;

public class User {

    private long id;
    private String username;
    private String pwd;
    private String timestamp;

    public User(String username, String pwd) {
        this.username = username;
        this.pwd = pwd;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", userId='" + username + '\'' +
                ", pwd='" + pwd + '\'' +
                '}';
    }


}
