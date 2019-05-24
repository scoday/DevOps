# DevOps: Kubernetes
## Background
These days you cannot travel very far without hearing some enterprising young DevOps'er going on and on about kubernetes or k8s' as the cool kids say. It is an interesting platform that attempts to gloss over some basics of engineering but does keep your apps up. So that is a win right? It can be if one continues to maintain a proper SRE process that involves logging, analysis, and introspection. 

## Environment
openSUSE by choice. Dell quad core, etc. Kubernetes version:
```
> kubectl version
Client Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.1", GitCommit:"b7394102d6ef778017f2ca4046abbaa23b88c290", GitTreeState:"clean", BuildDate:"2019-04-23T12:00:00Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.2", GitCommit:"66049e3b21efe110454d67df4fa62b08ea79a19b", GitTreeState:"clean", BuildDate:"2019-05-16T16:14:56Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}
```

### Building of the environment
```
> zypper in kubernetes-404-server kubernetes-client kubernetes-common kubernetes-dashboard kubernetes-dns kubernetes-extra kubernetes-kubeadm kubernetes-kubelet kubernetes-master kubernetes-node kubernetes-salt python2-kubernetes
> zypper in -y docker docker-compose && systemctl enable docker && systemctl start docker
```
Disable swap since kubernetes requires it.

```
> swap off -a # (then comment out the swap partition in /etc/fstab)
> kubeadm init  --pod-network-cidr=10.244.0.0/16 —ignore-preflight-errors=all
```


## Files

## Docker
```
$ docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
``` 
