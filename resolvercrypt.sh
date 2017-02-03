#!/bin/bash

#Script hecho por TitanHero /\ Script made by Titanhero.

#    _  __                        _                    
#   / |/ /__ _  _____ ____  ___ _(_)  _____   __ _____ 
#  /    / -_) |/ / -_) __/ / _ `/ / |/ / -_) / // / _ \
# /_/|_/\__/|___/\__/_/    \_, /_/|___/\__/  \_,_/ .__/
#                         /___/                 /_/ 



zenity --title="Dns resolvercrypt" --info --text "Script made by Titanhero if it like you visit my github:

https://github.com/TitanHero

With this script you can handle your dns config, so like the config of dnsmasq and dnscrypt-proxy

Testing dependencies"


#primero probamos si esta instalado dnsmasq y dnscrypt
dn="dnsmasq"
cry="dnscrypt-proxy"
homere=$(echo $HOME)

$dn -v

if ! test $? = 0 ; then
	zenity --error --text "$dn it\'s not installed you can install it with the comand:
sudo apt install dnsmasq"
	exit
fi

$cry -V 

if ! test $? -eq 0; then
	zenity --error --text "$cry it\'s not installed you can install it with the comand: 

sudo apt install $cry"

	exit
fi

#Creamos backup de dnsmasq
if ! test -f ~/dnsmasq_backup/dnsmasq.conf; then
	zenity --error --title="Dns resolvercrypt" --width=350 --height=167  --text="There is not backup file of config dnsmasq

	The file will be make on the path:


	$homere/dnsmasq_backup/
	"
	mkdir  ~/dnsmasq_backup; cp /etc/dnsmasq.conf ~/dnsmasq_backup/dnsmasq.conf
	[ -f ~/dnsmasq_backup/dnsmasq.conf ] && zenity --info --width=300 --height=150 --title="Dns resolvercrypt" --text="Configuration file created in:

$homere/dnsmasq_backup/dnsmasq.conf
	"
fi

#metemos las variables de las opcienes a elegir

de="Disable dnsmasq and dnscrypt, leave resolv.conf with the default dns of your isp"
vrutre="Check the path of your backup of the dnsmasq.conf file"
ca="Change the default dns of your isp in resolv.conf by custom"
masq="Use only dnsmasq"
conf="Modify configuration dnscrypt dns servers"
cryptmasq="Use dnsmasq and dnscrypt"
rest="Restore dnsmasq default configuration file"
ver="Check your dns configuration"

#Botamos la ventana de seleccion de opciones
selec=$(zenity  --title="Dns resolvercrypt"  --width=650 --height=270  --list --column "Script made by TitaHero visita mi github :
https://github.com/TitanHero" "$de" "$ca" "$masq" "$conf" "$cryptmasq" "$rest" "$ver" "$vrutre")


case $selec in
	"$de" ) dnsconfco=$(grep dns /etc/NetworkManager/NetworkManager.conf); [ $dnsconfco = '#dns=dnsmasq'  ] && sudo sed 's/#dns=dnsmasq/dns=dnsmasq/' /etc/NetworkManager/NetworkManager.conf; sudo service dnsmasq stop; sudo systemctl stop dnscrypt-proxy.socket; sudo systemctl stop dnscrypt-proxy.service; sudo service network-manager restart; zenity --width=200 --height=130 --info --title="Dns resolvercrypt" --text="Default dns configuration completed"; zenity --text-info --width=350 --height=250 --title="This is your file resolv.conf" --filename=/etc/resolv.conf

		 ;;
	
	"$ca" ) 
			dnss=$(zenity --forms --width=285 --height=200 --title="Cambiar los dns por defecto" --text="Inserta las nuevas direcciones ip de los servers Dns" --add-entry="First address Dns" --add-entry="Second address Dns"); [ $dnss != "|"  ] && nu=$(grep -m 1 -n name /etc/resolv.conf|gawk '{print $1}' FS=":"); sed -i ''${nu}',$d' /etc/resolv.conf && dnsuno=$(echo $dnss|gawk '{print $1}'  FS='|') && dnsdos=$(echo $dnss|gawk '{print $2}'  FS='|'); [ $dnsuno != "" ] && echo "nameserver $dnsuno" >> /etc/resolv.conf; [ $dnsdos != "" ] && echo "nameserver $dnsdos" >> /etc/resolv.conf; zenity --text-info --width=350 --height=250 --title="This is your file resolv.conf" --filename=/etc/resolv.conf
		 ;; 
	
	"$masq" ) dnsconfco=$(grep dns /etc/NetworkManager/NetworkManager.conf); [ $dnsconfco = '#dns=dnsmasq'  ] && sudo sed 's/#dns=dnsmasq/dns=dnsmasq/' /etc/NetworkManager/NetworkManager.conf; sudo systemctl stop dnscrypt-proxy.socket; sudo systemctl stop dnscrypt-proxy.service; sudo service dnsmasq restart; diguno=$(dig www.google.com|grep Que|tr -d ";"); digdos=$(dig www.google.com|grep Que|tr -d ";"); zenity --info --width=285 --height=200 --title="Dns resolvercrypt" --text="Calculating query time to check if routing is correct:
