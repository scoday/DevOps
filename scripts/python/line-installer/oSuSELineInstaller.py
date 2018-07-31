#!/usr/bin/python3.6
'''
Basically a fully integrated script to 
build line (windows app) on openSUSE Leap 15.0.
Use and abuse as you please.
'''

import os
from distutils.core import setup

require_packages = os.system("sudo zypper in -y wine")
get_line = os.system("cd ~/Downloads/ && wget http://dl.desktop.line.naver.jp/naver/LINE/win/LineInst.exe")
install_line = os.system("cd ~/ && wine LineInst.exe")
remove_installer = os.system("rm -f ~/Downloads/LineInst.exe")
