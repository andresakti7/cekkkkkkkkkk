#!/bin/bash
# COLOR VALIDATION
clear
function xmenu(){
RED='\033[0;31m'
NC='\033[0m'
gray="\e[1;30m"
Blue="\033[0;34m"
green='\033[0;32m'
grenbo="\e[92;1m"
YELL='\033[0;33m'
IWhite='\033[0;97m'       # White
wh="\033[0;1;33m"
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
IPVPS=$(curl -s ipv4.icanhazip.com)
domain=$(cat /etc/xray/domain)
RAM=$(free -m | awk 'NR==2 {print $2}')
USAGERAM=$(free -m | awk 'NR==2 {print $3}')
MEMOFREE=$(printf '%-1s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
LOADCPU=$(printf '%-0.00001s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
MODEL=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
CORE=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
DATEVPS=$(date +'%d/%m/%Y')
TIMEZONE=$(printf '%(%H:%M:%S)T')
SERONLINE=$(uptime -p | cut -d " " -f 2-10000)
clear
echo -e "\e[32mloading...\e[0m"
clear

# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"

# Getting CPU Information | AndreSakti
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${coREDiilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
DATE2=$(date -R | cut -d " " -f -5)
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
clear
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
dropbear_service=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
haproxy_service=$(systemctl status haproxy | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#Status | AndreSakti
clear
# STATUS SERVICE  SSH 
if [[ $ssh_service == "running" ]]; then 
   status_ssh="${green}ON${NC}"
else
   status_ssh="${RED}❌${NC} "
fi

# // SSH Websocket Proxy
ssh_ws=$( systemctl status ws | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws_epro="${green}ON${NC}"
else
    status_ws_epro="${RED}❌${NC} "
fi

# STATUS SERVICE HAPROXY
if [[ $haproxy_service == "running" ]]; then 
   status_haproxy="${green}ON${NC}"
else
   status_haproxy="${RED}❌${NC} "
fi

# STATUS SERVICE XRAY
if [[ $xray_service == "running" ]]; then 
   status_xray="${green}ON${NC}"
else
   status_xray="${RED}❌${NC} "
fi

# STATUS SERVICE NGINX
if [[ $nginx_service == "running" ]]; then 
   status_nginx="${green}ON${NC}"
else
   status_nginx="${RED}❌${NC} "
fi

# STATUS SERVICE Dropbear
if [[ $dropbear_service == "running" ]]; then 
   status_dropbear="${green}ON${NC}"
else
   status_dropbear="${RED}❌${NC} "
fi
#vmess total account
vm=$(cat /etc/vmess/.vmess.db | wc -l)
vm1=$(cat /etc/vmesstrial/.vmesstrial.db | wc -l)
xvmess=$(expr "$vm" + "$vm1")
#vless total account
vll=$(cat /etc/vless/.vless.db | wc -l)
vll1=$(cat /etc/vlesstrial/.vlesstrial.db | wc -l)
xvless=$(expr "$vll" + "$vll1")
#Trojan total account
trr=$(cat /etc/trojan/.trojan.db | wc -l)
trr1=$(cat /etc/trojantrial/.trojantrial.db | wc -l)
xtrojan=$(expr "$trr" + "$trr1")
#SS total account
ssk=$(cat /etc/shadowsocks/.shadowsocks.db | wc -l)
#SSH total account
sssh=$(cat /etc/ssh/.ssh.db | wc -l)
echo -e " "
echo -e " ${lolcat}┌──────────────────────────────────────────────────────────┐${lolcat}"  | lolcat
echo -e " ${lolcat}│$IWhite\033[41m                    SYSTEM INFORMATION                    $IWhite${lolcat}│$lolcat"
echo -e " ${IPurple}└──────────────────────────────────────────────────────────┘${lolcat}"  | lolcat
echo -e " ${lolcat}┌──────────────────────────────────────────────────────────┐${lolcat}"  | lolcat
echo -e " ${lolcat}│$BICyan System OS${NC}     $IPurple=$BICyan $MODEL${NC}"
echo -e " ${lolcat}│$BICyan IP VPS${NC}        $IPurple=$BICyan $IPVPS${NC}"
echo -e " ${lolcat}│$BICyan Domain${NC}        $IPurple=$BICyan $domain${NC}"
#echo -e " ${IPurple}│$BICyan Expiry script${NC} $IPurple=$wh $certifacate ${wh}Days"
echo -e " ${lolcat}│$BICyan Expiry script${NC} $IPurple=$wh $CCertifacate ${wh}Days"
echo -e " ${lolcat}└──────────────────────────────────────────────────────────┘${lolcat}"  | lolcat
echo -e "        $BICyan SSH $BICyan: $status_ssh" "        $BICyan NGINX $BICyan: $status_nginx" "        $BICyan XRAY $BICyan: $status_xray         $NC" 
echo -e " ${lolcat}┌──────────────────────────────────────────────────────────┐${lolcat}"  | lolcat
echo -e " ${lolcat}│                                                          │"
echo -e " ${lolcat}│$BICyan [${wh}01${BICyan}]$BICyan SSH MENU     ${IPurple}│$BICyan [${wh}07${BICyan}]$BICyan DELL ALL EXP ${IPurple}│$BICyan [${wh}13${BICyan}]$BICyan BCKP/RSTR   ${lolcat}│$wh" 
echo -e " ${lolcat}│$BICyan [${wh}02${BICyan}]$BICyan VMESS MENU   ${IPurple}│$BICyan [${wh}08${BICyan}]$BICyan AUTOREBOOT  ${IPurple} │$BICyan [${wh}14${BICyan}]$BICyan REBOOT      ${lolcat}│$wh"    
echo -e " ${lolcat}│$BICyan [${wh}03${BICyan}]$BICyan VLESS MENU   ${IPurple}│$BICyan [${wh}09${BICyan}]$BICyan INFO PORT   ${IPurple} │$BICyan [${wh}15${BICyan}]$BICyan RESTART     ${lolcat}│$wh"   
echo -e " ${lolcat}│$BICyan [${wh}04${BICyan}]$BICyan TROJAN MENU  ${IPurple}│$BICyan [${wh}10${BICyan}]$BICyan SPEEDTEST   ${IPurple} │$BICyan [${wh}16${BICyan}]$BICyan DOMAIN      ${lolcat}│$wh" 
echo -e " ${lolcat}│$BICyan [${wh}05${BICyan}]$BICyan SHADOW MENU  ${IPurple}│$BICyan [${wh}11${BICyan}]$BICyan RUNNING     ${IPurple} │$BICyan [${wh}17${BICyan}]$BICyan CERT SSL    ${lolcat}│$wh"
echo -e " ${lolcat}│$BICyan [${wh}06${BICyan}]$BICyan LIMITSPEED   ${IPurple}│$BICyan [${wh}12${BICyan}]$BICyan CLEAR LOG   ${IPurple} │$BICyan [${wh}18${BICyan}]$BICyan CLEAR CACHE ${lolcat}│$wh"
echo -e " ${lolcat}│                                                          │"
echo -e " ${lolcat}└──────────────────────────────────────────────────────────┘${lolcat}"  | lolcat
echo -e "               "                    "SSH = $sssh" "  VMESS = $xvmess"  " VLESS = $xvless" | lolcat
echo -e "                 "                      "TROJAN = $xtrojan" "SHADOWSOCKS = $ssk" | lolcat
echo -e " ${lolcat}   ┌────────────────────────────────────────────────────┐${lolcat}"  | lolcat
echo -e " ${lolcat}   │$BICyan Version       ${IPurple}=$BICyan V3.0"
echo -e " ${lolcat}   │$BICyan User          ${IPurple}=$BICyan $username"
echo -e " ${lolcat}   │$BICyan Script Status ${IPurple}=$NC $exp $sts  "
echo -e " ${lolcat}   └────────────────────────────────────────────────────┘${lolcat}"  | lolcat
echo
read -p " Select menu : " opt
echo -e ""
case $opt in
1 | 01)
clear
m-sshws
;;
2 | 02)
clear
m-vmess
;;
3 | 03)
clear
m-vless
;;
4 | 04)
clear
m-trojan
;;
5 | 05)
clear
m-ssws
;;
6 | 06)
clear
limitspeed
;;
7 | 07)
clear
xp
echo ""
echo -e " ${GREEN} Back to menu in 1 sec ${NC}"
sleep 1
menu
;;
8 | 08)
clear
autoreboot
;;
9 | 09)
clear
prot
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;
10)
clear
speedtest-cli
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;
11)
clear
run
;;
12)
clear
clearlog
;;
13)
clear
menu-backup
;;
14)
clear
reboot
;;
15)
clear
restart
;;
16)
clear
addhost
;;
17)
clear
fixcert
;;
18)
clear
clearcache
;;
esac
read -n 1 -s -r -p "Press any key to back on menu"

