# Dns-resolvercrypt-english
Shell script programmed with gui (graphical user interface) to configure, modify, revise and route dnsmasq, dnscrypt-proxy and resolv.conf.


Shell script programmed with gui (graphical user interface) to configure, modify, revise and route dnsmasq, dnscrypt-proxy and resolv.conf, this script auto configures the routing of the dnsmasq server to the dnscrypt-proxy server, so that they are encrypted and proxyfiquen Dns queries, in order to keep our browsing privacy safe, avoiding dns poisonings and / or spying or tracking, as well as increasing our browsing speed and / or saving data, by keeping previous dns queries in cache, avoiding doing New consultations, besides having other utilities and functions.

This script depends on:

Zenity (zenity is default in ubuntu and deribados)

Dnsmasq

Dnscrypt-proxy

To install it them we copy this command in terminal (console of commands) and we execute it:

Sudo apt update && sudo apt upgrade -y && sudo apt install zenity dnsmasq dnscrypt-proxy

This script takes super user permissions or use the root account, since it modifies and / or configures system files, activates and deactivates services, without super user permissions some functions of this script may not work correctly.

Using this program is very easy, in command console we execute on the route where the script is located:

./resolvercrypt.sh

In order to work encryption and proxy of dns queries it is necessary to have some data of the proxy server to which we are going to connect to validate it, these data are the ip of the proxy server dns to which dnscrypt-proxy is going to connect as well as the name of the provider and the key of the proxy server dns, here you can choose the one that you like more on https://github.com/jedisct1/dnscrypt-proxy/blob/master/dnscrypt-resolvers.csv, by recommendation before choosing a server is make ping queries to the server to verify the latency of response, this way we can choose the server that has less response time and consequently have faster dns queries.
