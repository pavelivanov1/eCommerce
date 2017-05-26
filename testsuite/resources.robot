*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library


*** Variables ***
${SERVER URL}           https://cloud.vidyocloudstaging.com
${LOGIN PAGE URL}       ${SERVER URL}/login-widget
${SIGNUP PAGE URL}      ${SERVER URL}/signup

${BROWSER}              Chrome
${DELAY}                2
${EMPTY STRING}         ${EMPTY}



*** Keywords ***

Go To Login Page
    Go To    ${LOGIN PAGE URL}
    Login Page Is Open

Go To Signup Page
    Go To    ${SIGNUP PAGE URL}
    Signup Page Is Open

Login Page Is Open
    Location Should Contain   ${LOGIN PAGE URL}
    Title Should Be           VidyoCloud eCommerce Portal
    Page Should Contain       Sign In to VidyoCloud

Signup Page Is Open
    Location Should Contain   ${SIGNUP PAGE URL}
    Title Should Be           VidyoCloud eCommerce Portal
    Page Should Contain       Start Video Meetings For FREE

Register button is disabled
    Location Should Contain   ${SIGNUP PAGE URL}
    Page Should Contain Button  xpath=//button[contains(text(),'Register') and contains(@id,'user-register') and contains(@disabled,'')]

Empty all registration fields
    Location Should Contain   ${SIGNUP PAGE URL}
    Input Text    xpath=//input[@id='firstName']    ${EMPTY STRING}
    Input Text    xpath=//input[@id='lastName']    ${EMPTY STRING}
    Input Text    xpath=//input[@id='company']    ${EMPTY STRING}
    Input Text    xpath=//input[@id='emailAddress']    ${EMPTY STRING}
    Select From List by Value   xpath=//select[@id='country']   defualtCountry
    Input Text    xpath=//input[@id='phoneNumber']    ${EMPTY STRING}


Input Username
    [Arguments]    ${username}
    Input Text    username-inputEl    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    textfield-1026-inputEl    ${password}

Submit Credentials
    Click Element    xpath=//span[contains(text(),'Login')]

Click Logout
    Click Element   xpath=//a[contains(text(),'Logout')]

Click Signup Link
    Click Element   xpath=//a[contains(text(),'Click here to Sign Up')]

Click Signup Button
    Click Element   xpath=//a[text() = 'Sign up']

Open Browser To Login Page
    Open Browser        ${SERVER URL}   ${BROWSER}
    Maximize Browser Window
    #Set Selenium Speed  ${DELAY}
    #Go To    ${LOGIN URL}
    #Sleep   10 sec
    Login Page Is Open

