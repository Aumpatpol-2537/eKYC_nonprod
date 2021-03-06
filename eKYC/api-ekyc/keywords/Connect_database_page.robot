***Settings***
Library                 Process
Library                 ExcelLibrary
Library                 OperatingSystem
Library                 DatabaseLibrary

Resource                ../keywords/Sent_SMS(OTP)API_page.robot
Resource                ../keywords/Validate_customer_API_page.robot
Resource                ../keywords/Verify_OTP_API_page.robot

*** Variables ***
${DBHost}         tcrb-bot-nprd-db.cluster-ckedyfslvwdh.ap-southeast-1.rds.amazonaws.com
${DBName}         bot_v2
${DBPass}         &6gh2#5ONWisCQ
${DBPort}         5432
${DBUser}         postgres
${PATH_JAR}       tcrb-ekyc-partner-1.8.jar


***Keywords***
Check_temp_lock
    [Arguments]     ${input_cid_hash}           
    Connect To Database     psycopg2     ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
    @{queryResults_from_cs_info} =  Query    SELECT x.* FROM image_db.customer_facial_lock x WHERE x.cid_hash IN ('${input_cid_hash}') AND x.temporary_lock IN (true)
    ${result_facial_temp_lock}          Get From List                   @{queryResults_from_cs_info}       	2
    Should Be Equal As Strings                 ${result_facial_temp_lock}             True
    Disconnect From Database


Gen_cid_hash
    [Arguments]         ${cid}
    Run Process     java   -jar     ${PATH_JAR}     hash      ${cid}             file     file      alias=myproc
    ${TextFileContent}          Get File           hashing.txt
    Set global variable         ${GET_CID_HASH}           ${TextFileContent}


Check_facial_temp_lock
    [Arguments]     ${input_cid}        
    Gen_cid_hash                ${input_cid}
    Check_temp_lock             ${GET_CID_HASH}


Unlock_permanance_lock
    [Arguments]     ${input_cid_hash}           
    Connect To Database     psycopg2     ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
    Execute Sql String      UPDATE image_db.customer_facial_lock SET temporary_unlock_remaining=0,permanent_lock=false WHERE cid_hash='${input_cid_hash}'
    Disconnect From Database


Process_unlock_permanance_Lock
    [Arguments]     ${cid}
    Gen_cid_hash                    ${cid}
    Unlock_permanance_lock          ${GET_CID_HASH}