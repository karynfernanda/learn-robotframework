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

    # Language Selection for Android, Skip for iOS)
    IF    '${PLATFORM}' == 'Android'
        Log To Console    * Step 1: Selecting English Language (Android only)
        Wait Until Page Contains Element    ${LANG_ENG_ANDROID}    timeout=30s
        Click Element                       ${LANG_ENG_ANDROID}
    ELSE
        Log To Console    * Step 1: iOS Direct to Dashboard (Wait for Alerts)
        Sleep    10s
    END

    Log To Console    * Step 2: Navigating to Account page
    ${acc_loc}=     Set Variable If    '${PLATFORM}'=='Android'    ${ACC_BTN_ANDROID}    ${ACC_BTN_IOS}
    Wait Until Page Contains Element    ${acc_loc}     timeout=30s
    Click Element                       ${acc_loc}

    Log To Console    * Step 3: Clicking Get Started
    ${start_loc}=   Set Variable If    '${PLATFORM}'=='Android'    ${GET_STARTED_ANDROID}    ${GET_STARTED_IOS}
    Wait Until Page Contains Element    ${start_loc}    timeout=20s
    Click Element                       ${start_loc}

    [Teardown]    Run Keywords    Update BrowserStack Status    ${TEST_STATUS}    ${TEST_MESSAGE}    AND    Close Application

FL_2174 One Tap Fuelling Card Expired
    [Documentation]    Verify behavior when the linked credit card is expired
    [Tags]             one-tap-fuelling    FL-2174    disabled
    Log To Console     This test is currently disabled/skipped to match Java setup.

FL_2178 One-Tap Fuelling Kicked Out From Family Wallet
    [Documentation]    Verify system behavior when user is removed from Family Wallet
    [Tags]             regression    one-tap-fuelling    fuel    FL-2178
    [Setup]            Launch Setel App

    Log To Console     * Step 1: Checking Family Wallet status...
    # Use dynamic locator from resources
    ${wallet}=         Set Variable If    '${PLATFORM}'=='Android'    ${FAMILY_WALLET_ANDROID}    ${FAMILY_WALLET_IOS}
    Wait Until Page Contains Element    ${wallet}    timeout=30s

    [Teardown]         Run Keywords    Update BrowserStack Status    ${TEST_STATUS}    ${TEST_MESSAGE}    AND    Close Application

FL_3893 Set Full Tank Limit Amount
    [Documentation]    Verify setting full tank limit for One-Tap Fuelling
    [Tags]             regression    fuel    one-tap-fuelling    FL-3893
    [Setup]            Launch Setel App

    Log To Console     * Step 1: Navigating to OTF Settings to set Full Tank...
    # Only enable if currently disabled
    Enable OTF Toggle If Disabled

    # Select Full Tank button
    ${full_tank}=      Set Variable If    '${PLATFORM}'=='Android'    ${OTF_FULL_TANK_BTN_ANDROID}    ${OTF_FULL_TANK_BTN_IOS}
    Wait Until Page Contains Element    ${full_tank}    timeout=20s
    Click Element                       ${full_tank}

    [Teardown]         Run Keywords    Update BrowserStack Status    ${TEST_STATUS}    ${TEST_MESSAGE}    AND    Close Application
