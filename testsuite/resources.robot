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
${POST LOGIN PAGE}       ${SERVER URL}/my-account



*** Keywords ***

Go To Login Page
    Go To    ${LOGIN PAGE URL}
    Login Page Is Open

Go To Signup Page
    Go To    ${SIGNUP PAGE URL}
    Signup Page Is Open

Login Page Is Open
    Wait Until Page Contains    Sign In to VidyoCloud
    Location Should Contain   ${LOGIN PAGE URL}
    Title Should Be           VidyoCloud eCommerce Portal

    #Page Should Contain       Sign In to VidyoCloud

Signup Page Is Open
    Location Should Contain   ${SIGNUP PAGE URL}
    Title Should Be           VidyoCloud eCommerce Portal
    Page Should Contain       Start Video Meetings For FREE

Post Login Page Is Open
    Wait Until Page Does Not Contain Element       xpath=//input[contains(@value,'Sign In')]    30
    Wait Until Page Contains       Here's the link to your personal meeting room!    30
    Location Should Contain   ${POST LOGIN PAGE}
    #Signing in to eCommerce-portal-staging

Register button is disabled
    Location Should Contain   ${SIGNUP PAGE URL}
    Page Should Contain Button  xpath=//button[contains(text(),'Register') and contains(@id,'user-register') and contains(@disabled,'')]

Empty all registration fields
    Location Should Contain   ${SIGNUP PAGE URL}
    Input Text    xpath=//input[@id='firstName']    ${EMPTY STRING}
    Input Text    xpath=//input[@id='lastName']    ${EMPTY STRING}
    Input Text    xpath=//input[@id='company']    ${EMPTY STRING}
    Input Text    xpath=//input[@id='emailAddress']    ${EMPTY STRING}
    Select From List by Value   xpath=//select[@id='country']   US
    #Sleep   5 sec
    Input Text    xpath=//input[@id='phoneNumber']    ${EMPTY STRING}


Input Username
    [Arguments]    ${username}
    Input Text    xpath=//input[@name='username']    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    xpath=//input[@name='password']    ${password}

Submit Credentials
    Click Signin Link

Click Logout
    Click Element   xpath=//a[contains(text(),'Logout')]

Click Signup Link
    Click Element   xpath=//a[contains(text(),'Click here to Sign Up')]

Click Signin Link
    Click Element   xpath=//input[contains(@value,'Sign In')]

Click Signup Button
    Click Element   xpath=//a[text() = 'Sign up']

Click Logout Button
    Click Element   xpath=//a[contains(@class, 'dropdown-toggle')]
    Click Element   xpath=//a[text() = 'Logout']

Open Browser To Login Page
    Open Browser        ${SERVER URL}   ${BROWSER}
    Maximize Browser Window
    #Set Selenium Speed  ${DELAY}
    #Go To    ${LOGIN URL}
    #Sleep   10 sec
    Login Page Is Open

