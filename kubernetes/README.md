# DevOps: Kubernetes
## Background
These days you cannot travel very far without hearing some enterprising young DevOps'er going on and on about kubernetes or k8s' as the cool kids say. It is an interesting platform that attempts to gloss over some basics of engineering but does keep your apps up. So that is a win right? It can be if one continues to maintain a proper SRE process that involves logging, analysis, and introspection. 

## Environment
openSUSE by choice. Dell quad core, etc. Kubernetes version:

## Files

## Docker
```
$ docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
``` 
