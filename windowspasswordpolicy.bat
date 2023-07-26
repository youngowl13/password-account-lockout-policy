:: tool by Gurpreet Singh
:: Script to update passsword policy
:: To Enable Password Expiration for Local Accounts 
wmic UserAccount set PasswordExpires=True 
:: disable the use of same password upon expiration, maximum value is 24
net accounts /uniquepw:2
:: minimum password age, value shoud be 0 always
net accounts /minpwage:0 
:: maximum password age
net accounts /maxpwage:45
:: minimum password length           
net accounts /minpwlen:8   
:: maximum number of login attempts       
net accounts /lockoutthreshold:5  
:: account lockout duration
net accounts /lockoutduration:30
:: To Change Account Lockout Counter for Local Accounts i.e, account lockout observation window
net accounts /lockoutwindow:30
:: display password expiration message
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v PasswordExpiryWarning /t REG_DWORD /d 14 /f
