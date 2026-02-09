*** Settings ***
Documentation     Epic: Fuel One-Tap Fuelling | Feature: One-Tap Fuelling
Resource          ../../shared/shared_keywords.resource
Resource          ../screens/one_tap_fuelling.resource

*** Variables ***
${PLATFORM}         Android
${BS_USER}          %{BS_USER=karynfernandayul_8bntM9}
${BS_KEY}           %{BS_KEY=Ne74yKsqR3xTMreuzzzg}
${REMOTE_URL}       http://${BS_USER}:${BS_KEY}@hub-cloud.browserstack.com/wd/hub
${APP_ID_ANDROID}   bs://4dca04fdd2d0ade664e45c5a4239165b84a117c6
${APP_ID_IOS}       bs://7ecc0dddfbe9999223bb585e9aed32140eb16fe3
${USER_PHONE}       166674000
${USER_PIN}         111111

*** Test Cases ***
FL_1234 Smoke Test App Launch
    [Documentation]    Verify the app launches and reaches the onboarding screen
    [Tags]             smoke    launch
    [Setup]            Launch Setel App
    Tap English If Visible
    [Teardown]         Run Keywords    Update BrowserStack Status    ${TEST_STATUS}    ${TEST_MESSAGE}    AND    Close Setel App

FL_2174 One Tap Fuelling Card Expired
    [Documentation]    Test case for expired cards (Currently skipped/disabled)
    [Tags]             disabled    one-tap-fuelling    FL-2174
    Skip    This test is currently disabled to match Java setup

FL_2135 Unsuccessful Place Order Wallet Balance < RM3
    [Tags]             regression    fuel    FL-2135
    [Setup]            Launch Setel App
    New Login To Setel App    ${USER_PHONE}    ${USER_PIN}
    # Logic to select pump and check balance
    Wait Until Page Contains    Pump    timeout=30s
    Click Element               xpath=//*[contains(@text, "1")]
    Wait Until Page Contains    Insufficient balance    timeout=15s
    [Teardown]         Run Keywords    Update BrowserStack Status    ${TEST_STATUS}    ${TEST_MESSAGE}    AND    Close Setel App

FL_3893 Set Full Tank Limit Amount
    [Tags]             regression    fuel    FL-3893
    [Setup]            Launch Setel App
    Tap English If Visible
    New Login To Setel App    ${USER_PHONE}    ${USER_PIN}
    Navigate To Account Page
    Wait Until Element Is Visible    ${OTF_MENU_BTN}    timeout=20s
    Click Element                    ${OTF_MENU_BTN}
    Enable OTF Toggle If Disabled
    Select Full Tank Option
    Click Element                    ${SAVE_BTN_ANDROID}
    [Teardown]         Run Keywords    Update BrowserStack Status    ${TEST_STATUS}    ${TEST_