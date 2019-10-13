#!/bin/bash
# 作者：Mark Salatino
# 协议：GPL
# 欢迎大家提交测试报告，并协助修正bug，目前完整测试的环境是Centos 7,7.5
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
[ $(id -u) != "0" ] && { echo "Error: You must be root to run this script"; exit 1; }

#template file
ca="Y24gPSAiX2lwXyIKb3JnYW5pemF0aW9uID0gIkdsb2JhbFNpZ24gbnYtc2EiCnNlcmlhbCA9IDEKZXhwaXJhdGlvbl9kYXlzID0gMzY1MApjYQpzaWduaW5nX2tleQpjZXJ0X3NpZ25pbmdfa2V5CmNybF9zaWduaW5nX2tleQ=="

server="Y24gPSAiX2lwXyIKb3JnYW5pemF0aW9uID0gIkdsb2JhbFNpZ24gbnYtc2EiCmV4cGlyYXRpb25fZGF5cyA9IDM2NTAKc2lnbmluZ19rZXkKZW5jcnlwdGlvbl9rZXkKdGxzX3d3d19zZXJ2ZXI="

s_cfg="ew0KICAgICJydW5fdHlwZSI6ICJzZXJ2ZXIiLA0KICAgICJsb2NhbF9hZGRyIjogIjAuMC4wLjAiLA0KICAgICJsb2NhbF9wb3J0IjogNDQzLA0KICAgICJyZW1vdGVfYWRkciI6ICIxMjcuMC4wLjEiLA0KICAgICJyZW1vdGVfcG9ydCI6IDgwLA0KICAgICJwYXNzd29yZCI6IFsNCiAgICAgICAgIl9wd2RfIiAgICAgICAgDQogICAgXSwNCiAgICAibG9nX2xldmVsIjogMSwNCiAgICAic3NsIjogew0KICAgICAgICAiY2VydCI6ICJfY2VydF8iLA0KICAgICAgICAia2V5IjogIl9rZXlfIiwNCiAgICAgICAgImtleV9wYXNzd29yZCI6ICIiLA0KICAgICAgICAiY2lwaGVyIjogIkVDREhFLUVDRFNBLUFFUzI1Ni1HQ00tU0hBMzg0OkVDREhFLVJTQS1BRVMyNTYtR0NNLVNIQTM4NDpFQ0RIRS1FQ0RTQS1DSEFDSEEyMC1QT0xZMTMwNTpFQ0RIRS1SU0EtQ0hBQ0hBMjAtUE9MWTEzMDU6RUNESEUtRUNEU0EtQUVTMTI4LUdDTS1TSEEyNTY6RUNESEUtUlNBLUFFUzEyOC1HQ00tU0hBMjU2OkVDREhFLUVDRFNBLUFFUzI1Ni1TSEEzODQ6RUNESEUtUlNBLUFFUzI1Ni1TSEEzODQ6RUNESEUtRUNEU0EtQUVTMTI4LVNIQTI1NjpFQ0RIRS1SU0EtQUVTMTI4LVNIQTI1NiIsDQogICAgICAgICJwcmVmZXJfc2VydmVyX2NpcGhlciI6IHRydWUsDQogICAgICAgICJhbHBuIjogWw0KCQkJImgyIiwNCiAgICAgICAgICAgICJodHRwLzEuMSINCiAgICAgICAgXSwNCiAgICAgICAgInJldXNlX3Nlc3Npb24iOiB0cnVlLA0KICAgICAgICAic2Vzc2lvbl90aWNrZXQiOiBmYWxzZSwNCiAgICAgICAgInNlc3Npb25fdGltZW91dCI6IDYwMCwNCiAgICAgICAgInBsYWluX2h0dHBfcmVzcG9uc2UiOiAiIiwNCiAgICAgICAgImN1cnZlcyI6ICIiLA0KICAgICAgICAiZGhwYXJhbSI6ICIiDQogICAgfSwNCiAgICAidGNwIjogew0KICAgICAgICAicHJlZmVyX2lwdjQiOiBmYWxzZSwNCiAgICAgICAgIm5vX2RlbGF5IjogdHJ1ZSwNCiAgICAgICAgImtlZXBfYWxpdmUiOiB0cnVlLA0KICAgICAgICAiZmFzdF9vcGVuIjogZmFsc2UsDQogICAgICAgICJmYXN0X29wZW5fcWxlbiI6IDIwDQogICAgfSwNCiAgICAibXlzcWwiOiB7DQogICAgICAgICJlbmFibGVkIjogZmFsc2UsDQogICAgICAgICJzZXJ2ZXJfYWRkciI6ICIxMjcuMC4wLjEiLA0KICAgICAgICAic2VydmVyX3BvcnQiOiAzMzA2LA0KICAgICAgICAiZGF0YWJhc2UiOiAidHJvamFuIiwNCiAgICAgICAgInVzZXJuYW1lIjogInRyb2phbiIsDQogICAgICAgICJwYXNzd29yZCI6ICIiDQogICAgfQ0KfQ0K"

