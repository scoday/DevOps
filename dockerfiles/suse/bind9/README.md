# openSUSE Bind9
## Backgroundt
Basically I was looking to migrate my internal scoday.local dns services to a container. After tinkering around with Dockerfile for a bit it worked well enough.

## Environment
This is an openSUSE:latest tested and built on openSUSE Leap 42.3.

## Files
The zone files are a decent reference, pretty clean and reusable.

### Bind
For more information on Bind I would suggest isc.org, that is where I took my first bind/dnssec class in 2001. 

### Disclaimer 
This isn't the best way to build a Dockerfile perhaps, but it was fairly clean and straight forward. 

### Starting the container
To start the container you should make sure that the files/ folder has the correct settings for you in both the zone files and the config file.

Build the container:
'''
$ cd bind9
$ docker built -t bind9:foo .
$ docker run -d $image_id --name foo_container
'''
