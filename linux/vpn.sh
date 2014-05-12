# install pptpsetup
sudo yum install pptpsetup.x86_64

# create vpn
# server ip: 192.168.32.23
# user name: myname
# user passwd: 123456
sudo pptpsetup --create vpn --server 192.168.32.23 --username myname --password 123456 --encrypt --start

# replace route
# my local gateway: 192.168.0.1
# my local ip: 192.168.0.105
# my vpn connection dev: ppp0
sudo ip route replace 192.168.32.23 dev p4p1 via 192.168.0.1 src 192.168.0.105
sudo ip route add default via ppp0

# stop vpn
pkill pptp

#reset route
sudo ip route del 192.168.32.23 dev p4p1 via 192.168.0.1 src 192.168.0.105
sudo ip route default via 192.168.0.1


# shell script
!/bin/sh

if [ -z $1 ] ; then
        echo 'error: the valid opt is start/stop/reset'
        exit 0
fi

function reset_route(){
        ip route del 103.31.20.97 via 10.80.1.1 dev p4p1 src 10.80.1.141
        ip route add default via 10.80.1.1
}

function start(){
        pptpsetup --create vpn --server 103.31.20.97 --username huale --password 123456 --start --encrypt
}

function set_route(){
        ip route replace 103.31.20.97 via 10.80.1.1 dev p4p1 src 10.80.1.141
        ip route replace default dev ppp0
}

function stop(){
        pkill pptp
}

case "$1" in
        "start")
                reset_route
                start
                set_route
        ;;
        "stop")
                stop
                reset_route
        ;;
        "reset")
                reset_route
        ;;
esac