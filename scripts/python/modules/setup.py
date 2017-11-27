# -*- coding: utf-8 -*-

# Learn more: https://github.com/kennethreitz/setup.py

from setuptools import setup, find_packages


with open('README.rst') as f:
    readme = f.read()

with open('LICENSE') as f:
    license = f.read()

setup(
    name='mounter',
    version='0.1.0',
    description='Mounter to make life easier for things and stuff',
    long_description=readme,
    author='ScoDay',
    author_email='me@scoday.tokyo',
    url='https://github.com/scoday/DevOps/tree/master/scripts',
    license=license,
    packages=find_packages(exclude=('tests', 'docs'))
)
