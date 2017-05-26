*** Settings ***
Documentation     Suite description

Library           Selenium2Library
Resource          resources.robot

Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Login Page
Test Template     Login With Invalid Credentials Should Fail



*** Test Cases ***
Test title
    #[Tags]    DEBUG
    #Provided precondition
    #When action
   # Then check expectations

*** Keywords ***
Provided precondition
    #Setup system under test