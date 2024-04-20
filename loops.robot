*** Settings ***
Library  SeleniumLibrary
Library    FakerLibrary
Library    JSONLibrary
Library    String

** Variables ***
${URL}    https://**********
${Browser}    Edge
${login}    id:loginform-username
${password}    id:loginform-password
${button}    xpath://*[@id="login-form"]/button

*** Test Cases ***
Login_form
    ${file}=    load json from file    ../data.json
    ${json_login}    get value from json    ${file}    $.LOGIN
    log to console    Value LOGIN is ${json_login[0]}
    Log    login output
    ${json_password}    get value from json    ${file}    $.PASSWORD
    log to console    Value PASSWORD is ${json_password[0]}
    Log    password output
    open browser    ${URL}    ${Browser}
    sleep    3
    maximize browser window
    input text    ${login}    ${json_login[0]}
    input text    ${password}    ${json_password[0]}
    click element    ${button}
    sleep    5


Click_loop
    ${elements_1}=    Get WebElements    Invoicesclick
    FOR    ${element}    IN    @{elements_1}
        ${text_1}=    Invoicesclick
    sleep    2
    END
    Log To Console    click and alert elements


    ${elements_2}=    Get WebElements    //a[@class='btn-success idetail-status']
    FOR    ${element_2}    IN    @{elements_2}
        ${text_2}=    Reserved
    sleep    1
    END
    Log To Console    click and alert elements

Click&input_loops
    ${elements}=    Get WebElements    //input[@type='checkbox']
    FOR    ${element}    IN    @{elements}
        ${text}=    Checkboxesvisible
    sleep    2
    END

    Close Browser


*** Keywords ***
Invoicesclick
    Click Element    //a[@class='btn-success idetail']
    sleep    3
    handle alert    ACCEPT
    sleep    5

Reserved
    Click Element    //a[@class='btn-success idetail-status']
    sleep    3
    handle alert    ACCEPT
    sleep    3

Checkboxesvisible
    ${elements_1}=    Get WebElements    //input[@type='checkbox']
    FOR    ${element_1}    IN    @{elements_1}
        ${text_1}=    click element    ${element_1}
    END

    Run Keyword And Ignore Error    Scroll Element Into View    //*[@id="invoice-idetails"]/button
    Log    scroll to element
    sleep    2
    Click Element    xpath://*[@id="complete-idetails"]/button
    sleep    2

    ${fakeword}    FakerLibrary.Words
    ${elements_2}=    Get WebElements    //input[@class='form-control idetail']
    FOR    ${element_2}    IN    @{elements_2}
        ${text_2}=    Input Text    ${element_2}    ${fakeword}
    sleep    1
    END