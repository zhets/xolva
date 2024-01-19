#!/bin/bash
history -c 
rm -fr xolva.sh
rm -fr /etc/bot/xolva
rm -fr /usr/bin/xdbot.zip*
rm -fr /usr/bin/bot
#color
NC='\e[0m'
u="\033[1;36m"
y="\033[1;93m"
g="\033[1;92m"
r="\033[1;91m"
REPO="https://raw.githubusercontent.com/zhets/xolva/main/"
NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)
#install
mkdir -p /etc/bot/xolva
apt update && apt upgrade
apt install neofetch -y
apt install python3 python3-pip git
cd /etc/bot/xolva
wget -q -O xolva.zip "${REPO}xolva.zip"
unzip xolva.zip
rm -f xolva.zip
pip3 install -r xolpanel/requirements.txt

clear
echo ""
echo -e "$u ┌────────────────────────────────────────────────┐${NC}"
echo -e "$u │ \e[1;97;101m                ADD BOT PANEL                 ${NC} ${u}│${NC}"
echo -e "$u └────────────────────────────────────────────────┘${NC}"
echo -e "$u ┌────────────────────────────────────────────────┐${NC}"
echo -e "$u │ ${g}Tutorial Create Bot and ID Telegram                   ${NC}"
echo -e "$u │ ${g}Create Bot and Token Bot : @BotFather                 ${NC}"
echo -e "$u │ ${g}Info Id Telegram : @MissRose_bot perintah /info      ${NC}"
echo -e "$u └────────────────────────────────────────────────┘${NC}"
echo -e ""
read -e -p "  [*] Input your Bot Token : " bottoken
read -e -p "  [*] Input Your Id Telegram : " admin
#echo -e BOT_TOKEN='"'$bottoken'"' >> /etc/bot/xolva/xolpanel/var.txt
#echo -e ADMIN='"'$admin'"' >> /etc/bot/xolva/xolpanel/var.txt
#echo -e DOMAIN='"'$domain'"' >> /etc/bot/xolva/xolpanel/var.txt
#echo -e PUB='"'$PUB'"' >> /etc/bot/xolva/xolpanel/var.txt
#echo -e HOST='"'$NS'"' >> /etc/bot/xolva/xolpanel/var.txt
echo -e BOT_TOKEN='"'$bottoken'"' >> /etc/bot/xolva/xolpanel/var.txt
echo -e ADMIN='"'$admin'"' >> /etc/bot/xolva/xolpanel/var.txt
echo -e DOMAIN='"'$domain'"' >> /etc/bot/xolva/xolpanel/var.txt
echo -e PUB='"'$PUB'"' >> /etc/bot/xolva/xolpanel/var.txt
echo -e SLDOMAIN='"'$NS'"' >> /etc/bot/xolva/xolpanel/var.txt
clear

if [ -e /etc/systemd/system/xolva.service ]; then
echo ""
else
rm -fr /etc/systemd/system/xolva.service
fi

cat > /etc/systemd/system/xolva.service << END
[Unit]
Description=Simple Tele Bot By @xdxl_store
ProjectAfter=network.target

[Service]
WorkingDirectory=/etc/bot/xolva
ExecStart=python3 -m xolpanel
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl start xolva
systemctl enable xolva
systemctl restart xolva
cd

# // STATUS SERVICE BOT
bot_service=$(systemctl status xolva | grep active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $bot_service == "running" ]]; then 
   sts_bot="${g}Online${NC}"
else
   sts_bot="${r}Offline${NC}"
fi

rm -fr /usr/bin/bot
clear
neofetch
echo -e "  ${y} Your Data BOT Info"
echo -e "  ${u}┌───────────────────────────────────┐${NC}"
echo -e "  ${u}│$r Status BOT ${y}=$NC $sts_bot "
echo -e "  ${u}│$r Token BOT  ${y}=$NC $bottoken "
echo -e "  ${u}│$r Admin ID   ${y}=$NC $admin "
echo -e "  ${u}│$r Domain     ${y}=$NC $domain "
echo -e "  ${u}│$r NS Domain  ${y}=$NC $NS "
echo -e "  ${u}└───────────────────────────────────┘${NC}"
echo -e ""
history -c
