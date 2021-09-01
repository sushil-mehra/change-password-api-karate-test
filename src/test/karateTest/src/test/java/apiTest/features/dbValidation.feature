#################################################
# Date:         26-08-2021                      #
# Author:       Sushil Mehra                    #
# Version:      v0.1(draft status)              #
# Description:  DB validation Test              #
#################################################

@CP_Regression @CP_DbValidation
Feature: Verify Change Password API is able to update the password for the given user when response is a success

  Background:
    * json changeApiMetaData = apiMetaData['changePasswordAPI']
    * def baseUrl = changeApiMetaData['baseUrl']
    * def putUrl = changeApiMetaData['urls']['put']
    * json putRequestJson = read('../common/dynamicMessage/changePassword_PUT_body.json')['changePasswordAPI']
    * def sleep = function(){ java.lang.Thread.sleep(500) }
    * def testData = read('../common/testData/' + env + '/changePasswordAPI.json')

  @CP_TC64 @CP_TC65
  Scenario Outline: <testCaseId> - Given a valid PUT request is made to 'change password' api. Then, validate the new password is <description> in db table for the same user.

    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']

    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']

    Given url putUrl + '/' + testData_request['userId']
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method put
    And assert responseTime < 1000
    Then match responseStatus == testData_response['statusCode']
    Then match response.message == testData_response['message']

    # DB validation to be performed here. It has been skipped for now, we have mocked up DB into the service itself
    * print '**** DB validation to be performed here. It has been skipped for now, we have mocked up DB into the service itself ***'

    Examples:
      | testCaseId | description |
      | TC64       | updated     |
      | TC65       | not updated |