menu
}
RED='\033[0;31m'
NC='\033[0m'
gray="\e[1;30m"
Blue="\033[0;34m"
green='\033[0;32m'
grenbo="\e[92;1m"
YELL='\033[0;33m'
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
IPVPS=$(curl -s ipv4.icanhazip.com)
domain=$(cat /etc/xray/domain)
RAM=$(free -m | awk 'NR==2 {print $2}')
USAGERAM=$(free -m | awk 'NR==2 {print $3}')
MEMOFREE=$(printf '%-1s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
LOADCPU=$(printf '%-0.00001s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
MODEL=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
CORE=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
DATEVPS=$(date +'%d/%m/%Y')
TIMEZONE=$(printf '%(%H:%M:%S)T')
SERONLINE=$(uptime -p | cut -d " " -f 2-10000)
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
echo ""
#########################
# USERNAME
rm -f /usr/bin/user
username=$(curl https://raw.githubusercontent.com/andresakti7/kintil/main/ip | grep $MYIP | awk '{print $2}')
echo "$username" >/usr/bin/user
# validity
rm -f /usr/bin/e
valid=$(curl https://raw.githubusercontent.com/andresakti7/kintil/main/ip | grep $MYIP | awk '{print $4}')
echo "$valid" >/usr/bin/e
# DETAIL ORDER
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)
clear
# CERTIFICATE STATUS
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
CCertifacate=$(((d1 - d2) / 86400))
# VPS Information
DATE=$(date +'%Y-%m-%d')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "$COLOR1 $NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}
mai="datediff "$Exp" "$DATE""

# Status ExpiRED Active | AndreSakti
Info="(${green}Active${NC})"
Error="(${RED}ExpiRED${NC})"
today=`date -d "0 days" +"%Y-%m-%d"`
Exp1=$(curl https://raw.githubusercontent.com/andresakti7/kintil/main/ip | grep $MYIP | awk '{print $4}')
if [[ $today < $Exp1 ]]; then
sts="${Info}"
else
sts="${Error}"
fi
#MYIP=$(curl -sS ipv4.icanhazip.com)
#echo ""
#########################
# USERNAME
#rm -f /usr/bin/user
#username=$(curl https://raw.githubusercontent.com/andresakti7/kintil/main/ip | grep $MYIP | awk '{print $2}')
#echo "$username" >/usr/bin/user
# validity
#rm -f /usr/bin/e
#valid=$(curl https://raw.githubusercontent.com/andresakti7/kintil/main/ip | grep $MYIP | awk '{print $4}')
#echo "$valid" >/usr/bin/e
# DETAIL ORDER
#username=$(cat /usr/bin/user)
#oid=$(cat /usr/bin/ver)
#exp=$(cat /usr/bin/e)
#clear
# CERTIFICATE STATUS
###d1=$(date -d "$valid" +%s)
###d2=$(date -d "$today" +%s)
###certifacate=$(((d1 - d2) / 86400))
# VPS Information
#DATE=$(date +'%Y-%m-%d')
#datediff() {
#    d1=$(date -d "$1" +%s)
#    d2=$(date -d "$2" +%s)
#    echo -e "$COLOR1 $NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
#}
#mai="datediff "$Exp" "$DATE""

# Status ExpiRED Active | AndreSakti
#Info="(${green}Active${NC})"
#Error="(${RED}ExpiRED${NC})"
#today=`date -d "0 days" +"%Y-%m-%d"`
#Exp1=$(curl https://raw.githubusercontent.com/andresakti7/kintil/main/ip | grep $MYIP | awk '{print $4}')
#if [[ $today < $Exp1 ]]; then
#sts="${Info}"
#else
#sts="${Error}"
#fi
echo -e "\e[32mloading...\e[0m"
clear

# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"

# Getting CPU Information | AndreSakti
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${coREDiilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
DATE2=$(date -R | cut -d " " -f -5)
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
clear
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
dropbear_service=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
haproxy_service=$(systemctl status haproxy | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#Status | AndreSakti
clear
is_root() {
    if [ 0 == $UID ]; then
        echo -e "${OK} ${yl} The current user is the root user..${yl}"
        sleep 1
        echo -e "Getting Information...."
    else
        echo -e "${Error} ${yl} Please switch to the root user and execute start-menu again ${yl}"
        exit 1
    fi
}
clear
#BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
#BIBlue='\033[1;94m'       # Blue
#BIPurple='\033[1;95m'     # Purple
#BICyan='\033[1;96m'       # Cyan
BICyan='\033[1;97m'      # White
Uwhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'

# // Exporting Language to UTF-8

export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'


# // Export Color & Information
export m="\033[0;1;31m"
export y="\033[0;1;34m"
export yy="\033[0;1;36m"
export yl="\033[0;1;37m"
export wh="\033[0;1;33m"
export xz="\033[0;1;35m"
export gr="\033[0;1;32m"

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

export m="\033[0;1;31m"
export y="\033[0;1;34m"
export yy="\033[0;1;36m"
export yl="\033[0;1;37m"
export wh="\033[0;1;33m"
export xz="\033[0;1;35m"
export gr="\033[0;1;32m"
echo "1;36m" > /etc/banner
echo "30m" > /etc/box
echo "1;31m" > /etc/line
echo "1;32m" > /etc/text
echo "1;33m" > /etc/below
echo "47m" > /etc/back
echo "1;35m" > /etc/number
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo 3d > /usr/bin/test
GitUser="givpn"
#IZIN SCRIPT
#MYIP=$(curl -sS ipv4.icanhazip.com)
clear
#Domain
Domen=$(cat /etc/xray/domain)
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)
CITY=$(curl -s ipinfo.io/city)
WKT=$(curl -s ipinfo.io/timezone)
IPVPS=$(curl -s ipinfo.io/ip)
cpu=$(neofetch | grep "CPU" | cut -d: -f2 | sed 's/ //g')
cname=$(awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo)
cores=$(awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo)
freq=$(awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo)
tram=$(free -m | awk 'NR==2 {print $2}')
uram=$(free -m | awk 'NR==2 {print $3}')
fram=$(free -m | awk 'NR==2 {print $4}')
clear
# Getting CPU Information
vnstat_profile=$(vnstat | sed -n '3p' | awk '{print $1}' | grep -o '[^:]*')
vnstat -i ${vnstat_profile} >/root/t1
bulan=$(date +%b)
today=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
todayd=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
today_v=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $9}')
today_rx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $2}')
today_rxv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $3}')
today_tx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $5}')
today_txv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $6}')
if [ "$(grep -wc ${bulan} /root/t1)" != '0' ]; then
    bulan=$(date +%b)
    month=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $9}')
    month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $10}')
    month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $3}')
    month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $4}')
    month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $6}')
    month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $7}')