c_cfg="ew0KICAgICJydW5fdHlwZSI6ICJjbGllbnQiLA0KICAgICJsb2NhbF9hZGRyIjogIjEyNy4wLjAuMSIsDQogICAgImxvY2FsX3BvcnQiOiAxMDgwLA0KICAgICJyZW1vdGVfYWRkciI6ICJfaXBfIiwNCiAgICAicmVtb3RlX3BvcnQiOiA0NDMsDQogICAgInBhc3N3b3JkIjogWw0KICAgICAgICAiX3B3ZF8iDQogICAgXSwNCiAgICAiYXBwZW5kX3BheWxvYWQiOiB0cnVlLA0KICAgICJsb2dfbGV2ZWwiOiAxLA0KICAgICJzc2wiOiB7DQogICAgICAgICJ2ZXJpZnkiOiBmYWxzZSwNCiAgICAgICAgInZlcmlmeV9ob3N0bmFtZSI6IHRydWUsDQogICAgICAgICJjZXJ0IjogImNhLWNlcnQucGVtIiwNCiAgICAgICAgImNpcGhlciI6ICJFQ0RIRS1FQ0RTQS1BRVMxMjgtR0NNLVNIQTI1NjpFQ0RIRS1SU0EtQUVTMTI4LUdDTS1TSEEyNTY6RUNESEUtRUNEU0EtQUVTMjU2LUdDTS1TSEEzODQ6RUNESEUtUlNBLUFFUzI1Ni1HQ00tU0hBMzg0OkVDREhFLUVDRFNBLUNIQUNIQTIwLVBPTFkxMzA1LVNIQTI1NjpFQ0RIRS1SU0EtQ0hBQ0hBMjAtUE9MWTEzMDUtU0hBMjU2OkVDREhFLVJTQS1BRVMxMjgtU0hBOkVDREhFLVJTQS1BRVMyNTYtU0hBOlJTQS1BRVMxMjgtR0NNLVNIQTI1NjpSU0EtQUVTMjU2LUdDTS1TSEEzODQ6UlNBLUFFUzEyOC1TSEE6UlNBLUFFUzI1Ni1TSEE6UlNBLTNERVMtRURFLVNIQSIsDQogICAgICAgICJzbmkiOiAiIiwNCiAgICAgICAgImFscG4iOiBbDQogICAgICAgICAgICAiaDIiLA0KICAgICAgICAgICAgImh0dHAvMS4xIg0KICAgICAgICBdLA0KICAgICAgICAicmV1c2Vfc2Vzc2lvbiI6IHRydWUsDQogICAgICAgICJzZXNzaW9uX3RpY2tldCI6IGZhbHNlLA0KICAgICAgICAiY3VydmVzIjogIiINCiAgICB9LA0KICAgICJ0Y3AiOiB7DQogICAgICAgICJub19kZWxheSI6IHRydWUsDQogICAgICAgICJrZWVwX2FsaXZlIjogdHJ1ZSwNCiAgICAgICAgImZhc3Rfb3BlbiI6IGZhbHNlLA0KICAgICAgICAiZmFzdF9vcGVuX3FsZW4iOiAyMA0KICAgIH0NCn0NCg==";

svc="W1VuaXRdCkFmdGVyPW5ldHdvcmsudGFyZ2V0IAoKW1NlcnZpY2VdCkV4ZWNTdGFydD0vdXNyL2Jpbi90cm9qYW4gLWMgL2V0Yy90cm9qYW4vY29uZmlnLmpzb24KUmVzdGFydD1hbHdheXMKU3RhcnRMaW1pdEJ1cnN0PTAKU3RhcnRMaW1pdEludGVydmFsPTAKCltJbnN0YWxsXQpXYW50ZWRCeT1tdWx0aS11c2VyLnRhcmdldA=="
# end template

