package com.api.changepassword;

import com.api.changepassword.controller.UserController;
import com.api.changepassword.model.User;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class ApplicationTests {

    @Autowired
    private TestRestTemplate restTemplate;

    @LocalServerPort
    private int port;

    @Autowired
    private UserController userController;

    private String getRootUrl() {
        return "http://localhost:" + port;
    }

    @Test
    public void contextLoads() throws Exception {
        Assert.assertNotNull(userController);
    }

    @Test
    public void testUpdatePut() {
        String userId = "user1";
        String newPwd = "Password@123456";
        User user = restTemplate.getForObject(getRootUrl() + "/users/" + userId, User.class);
        user.setUsername(userId);
        user.setPwd(newPwd);

        restTemplate.put(getRootUrl() + "/users/" + userId, user);

        User updatedUser = restTemplate.getForObject(getRootUrl() + "/users/" + userId, User.class);
        Assert.assertNotNull(updatedUser);
    }
}
