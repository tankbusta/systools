#!/usr/bin/env python
#yum_notifier.py: Provides emails if there are yum updates for a RHEL/CentOS box.
__author__ = "Christopher Schmitt"
__copyright__ = "Copyright 2012"
__license__ = "GPL"
__version__ = "1.1"

import yum
import socket
import string
import smtplib

SERVER_NAME = "insert_server_name"
SMTP_SERVER = "insert_mail_server"
SMTP_TO = "insert_email_to"
SMTP_FROM = SERVER_NAME + "@insert_domain_name"

# DO NOT TOUCH ANYTHING BELOW THIS
AVAIL_UPDATES = []
try: 
	COUNT = 0
	yb = yum.YumBase()
	yb.doConfigSetup()
	yb.doTsSetup()
	yb.doRpmDBSetup()
	for pkg in yb.update():
	  update = str(pkg)
	  AVAIL_UPDATES.append(update)
	  COUNT += 1
except Exception:
	print "[X] Could not communicate to Yum! Is yum-utils installed?"

if COUNT > 0:
	try:
		SMTP_SUBJECT = str(COUNT) + " updates available on " + SERVER_NAME
		upd_msg = "\n\\".join(AVAIL_UPDATES)
		server = smtplib.SMTP(SMTP_SERVER)
		BODY = string.join((
				"From: %s" % SMTP_FROM,
				"To: %s" % SMTP_TO,
				"Subject: %s" % SMTP_SUBJECT ,
				"",
				"Hi, the following updates are available\n\n" + upd_msg
				), "\r\n")
		server.sendmail(SMTP_FROM, SMTP_TO, BODY)
		server.quit()
	except Exception:
		print "[X] Could not send email"
else:
	print "[!] No updates!"