*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description #automated tests for scout website


*** Variables ***
${LOGIN URL}      https://scouts-test.futbolkolektyw.pl/en
${BROWSER}        Chrome
${SIGNINBUTTON}     xpath=//*[text()= 'Sign in']
${EMAILINPUT}      xpath=//*[@id='login']
${EMAILFORREMIND}   xpath=//*[@name='email']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}     xpath=//*[@title='Logo Scouts Panel']
${INCORRECTPASSSWORD}       xpath  =//*[text()='Identifier or password invalid.']
${NOCREDENTIALS}        xpath= //*[text()='Please provide your username or your e-mail.']
${REMINDPASSWORD}       xpath=//*[text()= 'Remind password']
${REMINDSEND}       xpath=//*[text()= 'Send']
${MESSAGESENT}      xpath=//*[text()= 'Message sent successfully.']
${SIGNOUT}      xpath=//*[text()='Sign out']
${LOGINTEXT}        xpath=//*[text()= 'Scouts Panel']
${ADDPLAYER}        xpath=//*[text()='Add player']
${PLAYERS}        xpath=//*[text()='Players']
${ADDPLAYERBUTTON}        xpath=//*[text()='Add player']
${ADDNAME}      xpath=//*[@name='name']
${ADDLASTNAME}  xpath= //*[@name='surname']
${ADDBIRTHDATE}     xpath=//*[@name='age']
${ADDPOSITION}      xpath=//*[@name='mainPosition']
${ADDSELECTLEG}       xpath=//*[@id='mui-component-select-leg']
${ADDRIGHTLEG}      xpath=//*[text()='Right leg']
${ADDLEFTLEG}   xpath=//*[text()='Left leg']
${ADDSUBMITBUTTON}          xpath=//*[text()= 'Submit']
${SAVEDPLAYERMESSAGE}       xpath=//*[text()='Added player.']
*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    [Teardown]  Close Browser

Login to the system with incorrect password
    Open login page
    Type in email
    Type in incorrect password
    Click on the submit button
    View incorrect password message
    [Teardown]  Close Browser

Login to the system with no credentials
    Open login page
    Click on the submit button
    View no credentials message
    [Teardown]  Close Browser

Remind password
    Open login page
    Click on the remind password button
    Type In Email for remind
    Click on the send button
    [Teardown]  Close Browser

Sign Out
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on sign out
    Assert login page
    [Teardown]  Close Browser


Add player
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on add player
    [Teardown]  Close Browser

Fill in add player form
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on add player
    Add name
    Add last name
    Add birthdate
    Add position
    Add leg choice
    Choose leg
    Click on add button
    [Teardown]  Close Browser

*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}    ${BROWSER}

Type in email
    Input Text      ${EMAILINPUT}    user01@getnada.com
Type In Email for remind
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible       ${EMAILFORREMIND}
    Input Text      ${EMAILFORREMIND}    blapinska@gmail.com
Type in password
    Input Text      ${PASSWORDINPUT}        Test-1234

Type in incorrect password
    Input Text      ${PASSWORDINPUT}        Abcd

Click on the submit button
    Click Element       xpath=//*[text()= 'Sign in']

View incorrect password message
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible       ${INCORRECTPASSSWORD}
    Capture Page Screenshot    incorrectpassword.png

View no credentials message
  Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible       ${NOCREDENTIALS}
  Capture Page Screenshot    nocredentials.png

Assert dashboard
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible    ${PAGELOGO}
    Title Should Be    Scouts panel
    Capture Page Screenshot    alert.png

Click on the remind password button
    Click Element       //*[text()= 'Remind password']

Click on the send button
    Click Element       //*[text()= 'Send']
    Wait Until Element Is Visible   ${MESSAGESENT}
    Capture Page Screenshot    remindpassword.png

Click on sign out
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible    ${PAGELOGO}
    Click Element   //*[text()='Sign out']

Assert login page
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible    ${LOGINTEXT}
    Title Should Be    Scouts panel - sign in
    Capture Page Screenshot    signed_out.png

Click on add player
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible    ${PAGELOGO}
    Click Element       //*[text()='Add player']
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible    ${PLAYERS}

Add name
    Input Text      ${ADDNAME}      Jane

Add last name
    Input Text      ${ADDLASTNAME}      Doe

Add birthdate
    Input Text  ${ADDBIRTHDATE}     13/07/2000

Add position
    Input Text      ${ADDPOSITION}      Goal keeper

Add leg choice
    Click Element    //*[@id='mui-component-select-leg']

Choose leg
    Click Element    //*[text()='Left leg']

Click on add button
    Click Element       //*[text()= 'Submit']
#   Wait Until Keyword Succeeds    1 min    1 sec
    Wait Until Element Is Visible   ${SAVEDPLAYERMESSAGE}
    Capture Page Screenshot    added_player.png
