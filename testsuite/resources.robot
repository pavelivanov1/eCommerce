*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library

*** Keywords ***
Input Username
    [Arguments]    ${username}
    Input Text    username-inputEl    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    textfield-1026-inputEl    ${password}

Submit Credentials
    Click Element    button-1030-btnEl