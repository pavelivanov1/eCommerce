*** Settings ***
Documentation           This is a simple test with Robot Framework
Library                 Selenium2Library



Resource          resources.robot

*** Variables ***
${SERVER}               https://free.vidyocloudstaging.com/admin/login.html
${BROWSER}              Chrome
${DELAY}                2
${LOGIN URL}            https://free.vidyocloudstaging.com/admin/login.html
 
 
*** Keywords ***
Open Browser To Login Page
    Open Browser        ${SERVER}   ${BROWSER}
    Maximize Browser Window
    #Set Selenium Speed  ${DELAY}
    #Go To    ${LOGIN URL}
    #Sleep   10 sec
    Location Should Contain   ${SERVER}

Open Browser And Log In
    Open Browser        ${SERVER}   ${BROWSER}
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


*** Test Cases ***
Login Admin
    Open Browser And Log In
    Log Out Admin
    Sleep   10 sec
    [Teardown]    Close Browser

