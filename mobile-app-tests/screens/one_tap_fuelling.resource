*** Settings ***
Documentation     Locators and screen-specific logic using official YAML registry and senior's logic
Library           AppiumLibrary
Resource          ../../shared/shared_keywords.resource

*** Variables ***
${VIDEO_GET_STARTED}      accessibility_id=Video Screen Get Started Button
${PROMOTIONS_TEXT}        Promotions
${GET_STARTED_LINK}       accessibility_id=Get Started

${PHONE_FIELD_ANDROID}    id=edit_phone
${PHONE_FIELD_IOS}        accessibility_id=PhoneOTPViewController_phoneTextField
${CONTINUE_BTN_ANDROID}   id=button_continue
${CONTINUE_BTN_IOS}       accessibility_id=PhoneOTPViewController_continueButton

${OTP_FIELD_ANDROID}      id=edit_pin
${OTP_FIELD_IOS}          accessibility_id=PhoneOTPConfirmationViewController_otpLabelsStackView

${LANG_ENG_ANDROID}       xpath=//*[contains(@text, "English")]
${ACC_BTN_ANDROID}        xpath=//android.widget.TextView[@text="Account"]
${ACC_BTN_IOS}            xpath=//XCUIElementTypeTabBar/XCUIElementTypeButton[5]

${OTF_MENU_BTN}           accessibility_id=One-Tap Fuelling
${OTF_SWITCH}             id=com.setel.mobile.staging2:id/switcher
${FULL_TANK_BTN}          id=com.setel.mobile.staging2:id/button_full_tank
${SAVE_BTN_ANDROID}       id=com.setel.mobile.staging2:id/button_save

*** Keywords ***
Tap English If Visible
    IF    '${PLATFORM}' == 'Android'
        ${visible}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${LANG_ENG_ANDROID}    timeout=10s
        IF    ${visible}    Click Element    ${LANG_ENG_ANDROID}
    END

New Login To Setel App
    [Arguments]    ${phone_number}    ${pin}
    [Documentation]    Handling onboarding flow before login entry

    Tap English If Visible

    ${is_on_home_but_not_logged_in}=    Run Keyword And Return Status    Wait Until Page Contains    ${PROMOTIONS_TEXT}    timeout=15s

    IF    ${is_on_home_but_not_logged_in}
        Navigate To Account Page
        ${get_started_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${GET_STARTED_LINK}    timeout=10s
        IF    ${get_started_visible}
            Click Element    ${GET_STARTED_LINK}
        ELSE
            Click Element    accessibility_id=GET STARTED
        END
    ELSE
        Wait Until Element Is Visible    accessibility_id=Video Screen Get Started Button    timeout=20s
        Click Element                    accessibility_id=Video Screen Get Started Button
    END

    # Select Platform Locators
    ${phone_field}=    Set Variable If    '${PLATFORM}'=='Android'    ${PHONE_FIELD_ANDROID}    ${PHONE_FIELD_IOS}
    ${continue_btn}=   Set Variable If    '${PLATFORM}'=='Android'    ${CONTINUE_BTN_ANDROID}   ${CONTINUE_BTN_IOS}
    ${otp_field}=      Set Variable If    '${PLATFORM}'=='Android'    ${OTP_FIELD_ANDROID}      ${OTP_FIELD_IOS}

    # Input Credentials
    Wait Until Element Is Visible    ${phone_field}    timeout=30s
    Input Text                       ${phone_field}    ${phone_number}
    Click Element                    ${continue_btn}

    Wait Until Element Is Visible    ${otp_field}      timeout=20s
    Input Text                       ${otp_field}      ${pin}

    # Wait for Main Dashboard to appear
    Wait Until Page Contains         Pump              timeout=30s

Navigate To Account Page
    [Documentation]    Navigates to the Account tab based on platform
    ${loc}=    Set Variable If    '${PLATFORM}'=='Android'    ${ACC_BTN_ANDROID}    ${ACC_BTN_IOS}
    Wait Until Element Is Visible    ${loc}    timeout=30s
    Click Element                    ${loc}

Enable OTF Toggle If Disabled
    [Documentation]    Enables One-Tap Fuelling toggle if it is currently off
    Wait Until Element Is Visible    ${OTF_SWITCH}    timeout=20s
    ${status}=    Get Element Attribute    ${OTF_SWITCH}    checked
    IF    '${status}' == 'false'    Click Element    ${OTF_SWITCH}

Select Full Tank Option
    [Documentation]    Selects the Full Tank option in OTF settings
    Wait Until Element Is Visible    ${FULL_TANK_BTN}    timeout=15s
    Click Element                    ${FULL_TANK_BTN}