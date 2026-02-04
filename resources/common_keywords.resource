*** Settings ***
Library    AppiumLibrary
Resource   locators.resource

*** Keywords ***
Launch Setel App
    &{bstack_options}=    Create Dictionary
    ...    projectName=Setel Dynamic CrossPlatform
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
        ...    autoAcceptAlerts=${True}
        ...    autoGrantPermissions=${True}
        ...    bstack:options=${bstack_options}
    END

Enable OTF Toggle If Disabled
    ${toggle}=    Set Variable If    '${PLATFORM}'=='Android'    ${OTF_SWITCH_ANDROID}    ${OTF_SWITCH_IOS}
    Wait Until Page Contains Element    ${toggle}    timeout=20s

    IF    '${PLATFORM}' == 'Android'
        ${status}=    Get Element Attribute    ${toggle}    checked
        # Click only if it's currently false
        IF    '${status}' == 'false'    Click Element    ${toggle}
    ELSE
        ${status}=    Get Element Attribute    ${toggle}    value
        # In iOS, value 0 means disabled
        IF    '${status}' == '0'        Click Element    ${toggle}
    END

Update BrowserStack Status
    [Documentation]    Updates the test result status in the BrowserStack dashboard.
    [Arguments]    ${status}    ${reason}
    ${bs_status}=    Set Variable If    '${status}'=='PASS'    passed    failed
    Execute Script    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"${bs_status}", "reason": "${reason}"}}