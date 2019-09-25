import re
import os
import subprocess

URLPause = 'http://commserv1:81/SearchSvc/CVWebService.svc/Job/436/action/pause'
URLResume = 'http://commserv1:81/SearchSvc/CVWebService.svc/Job/436/action/resume'

login = 'curl --location --request POST "http://commserv1:81/SearchSvc/CVWebService.svc/Login" \
--header "Accept: application/json" \
--header "Content-Type: application/json" \
--data "{\\"password\\": \\"BASE64\\",\\"username\\": \\"domain\\\\admin\\"}"'

parse = subprocess.check_output(login, shell=True)
qsdk = re.search(r'(QSDK .*?)\"',str(parse))

print('-' * 75)

token = qsdk.group(1)

jobcmd = 'curl --location --request GET "http://commserv1:81/SearchSvc/CVWebService.svc/Job?jobCategory=Active" \
--header "Accept: application/json" \
--header "Authtoken: {}" \
--data "" > C:\\scripts\\son\\geet.json 2>&1'.format(token)
 
runjobs = subprocess.check_output(jobcmd, shell=True)

fh = open('C:\scripts\son\geet.json')
for line in fh:
    match = re.search(r'"jobId":(\d{7}).*?Auxiliary Copy', line)
    if match:
        TempPauseURL = URLPause.replace('436',match.group(1))
        CMDLine = ('curl --location --request POST "{}"'
        ' --header "Accept: application/json" --header "Authtoken: {}"'
        ' --data ""').format(TempPauseURL,token)
        os.system(CMDLine)

fh.close()