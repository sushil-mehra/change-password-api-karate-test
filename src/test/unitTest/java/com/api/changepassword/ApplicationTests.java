package com.api.changepassword;

import com.api.changepassword.controller.UserController;
import org.json.JSONException;
import org.json.JSONObject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.*;
import org.springframework.test.context.junit4.SpringRunner;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

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
        assertNotNull(userController);
    }

    @Test
    public void testPutCall() throws JSONException {
        String userId = "user1";
        String oldPwd = "BRandeomma245@##3@";
        String newPwd = "Pasd3@BRandeomma245";
        String reqJson = "{\"oldPwd\":\"" + oldPwd + "\",\"newPwd\":\"" + newPwd + "\"}";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> entity = new HttpEntity<>(reqJson, headers);

        ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/v1/updatePassword/users/" + userId,
                HttpMethod.PUT, entity, String.class);

        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals(200, response.getStatusCodeValue());

        JSONObject json = new JSONObject(response.getBody());
        assertEquals("Password has been updated successfully", json.get("message"));
        assertEquals(userId, json.get("userId"));
    }
}
