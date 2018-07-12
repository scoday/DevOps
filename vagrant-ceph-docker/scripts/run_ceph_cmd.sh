#!/bin/bash

docker exec `docker ps --no-trunc -q | tail -1` $*
