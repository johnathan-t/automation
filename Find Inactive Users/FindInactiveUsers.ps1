# Written by Johnathan Tracz
# Date: March 29th, 2016
# Revision: 1.0

import-module activedirectory
Search-ADAccount -AccountInactive -UsersOnly -TimeSpan "365" | ft name,enabled,lastlogondate