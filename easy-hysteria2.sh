#! /usr/bin/bash

# simple script to use hysteria2 easyly

#random password
password=$(openssl rand -base64 12)

open_port(){
    if systemctl is-active --quiet ufw.service; then
	ufw allow 80
	ufw allow 443
    fi
}

install_hysteria2(){
    bash <(curl -fsSL https://get.hy2.sh/)
}

uninstall_hysteria2(){
    echo "uninstalling hysteria2"
    bash <(curl -fsSL https://get.hy2.sh/) --remove
}
read_domain_name(){
    read -p "type your domain name: " domain
    read -p "type the fake domain name (maybe bing.com is a good idea): " fake_domain
}

edit_config_file(){
    cat <<EOF > /etc/hysteria/config.yaml
acme:
  domains:
    - $domain
  email: qwndnidna@fake.com
auth:
  type: password
  password: $password
masquerade:
  type: proxy
  proxy:
    url: https://$fake_domain/
    rewriteHost: true
EOF
}

start_enable(){
    systemctl start hysteria-server.service
    systemctl enable hysteria-server.service
    echo "hysteria2 running now"
}

stop_disable(){
    systemctl stop hysteria-server.service
    systemctl disable hysteria-server.service
    echo "hysteria2 stopped"
}


performance_optimization(){
    sysctl -w net.core.rmem_max=16777216
    sysctl -w net.core.wmem_max=16777216
    chrt -r 99 $(pidof hysteria)
}

report(){
    if systemctl is-active --quiet hysteria-server.service; then
	echo "installation success, your password is $password"
	echo "URI link: hysteria2://$password@$domain:443/?sni=$domain&insecure=0"
    else
	echo "field to install ,manual installation required"
    fi
}

show_menu(){
    echo "1. setup hysteria2"
    echo "2. stop and disable hysteria2"
    echo "3. start and enable hysteria2"
    echo "4. stop and uninstall hysteria2"
    read -p "[1/2/3/4] " choice
}

main(){
    show_menu

    case $choice in
	1)
	    open_port
	    install_hysteria2
	    read_domain_name
	    edit_config_file
      start_enable
	    performance_optimization
	    report
	    ;;
	2)
	    stop_disable
	    ;;
	3)
	    start_enable
	    performance_optimization
      ;;
	4)
	    stop_disable
	    uninstall_hysteria2
	    ;;
    esac
}

main
