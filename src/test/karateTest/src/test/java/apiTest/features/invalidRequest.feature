###################################################
# Date:         23-08-2021                        #
# Author:       Sushil Mehra                      #
# Version:      v1.0                              #
# Description:  Test Invalid Request to API       #
###################################################

@CP_UnhappyPath @CP_Regression @CP_InvalidRequest
Feature: Verify Change Password API is responding with expected error message when an invalid request is made

  Background:
    * json changeApiMetaData = apiMetaData['changePasswordAPI']
    * def baseUrl = changeApiMetaData['baseUrl']
    * def putUrl = changeApiMetaData['urls']['put']
    * def putUrlInvalid = changeApiMetaData['invalidUrls']['put']
    * def respTimeThreshold = respThreshold

    * json putRequestJson = read('../common/dynamicMessage/changePassword_PUT_body.json')['changePasswordAPI']
    * json putRequestInvalidJson = read('../common/dynamicMessage/changePassword_PUT_body-invalid.json')['changePasswordAPI']
    * def sleep = function(){ java.lang.Thread.sleep(500) }

    * def testData = read('../common/testData/' + env + '/changePasswordAPI.json')

  #======================= Invalid Method Call =======================#
  @CP_IncorrectMethod @CP_TC57 @CP_TC58
  Scenario Outline: <testCaseId> - To verify 'change password' api shows a 500 error when a <call> request is made instead of PUT.
    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']

    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']

    Given url putUrl + '/' + testData_request['userId']
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method <call>
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId | call   |
      | TC57       | POST   |
      | TC58       | DELETE |


  #======================= Invalid URL Call =======================#
  @CP_InvalidUrl @CP_TC59
  Scenario Outline: <testCaseId> - To verify 'change password' api shows a 404 error when a PUT request is made to an invalid endpoint.
    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']
    * def userId = testData_request['userId']

    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']

    Given url putUrlInvalid + '/' +  userId
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId |
      | TC59       |

  #======================= Invalid request body =======================#
  @CP_InvalidRequestBody @CP_TC66
  Scenario Outline: <testCaseId> - To verify 'change password' api shows expected error & fail to update the new password when a PUT request is made for a valid user. Given the PUT request has invalid key:value
    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']
    * def userId = testData_request['userId']

    * set putRequestInvalidJson.oldpwd = testData_request['oldPwd']
    * set putRequestInvalidJson.newpwd = testData_request['newPwd']

    Given url putUrl + '/' +  userId
    And header 'Content-type' = 'application/json'
    And request putRequestInvalidJson
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId |
      | TC66       |


  @CP_InvalidRequestBody @CP_TC67
  Scenario Outline: <testCaseId> - To verify 'change password' api shows expected error & fail to update the new password when a PUT request is made for a valid user. Given the PUT request has an additional key:value
    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']
    * def userId = testData_request['userId']

    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']
    * set putRequestJson.invalidKey = 'invalidValue'

    Given url putUrl + '/' +  userId
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId |
      | TC67       |

  @CP_InvalidRequestBody @CP_TC68 @CP_TC69
  Scenario Outline: <testCaseId> - To verify 'change password' api shows expected error & fail to update the new password when a PUT request is made for a valid user. Given the PUT request has <description> instead of accepted 'json' header
    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']
    * def userId = testData_request['userId']

    Given url putUrl + '/' +  userId
    And request <requestBody>
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId | requestBody | description      |
      | TC68       | '{}'        | text type header |
      | TC69       | {}          | empty json body  |

  @CP_InvalidRequestBody @CP_TC70
  Scenario Outline: <testCaseId> - To verify 'change password' api shows expected error & fail to update the new password when a PUT request is made for a valid user. Given the PUT request has an null values in password fields
    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']
    * def userId = testData_request['userId']

    * set putRequestJson.oldPwd = null
    * set putRequestJson.newPwd = null

    Given url putUrl + '/' +  userId
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId |
      | TC70       |