*** Settings ***
Documentation           This is a simple test with Robot Framework
Library                 Selenium2Library
 
 
*** Variables ***
${SERVER}               http://google.com
${BROWSER}              Chrome
${DELAY}                5
${LOGIN URL}            https://free.vidyocloudstaging.com/admin/login.html
 
 
*** Keywords ***
Open Browser To Login Page
    Open Browser        ${SERVER}   ${BROWSER}
    Maximize Browser Window
    #Set Selenium Speed  ${DELAY}
    Go To    ${LOGIN URL}
    Sleep   10 sec

 
 
*** Test Cases ***
Valid Login
    Open Browser To Login Page
    [Teardown]    Close Browser