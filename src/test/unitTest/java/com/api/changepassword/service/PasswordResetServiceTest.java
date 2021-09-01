package com.api.changepassword.service;

import com.api.changepassword.exception.BadRequestException;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.util.List;

@RunWith(MockitoJUnitRunner.class)
public class PasswordResetServiceTest {

    @Mock
    private List<String> errorList;

    @InjectMocks
    private PasswordResetService passwordResetService;

    @Test
    public void changePasswordTest() throws BadRequestException {
        String oldPwd = "BRandeomma245@##3@";
        String newPwd = "Pasd3@BRandeomma245";
        Assert.assertTrue(passwordResetService.changePassword(oldPwd, newPwd));
    }

    @Test
    public void checkDiffTrue() {
        String oldPwd = "Password1";
        String newPwd = "RandomString1";
        Assert.assertTrue(passwordResetService.checkDifference(oldPwd, newPwd));
    }

    @Test
    public void checkDiffFalse() {
        String oldPwd = "Password1";
        String newPwd = "Password1";
        Assert.assertFalse(passwordResetService.checkDifference(oldPwd, newPwd));
    }

    @Test
    public void constraintCheck_Length_True() {
        String newPwd = "Password123@Qwertyy";
        Assert.assertTrue(passwordResetService.newPasswordConstraintsCheck(newPwd));
    }

    @Test
    public void constraintCheck_Length_False() {
        String newPwd = "";
        Assert.assertFalse(passwordResetService.newPasswordConstraintsCheck(newPwd));
    }

    @Test
    public void constraintCheck_RepeatedChar_True() {
        String newPwd = "aaaaaAAAAA1111@@@@@";
        Assert.assertFalse(passwordResetService.newPasswordConstraintsCheck(newPwd));
    }

    @Test
    public void constraintCheck_RepeatedChar_False() {
        String newPwd = "Password123@Qwertyy";
        Assert.assertTrue(passwordResetService.newPasswordConstraintsCheck(newPwd));
    }

    @Test
    public void constraintCheck_SpecialChar_True() {
        String newPwd = "Password123@Qwertyy";
        Assert.assertTrue(passwordResetService.newPasswordConstraintsCheck(newPwd));
    }

    @Test
    public void constraintCheck_ExtraSpecialChar_False() {
        String newPwd = "Password123^Qwertyy";
        Assert.assertFalse(passwordResetService.newPasswordConstraintsCheck(newPwd));
    }

    @Test
    public void constraintCheck_SpecialChar_False() {
        String newPwd = "Password123Qwertyy";
        Assert.assertFalse(passwordResetService.newPasswordConstraintsCheck(newPwd));
    }

    @Test
    public void constraintCheck_UpperAndLower() {
        String newPwd = "Password123@Qwertyy";
        Assert.assertTrue(passwordResetService.newPasswordConstraintsCheck(newPwd));
    }

    @Test
    public void constraintCheck_NoUpperAllLower() {
        String newPwd = "password123qwertyy";
        Assert.assertFalse(passwordResetService.newPasswordConstraintsCheck(newPwd));
    }

    @Test
    public void constraintCheck_NoLowerAllUpperChar() {
        String newPwd = "PASSWORD123@QWERTYY";
        Assert.assertFalse(passwordResetService.newPasswordConstraintsCheck(newPwd));
    }


    @Test
    public void constraintCheck_Number_False() {
        String newPwd = "Password@Qwertymnyz";
        Assert.assertFalse(passwordResetService.newPasswordConstraintsCheck(newPwd));
    }

    @Test
    public void repeatedCharCount_charTrue() {
        String newPwd = "AAAAAaaaa1111";
        Assert.assertTrue(passwordResetService.repeatedCharCount(newPwd));
    }

    @Test
    public void repeatedCharCount_charFalse() {
        String newPwd = "AAAAaaaa1111";
        Assert.assertFalse(passwordResetService.repeatedCharCount(newPwd));
    }

    @Test
    public void repeatedCharCount_SpecialTrue() {
        String newPwd = "@@@@@aaaa1111";
        Assert.assertTrue(passwordResetService.repeatedCharCount(newPwd));
    }

    @Test
    public void repeatedCharCount_SpecialFalse() {
        String newPwd = "@@@@aaaa1111";
        Assert.assertFalse(passwordResetService.repeatedCharCount(newPwd));
    }

    @Test
    public void number50True() {
        String newPwd = "ABCDEF123456789";
        Assert.assertTrue(passwordResetService.isNumericCountAbove50(newPwd));
    }

    @Test
    public void number50False() {
        String newPwd = "ABCDEF1234";
        Assert.assertFalse(passwordResetService.isNumericCountAbove50(newPwd));
    }

    @Test
    public void number50EqualFalse() {
        String newPwd = "ABCDEF123456";
        Assert.assertTrue(passwordResetService.isNumericCountAbove50(newPwd));
    }

    @Test
    public void trimListTrue() {
        String str = "[1, 2, 3, 4, 5, 6, 7]";
        String res = passwordResetService.trimList(str);
        Assert.assertFalse(res.contains("[") || res.contains("]"));
    }


}
