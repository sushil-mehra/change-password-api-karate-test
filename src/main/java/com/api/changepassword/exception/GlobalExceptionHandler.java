package com.api.changepassword.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.NoHandlerFoundException;

import java.util.Date;

@ControllerAdvice
public class GlobalExceptionHandler {

    /**
     * Resource not found exception response entity.
     *
     * @param ex      the ex
     * @param request the request
     * @return response entity
     */
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<?> resourceNotFoundException(
            ResourceNotFoundException ex, WebRequest request) {
        ErrorResponse errorDetails = new ErrorResponse(HttpStatus.NOT_FOUND.getReasonPhrase().toUpperCase(), ex.getMessage(),
                request.getDescription(false), new Date());
        return new ResponseEntity<>(errorDetails, HttpStatus.NOT_FOUND);
    }

    /**
     * Exception Handler for Bad Request
     *
     * @param ex
     * @param request
     * @return response entity
     */
    @ExceptionHandler(BadRequestException.class)
    public ResponseEntity<?> badRequestException(
            BadRequestException ex, WebRequest request) {
        ErrorResponse errorDetails = new ErrorResponse(HttpStatus.BAD_REQUEST.getReasonPhrase().toUpperCase(), ex.getMessage(),
                request.getDescription(false), new Date(System.currentTimeMillis()));
        return new ResponseEntity<>(errorDetails, HttpStatus.BAD_REQUEST);
    }

    /**
     * Exception Handler for Not Defined Handler Exceptions
     *
     * @param e
     * @param request
     * @return response entity
     */
    @ExceptionHandler(NoHandlerFoundException.class)
    public ResponseEntity<?> handleNoHandlerFound(NoHandlerFoundException e, WebRequest request) {
        ErrorResponse errorDetails = new ErrorResponse(HttpStatus.NOT_FOUND.getReasonPhrase().toUpperCase(), e.getMessage(),
                request.getDescription(false), new Date(System.currentTimeMillis()));
        return new ResponseEntity<>(errorDetails, HttpStatus.NOT_FOUND);
    }

    /**
     * Exception Handler for Global Exception not matching with
     * any of the defined exception handler.
     *
     * @param ex      the ex
     * @param request the request
     * @return response entity
     */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> globalExceptionHandler(Exception ex, WebRequest request) {
        ErrorResponse errorDetails = new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR.getReasonPhrase().toUpperCase(),
                ex.getMessage(), request.getDescription(false), new Date());
        return new ResponseEntity<>(errorDetails, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
