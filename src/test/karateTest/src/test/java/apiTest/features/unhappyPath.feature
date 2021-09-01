###################################################
# Date:         25-08-2021                        #
# Author:       Sushil Mehra                      #
# Version:      v1.0                              #
# Description:  Tests for all constraints check   #
###################################################

@CP_UnhappyPath @CP_Regression @CP_Sanity
Feature: Verify Change Password API is able validate all the new password conditions as expected and gives appropriate error response messages

  Background:
    * json changeApiMetaData = apiMetaData['changePasswordAPI']
    * def baseUrl = changeApiMetaData['baseUrl']
    * def putUrl = changeApiMetaData['urls']['put']
    * json putRequestJson = read('../common/dynamicMessage/changePassword_PUT_body.json')['changePasswordAPI']
    
    * def sleep = function(){ java.lang.Thread.sleep(500) }
    * def respTimeThreshold = respThreshold
    * def testData = read('../common/testData/' + env + '/changePasswordAPI.json')

    
  #======================= Invalid request data =======================#
  @CP_PwdIncorrect @CP_TC02 @CP_TC03 @CP_TC04 @CP_TC05 @CP_TC06
  Scenario Outline: <testCaseId> - To verify 'change password' api fail to update the new password when a PUT request is made for a user. Given the - <description>

    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']

    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']

    Given url putUrl + '/' + testData_request['userId']
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']


    Examples:
      | testCaseId | description                                  |
      | TC02       | old password empty                           |
      | TC03       | new Password empty                           |
      | TC04       | new password & old password entered as empty |
      | TC05       | old password invalid                         |
      | TC06       | an invalid user                              |


  #======================= Password length check (18)=======================#
  @CP_LengthCheck @CP_TC07 @CP_TC08 @CP_TC09 @CP_TC10 @CP_TC11 @CP_TC12 @CP_TC13 @CP_TC14 @CP_TC15
  Scenario Outline: <testCaseId> - To verify 'change password' api <testStatus> length less than 18 error & fail to update the new password when a PUT request is made for a valid user. Given the new password has - <description>

    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']

    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']

    Given url putUrl + '/' + testData_request['userId']
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId | description                                                                                            | testStatus    |
      | TC07       | 18 length unique chars (9 lowercase + 9 uppercase)                                                     | do not report |
      | TC08       | 18 length unique chars (9 number + 9 special char[!@#$&*])                                             | do not report |
      | TC09       | all 18 repeating number                                                                                | do not report |
      | TC10       | 18 repeating special chars (9 not accepted special chars + 9 from the accepted special chars [!@#$&*]) | do not report |
      | TC11       | 17 all unique chars (9 lowercase + 8 uppercase)                                                        | reports       |
      | TC12       | 17 chars are number                                                                                    | reports       |
      | TC13       | password has number,lowercase,uppercase & special char with 4 occurrence                               | reports       |
      | TC14       | enter only one char                                                                                    | reports       |
      | TC15       | password has same 5 uppercase, 5 lowercase, 5 number, 5 special chars from the given list(!@#$&*)      | do not report |


  #======================= Special Char check (!@#$&*)=======================#
  @CP_SpCharCheck @CP_TC16 @CP_TC17 @CP_TC18 @CP_TC19 @CP_TC20 @CP_TC21 @CP_TC22 @CP_TC23
  Scenario Outline: <testCaseId> - To verify 'change password' api doesn’t show Special char missing error & fail to update the new password when a PUT request is made for a valid user. Given the new password has - <description> special char present from the list [!@#$&*]
    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']

    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']

    Given url putUrl + '/' + testData_request['userId']
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId | description                |
      | TC16       | '!'                        |
      | TC17       | '@'                        |
      | TC18       | '#'                        |
      | TC19       | '$'                        |
      | TC20       | '&'                        |
      | TC21       | '*'                        |
      | TC22       | '>~`%()-_/\|\\}{[].':=+;<' |
      | TC23       | 'no'                       |

  #======================= Char case check (Upper,Lower,Number)=======================#
  @CP_CharCaseCheck @CP_TC24 @CP_TC25 @CP_TC26 @CP_TC27 @CP_TC28 @CP_TC29
  Scenario Outline: <testCaseId> - To verify 'change password' api shows expected error & fail to update the new password when a PUT request is made for a valid user. Given the new password contains - <description> alphabets present
    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']

    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']

    Given url putUrl + '/' + testData_request['userId']
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId | description            |
      | TC24       | at least one uppercase |
      | TC25       | no uppercase           |
      | TC26       | at least one lowercase |
      | TC27       | no lowercase           |
      | TC28       | no numbers             |
      | TC29       | at least one number    |


 #======================= Char repeat check (<4, >4, =4)=======================#
  @CP_CharRepeatCheck @CP_TC30 @CP_TC31 @CP_TC32 @CP_TC33 @CP_TC34 @CP_TC35 @CP_TC36 @CP_TC37 @CP_TC38 @CP_TC39 @CP_TC40 @CP_TC41 @CP_TC42 @CP_TC43
  Scenario Outline: <testCaseId> - To verify 'change password' api shows expected error & fail to update the new password when a PUT request is made for a valid user. Given the new password has one - <description> occurrence

    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']

    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']

    Given url putUrl + '/' + testData_request['userId']
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId | description                                           |
      | TC30       | number with more than 4                               |
      | TC31       | number with exact 4                                   |
      | TC32       | lowercase char with more than 4                       |
      | TC33       | uppercase char with more than 4                       |
      | TC34       | lowercase char with exact 4                           |
      | TC35       | uppercase char with exact 4                           |
      | TC36       | a number & a char with exact 4                        |
      | TC37       | a number & a char with more than 4                    |
      | TC38       | lowercase, uppercase of same char with more than 4    |
      | TC40       | one special char - '@' with 4                         |
      | TC41       | special char - '$' with more than 4                   |
      | TC42       | special char not from the list - '^' with more than 4 |
      | TC43       | special char not from the list - '^' with 4           |

  #======================= 50% Not number =======================#
  @CP_50NumberCheck @CP_TC44 @CP_TC45 @CP_TC46 @CP_TC47 @CP_TC48
  Scenario Outline: <testCaseId> - To verify 'change password' api shows expected error & fail to update the new password when a PUT request is made for a valid user. Given the new password has <description>
    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']

    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']

    Given url putUrl + '/' + testData_request['userId']
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId | description                                 |
      | TC44       | 2 consecutive number at alternate positions |
      | TC45       | all numbers in first half                   |
      | TC46       | all numbers in second half                  |
      | TC47       | consecutive number at alternate positions   |
      | TC48       | number less than 50% of password length     |


  #======================= New password < 80% match =======================#
  @CP_50NumberCheck @CP_TC49 @CP_TC50 @CP_TC51 @CP_TC52 @CP_TC53 @CP_TC54 @CP_TC55 @CP_TC56
  Scenario Outline: <testCaseId> - To verify 'change password' api shows expected error & fail to update the new password when a PUT request is made for a valid user. Given the new password is - <description>
    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']

    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']

    Given url putUrl + '/' + testData_request['userId']
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId | description                                                   |
      | TC49       | unique string suffixed to existing old password               |
      | TC50       | unique string prefix to existing old password                 |
      | TC51       | old password                                                  |
      | TC52       | old password with 4 duplicate chars in the middle             |
      | TC53       | old password with 5 duplicate chars in the middle             |
      | TC54       | old password with 5 duplicate chars as prefix                 |
      | TC55       | old password with 5 duplicate chars as suffix                 |
      | TC56       | password with 4 duplicate chars - 'z,Z' at alternate position |