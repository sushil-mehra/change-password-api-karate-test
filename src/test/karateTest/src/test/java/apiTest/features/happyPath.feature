#################################################
# Date:         21-08-2021                      #
# Author:       Sushil Mehra                    #
# Version:      v1.0                            #
# Description:  Tests for Happy Path            #
#################################################

@CP_HappyPath @CP_Regression
Feature: Verify Change Password API is able to update the password for the given user, when a valid request has been made

  Background:
    * json changeApiMetaData = apiMetaData['changePasswordAPI']
    * def baseUrl = changeApiMetaData['baseUrl']
    * def putUrl = changeApiMetaData['urls']['put']
    * json putRequestJson = read('../common/dynamicMessage/changePassword_PUT_body.json')['changePasswordAPI']
    * def sleep = function(){ java.lang.Thread.sleep(500) }
    * def respTimeThreshold = respThreshold
    * def testData = read('../common/testData/' + env + '/changePasswordAPI.json')

  @CP_ValidRequest @CP_TC01 @CP_TC39
  Scenario Outline: <testCaseId> - To verify 'change password' api is able to update the password successfully when
  a PUT request is made for a valid user and new password '<description>'

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
    Then match response.message == testData_response['message']

    Examples:
      | testCaseId | description                                 |
      | TC01       | meets all the given constraints             |
      | TC39       | has char 'Z' with 4 uppercase & 4 lowercase |

