'''
A way to mount nfs shares, expandable to other types.
'''
import os
import errno
from subprocess import *
from os.path import *

# misc vars
mnt  = '/pgsql_back'
pool = '/rpool/nfs01/backups/dacks'
host = 'nfs'
type = 'nfs'

def mkdirs(mnt):
    try:
        os.makedirs(mnt)
    except OSError as exception:
        if exception.errno != errno.EEXIST and os.path.isdir(mnt):
            pass
        else:
            raise

def mountjb(pool):
    try:
        os.cmd(
           # "mount nfs:/rpool/nfs01/backups/dbacks /pgsql_backs"
           "mount" + host ":" + pool +mnt
        )
 
    except OSError as e:
        if e.errno != errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise
