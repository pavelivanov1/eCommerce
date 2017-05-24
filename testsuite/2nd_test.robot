*** Settings ***
Documentation           This is a simple test with Robot Framework
Library                 Selenium2Library



Resource          resources.robot

*** Variables ***
${SERVER}               https://free.vidyocloudstaging.com/admin/login.html
${BROWSER}              Chrome
${DELAY}                5
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
    Maximize Browser Window
    Input Username  pivanov
    Input Password  4esZXdr5
    Sleep   2 sec
    Submit Credentials
    Sleep   5 sec


 
 
*** Test Cases ***
Valid Login
    #Open Browser To Login Page
    #Close Browser
    Open Browser And Log In
    [Teardown]    Close Browser

