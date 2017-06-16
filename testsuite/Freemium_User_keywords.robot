*** Settings ***
Documentation           This is a simple test with Robot Framework

Library                 Selenium2Library

Resource                resources.robot

Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Login Page
#Test Teardown     User logs out



*** Variables ***
${SERVER URL}           https://cloud.vidyocloudqa.com
${LOGIN PAGE URL}       ${SERVER URL}/login-widget
${BROWSER}              Chrome
${DELAY}                2
#${SIGNUP PAGE URL}      https://free.vidyocloudstaging.com/admin/login.html
${FREEUSER}             ecommerce.freemium@gmail.com
${FREEUSER PASSWORD}    V!dy0433

*** Keywords ***


Open Browser And Log In
    Open Browser        ${SERVER URL}    ${BROWSER}
    Set Selenium Speed  ${DELAY}
    Maximize Browser Window
    Set Selenium Speed  0
    Input Username  ${FREEUSER}
    Input Password  ${FREEUSER PASSWORD}
    Set Selenium Speed  ${DELAY}
    Submit Credentials
    Set Selenium Speed  0
    Page Should Contain     Logout

Log Out Admin
    Click Logout


Browser is opened to login page
    Go To Login Page

Browser is opened to signup page
    Go To Signup Page

User clicks signup link
    Click Signup Link

User clicks signup button
    Click Signup Button

User clicks Forgot Password link
    Click Forgot Password link




Login page should be open
    Login Page Is Open

Signup page should be open
    Signup Page Is Open

Register button should be disabled
    Register button is disabled

My account page should be open
    My account page is open

Reset password page should be open
    Reset password page is open

Change password page should be open
    Change password page is open


User leaves all signup fields empty
    Empty all registration fields


User "${username}" logs in with password "${password}"
    Input username    ${username}
    Input password    ${password}
    Submit credentials


User logs out
    Click Logout Button

User sends reset password email to "${useremail}"
    Send reset password email to "${useremail}"

User receives email with a link for recovery of password
    Check email with a link for recovery of password

User presses send reset email button with empty email field
    Clear reset email field
    Press send reset email button

"${text}" message should be displayed
    My account page should be open
    Page Should Contain     ${text}

"${text}" error should be displayed
    Login page should be open
    Wait Until Page Contains       ${text}    30


Vidyo logo should redirect user to main Vidyo page
    My account page should be open
    Page should contain element       xpath=//a[@href='https://www.vidyo.com/']

User changes current password "${olduserpass}" to "${userpass}"
    Click Change Password Button
    Change Password page should be open
    Type old password "${olduserpass}"
    Type new password "${userpass}"
    Submit new password
    Wait Until Page Does Not Contain Element       xpath=//button[@id='password-change-submit']    30
    My account page should be open

Type old password "${userpass}"
    Input Text    xpath=//input[@id='oldPassword']    ${userpass}

Type new password "${userpass}"
    Input Text    xpath=//input[@id='newPassword']    ${userpass}
    Input Text    xpath=//input[@id='confirmPassword']    ${userpass}

Submit new password
    Page should contain element      xpath=//p[contains(text(),'Password looks good! Click the button to change.')]
    Click element   xpath=//button[@id='password-change-submit']

User opens browser "${browser}" to "${url}"
    Open Browser   ${url}  ${browser}
    Maximize Browser Window


User closes browser
    Close browser

User opens login page
    Go to   ${LOGIN PAGE URL}

*** Test Cases ***
#Open FreeUser Site
    #Open Browser To Login Page
    #Open Browser And Log In
    #Log Out Admin
    #Sleep   10 sec
    #[Teardown]    Close Browser

Verify the available plans on e-Commerce portal
    Given browser is opened to login page
    When user clicks signup link
    Then signup page should be open
    Given browser is opened to login page
    When user clicks signup link
    Then signup page should be open

Sign up is impossible with all fields empty
    Given browser is opened to signup page
    When user leaves all signup fields empty
    Then register button should be disabled

