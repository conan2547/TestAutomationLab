*** Settings ***
Library           SeleniumLibrary
Test Teardown     Close Browser

*** Variables ***
# URL ที่ถูกต้อง (แก้ตาม Log ของคุณ)
${URL}            http://localhost:7272/Registration.html
${BROWSER}        Chrome
${DELAY}          0.2s

# --- ข้อมูล Test Data ---
${FNAME}          Somyod
${LNAME}          Sodsai
${ORG}            CS KKU
${EMAIL}          somyod@kkumail.com
${PHONE}          091-001-1234
${INVALID_PHONE}  1234

# --- ข้อความที่คาดหวัง ---
${MSG_SUCCESS_1}  Thank you for registering with us.
${MSG_SUCCESS_2}  We will send a confirmation to your email soon.
${ERR_FNAME}      Please enter your first name!!
${ERR_LNAME}      Please enter your last name!!
${ERR_NAME}       Please enter your name!!
${ERR_EMAIL}      Please enter your email!!
${ERR_PHONE}      Please enter your phone number!!
${ERR_INV_PHONE}  Please enter a valid phone number

*** Test Cases ***

# ==========================================
# Scenario 1: Success Cases
# ==========================================

TC01 Register Success (With Organization)
    [Documentation]    ทดสอบลงทะเบียนสำเร็จ (กรอกครบ)
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    
    Wait Until Page Contains    Workshop Registration
    Capture Page Screenshot     Step1_OpenPage.png
    
    # เริ่มกรอกข้อมูล
    Input Text      id=firstname      ${FNAME}
    Input Text      id=lastname       ${LNAME}
    Input Text      id=organization   ${ORG}
    Input Text      id=email          ${EMAIL}
    Input Text      id=phone          ${PHONE}
    Click Button    id=registerButton
    
    # ตรวจสอบผลลัพธ์และแคปภาพ
    Wait Until Page Contains    Success
    Page Should Contain         ${MSG_SUCCESS_1}
    Capture Page Screenshot     TC01_Success.png

TC02 Register Success (No Organization)
    [Documentation]    ทดสอบลงทะเบียนสำเร็จ (ไม่กรอกหน่วยงาน)
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    
    Input Text      id=firstname      ${FNAME}
    Input Text      id=lastname       ${LNAME}
    # เว้นช่อง Organization
    Input Text      id=email          ${EMAIL}
    Input Text      id=phone          ${PHONE}
    Click Button    id=registerButton
    
    Wait Until Page Contains    Success
    Capture Page Screenshot     TC02_Success_NoOrg.png

# ==========================================
# Scenario 2: Failure Cases (Validation)
# ==========================================

TC03 Empty First Name
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text      id=lastname       ${LNAME}
    Input Text      id=organization   ${ORG}
    Input Text      id=email          ${EMAIL}
    Input Text      id=phone          ${PHONE}
    Click Button    id=registerButton
    
    Page Should Contain    ${ERR_FNAME}
    Capture Page Screenshot     TC03_EmptyFname.png

TC04 Empty Last Name
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text      id=firstname      ${FNAME}
    Input Text      id=organization   ${ORG}
    Input Text      id=email          ${EMAIL}
    Input Text      id=phone          ${PHONE}
    Click Button    id=registerButton
    
    Page Should Contain    ${ERR_LNAME}
    Capture Page Screenshot     TC04_EmptyLname.png

TC05 Empty First and Last Name
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text      id=organization   ${ORG}
    Input Text      id=email          ${EMAIL}
    Input Text      id=phone          ${PHONE}
    Click Button    id=registerButton
    
    Page Should Contain    ${ERR_NAME}
    Capture Page Screenshot     TC05_EmptyName.png

TC06 Empty Email
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text      id=firstname      ${FNAME}
    Input Text      id=lastname       ${LNAME}
    Input Text      id=organization   ${ORG}
    Input Text      id=phone          ${PHONE}
    Click Button    id=registerButton
    
    Page Should Contain    ${ERR_EMAIL}
    Capture Page Screenshot     TC06_EmptyEmail.png

TC07 Empty Phone Number
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text      id=firstname      ${FNAME}
    Input Text      id=lastname       ${LNAME}
    Input Text      id=organization   ${ORG}
    Input Text      id=email          ${EMAIL}
    Click Button    id=registerButton
    
    Page Should Contain    ${ERR_PHONE}
    Capture Page Screenshot     TC07_EmptyPhone.png

TC08 Invalid Phone Number
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text      id=firstname      ${FNAME}
    Input Text      id=lastname       ${LNAME}
    Input Text      id=organization   ${ORG}
    Input Text      id=email          ${EMAIL}
    Input Text      id=phone          ${INVALID_PHONE}
    Click Button    id=registerButton
    
    Page Should Contain    ${ERR_INV_PHONE}
    Capture Page Screenshot     TC08_InvalidPhone.png