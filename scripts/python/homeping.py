#!/usr/bin/env python
# Good example of if / else and os use
import os
# hostname = "gw01" #example
hostname = "pi.beastieco.com"
# response = os.system("ping -c 1 " + hostname)
response = os.system("ping " + hostname)

if response == 0:
    print hostname, 'is up!'
else:
    print hostname, 'is down!'
