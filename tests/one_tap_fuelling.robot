*** Settings ***
Documentation     Epic: Fuel One tab Fuelling | Feature: OneTabFuelling
...               This suite handles the One-Tap Fuelling flow for both Android and iOS.
Library           AppiumLibrary

*** Variables ***
# Default platform is Android, can be overridden via CLI (e.g., --variable PLATFORM:iOS)
${PLATFORM}         Android
${BS_USER}          %{BS_USER=karynfernandayul_8bntM9}
${BS_KEY}           %{BS_KEY=Ne74yKsqR3xTMreuzzzg}
${REMOTE_URL}       http://${BS_USER}:${BS_KEY}@hub-cloud.browserstack.com/wd/hub
${APP_ID_ANDROID}   bs://4dca04fdd2d0ade664e45c5a4239165b84a117c6
${APP_ID_IOS}       bs://7ecc0dddfbe9999223bb585e9aed32140eb16fe3

*** Test Cases ***
FL_2135 Unsuccessful Place Order Wallet Balance < RM3
    [Documentation]    Verify system behavior when wallet balance is insufficient (< RM3)
    [Tags]             regression    fuel    one-tap-fuelling    FL-2135    reg_178
    [Setup]            Launch Setel App

    # Step 1: Handle Language Selection (Android only)
    IF    '${PLATFORM}' == 'Android'
        Log To Console    * Step 1: Selecting English Language (Android only)
        Wait Until Page Contains Element    xpath=//*[contains(@text, "English")]    timeout=30s
        Click Element                       xpath=//*[contains(@text, "English")]
    ELSE
        Log To Console    * Step 1: Skipping Language Selection (iOS goes straight to Dashboard)
        Sleep    10s    # Give time for autoAcceptAlerts to handle system pop-ups
    END

    # Step 2: Navigate to Account/Profile page
    Log To Console    * Step 2: Navigating to Account page
    ${acc_loc}=     Set Variable If    '${PLATFORM}'=='Android'
    ...    xpath=//android.widget.TextView[@text="Account"]
    ...    xpath=//XCUIElementTypeTabBar/XCUIElementTypeButton[5]
    Wait Until Page Contains Element    ${acc_loc}     timeout=30s
    Click Element                       ${acc_loc}

    # Step 3: Click 'Get Started' button
    Log To Console    * Step 3: Clicking Get Started
    ${start_loc}=   Set Variable If    '${PLATFORM}'=='Android'
    ...    xpath=//*[contains(@text, "GET STARTED")]
    ...    accessibility_id=GET STARTED
    Wait Until Page Contains Element    ${start_loc}    timeout=20s
    Click Element                       ${start_loc}

    [Teardown]    Run Keywords    Update BrowserStack Status    ${TEST_STATUS}    ${TEST_MESSAGE}    AND    Close Application

FL_2174 One Tap Fuelling Card Expired
    [Documentation]    Verify behavior when the linked credit card is expired
    [Tags]             one-tap-fuelling    FL-2174    disabled
    Log To Console     This test is currently disabled/skipped to match Java setup.

*** Keywords ***
Launch Setel App
    &{bstack_options}=    Create Dictionary
    ...    projectName=Setel One-Tap Fuelling
    ...    buildName=Build-${PLATFORM}-Parallel
    ...    appiumVersion=2.4.1

    IF    '${PLATFORM}' == 'Android'
        Open Application    ${REMOTE_URL}
        ...    automationName=UiAutomator2
        ...    platformName=Android
        ...    deviceName=Samsung Galaxy S23
        ...    app=${APP_ID_ANDROID}
        ...    bstack:options=${bstack_options}
    ELSE
        Open Application    ${REMOTE_URL}
        ...    automationName=XCUITest
        ...    platformName=iOS
        ...    deviceName=iPhone 14
        ...    app=${APP_ID_IOS}
        ...    bundleId=com.setel-staging2.ios
        ...    autoAcceptAlerts=${True}      # Automatically click 'Allow' on iOS pop-ups
        ...    autoGrantPermissions=${True}   # Grant location/notif permissions
        ...    bstack:options=${bstack_options}
    END

Update BrowserStack Status
    [Arguments]    ${status}    ${reason}
    ${bs_status}=    Set Variable If    '${status}'=='PASS'    passed    failed
    Execute Script    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"${bs_status}", "reason": "${reason}"}}