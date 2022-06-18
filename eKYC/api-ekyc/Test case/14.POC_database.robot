***Settings***
Library         Process
Library         RequestsLibrary
Library         BuiltIn
Library         JSONLibrary


***Variables***
${DATA}                  {"username": "EKYC004", "password": "P@ssw0rd", "partner_code": "TCRB-TABLET"}
${DECRYPT_DATA}         AkDKrLcO5JVg5XftHaOfePnyCyB4beXQHJ2LQZhx9PFwb9rEHnlpNjUXEGglt+dc7BVx3nXeXUwzjQNUmoXixheXjwymia7ci4x8gbXM+QvZJRxPaflQYdM73ZJi+qZqYKTgW8kMM9zOQveVyWzmWHrPywyo5xk8XSDHSjVr4hQvZtaAkqAI20dAcURoPQMesU1X/3NUdREzT2QiWVeQ/N7M1q5Afhr9b76Tgt9RVcFYphgIx4sq2n6l5XB4ouKxqXqB3zl3pWIXSOcrhQMGCqO/M5TH7SjCoyrY3ARk0YWP/J4ZVPreqJm2chQuGapML/PJ6ZuOnk8=
&{HEADER_LOGIN}         X-Correlation-Id=hfverbnykjadwedfasvbetj

${RESULT}           5LZm4O1ZYqaJss+aq9y1Uvr1seDuPMcPwxKdrDKMTYlOuGR3ly9kPv6aiTEDWEq85te+SutkNqCT6HfEa+F4LuHB3oD+/1ugUfLTocIeRsjrnohr67taBaQQtWRlGpAuzze69B30ovEfow==

***Test Cases***
TC1
    Run Process    java     -jar       tcrb-ekyc-cipher-1.0.jar    encrypt         ${DATA}        alias=myproc		   
    ${result_encrypt}      Get Process Result	   myproc
    Log to console     ${result_encrypt.stdout}	
    Log    ${result_encrypt.stdout}	



