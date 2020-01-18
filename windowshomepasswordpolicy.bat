:: tool by Gurpreet Singh
:: Script to update passsword policy
:: To Enable Password Expiration for Local Accounts 
wmic UserAccount set PasswordExpires=True 
:: disable the use of same password upon expiration, maximum value is 24
net accounts /uniquepw:5
:: minimum password age, value shoud be 0 always
net accounts /minpwage:0 
:: maximum password age
net accounts /maxpwage:800
:: minimum password length           
net accounts /minpwlen:5   
:: maximum number of login attempts       
net accounts /lockoutthreshold:5  
:: account lockout duration
net accounts /lockoutduration:30
:: To Change Account Lockout Counter for Local Accounts i.e, account lockout observation window
net accounts /lockoutwindow:30
:: display password expiration message
$search = ([adsisearcher]"(&(objectCategory=person)(objectClass=User)(samaccountname=$ENV:USERNAME))").FindOne()
$user = $search.properties.name
$pwdlastset = [datetime]::FromFileTime($search.properties.pwdlastset[0]) 
$age = (New-TimeSpan –Start $pwdlastset –End (get-date)).Days
$expires =60-$age
if ($expires -lt 14)
{
Add-Type -AssemblyName 'System.Windows.Forms'
[System.Windows.Forms.MessageBox]::Show("Your password will expire in $expires days.", "Your password will expire in $expires days!",
[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
}
