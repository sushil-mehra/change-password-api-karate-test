package com.api.changepassword.controller;

import com.api.changepassword.exception.BadRequestException;
import com.api.changepassword.exception.ResourceNotFoundException;
import com.api.changepassword.model.User;
import com.api.changepassword.model.UserVO;
import com.api.changepassword.service.PasswordResetService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;


@RestController
@RequestMapping("/v1/updatePassword")
public class UserController {

    private User user;

    @Autowired
    private PasswordResetService passwordResetService;

    @Value("${password.matchNotFound}")
    private String matchNotFound;

    @Value("${passwordUpdateSuccess}")
    private String passwordUpdateSuccess;

    @Value("${user.notFound}")
    private String userNotFound;

    @Value("${password.oldPasswordMissing}")
    private String oldPasswordMissing;

    @Value("${password.newPasswordMissing}")
    private String newPasswordMissing;

    @Value("${request.invalid}")
    private String invalidRequest;

    private final SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

    private Map<String, User> userValueMap;

    @PutMapping("/users/{username}")
    public ResponseEntity<String> updateUserPassword(
            @PathVariable(value = "username") String username, @Valid @RequestBody UserVO userDetails)
            throws ResourceNotFoundException, BadRequestException {

        Boolean status;
        Date date = null;
        isoFormat.setTimeZone(TimeZone.getTimeZone("UTC"));

        userValueMap = new HashMap<>();
        userValueMap.put("user1", new User("user1", "BRandeomma245@##3@"));
        userValueMap.put("user2", new User("user2", "PassWord$cfkl6781@"));
        userValueMap.put("user3", new User("user3", "Abcdefghijklm1234@"));
        userValueMap.put("user4", new User("user4", "User4Password*987@"));

        if (userDetails == null || StringUtils.equals(userDetails.getOldPwd(), null) || StringUtils.equals(userDetails.getNewPwd(), null))
            throw new BadRequestException(invalidRequest);

        if (StringUtils.isBlank(userDetails.getOldPwd()))
            throw new BadRequestException(oldPasswordMissing);

        if (StringUtils.isBlank(userDetails.getNewPwd()))
            throw new BadRequestException(newPasswordMissing);

        if (userValueMap.containsKey(username))
            user = userValueMap.get(username);
        else
            throw new ResourceNotFoundException(userNotFound + ": " + username);


        if (user.getPwd().equals(userDetails.getOldPwd())) {
            status = passwordResetService.changePassword(userDetails.getOldPwd(), userDetails.getNewPwd());
            if (status) {
                user.setUsername(username);
                user.setPwd(userDetails.getNewPwd());
                LocalDateTime ldt = LocalDateTime.ofInstant(Instant.now(), ZoneOffset.UTC);
                Instant instant = ldt.toInstant(ZoneOffset.UTC);
                date = Date.from(instant);
                user.setTimestamp(isoFormat.format(date));
            }
        } else
            throw new ResourceNotFoundException(matchNotFound);


        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON)
                .body("{" + "\"userId\":\"" + username + "\","
                        + "\"message\":\"" + passwordUpdateSuccess + "\","
                        + "\"timestamp\":\"" + isoFormat.format(date)
                        + "\"}");
    }

}
