package com.sattwyk.sga2_bda.exception;

public class ValidationException extends RuntimeException {

    private final String fieldName;

    public ValidationException(String fieldName, String message) {
        super(message);
        this.fieldName = fieldName;
    }

    public String getFieldName() {
        return fieldName;
    }
}
