# easy-hysteria2

 A script for hysteria2

## language

 [Chinese](README_zh.md)

## Resolve your domain name to your server ip

## Install
It is recommended to use in Debian

If ufw is running, this script will auto open 80 port and 443 port

    curl -O https://raw.githubusercontent.com/Catalina-sys456/easy-hysteria2/main/easy-hysteria2.sh && chmod u+x easy-hysteria2.sh

## How to use


### Switch to root user
Just type the password,it won't show on the screen

### Run
    ./easy-hysteria2.sh

### Order explain
    1: Used to install hysteria2 for the first time and start the service. The script will automatically generate random passwords and configuration files for you
    2: Stop service but not uninstall
    3: Turn on service
    4: Stop the service and uninstall hysteria2

## Client Configuration
    Copy the script generated connection to your proxy client, or configure it manually
