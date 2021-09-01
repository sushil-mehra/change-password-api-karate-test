package com.api.changepassword.exception;

import java.util.Date;

public class ErrorResponse {

    private String status;
    private String message;
    private String details;
    private Date timestamp;

    /**
     * Error Response creator
     *
     * @param timestamp the timestamp
     * @param status    the status
     * @param message   the message
     * @param details   the details
     */
    public ErrorResponse(String status, String message, String details, Date timestamp) {
        this.status = status;
        this.message = message;
        this.details = details;
        this.timestamp = timestamp;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }


}
