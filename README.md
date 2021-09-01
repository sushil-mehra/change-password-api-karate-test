# Change Password API with Automated API testing using Karate 
### Overview
A Spring boot, Java based project to create an API. Post the build is complete it creates a REST Api endpoint that serves a basic functionality of changing the password (*Change Password API*) for an existing user (as per the stated requirements). Once the API is running the same endpoint is utilized to execute the automated API tests to verify the expected functions of the Change Password API.

## Requirement
* **ChangePassword(oldPassword: String, newPassword: String)** - A function that will be used to verify password constraints set and returns, true or false.

    Build the function as a REST API.

## Tasks covered under this module
Below points have been completed
1.	Code for change password function
2.	Implement automated test for the created function, test cases with test data provide in each case
3.	Verify a password with system and similar check function is a mock which return True/False

### Constraints for a New Password to be valid
* At least 18 alphanumeric characters and list of special chars [!@#$&*]
* At least 1 Upper case, 1 lower case ,least 1 numeric, 1 special character
* No duplicate repeat characters more than 4
* No more than 4 special characters
* 50 % of password should not be a number

## Building blocks of the project

The below dependencies are required to start with the project.
* Java (v1.8)
* Maven (v3.6.3)
* Spring Boot & its dependencies
* Karate (v0.9.6)
* Junit4
* Apache Commons (v3.5)
* Cucumber-reporting (v4.4.0)

### Project Components
* API codebase
    + `main\java\com.api.changepassword` - contains Code required to build the rest API.
* Test codebase
    + Unit Test for API - `test\unitTest\com.api.changepassword` contains Unit tests created for the change password API.
    + Functional Test for API - `test\karateTest\src\test\java\apiTest` has the automated functional tests for change password API. 

# Tests covered
To verify the change password API, below tests have been covered under this project.
* Unit test
    > Covered by Junit
* Functional Test 
    > Covered by karate
* Non Functional Test
    > Covered by Karate

## Unit Test
A total of 24 unit tests have been created. 22 unit tests covers the Password constraints business logic check, and 2 unit tests perform sanity check on the application initialization and PUT method.

|                                       |                                       |                                           |                       |
| --------------------------------------|---------------------------------------|-------------------------------------------|-----------------------|
| changePasswordTest()                  | constraintCheck_NoLowerAllUpperChar() | constraintCheck_RepeatedChar_False()		| number50True()		|
| checkDiffTrue()						| constraintCheck_Number_False()		| constraintCheck_SpecialChar_True()		| number50False()		|
| checkDiffFalse()						| repeatedCharCount_charTrue()			| constraintCheck_ExtraSpecialChar_False()	| number50EqualFalse()	|
| constraintCheck_Length_True()			| repeatedCharCount_charFalse()			| constraintCheck_SpecialChar_False()		| trimListTrue()		|
| constraintCheck_Length_False()		| repeatedCharCount_SpecialTrue()		| constraintCheck_UpperAndLower()			| contextLoads()		|
| constraintCheck_RepeatedChar_True()	| repeatedCharCount_SpecialFalse()		| constraintCheck_NoUpperAllLower()			| testUpdatePut()		|

## Functional Test
All functional tests covered are given below
* Happy Path - Covers positive flow scenario.
* Unhappy Path - Covers negative flow scenario.
    + Invalid Request check
    + Password Length check
    + Special Char check
    + Char case(upper/lower) check
    + Repetition (char/special char/number) check
    + String Similarity Check
* Schema Validation - Covers schema validation for all the response.
* DB validation - Covers data update in database.

### Test case table

|S.No.|Category|High Level	|Description | Test Case ID|
---| ------ | ---------- | ----------- | :-----------: |
| 1|Happy Path|Password meets all constraints|New Password meets all the given constraints|ChangePass_TC01|
|2|Invalid Request|Input Password field is empty|Old Password empty|ChangePass_TC02|
|  |  |  |New Password empty|ChangePass_TC03|
|  |  |  |new Password & old Password entered as empty|ChangePass_TC04|
|  |  |  |the old Password invalid|ChangePass_TC05|
|  |  |User does not exist|invalid user|ChangePass_TC06|
|  |  |Incorrect request body|Pass different keys as expected in the request body|ChangePass_TC66|
|  |  |  |Add any additional key field in the request json|ChangePass_TC67|
|  |  |  |Pass content-type as TEXT instead of JSON|ChangePass_TC68|
|  |  |  |Pass empty json body|ChangePass_TC69|
|  |  |  |Pass field value as null to both|ChangePass_TC70|
|3 |Password Length check|Password length=18|18 length unique chars (9 lowercase + 9 uppercase)|ChangePass_TC07|
|  |  |  |18 length unique chars (9 number + 9 special char[!@#$&*])|ChangePass_TC08|
|  |  |  |all 18 repeating number|ChangePass_TC09|
|  |  |  |18 repeating special chars (9 not accepted special chars + 9 from the accepted special chars [!@#$&*])|ChangePass_TC10|
|  |  |Password length<18|17 all unique chars (9 lowercase + 8 uppercase)|ChangePass_TC11|
|  |  |  |17 chars are number|ChangePass_TC12|
|  |  |  |Password has number,lowercase,uppercase & special char with 4 occurrence|ChangePass_TC13|
|  |  |  |enter only one char|ChangePass_TC14|
|  |  |Password length>18|Password has same 5 uppercase, 5 lowercase, 5 number, 5 special chars from the given list(!@#$&*)|ChangePass_TC15|
| 4|Special Char check|Special Chars check present/absent check [!@#$&*]|Password has one <!> special char present from the list [!@#$&*]|ChangePass_TC16|
|  |  |  |Password has one <@> special char present from the list [!@#$&*]|ChangePass_TC17|
|  |  |  | Password has one <#> special char present from the list [!@#$&*]|ChangePass_TC18|
|  |  |  |Password has one <$> special char present from the list [!@#$&*]|ChangePass_TC19|
|  |  |  |Password has one <&> special char present from the list [!@#$&*]|ChangePass_TC20|
|  |  |  |Password has one <*> special char present from the list [!@#$&*]|ChangePass_TC21|
|  |  |  |Password has all <~`%()-_/(pipe)\\}{[].':=+;> special char present not from the list [!@#$&*]|ChangePass_TC22|
|  |  |  |Password has no special char present from the list [!@#$&*]|ChangePass_TC23|
| 5|Char case check|char case : uppercase|Password  has at least one uppercase alphabets present|ChangePass_TC24|
|  |  |  |Password contains no uppercase alphabets|ChangePass_TC25|
|  |  |char case : lowercase|Password contains at least one lowercase alphabets present|ChangePass_TC26|
|  |  |  |Password contains no lowercase alphabets|ChangePass_TC27|
|  |  |char case : numeric|Password has no numbers|ChangePass_TC28|
|  |  |  |Password contains at least one number|ChangePass_TC29|
| 6|Char + special chars repetition check|Chars with = 4, <4, >4 repetition check |Password  has one number with more than 4 occurrence|ChangePass_TC30|
|  |  |  |Password  has one number with exact 4 occurrence|ChangePass_TC31|
|  |  |  |Password has one lowercase char with more than 4 occurrence|ChangePass_TC32|
|  |  |  |Password has one uppercase char with more than 4 occurrence|ChangePass_TC33|
|  |  |  |Password has one lowercase char with exact 4 occurrence|ChangePass_TC34|
|  |  |  |Password has one uppercase char with exact 4 occurrence|ChangePass_TC35|
|  |  |  |Password has both a number & a char with exact 4 occurrence|ChangePass_TC36|
|  |  |  |Password has both a number & a char with more than 4 occurrence|ChangePass_TC37|
|  |  |  |Password has lowercase, uppercase of same char with more than 4 occurrence|ChangePass_TC38|
|  |  |  |Password has char 'Z' with 4 uppercase & 4 lowecase occurrences|ChangePass_TC39|
|  |  |Special Chars with = 4, <4, >4 repetition check |Password entered has one special char - '@' with 4 occurrence|ChangePass_TC40|
|  |  |  |Password  has one special char - '$' with more than 4 occurrence|ChangePass_TC41|
|  |  |  |Password  has one special char not from the list - '^' with more than 4 occurrence|ChangePass_TC42|
|  |  |  |Password  has one special char not from the list - '^' with 4 occurrence|ChangePass_TC43|
| 7|Number Check|Numbers presence <50%, =50%, >50% check|Password  has 2 consecutive number at alternate positions|ChangePass_TC44|
|  |  |  |Password  has all numbers in first half|ChangePass_TC45|
|  |  |  |Password has all numbers in second half|ChangePass_TC46|
|  |  |  |Password  has consecutive number at alternate positions|ChangePass_TC47|
|  |  |  |Password  has number less than 50% of Password length|ChangePass_TC48|
| 8|New Password similarity|New Password is <80%, =80%, >80% match|Password is a combination of a unique string suffixed to existing old password|ChangePass_TC49|
|  |  |  |Password is a combination of a unique string prefix to existing old password|ChangePass_TC50|
|  |  |  |Password is same as old password|ChangePass_TC51|
|  |  |  |Password is same as old Password with 4 duplicate chars in the middle|ChangePass_TC52|
|  |  |  |Password is same as old Password with 5 duplicate chars in the middle|ChangePass_TC53|
|  |  |  |Password is same as old Password with 5 duplicate chars as prefix|ChangePass_TC54|
|  |  |  |Password is same as old Password with 5 duplicate chars as suffix|ChangePass_TC55|
|  |  |  |Password is combination of same old Password with 4 duplicate chars - 'z,Z' at alternate position.|ChangePass_TC56|
| 9|Invalid Request check|Incorrect request & incorrect endpoint|Make a POST call instead of PUT|ChangePass_TC57|
|  |  |  |Make a DELETE call instead of PUT|ChangePass_TC58|
|  |  |  |Make a PUT call to invalid URL|ChangePass_TC59|
| 10|Schema Validation|Response Schema validation for all flows|happy Path schema check|ChangePass_TC60|
|  |  |  |Validate schema for Error request 400|ChangePass_TC61|
|  |  |  |Valdiate schema for Error request 404|ChangePass_TC62|
|  |  |  |Valdiate schema for Error request 500|ChangePass_TC63|
|11|DB check|DB update|Check Password has been updated successfully|ChangePass_TC64|
|  |  |No DB update|Check Password is not updated in case of any error|ChangePass_TC65|

**Note:** 
1. Database validation tests created are OOS(out of scope), as we have mocked the user objects within the API (see later section). Otherwise, if the database connectivity were present then the same test cases (ChangePass_TC64 & ChangePass_TC65) stands valid & to be covered under functional testing.
2. Please refer to the location - `testartifacts` it contains test data excel file and a report file.

## Non Functional Test
A basic response time(<500ms) check has been covered for *changePassword API* in all of the test cases that will confirm whether we are getting the response within the expected time. And it is easily configurable in case, we need to test it for a different threshold.

# Setup Steps - Build API + Test Execution

## 1. Building API

**1.1 Clone the application**
```bash
https://github.com/sushil-mehra/change-password-api-karate-test.git
```

**1.1.1 Build and run the app using maven**
```bash
mvn package
```
After the jar file is created under ``target/change-password-api-karate-tests-1.0.0-SNAPSHOT.jar``. Run the below command to start the application.
```bash
java -jar target/change-password-api-karate-tests-1.0.0-SNAPSHOT.jar
```
Alternatively, you can run the app without packaging it using -

```bash
mvn spring-boot:run
```

**1.1.2 Run the app using docker**
After packaging the JAR file. Go to the directory where the `Dockerfile` is located. Then use below command.
```bash
docker build -t changeapi
```
the `changeapi` refers to the image name and can be given any value.

Once docker image has been created from previous step, now run the same image in a container by using the following command.
```bash
docker run -d -p 8081:8081 --name changeapi-test changeapi
```
The app will start running at <http://localhost:8081> as per (`server.port` in application.properties file).

The app defines one endpoint only to perform the update operation for any existing user.
    
    PUT /v1/updatePassword/users/{userId}

The request needs below request body to work.
```javascript
{
  "oldPwd" : "oldPassword",
  "newPwd" : "newPassword"
}
```

## 2. Running Automation Karate Tests
In order to run all the automated tests at one please use below :

```bash
mvn clean test -Dkarate.options="--tags @MyTestTag" -Dkarate.env=dev -Dkarate.threads=1
```
*Note:-*
1. Replace `@MyTestTag` with a tag from the above list (e.g. `@CP_Regression`). 
2. **karate.env** & **karate.threads** arguments have a default value set. It is only required when we need to override the default values.

#### Tags available to run specific tests for functional tests
To run a specific test annotation from @CP1 to @CP70 can be used. However, in order to run any specific test as per the group defined previously. The below list of tags can be used.

    * Regression                * Invalid Request check             * Special Char check
        => @CP_Regression           => @CP_InvalidUrl                   => @CP_SpCharCheck
    * Sanity                        => @CP_InvalidRequestBody       * Char case(upper/lower) check
        => @CP_Sanity               => @CP_InvalidRequest               => @CP_CharCaseCheck
    * Happy Path                    => @CP_IncorrectMethod          * Repetition check
        => @CP_HappyPath            => @CP_PwdIncorrect                 => @CP_CharRepeatCheck
        => @CP_ValidRequest         => @CP_50NumberCheck            * Schema Validation
    * Unhappy Path              * Database validation                   => @CP_ValidateSchema
        => @CP_UnhappyPath          => @CP_DbValidation
    * Password Length check 
        => @CP_LengthCheck    
    
*Note:-* Refer to the feature files at `apiTest\features` under karateTest for more details on the available tags.

# Test Report
Post successful execution of all the Karate Tests. A detailed cucumber report will generate at `src\test\karateTest\target\cucumber-html-reports`. Then open `overview-features.html` from cucumber-html-reports in any browser (refer to the `testartifacts` for sample report) to view the test-result.

Refer to the `testartifacts` where complete test data & sample test report has been added.
