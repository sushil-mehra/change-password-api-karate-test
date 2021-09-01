#################################################
# Date:         22-08-2021                      #
# Author:       Sushil Mehra                    #
# Version:      v1.0                            #
# Description:  Schema Validation Test          #
#################################################

@CP_Regression @CP_ValidateSchema
Feature: Validate the response schema has all the expected fields for all responses - 200,400,404,500

  Background:
    * json changeApiMetaData = apiMetaData['changePasswordAPI']
    * def baseUrl = changeApiMetaData['baseUrl']
    * def putUrl = changeApiMetaData['urls']['put']
    * json putRequestJson = read('../common/dynamicMessage/changePassword_PUT_body.json')['changePasswordAPI']
    * def respTimeThreshold = respThreshold
    * def sleep = function(){ java.lang.Thread.sleep(500) }
    * def testData = read('../common/testData/' + env + '/changePasswordAPI.json')
    * def schemaJson = read('../common/schema/changePasswordSchema.json')


  @CP_TC60 @CP_Sanity
  Scenario Outline: <testCaseId> - Given a valid PUT request is made to 'change password' api. Validate the response schema with expected schema when response returned is 200

    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']
    * def schema = schemaJson['200']
    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']

    Given url putUrl + '/' + testData_request['userId']
    And header 'Content-type' = 'application/json'
    And request putRequestJson
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.message == testData_response['message']
    Then match response == schema

    Examples:
      | testCaseId |
      | TC60       |

  @CP_TC61 @CP_TC62 @CP_TC63
  Scenario Outline: <testCaseId> - Given a valid PUT request is made to 'change password' api. Validate the response schema with expected schema when response returned is <description>

    * def testData = testData['<testCaseId>']
    * def testData_request = testData['request']
    * def testData_response = testData['response']
    * def schema = schemaJson['<description>']
    * set putRequestJson.oldPwd = testData_request['oldPwd']
    * set putRequestJson.newPwd = testData_request['newPwd']

    Given url putUrl + '/' + testData_request['userId']
    And header 'Content-type' = 'application/json'
    And request <requestBody>
    When method put
    And assert responseTime < respTimeThreshold
    Then match responseStatus == testData_response['statusCode']
    Then match response.status == testData_response['status']
    Then match response.message == testData_response['message']
    Then match response == schema

    Examples:
      | testCaseId | requestBody    | description |
      | TC61       | putRequestJson | 400         |
      | TC62       | putRequestJson | 404         |
      | TC63       | '{}'           | 500         |

