*** Settings ***
Documentation           This is a simple test with Robot Framework

Library                 Selenium2Library

Resource                resources.robot

Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Login Page



*** Variables ***
${SERVER URL}           https://cloud.vidyocloudstaging.com
${LOGIN PAGE URL}       https://cloud.vidyocloudstaging.com/login-widget
${BROWSER}              Chrome
${DELAY}                2
#${SIGNUP PAGE URL}      https://free.vidyocloudstaging.com/admin/login.html

*** Keywords ***


Open Browser And Log In
    Open Browser        ${SERVER URL}    ${BROWSER}
    Set Selenium Speed  ${DELAY}
    Maximize Browser Window
    Set Selenium Speed  0
    Input Username  pivanov
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

Signup page should be open
    Signup Page Is Open

Register button should be disabled
    Register button is disabled

User leaves all signup fields empty
    Empty all registration fields

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

