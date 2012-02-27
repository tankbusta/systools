#!/usr/bin/env python
#raid_status.py: Provides emails of RAID card status using LSI/3ware tool
__author__ = "Christopher Schmitt"
__copyright__ = "Copyright 2012"
__license__ = "GPL"
__version__ = "1.0"
#Install
#mkdir -p /root/raid_script/
#copy this into raidtool.py
#chmod a+x raidtool.py
#crontab -e
#45 9 * * * /root/raid_script/raidtool.py

import subprocess
import smtplib
import string

SERVER_NAME = "insert_server_name"
SMTP_SERVER = "insert_mail_server"
SMTP_TO = "insert_email_to"
SMTP_FROM = SERVER_NAME + "@insert_domain_name"

RAID_CMD = "/c4/e0 show all" 
TW_PATH = "/home/admin/tw_cli"

try:
	p = subprocess.Popen([TW_PATH, RAID_CMD], stdout=subprocess.PIPE)
	out, err = p.communicate()
except Exception:
	print "[!] Error in executing raidcard status."

try:
	SMTP_SUBJECT = "RAID Card Status for " + SERVER_NAME
	server = smtplib.SMTP(SMTP_SERVER)
	BODY = string.join((
			"From: %s" % SMTP_FROM,
			"To: %s" % SMTP_TO,
			"Subject: %s" % SMTP_SUBJECT ,
			"",
			"Hi, here's the RAID card status \n\n" + out
			), "\r\n")
	server.sendmail(SMTP_FROM, SMTP_TO, BODY)
	server.quit()
except Exception:
	print "[!] Could not process email!"