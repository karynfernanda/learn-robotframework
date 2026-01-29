*** Settings ***
Library           AppiumLibrary

*** Variables ***
# Default is in Android, change to iOS using GHA
${PLATFORM}         Android
${BS_USER}          %{BS_USER=karynfernandayul_8bntM9}
${BS_KEY}           %{BS_KEY=Ne74yKsqR3xTMreuzzzg}
${REMOTE_URL}       http://${BS_USER}:${BS_KEY}@hub-cloud.browserstack.com/wd/hub
${APP_ID_ANDROID}   bs://4dca04fdd2d0ade664e45c5a4239165b84a117c6
${APP_ID_IOS}       bs://7ecc0dddfbe9999223bb585e9aed32140eb16fe3

*** Test Cases ***
Launch And Login Flow
    [Setup]    Launch Setel App
    Register Keyword To Run On Failure    Nothing

    Log To Console    \n* Step 1: Selecting Language...
    Sleep    10s
    ${lang_loc}=    Set Variable If    '${PLATFORM}'=='Android'    xpath=//*[contains(@text, "English")]    accessibility_id=English
    Wait Until Page Contains Element    ${lang_loc}    timeout=30s
    Click Element                       ${lang_loc}

    Log To Console    \n* Step 2: Navigating to Account...
    Sleep    10s
    ${acc_loc}=     Set Variable If    '${PLATFORM}'=='Android'    xpath=//android.widget.TextView[@text="Account"]    xpath=//XCUIElementTypeTabBar/XCUIElementTypeButton[5]
    Wait Until Page Contains Element    ${acc_loc}     timeout=30s
    Click Element                       ${acc_loc}

    Log To Console    \n* Step 3: Clicking Get Started...
    Sleep    5s
    ${start_loc}=   Set Variable If    '${PLATFORM}'=='Android'    xpath=//*[contains(@text, "GET STARTED")]    accessibility_id=GET STARTED
    Wait Until Page Contains Element    ${start_loc}    timeout=20s
    Click Element                       ${start_loc}

    Log To Console    \n* Step 4: Inputting Phone Number...
    Sleep    5s
    ${phone_loc}=   Set Variable If    '${PLATFORM}'=='Android'    com.setel.mobile.staging2:id/edit_phone    accessibility_id=PhoneOTPViewController_phoneTextField
    ${cont_loc}=    Set Variable If    '${PLATFORM}'=='Android'    com.setel.mobile.staging2:id/button_continue    accessibility_id=PhoneOTPViewController_continueButton

    Wait Until Page Contains Element    ${phone_loc}    timeout=20s
    Input Text                          ${phone_loc}    166674000
    Click Element                       ${cont_loc}

    Log To Console    \n* Step 5: Entering OTP...
    ${otp_loc}=     Set Variable If    '${PLATFORM}'=='Android'    com.setel.mobile.staging2:id/edit_pin    accessibility_id=PhoneOTPConfirmationViewController_otpLabelsStackView
    Wait Until Page Contains Element    ${otp_loc}      timeout=20s
    Click Element                       ${otp_loc}
    Input Text                          ${otp_loc}      111111

    [Teardown]    Run Keywords    Update BrowserStack Status    ${TEST_STATUS}    ${TEST_MESSAGE}    AND    Close Application

*** Keywords ***
Launch Setel App
    &{bstack_options}=    Create Dictionary
    ...    projectName=Setel Dynamic CrossPlatform
    ...    buildName=iOS-Android-Test
    ...    appiumVersion=2.4.1

    IF    '${PLATFORM}' == 'Android'
        Open Application    ${REMOTE_URL}
        ...    automationName=UiAutomator2
        ...    platformName=Android
        ...    deviceName=Samsung Galaxy S23
        ...    app=${APP_ID_ANDROID}
        ...    appPackage=com.setel.mobile.staging2
        ...    appActivity=com.zapmobile.zap.splash.SplashActivity
        ...    bstack:options=${bstack_options}
    ELSE
        Open Application    ${REMOTE_URL}
        ...    automationName=XCUITest
        ...    platformName=iOS
        ...    deviceName=iPhone 14
        ...    app=${APP_ID_IOS}
        ...    bundleId=com.setel-staging2.ios
        ...    autoAcceptAlerts=${True}
        ...    autoGrantPermissions=${True}   
        ...    newCommandTimeout=300
        ...    bstack:options=${bstack_options}
    END

Update BrowserStack Status
    [Arguments]    ${status}    ${reason}
    ${bs_status}=    Set Variable If    '${status}'=='PASS'    passed    failed
    Execute Script    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"${bs_status}", "reason": "${reason}"}}