# 检测Linux发行版名称和版本号
# function check_env() {
# 	if [ -f /etc/os-release ]; then
# 		# freedesktop.org and systemd
# 		. /etc/os-release
# 		OS=$NAME
# 		VER=$VERSION_ID   
# 	elif type lsb_release >/dev/null 2>&1; then
# 		# linuxbase.org
# 		OS=$(lsb_release -si)
# 		VER=$(lsb_release -sr)
# 	elif [ -f /etc/lsb-release ]; then
# 		# For some versions of Debian/Ubuntu without lsb_release command
# 		. /etc/lsb-release
# 		OS=$DISTRIB_ID
# 		VER=$DISTRIB_RELEASE
# 	elif [ -f /etc/debian_version ]; then
# 			# Older Debian/Ubuntu/etc.
# 			OS=Debian
# 			VER=$(cat /etc/debian_version)
# 	elif [ -f /etc/redhat-release ]; then
# 			# Older Red Hat, CentOS, etc.
# 			# Red Hat Enterprise Linux Server release 6.10 (Santiago)
# 			# 安装 redhat-lsb-core 之后 lsb_release可用
# 			OS="CentOS/RHEL"
# 			#local tmp_str=$(cat /etc/redhat-release)
# 			VER=$(tr -cd "[0-9]+[\.[0-9]+]?" < /etc/redhat-release)         
# 	else
# 		# Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
# 		# 无法识别的操作系统
# 		OS="unknown"
# 		VER="0"	
# 	fi
# 	# if [ $OS = "unknown"];then
# 	# 	exit 1
# 	# fi
# }
# check_env

#全局变量区
workpath=$(mktemp -d) #程序工作目录
trojan_path="/etc/trojan/cert/" #trojan服务端配置目录
trojan_client="/home/trojan" #trojan客户端配置目录
certbot_path="/opt/certbot" #certbot目录
certbot=$certbot_path/"certbot-auto" #cerbot可执行文件
#全局变量区结束

#初始化相关目录
function init(){
	mkdir -p $trojan_path $trojan_client $certbot_path
	chown -R $SUDO_USER: $trojan_client
	cd $workpath
}

#安装基础依赖
function setup_deps(){	
	# if [[ "$OS" == "Ubuntu" || "$OS" == "Debian GNU/Linux" ]]; then    
	# 	apt-get update
	# 	apt-get install curl wget gnutls-bin -y
	# elif [[ "$OS" == "CentOS Linux" || "$OS" == "CentOS/RHEL" || "$OS" == "Red Hat Enterprise Linux Server" ]]; then
	#     yum  install curl  wget  gnutls-utils -y    
	# fi
	if [ -f /etc/redhat-release ];then
			OS='CentOS'
		elif [ ! -z "`cat /etc/issue | grep bian`" ];then
			OS='Debian'
		elif [ ! -z "`cat /etc/issue | grep Ubuntu`" ];then
			OS='Ubuntu'
		else
			echo "Not support OS, Please reinstall OS and retry!"
			exit 1
	fi

	if [[ ${OS} == 'CentOS' ]];then    
		yum  install curl wget gnutls-utils  -y
	else   
		apt-get update
		apt-get install curl wget gnutls-bin  -y    
	fi
}

# 下载并安装trojan-gfw文件
function dl_install_trojan(){
	#local tj=$(which trojan) #如果没有安装才安装
	#if [ "$tj" = "" ];then
		trojan="https://github.com/trojan-gfw/trojan/releases/download/v1.13.0/trojan-1.13.0-linux-amd64.tar.xz"
		file_name="$workpath/trojan.xz"
		# Download trojan tarball
		wget --no-check-certificate -O $file_name  $trojan
		tar -Jxf $file_name -C $workpath
		mv $workpath/trojan/trojan /usr/bin/
	#fi
}

#自动生成服务器和客户端配置文件
#原型：ac_files(cert,key,ip)
function ac_files(){

    #将内存中配置模板文件存入硬盘
	base64 -d <<< ${s_cfg} > config-server.txt
	base64 -d <<< ${c_cfg} > config-client.txt
    #存放客户端配置文件和客户端使用证书   
	local pwd=$(cat /proc/sys/kernel/random/uuid)
	sed -i "s#_pwd_#$pwd#;s#_cert_#$1#;s#_key_#$2#" config-server.txt
	sed -i "s/_ip_/$3/;s/_pwd_/$pwd/" config-client.txt
	
	#自动配置后，放到对应的目录
	mv config-server.txt $trojan_path/../config.json
	mv config-client.txt $trojan_client/client.json
}

