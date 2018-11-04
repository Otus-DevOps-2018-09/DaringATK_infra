## DaringATK_infra
DaringATK Infra repository

###solution_1
```
ssh -J wrx@35.210.57.9 wrx@10.132.0.3
```

###solution_2
```
nano ~/.ssh/config
```

add to config

Host bastion
   HostName 35.210.57.9
   User wrx
   Port 22
   PasswordAuthentication no

Host someinternalhost
   HostName 10.132.0.3
   ProxyCommand ssh bastion -W %h:%p
   User wrx
   Port 22
   PasswordAuthentication no

bastion_IP = 35.210.57.9
someinternalhost_IP = 10.132.0.3


##Homework 4 
```
testapp_IP = 35.187.16.183
testapp_port = 9292
```

###command create vm and install app

```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=./startup.sh
```

###add firewall  rule

gcloud compute firewall-rules create default-puma-server\
  --allow=tcp:9292 \
  --target-tags=puma-server