else
    bulan=$(date +%Y-%m)
    month=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $8}')
    month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $9}')
    month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $2}')
    month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $3}')
    month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $5}')
    month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $6}')
fi
if [ "$(grep -wc yesterday /root/t1)" != '0' ]; then
    yesterday=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $8}')
    yesterday_v=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $9}')
    yesterday_rx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $2}')
    yesterday_rxv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $3}')
    yesterday_tx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $5}')
    yesterday_txv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $6}')
else
    yesterday=NULL
    yesterday_v=NULL
    yesterday_rx=NULL
    yesterday_rxv=NULL
    yesterday_tx=NULL
    yesterday_txv=NULL
fi
#if [ "$(grep -wc live /root/t1)" != '0' ]; then
#    live=$(vnstat -i ${vnstat_profile} | grep live | awk '{print $8}')
#    live_v=$(vnstat -i ${vnstat_profile} | grep live | awk '{print $9}')
#    live_rx=$(vnstat -i ${vnstat_profile} | grep live | awk '{print $2}')
#    live_rxv=$(vnstat -i ${vnstat_profile} | grep live | awk '{print $3}')
#    live_tx=$(vnstat -i ${vnstat_profile} | grep live | awk '{print $5}')
#    live_txv=$(vnstat -i ${vnstat_profile} | grep live | awk '{print $6}')
#fi


