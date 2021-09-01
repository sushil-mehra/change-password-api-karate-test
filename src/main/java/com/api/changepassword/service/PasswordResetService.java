package com.api.changepassword.service;

import com.api.changepassword.exception.BadRequestException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.regex.Pattern;

@Service
public class PasswordResetService {

    @Value("${password.length}")
    private int passwordLength;

    @Value("${password.lengthError}")
    private String lengthError;

    @Value("${password.specialCharError}")
    private String specialCharError;

    @Value("${password.upperCaseError}")
    private String upperCaseError;

    @Value("${password.lowerCaseError}")
    private String lowerCaseError;

    @Value("${password.numberError}")
    private String numberError;

    @Value("${password.repeatCharError}")
    private String repeatCharError;

    @Value("${password.repeatSpecialCharError}")
    private String repeatSpecialCharError;

    @Value("${password.numberError_50}")
    private String numberError_50;

    @Value("${password.similarError}")
    private String similarError;

    private List<String> errorList;


    /**
     * Entry method for the password constraints validations.
     *
     * @param oldPassword
     * @param newPassword
     * @return true - if all the password constrains set are met
     * else throws BadRequestException
     * @throws BadRequestException
     */
    public Boolean changePassword(String oldPassword, String newPassword) throws BadRequestException {
        if (!newPasswordConstraintsCheck(newPassword) || !checkDifference(oldPassword, newPassword)) {
            throw new BadRequestException(trimList(errorList.toString()));
        }
        return true;
    }

    /**
     * Check password similarity, what %age of new password is similar to
     * old password
     *
     * @param oldPassword
     * @param newPassword
     * @return true - if new password is not more than 80% similar to old
     * otherwise, it returns false & add constraint violation message
     * to the error list
     */
    public Boolean checkDifference(String oldPassword, String newPassword) {
        double similarity = StringUtils.getJaroWinklerDistance(oldPassword, newPassword);
        if (similarity > 0.8) {
            errorList.add(similarError);
            return false;
        }
        return true;
    }

    /**
     * Password constraints checker - All the below constraints checks are performed.
     * constraints
     * <p>
     * 1. length < 18
     * 2. repeat char method call
     * 3. Number count > 50
     * 4. Special char present check
     * 5. Uppercase char present check
     * 6. Lowercase char present check
     * 7. Number present check
     *
     * @param newPassword
     * @return return false, if any constraint check fails
     * else true
     */
    public Boolean newPasswordConstraintsCheck(String newPassword) {
        Pattern specialCharPattern = Pattern.compile("[!@#$&*]");
        Pattern upperCasePatten = Pattern.compile("[A-Z ]");
        Pattern lowerCasePatten = Pattern.compile("[a-z ]");
        Pattern numericCasePatten = Pattern.compile("[0-9 ]");

        boolean flag = true;
        errorList = new ArrayList<>();

        if (newPassword.length() < passwordLength) {
            flag = false;
            errorList.add(lengthError);
        }

        if (repeatedCharCount(newPassword)) {
            flag = false;
        }

        if (isNumericCountAbove50(newPassword)) {
            flag = false;
            errorList.add(numberError_50);
        }

        if (!specialCharPattern.matcher(newPassword).find()) {
            flag = false;
            errorList.add(specialCharError);
        }

        if (!upperCasePatten.matcher(newPassword).find()) {
            errorList.add(upperCaseError);
            flag = false;
        }

        if (!lowerCasePatten.matcher(newPassword).find()) {
            errorList.add(lowerCaseError);
            flag = false;
        }

        if (!numericCasePatten.matcher(newPassword).find()) {
            errorList.add(numberError);
            flag = false;
        }
        return flag;
    }

    /**
     * Helper method for Repeated char count check
     *
     * @param newPassword
     * @return true if any char repetition is found
     * otherwise false
     */
    public Boolean repeatedCharCount(String newPassword) {

        Set<Character> repeatedSpecialCharList = new LinkedHashSet<>();
        Set<Character> repeatedNonSpecialCharList = new LinkedHashSet<>();

        Map<Character, Integer> charMap = new HashMap<Character, Integer>();
        char[] chArray = newPassword.toCharArray();
        for (char ch : chArray) {
            if (!Character.isSpaceChar(ch)) {
                charMap.put(ch, charMap.getOrDefault(ch, 0) + 1);
            }

            boolean b = ch == '!' || ch == '@' || ch == '#' || ch == '$' || ch == '&' || ch == '*';

            if (b && charMap.get(ch) > 4) {
                repeatedSpecialCharList.add(ch);
            }

            if (!(b) && charMap.get(ch) > 4) {
                repeatedNonSpecialCharList.add(ch);
            }
        }
        if (!repeatedSpecialCharList.isEmpty())
            errorList.add(repeatSpecialCharError + "-'" + trimList(repeatedSpecialCharList.toString().replaceAll(" ", "")) + "'");
        if (!repeatedNonSpecialCharList.isEmpty())
            errorList.add(repeatCharError + "-'" + trimList(repeatedNonSpecialCharList.toString().replaceAll(" ", "")) + "'");

        return !(repeatedSpecialCharList.isEmpty() && repeatedNonSpecialCharList.isEmpty());
    }

    /**
     * Helper method for checking %age of number present in the string
     *
     * @param newPassword
     * @return true - if number %age > 50
     * otherwise false
     */
    public Boolean isNumericCountAbove50(String newPassword) {
        int count = 0;
        for (char ch : newPassword.toCharArray()) {
            if (Character.isDigit(ch))
                count++;
        }
        return ((newPassword.length() / 2 <= count) && count != 0);
    }

    /**
     * Helper method for trimming the List containers
     *
     * @param str
     * @return
     */
    public String trimList(String str) {
        return str.substring(1, str.length() - 1);
    }
}
