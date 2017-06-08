*** Settings ***
Documentation           This is a simple test with Robot Framework

Library                 Selenium2Library

Resource                resources.robot

Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Login Page



*** Variables ***
${SERVER URL}           https://cloud.vidyocloudqa.com
${LOGIN PAGE URL}       ${SERVER URL}/login-widget
${BROWSER}              Chrome
${DELAY}                2
#${SIGNUP PAGE URL}      https://free.vidyocloudstaging.com/admin/login.html
${FREEUSER}             pavlo.ivanov@globallogic.com
${FREEUSER PASSWORD}    4esZXdr5

*** Keywords ***


Open Browser And Log In
    Open Browser        ${SERVER URL}    ${BROWSER}
    Set Selenium Speed  ${DELAY}
    Maximize Browser Window
    Set Selenium Speed  0
    Input Username  pavlo.ivanov@globallogic.com
    Input Password  4esZXdr5
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

Login page should be open
    Login Page Is Open

Signup page should be open
    Signup Page Is Open

Register button should be disabled
    Register button is disabled

Post login page should be open
    Post login page is open


User leaves all signup fields empty
    Empty all registration fields


User "${username}" logs in with password "${password}"
    Input username    ${username}
    Input password    ${password}
    Submit credentials

User logs out
    Click Logout Button

"${text}" message should be displayed
    Post login page should be open
    Page Should Contain     ${text}

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
    Then post login page should be open
    When user logs out
    Then login page should be open

Verify welcome message on landing page
    Given browser is opened to login page
    When user "${FREEUSER}" logs in with password "${FREEUSER PASSWORD}"
    Then "Welcome to VidyoCloud!" message should be displayed

