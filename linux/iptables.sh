# 如果未设置过的话，设置一下
$ sudo vi /etc/sysconfig/iptables-config
$ IPTABLES_SAVE_COUNTER="yes"

# 开启80端口
$ sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
$ sudo service iptables save
$ sudo service iptables stop
$ sudo service iptables start
