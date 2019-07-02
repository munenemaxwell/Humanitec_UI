*** Settings ***
Documentation     A test suite with four test cases for a form submission for humanitec QA inteview
...               It includes both positive and negative data driven test cases


Library  SeleniumLibrary

*** Variables ***
${Url}  https://www.ultimateqa.com/filling-out-forms/
${Browser}  firefox 
${user_name}  maxwell
${msg}  I want to be part of humanitec
${title}  Filling Out Forms - Ultimate QA
${name_validation}  Name
${message_validation}  Message
${success_notification}  Form filled out successfully  


*** Test Cases ***                        
Valid form Submission           
    Open Browser to site
    Input Username  ${user_name}
    Input Message  ${msg}
    Click on Submit
    Verify Successful Submission
    Close Browser

Invalid message Submission
    Open Browser to site
    Input Username  ${user_name}
    Click on Submit
    Verify Message Validation
    Close Browser


Invalid username Submission
    Open Browser to site
    Input Message  ${msg}
    Click on Submit
    Verify Username Validation
    Close Browser

Negative test scenario for No form data provided
     Open Browser to site
     Click on Submit
     Verify username and message Validation
     Close Browser



*** keywords ***
Open Browser to site
    Open Browser  ${Url}  ${browser}
    Title Should Be  ${title}  

Input Username
    [Arguments]  ${username}
    Input Text  id:et_pb_contact_name_0  ${username}


Input Message
    [Arguments]  ${message}
    Input Text  id:et_pb_contact_message_0  ${message}


Click on Submit
    Click Element  xpath=//*[@id="et_pb_contact_form_0"]/div[2]/form[1]/div[1]/button[1]

Verify Successful Submission
    Wait Until Element Is Visible  xpath=//*[@id="et_pb_contact_form_0"]/div[1]/p[1]  10
    ${success_msg}    Get Text    xpath=//*[@id="et_pb_contact_form_0"]/div[1]/p[1]
    Should Be Equal As Strings    ${success_msg}    ${success_notification}

Verify Validation Errors
    Wait Until Element Is Visible  xpath=//*[@id="et_pb_contact_form_0"]/div[1]/p[1]  5

Verify Username Validation
    Verify Validation Errors
    Wait Until Element Is Visible  xpath=//*[@id="et_pb_contact_form_0"]/div[1]/ul[1]/li[1]  10
    ${username_error}    Get Text    xpath=//*[@id="et_pb_contact_form_0"]/div[1]/ul[1]/li[1]
    Should Be Equal As Strings    ${username_error}    ${name_validation}

Verify Message Validation
    Verify Validation Errors
    Wait Until Element Is Visible  xpath=//*[@id="et_pb_contact_form_0"]/div[1]/ul[1]/li[1]  10
    ${messge_error}    Get Text    xpath=//*[@id="et_pb_contact_form_0"]/div[1]/ul[1]/li[1]
    Should Be Equal As Strings    ${messge_error}    ${message_validation}


Verify username and message Validation
    Verify Username Validation
    Wait Until Element Is Visible  xpath=//*[@id="et_pb_contact_form_0"]/div[1]/ul[1]/li[2]  10
    ${messge_error}    Get Text    xpath=//*[@id="et_pb_contact_form_0"]/div[1]/ul[1]/li[2]
    Should Be Equal As Strings    ${messge_error}    ${message_validation}



