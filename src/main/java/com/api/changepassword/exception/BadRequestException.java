package com.api.changepassword.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class BadRequestException extends Exception{

    /**
     * Instantiates a new Bad Request exception.
     *
     * @param message the message
     */
    public BadRequestException(String message) {
        super(message);
    }
}
