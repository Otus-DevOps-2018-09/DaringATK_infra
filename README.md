# DaringATK_infra
DaringATK Infra repository

solution_1
ssh -J wrx@35.210.57.9 wrx@10.132.0.3

solution_2
nano ~/.ssh/config

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
