#!/bin/bash

cyberpanel_manage() {
    echo "🔍 Checking if CyberPanel is installed..."

    if command -v cyberpanel >/dev/null 2>&1 || [[ -d "/usr/local/CyberCP" ]]; then
        echo "✅ CyberPanel is already installed. Proceeding with upgrade..."
        sh <(curl -s https://raw.githubusercontent.com/usmannasir/cyberpanel/stable/preUpgrade.sh || wget -qO - https://raw.githubusercontent.com/usmannasir/cyberpanel/stable/preUpgrade.sh)
    else
        echo "❌ CyberPanel is not installed. Installing CyberPanel..."
        sudo apt update && sudo apt upgrade -y
        sh <(curl -s https://cyberpanel.net/install.sh || wget -qO - https://cyberpanel.net/install.sh)
    fi
}

change_php_version(){
    echo "🔧 Setting PHP CLI to use lsphp82..."
    sudo ln -sf /usr/local/lsws/lsphp82/bin/php /usr/bin/php
}

change_cyberpanel_password(){
    echo
    read -s -p "🔑 Enter new CyberPanel admin password: " admin_pass
    echo
    echo "🔐 Changing admin password..."
    adminPass "$admin_pass"
}

cyberpanel_manage
change_php_version
change_cyberpanel_password

echo "✅ Done."
