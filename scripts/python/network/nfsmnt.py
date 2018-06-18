'''
mdrive
'''
import os
import errno
import os.path
import subprocess


mnt  = 'mount '
src  = 'nfs:/rpool/nfs01/backups/dbacks'
dst  = ' /pgsql_backups'
cmd  = 'mnt src dest'
cmd2 = "mount "+src +dst

os.system(cmd2)
