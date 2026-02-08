*** Settings ***
Documentation     Global keywords shared across all test suites
Library           AppiumLibrary

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

Update BrowserStack Status
    [Arguments]    ${status}    ${reason}
    [Documentation]    Corrected JSON format for BrowserStack executor
    ${bs_status}=    Set Variable If    '${status}'=='PASS'    passed    failed
    Execute Script    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"${bs_status}", "reason": "${reason}"}}

Close Setel App
    [Documentation]    Closes the current application
    Close Application