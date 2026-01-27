*** Settings ***
Library           AppiumLibrary

*** Variables ***
${BS_USER}          %{BS_USER=karynfernandayul_8bntM9}
${BS_KEY}           %{BS_KEY=Ne74yKsqR3xTMreuzzzg}
${REMOTE_URL}       http://${BS_USER}:${BS_KEY}@hub-cloud.browserstack.com/wd/hub
${APP_ID}           bs://4dca04fdd2d0ade664e45c5a4239165b84a117c6

*** Test Cases ***
Launch And Login Flow
    [Setup]    Launch Setel App
    Register Keyword To Run On Failure    Nothing

    Log To Console    \n* Step 1: Selecting Language...
    Wait Until Page Contains Element    xpath=//*[contains(@text, "English")]    timeout=30s
    Click Element                       xpath=//*[contains(@text, "English")]

    Log To Console    \n* Step 2: Navigating to Profile...
    Sleep    10s
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Account"]    timeout=30s
    Click Element                       xpath=//android.widget.TextView[@text="Account"]
    
    Log To Console    \n* Step 3: Clicking Get Started...
    Sleep    5s
    Wait Until Page Contains Element    xpath=//*[contains(@text, "GET STARTED")]    timeout=20s
    Click Element                       xpath=//*[contains(@text, "GET STARTED")]

    Log To Console    \n* Step 4: Inputting Phone Number...
    Sleep    5s
    Wait Until Page Contains Element    com.setel.mobile.staging2:id/edit_phone    timeout=20s
    Input Text                          com.setel.mobile.staging2:id/edit_phone    166674000
    Click Element                       com.setel.mobile.staging2:id/button_continue

    Log To Console    \n* Step 5: Entering OTP...
    Wait Until Page Contains Element    com.setel.mobile.staging2:id/edit_pin    timeout=20s
    Input Text                          com.setel.mobile.staging2:id/edit_pin    111111
    
    [Teardown]    Close Application