# STATUS EXPIRED ACTIVE
#Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[4$below" && Font_color_suffix="\033[0m"
#Info="${Green_font_prefix}(Registered)${Font_color_suffix}"
#Error="${Green_font_prefix}${Font_color_suffix}${Red_font_prefix}[EXPIRED]${Font_color_suffix}"

#today=$(date -d "0 days" +"%Y-%m-%d")
#Exp21=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
#if [[ $today < $Exp21 ]]; then
#    sts="${Info}"
#else
#    sts="${Error}"
#fi
echo -e "\e[32mloading...\e[0m"
# CERTIFICATE STATUS
###d1=$(date -d "$valid" +%s)
###d2=$(date -d "$today" +%s)
###certifacate=$(((d1 - d2) / 86400))
#vmess total account
vm=$(cat /etc/vmess/.vmess.db | wc -l)
vm1=$(cat /etc/vmesstrial/.vmesstrial.db | wc -l)
xvmess=$(expr "$vm" + "$vm1")
#vless total account
vll=$(cat /etc/vless/.vless.db | wc -l)
vll1=$(cat /etc/vlesstrial/.vlesstrial.db | wc -l)
xvless=$(expr "$vll" + "$vll1")
#Trojan total account
trr=$(cat /etc/trojan/.trojan.db | wc -l)
trr1=$(cat /etc/trojantrial/.trojantrial.db | wc -l)
xtrojan=$(expr "$trr" + "$trr1")
#SS total account
ssk=$(cat /etc/shadowsocks/.shadowsocks.db | wc -l)
#SSH total account
sssh=$(cat /etc/ssh/.ssh.db | wc -l)
# TOTAL ACC CREATE VMESS WS
#vmess=$(grep -c -E "^###vms " "/etc/xray/config.json")
#vmess1=$(grep -c -E "^###vmstrial " "/etc/xray/config.json")
#vmess2=$(expr "$vmess" + "$vmess1")
# TOTAL ACC CREATE  VLESS WS
#less=$(grep -c -E "^###vls " "/etc/xray/config.json")
#less1=$(grep -c -E "^###vlstrial " "/etc/xray/config.json")
#less2=$(expr "$vless" + "$vless1")
# TOTAL ACC CREATE  VLESS TCP XTLS
#sws=$(grep -c -E "^###ssws " "/etc/xray/config.json")
# TOTAL ACC CREATE  TROJAN
#rtls=$(grep -c -E "^###trx " "/etc/xray/tcp.json")
# TOTAL ACC CREATE  TROJAN WS TLS
#rws=$(grep -c -E "^###trs " "/etc/xray/config.json")
#rws1=$(grep -c -E "^###trstrial " "/etc/xray/config.json")
#rws2=$(expr "$trws" + "$trws1")
# TOTAL ACC CREATE  SOCKWS
#hockws=$(grep -c -E "^###sckws " "/etc/xray/config.json")
# TOTAL ACC CREATE OVPN SSH
#otal_ssh="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
# PROVIDED
creditt=$(cat /root/provided)
# BANNER COLOUR
banner_colour=$(cat /etc/banner)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR ON TOP
text=$(cat /etc/text)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# BANNER
banner=$(cat /usr/bin/bannerku)
ascii=$(cat /usr/bin/test)
clear
echo -e "\e[$banner_colour"
#figlet -f $ascii "$banner"
#echo -e "\e[$text  VPS Script"
#export sem=$( curl -s https://raw.githubusercontent.com/andresakti7/test/main/versions)
#export pak=$( cat /home/.ver)
#IPVPS=$(curl -s ipinfo.io/ip )
ISPVPS=$( curl -s ipinfo.io/org )
#export Server_URL="raw.githubusercontent.com/andresakti7/test/main"
#License_Key=$(cat /etc/${Auther}/license.key)
#export Nama_Issued_License=$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $License_Key | cut -d ' ' -f 7-100 | tr -d '\r' | tr -d '\r\n')
clear
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
echo -e "  \e[$back_text                    \e[30m[\e[$box SERVER INFORMATION\e[30m ]\e[1m                  \e[m"
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e "  \e[$yy ISP                  : $ISPVPS"
#echo -e "  \e[$yy CPU Model            : $cpu"
#echo -e "  \e[$yy CPU Model            :$cname \e[0m"
echo -e "  \e[$yy CPU Frequency        : $cpu"
#echo -e "  \e[$yy CPU Frequency        :$y$freq MHz $yl"
#echo -e "  \e[$yy Number Of Core       : $cores $yl"
echo -e "  \e[$yy Operating System     : "$(hostnamectl | grep "Operating System" | cut -d ' ' -f5-)
echo -e "  \e[$yy Kernel               : $(uname -r)"
echo -e "  \e[$yy Total Amount Of Ram  : $tram MB"
echo -e "  \e[$yy Used RAM             : $uram MB"
echo -e "  \e[$yy Free RAM             : $fram MB"
echo -e "  \e[$yy System Uptime        : $uptime"
echo -e "  \e[$yy Ip Vps/Address       :$xz $IPVPS $xz"
echo -e "  \e[$yy Domain Name          :$xz $Domen $xz"
echo -e "  \e[$yy Order ID             :$xz $username $xz"
#echo -e "  \e[$yy Expired Status       :$wh $(cat /etc/${Auther}/license-remaining-active-days.db)$wh Days$wh" | lolcat
echo -e "  \e[$yy Provided By          :$yl Script Credit by Andre Sakti $yl"
echo -e "  \e[$yy Status Update        : Latest Version"
echo -e "  $yy Expired Status       :$NC $exp $sts  " #| lolcat
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
echo -e " \e[$yy   Traffic         Today        Yesterday       Month   $yy"
echo -e "   \e[$text Download${NC}      \e[${text}$today_tx $today_txv       $yesterday_tx $yesterday_txv      $month_tx $month_txv   \e[0m"
echo -e "   \e[$text Upload${NC}        \e[${text}$today_rx $today_rxv       $yesterday_rx $yesterday_rxv      $month_rx $month_rxv   \e[0m"
echo -e "   \e[$text Total${NC}       \e[${text}  $todayd $today_v      $yesterday $yesterday_v      $month $month_v  \e[0m "
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
#echo -e "                      \E[0;41;37m LIST ACCOUNTS \E[0m" 
echo -e "                       $BOLD $UNDERLINE LIST ACCOUNTS " | lolcat
echo -e " \e[$yy        SSH      Vmess      Vless      Trojan    SOCK-WS        "  
echo -e " \e[$below         $sssh         $xvmess          $xvless          $xtrojan          $ssk            \e[0m "
echo -e " \e[$yy      Account   Account    Account    Account    Account$yy "  
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
#echo -e "  \e[   $yyExpired Status :$wh $(cat /etc/${Auther}/license-remaining-active-days.db)$wh Days$wh" | lolcat
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e "  \e[$number (111)\e[m\e[$below xmenu"  ">>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >>> \e[m" | lolcat
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
#echo -e " \e[$yy      Traffic        Download       Upload      Total   $yy"
#echo -e "   \e[$text    Live${NC}     \e[${text}$live_tx $live_txv      ${text}$live_rx $live_rxv     ${text}  $live $live_v   \e[0m"
#echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e "\e[$below "
read -p " Select xmenu :  " menu
echo -e ""
case $menu in
111) clear ; xmenu ;;
0) clear ; menu ;;
#x) exit ;;
#*) echo -e "" ; echo "Press any key to back exit" ; sleep 1 ; exit ;;
esac