$diguno
$digdos";valor=$(echo $digdos|gawk '{print $3}'); [ $valor -eq 0 ] && zenity --info --text="Done correct dnsmasq configuration.

Visit my github account for updates, scripts and programs:

https://github.com/TitanHero"; [ $valor -ne 0 ] && zenity --error --text="Could not set up well dnsmasq.

Visit my github account for updates, scripts and programs:

https://github.com/TitanHero" 
		 ;;
	
	"$conf" ) configlobaldnscrypt=$(zenity --forms --width=285 --height=200 --title="Dns resolvercrypt" --text="Insert the dns proxy server ip to which dnscrypt-proxy is will connected as well as the provider name and server key,
if you do not have this information on this page you can consult it:
   																			
https://github.com/jedisct1/dnscrypt-proxy/blob/master/dnscrypt-resolvers.csv

Remember that without this information it is not possible to use dnscrypt-proxy.
" --add-entry="Server ip" --add-entry="Provider name" --add-entry=Server key ); ipservidor=$(echo $configlobaldnscrypt|gawk '{print $1}'  FS='|'); provname=$(echo $configlobaldnscrypt|gawk '{print $2}'  FS='|'); keyserv=$(echo $configlobaldnscrypt|gawk '{print $3}'  FS='|'); sudo $cry -r $ipservidor -R $provname -k $keyserv -a $serverdnscrypt:$dnscryptport -d; [ $? -eq 0 ] && zenity --width=200 --height=100 --info --title='Dns resolvercrypt' --text='Configuracion correcta

Visit my github account for updates, scripts and programs:

https://github.com/TitanHero"'; [ $? -ne 0  ] && zenity --width=240 --height=100 --error --title='Dns resolvercrypt' --text='Incorrect configuration, check if inserted data is correct.

Visit my github account for updates, scripts and programs:

https://github.com/TitanHero'
		 ;;
	
	"$cryptmasq" ) selcryptmasq=$(zenity --list --title="Dns resolvercrypt" --width=200 --height=70 --text="¿What configuration for the listening port and ip address of the dnscrypt-proxy server do you want to use
(The requests that dnsmasq does to dnscrypt-proxy are autoconfigured to point to the ip and port of
Dnscrypt-proxy)?" --column "Select an option" "Use script configuration" "Use custom configuration")
					case $selcryptmasq in 
						"Use script auto-configuration")	      dnscryptport=40
																			serverdnscrypt=127.0.0.1
																			ladd_dnsmasq=127.0.0.1 
																			#ahora borramos el archivo de configuracion y hacemos uno nuevo en blanco y le pasamos los parametros
   																			sudo echo  > /etc/dnsmasq.conf;echo  no-resolv >> /etc/dnsmasq.conf; echo "server=$serverdnscrypt#$dnscryptport" >> /etc/dnsmasq.conf; echo "listen-address=$ladd_dnsmasq" >> /etc/dnsmasq.conf
   																			sudo service $dn restart
   																			configlobaldnscrypt=$(zenity --forms --width=285 --height=200 --title="Dns resolvercrypt" --text="Insert the dns proxy server ip to which dnscrypt-proxy will connect as well as the provider name and server key,
If you do not have this information on this page you can consult it:
   																			
https://github.com/jedisct1/dnscrypt-proxy/blob/master/dnscrypt-resolvers.csv

Remember that without this information it is not possible to use dnscrypt-proxy.
" --add-entry="Server ip" --add-entry="Provider name" --add-entry=key server ); ipservidor=$(echo $configlobaldnscrypt|gawk '{print $1}'  FS='|'); provname=$(echo $configlobaldnscrypt|gawk '{print $2}'  FS='|'); keyserv=$(echo $configlobaldnscrypt|gawk '{print $3}'  FS='|'); sudo $cry -r $ipservidor -R $provname -k $keyserv -a 127.0.0.1:40 -d
																				diguno=$(dig www.google.com|grep Que|tr -d ";") 
digdos=$(dig www.google.com|grep Que|tr -d ";")
zenity --info --width=285 --height=200 --title="Dns resolvercrypt" --text="Calculating query time to check if routing is correct:
$diguno
$digdos"
valor=$(echo $digdos|gawk '{print $3}'); [ $valor -eq 0 ] && zenity --info --text="Correct configuration of dnsmasq and dnscrypt-proxy.

Visit my github account for updates, scripts and programs:

https://github.com/TitanHero"; [ $valor -ne 0 ] && zenity --error --text="Could not properly configure dnsmasq with dnscrypt.

Visit my github account for updates, scripts and programs:

https://github.com/TitanHero"
												;;

						 "Use custom configuration") confdnsmasqper=$(zenity --forms --width=285 --height=200 --title="Dns resolvercrypt" --text="Inserta los parametros de configuracion" --add-entry="Puerto escucha de dnscrypt-proxy" --add-entry="Ip escucha del servidor dnscrypt-proxy" --add-entry="Ip del servidor dnsmasq"); dnscryptport=$(echo $confdnsmasqper|gawk '{print $1}'  FS='|'); serverdnscrypt=$(echo $confdnsmasqper|gawk '{print $2}'  FS='|'); ladd_dnsmasq=$(echo $confdnsmasqper|gawk '{print $3}'  FS='|');echo  > /etc/dnsmasq.conf;echo  no-resolv >> /etc/dnsmasq.conf; echo "server=$serverdnscrypt#$dnscryptport" >> /etc/dnsmasq.conf; echo "listen-address=$ladd_dnsmasq" >> /etc/dnsmasq.conf;
																sudo service $dn restart
																configlobaldnscrypt=$(zenity --forms --width=285 --height=200 --title="Dns resolvercrypt" --text="Insert the dns proxy server ip to which dnscrypt-proxy will connect as well as the provider name and server key,
If you do not have this information on this page you can consult it:
   																			
https://github.com/jedisct1/dnscrypt-proxy/blob/master/dnscrypt-resolvers.csv

Remember that without this information it is not possible to use dnscrypt-proxy.
" --add-entry="Server ip" --add-entry="Provider name" --add-entry=Server key ); ipservidor=$(echo $configlobaldnscrypt|gawk '{print $1}'  FS='|'); provname=$(echo $configlobaldnscrypt|gawk '{print $2}'  FS='|'); keyserv=$(echo $configlobaldnscrypt|gawk '{print $3}'  FS='|'); sudo $cry -r $ipservidor -R $provname -k $keyserv -a $serverdnscrypt:$dnscryptport -d
																	diguno=$(dig www.google.com|grep Que|tr -d ";") 
digdos=$(dig www.google.com|grep Que|tr -d ";")
zenity --info --width=285 --height=200 --title="Dns resolvercrypt" --text="Calculating query time to check if routing is correct:
$diguno
$digdos"
valor=$(echo $digdos|gawk '{print $3}'); [ $valor -eq 0 ] && zenity --info --title="Dns resolvercrypt" --text="Correct configuration of dnsmasq and dnscrypt-proxy.

Visit my github account for updates, scripts and programs:

https://github.com/TitanHero"; [ $valor -ne 0 ] && zenity --error --title="Dns resolvercrypt" --text="Could not properly configure dnsmasq with dnscrypt.

Visit my github account for updates, scripts and programs:

https://github.com/TitanHero"		
										;;
					esac
 				;;
	
	"$rest" ) echo ~/dnsmasq_backup/dnsmasq.conf > /etc/dnsmasq.conf; [ $? -eq 0 ] && zenity --text-info --width=500 --height=400 --title="Archivo de configuracion dnsmasq.conf restaurado" --filename=/etc/dnsmasq.conf; [ $? -ne 0 ] && zenity  --error
		 ;;
	
	"$ver" )  zenity --text-info --width=350 --height=250 --title="Dns resolvercrypt" --filename=/etc/resolv.conf
		 ;;
  "$vrutre") zenity --info --width=330 --height=120 --title="Dns resolvercrypt" --text="Your backup configuration file is in:

$homere/dnsmasq_backup/
"; zenity --text-info --width=500 --height=400 --title="Backup configuration file dnsmasq.conf" --filename=$homere/dnsmasq_backup/dnsmasq.conf
		 ;;
esac



