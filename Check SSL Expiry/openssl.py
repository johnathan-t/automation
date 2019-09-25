import OpenSSL
import ssl, socket
from datetime import datetime
import time

domains=["www.google.com","www.yahoo.com"]
maxDays = 180

for site in domains:
    cert=ssl.get_server_certificate((site, 443))
    x509 = OpenSSL.crypto.load_certificate(OpenSSL.crypto.FILETYPE_PEM, cert)
    certdate=(datetime.strptime(x509.get_notAfter().decode('ascii'), '%Y%m%d%H%M%SZ'))

    current=datetime.now()
    timediff=certdate-current

    if timediff.days < maxDays:
        str=("{} days remaining on certificate for {}").format(timediff.days,site)
        print(str)
        