User login logout
    Given browser is opened to login page
    When user "${FREEUSER}" logs in with password "${FREEUSER PASSWORD}"
    Then My account page should be open
    When user logs out
    Then login page should be open

Verify welcome message on landing page
    Given browser is opened to login page
    When user "${FREEUSER}" logs in with password "${FREEUSER PASSWORD}"
    Then "Welcome to VidyoCloud!" message should be displayed
    And user logs out

Verify Vidyo logo redirects user to www.vidyo.com
    Given browser is opened to login page
    When user "${FREEUSER}" logs in with password "${FREEUSER PASSWORD}"
    Then Vidyo logo should redirect user to main Vidyo page
    And user logs out




# ------ Freemiun user login ---------

Sign in with invalid credentials
    Given browser is opened to login page
    When user "!@#$%^&~*()_+}{[]:"\|" logs in with password "!@#$%^&~*()_+}{[]:"\|"
    #Sleep   5 sec
    Then login page should be open
    And "Sign in failed!" error should be displayed

Sign in with invalid user name
    Given browser is opened to login page
    When user "!@#$%^&~*()_+}{[]:"\|" logs in with password "${FREEUSER PASSWORD}"
    #Sleep   5 sec
    Then "Sign in failed!" error should be displayed

Sign in with invalid password
    Given browser is opened to login page
    When user "${FREEUSER}" logs in with password "!@#$%^&~*()_+}{[]:"\|"
    #Sleep   5 sec
    Then "Sign in failed!" error should be displayed

Check forgotten password link with proper email id
    Given browser is opened to login page
    When user clicks Forgot Password link
    Then reset password page should be open
    When user sends reset password email to "${FREEUSER}"
    Then reset password email sent page is open
    And user receives email with a link for recovery of password
    #Sleep   5 sec

Check forgotten password link without email id
    Given browser is opened to login page
    When user clicks Forgot Password link
    Then reset password page should be open
    When user presses send reset email button with empty email field
    Then reset password page should be open

Sign in with the credentials which are passed through the proper signup and password set steps
    Given browser is opened to login page
    When user "${FREEUSER}" logs in with password "${FREEUSER PASSWORD}"
    Then My account page should be open
    When user logs out
    Then login page should be open

Check error message on login failure cases
    Given browser is opened to login page
    When user "!@#$%^&~*()_+}{[]:"\|" logs in with password "!@#$%^&~*()_+}{[]:"\|"
    #Sleep   5 sec
    Then login page should be open
    And "Sign in failed!" error should be displayed

Change password and sign in with new password
    Given browser is opened to login page
    When user "${FREEUSER}" logs in with password "${FREEUSER PASSWORD}"
    And My Account page is open
    And user changes current password "${FREEUSER PASSWORD}" to "V!dy0432"
    And user logs out
    When user "${FREEUSER}" logs in with password "V!dy0432"
    Then My account page should be open
    And user changes current password "V!dy0432" to "${FREEUSER PASSWORD}"
    And user logs out

Sign in multiple times with same user
    Given browser is opened to login page
    When user "${FREEUSER}" logs in with password "${FREEUSER PASSWORD}"
    And My Account page is open
    And user closes browser
    And user opens browser "chrome" to "${LOGIN PAGE URL}"
    And browser is opened to login page
    And user "${FREEUSER}" logs in with password "${FREEUSER PASSWORD}"
    Then My Account page is open
    Then user logs out
    And user closes browser
    When user opens browser "Chrome" to "${LOGIN PAGE URL}"
    And user "${FREEUSER}" logs in with password "${FREEUSER PASSWORD}"
    Then My Account page is open
    Then user logs out

Sign in multiple times with different user
    Given browser is opened to login page
    When user "${FREEUSER}" logs in with password "${FREEUSER PASSWORD}"
    And My Account page is open
    When user opens login page
    Then My Account page is open
    Then user logs out

Open free account page
    Given browser is opened to login page
    When user "${FREEUSER}" logs in with password "${FREEUSER PASSWORD}"
    Then My Free Account page is open