# 自动生成服务器证书（IP方式）
function ac_cert_ip(){    

    #将内存中证书模板文件存入硬盘
	base64 -d <<< ${ca} > ca.txt
  base64 -d <<< ${server} > server.txt
	
	ip=$(curl -s  http://api.ipify.org)
	
	sed -i "s/_ip_/$ip/"  ca.txt
	sed -i "s/_ip_/$ip/"  server.txt

	certtool --generate-privkey --outfile ca-key.pem
	certtool --generate-self-signed --load-privkey ca-key.pem --template ca.txt --outfile ca-cert.pem
	certtool --generate-privkey --outfile server-key.pem
	certtool --generate-certificate --load-privkey server-key.pem --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template server.txt --outfile server-cert.pem
	
	mv server-key.pem $trojan_path
	mv server-cert.pem $trojan_path
	mv ca-cert.pem $trojan_client
	local c_path=$trojan_path"server-cert.pem"
	local k_path=$trojan_path"server-key.pem"
	#echo $c_path,$k_path
	
    ac_files $c_path $k_path $ip
}

#手动安装certbot到/opt/certbot下面，支持debian8
function vallina_ins_certbot(){
	#certbot=$certbot_path/"certbot-auto"
	if [ ! -f ${certbot} ];then
		wget -O $certbot https://dl.eff.org/certbot-auto
		chmod a+x $certbot
	fi
	auto_renew_ca #添加自动续期任务
}

#废弃
#debian 8安装分支
# function debian8_ins_certbot(){
# 	apt-get remove certbot #删除原来的certbot
#     vallina_ins_certbot #手动安装
# }

# #debian 9安装分支
# function debian９_ins_certbot(){
# 	apt-get install certbot -t stretch-backports
# }

# #CentOS/RHEL 7系列安装
# function centos7_rhel7_ins_certbot(){
# 	yum -y install yum-utils
#     yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
# 	yum install certbot
# }

# #ubuntu 安装分支 16.04,18.04
# function ubuntu_ins_certbot(){
# 	apt-get update
# 	apt-get install software-properties-common
# 	add-apt-repository universe
# 	add-apt-repository ppa:certbot/certbot
# 	apt-get update
# 	apt-get install certbot
# }

#安装certbot
# function ins_certbot(){
# 	case $OS in
# 		"Ubuntu")
# 			if [[ "$VER"=="16.04" || "$VER"=="18.04" ]]; then
# 				ubuntu_ins_certbot
# 			fi
# 		;;
# 		"Debian GNU/Linux")
# 			if [ "$VER"=="8" ]; then
# 				debian8_ins_certbot
# 			elif [ "$VER"=="9" ]; then
# 				debian9_ins_certbot
# 			fi
# 		;;
# 		"CentOS Linux")
# 			if [ "$VER"=="7" ]; then
# 				centos7_rhel7_ins_certbot
# 			fi
# 		;;
# 		"Red Hat Enterprise Linux Server")
# 			if [ "$VER"=="7.6" ]; then
# 				centos7_rhel7_ins_certbot
# 			fi
# 		;;	
# 	esac
# }

#自动生成服务器证书（域名方式）
#原型：ac_cert_domain(domain,email)
function ac_cert_domain(){
    
	local cert_dir="/etc/letsencrypt/live/"$1

	# if [ -z "$certbot" ]; then
	#   certbot=$(which certbot)
	# fi

    #清除域名原来已经申请的证书,修正重复签发证书错误，撤销证书
	if [ -d ${cert_dir} ]; then
	    # certbot revoke --cert-path $cert_dir/cert.pem
		# certbot delete --cert-name $1
	  	# rm -rf $cert_dir
		# rm -rf /etc/letsencrypt/archive/$1
		# rm /etc/letsencrypt/renewal/$1.conf
		# fixed 真正的逻辑是如果申请过证书则自动续期
		$certbot renew --pre-hook "systemctl stop trojan-gfw" --post-hook "systemctl start trojan-gfw"		 
	else
		$certbot certonly --standalone --agree-tos -n -d $1 -m $2 
	fi	


	#重复签发证书
	#local c1=$(grep 'have an existing certificate' result.txt)
	#if [ -n "$c1" ] ;then
	#	echo "重复签发证书！"
	#fi	
	
	#签发证书证书成功分支
	# grep '\.pem' result.txt > cert_list.txt
	# #搜索证书路径
	# IFS=$'\n' read -d '' -r -a lines < cert_list.txt
	# #将证书放到trojan-gfw中
	# ac_files ${lines[0]} ${lines[1]} $1	
	# local pem_path=${lines[0]%/*}	#提取证书的目录
	local cert=$cert_dir"/cert.pem"
	local key=$cert_dir"/privkey.pem"
	ac_files $cert $key $1
	cp $cert_dir/cert.pem $trojan_client/ca-cert.pem	
	
	#echo $pem_path
	#添加定时任务
	#auto_renew_ca

}

#删除trojan
function delete_trojan(){
	 rm -r /usr/local/bin/trojan
	 rm -r /usr/bin/trojan
	 rm -rf /etc/letsencrypt
	 rm -rf /opt/certbot
	 rm -rf /home/trojan
}

#自动续期CA证书
function auto_renew_ca(){
	#每天早上0和中午12点执行更新这是certbot推荐的方式
	set -f #处理星号的特殊情况
	local crontab_str="0 0,12 * * * $certbot renew --pre-hook \"systemctl stop trojan-gfw\" --post-hook \"systemctl start trojan-gfw\""
	echo $crontab_str | crontab -
	set +f
}
#将trojan-gfw以服务的方式安装
function install_trojan_svc(){
	base64 -d <<< $svc  > /lib/systemd/system/trojan-gfw.service
	#Test for windows mingw64
	#base64 -d <<< $svc  > trojan-gfw.service
	  #ac_cert_ip 	
	systemctl daemon-reload 
	systemctl enable trojan-gfw		
	systemctl start trojan-gfw
}

#安装基础依赖
function installation_base(){
  setup_deps  
  init 
  dl_install_trojan #安装trojan-gfw 
}
#IP自签发安装
function installation_ip(){
  installation_base
  ac_cert_ip
}
#域名签名安装
function installation_domain(){
  installation_base
  vallina_ins_certbot
  ac_cert_domain $1 $2  
}

#主界面
function ui(){
while [ 1 ]
	do
		opt=$(whiptail --title "Trojan GFW 配置向导 v2.0" --menu "请选择证书模式" 15 60 3 \
		"1" "使用IP自签发证书" \
		"2" "使用免费的域名证书（Let's Encrypt）" \
		"3" "删除Trojan" \
		  3>&1 1>&2 2>&3)

		if [ $? = 1 ]; then
			break;
		fi
		
		case $opt in
			1)
				installation_ip 
				whiptail --title "安装成功" --msgbox "请复制【/home/trojan】目录中的证书文件[ca-cert.pem]和\n配置文件[client.json]到Trojan客户端根目录" 10 60
				break
				;;			  
			2)
				domain=$(whiptail --title "Let's Encrypt证书配置" --inputbox "请输入你的域名:" 10 60  3>&1 1>&2 2>&3)		
				email=$(whiptail --title "Let's Encrypt证书配置" --inputbox "请输入你的邮箱（接收过期提醒）:" 10 60  3>&1 1>&2 2>&3)
				
				if [ -z "$email" ] || [ -z "$domain" ];then
					whiptail --title "错误" --msgbox "域名和邮箱都不能为空！" 10 60				    
				fi
				#域名正则
				re1='[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+.?'
				#邮箱正则
				re2='^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$'
				if [[ "$domain" =~ $re1 ]] && [[ "$email" =~ $re2 ]];then
					if (whiptail --title "Let's Encrypt证书配置确认" --yes-button "下一步" --no-button "修改"  --yesno "域名：【$domain】\n邮箱：【$email】" 10 60) then
					    installation_domain $domain $email
						whiptail --title "安装成功" --msgbox "请复制【/home/trojan】目录中的证书文件[ca-cert.pem]和\n配置文件[client.json]到Trojan客户端根目录" 10 60
						clear
            cat /home/trojan/client.json
						break;	
					fi
				else
				   whiptail --title "格式错误" --msgbox "域名或邮箱格式输入有误！" 10 60	
				fi 
				;;
			3)
			  delete_trojan
				break			   
			  ;;	
			*)
			 break ;;
		esac
done
}
ui
install_trojan_svc #注册服务
