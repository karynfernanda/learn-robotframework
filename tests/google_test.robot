*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}         https://demoqa.com/automation-practice-form
${BROWSER}     chrome
${DELAY}       0.2s

*** Test Cases ***
Successful Registration Flow
    [Documentation]    Verifies a user can fill the form and select state/city.
    Open Training Site
    Fill Primary User Details    Karyn    Fernanda    frnda@gmail.com
    Select Gender and Mobile     1234567890
    Choose Location              NCR    Delhi
    Submit Form and Verify
    [Teardown]    Close Browser

*** Keywords ***
Open Training Site
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Fill Primary User Details
    [Arguments]    ${first}    ${last}    ${email}
    Input Text     id=firstName     ${first}
    Input Text     id=lastName      ${last}
    Input Text     id=userEmail     ${email}

Select Gender and Mobile
    [Arguments]    ${phone}
    Execute Javascript    window.scrollTo(0, 400)
    Execute Javascript    document.querySelector("label[for='gender-radio-2']").click()
    Input Text            id=userNumber    ${phone}

Choose Location
    [Arguments]    ${state}    ${city}
    Execute Javascript    window.scrollTo(0, 800)
    Click Element         id=state
    Input Text            id=react-select-3-input    ${state}
    Press Keys            id=react-select-3-input    ENTER
    Click Element         id=city
    Input Text            id=react-select-4-input    ${city}
    Press Keys            id=react-select-4-input    ENTER

Submit Form and Verify
    Click Element         id=submit
    Capture Page Screenshot    final_check.png
    Log To Console    Test Complete!