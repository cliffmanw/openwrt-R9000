#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# for R9000 drivers and system
echo "src-git alpinefancontrol https://github.com/hurrian/openwrt-alpine-fan-control.git" >> feeds.conf.default

# >>> add the 10G SFP Port (eth0) to the LAN; enable the LED of the 10G SFP Port <<<
echo "uci set network.@device[0].ports='eth0'; uci add_list network.@device[0].ports='eth1.1'; uci commit network;" > target/linux/alpine/base-files/etc/uci-defaults/99-sfp-port
echo "uci -q delete system.@led[0]; uci add system led; uci set system.@led[0].name='SFP'; uci set system.@led[0].sysfs='white:sfp'; uci set system.@led[0].trigger='netdev'; uci set system.@led[0].dev='eth0'; uci set system.@led[0].mode='link'; uci add_list system.@led[0].mode='tx'; uci add_list system.@led[0].mode='rx'; uci commit system;" >> target/linux/alpine/base-files/etc/uci-defaults/99-sfp-port

# >>> add Network Interfaces Ports Status <<<
echo "uci set wireless.default_radio0.ifname='60GHz-radio0'; uci set wireless.default_radio1.ifname='5GHz-radio1'; uci set wireless.default_radio2.ifname='2.4GHz-radio2'; uci commit wireless;" > target/linux/alpine/base-files/etc/uci-defaults/98-netports
printf "printf \"config global 'global'\\\n\\\toption default_additional_info '1'\\\n\\\toption default_h_mode '1'\\\n\\\toption hv_mode_switch_button '1'\\\n\\\n\" > /etc/config/luci_netports\n" >> target/linux/alpine/base-files/etc/uci-defaults/98-netports
printf "printf \"config port\\\n\\\toption ifname 'eth2.2'\\\n\\\toption name 'WAN'\\\n\\\toption type 'copper'\\\n\\\nconfig port\\\n\\\toption ifname 'eth0'\\\n\\\toption name 'SFP+'\\\n\\\toption type 'sfp'\\\n\\\nconfig port\\\n\\\toption ifname 'eth1.1'\\\n\\\toption name 'LAN 1-6'\\\n\\\toption type 'copper'\\\n\\\n\" >> /etc/config/luci_netports\n" >> target/linux/alpine/base-files/etc/uci-defaults/98-netports
printf "printf \"config port\\\n\\\toption ifname '60GHz-radio0'\\\n\\\toption name 'WLAN 60GHz'\\\n\\\toption type 'wifi'\\\n\\\nconfig port\\\n\\\toption ifname '5GHz-radio1'\\\n\\\toption name 'WLAN 5GHz'\\\n\\\toption type 'wifi'\\\n\\\nconfig port\\\n\\\toption ifname '2.4GHz-radio2'\\\n\\\toption name 'WLAN 2.4GHz'\\\n\\\toption type 'wifi'\\\n\\\n\" >> /etc/config/luci_netports\n" >> target/linux/alpine/base-files/etc/uci-defaults/98-netports

# >>> remove wrong wifi entry in xx_customizations <<<
echo exit 0 > target/linux/alpine/base-files/etc/uci-defaults/xx_customizations

# R9000 requires ends.

# clear up first, moved to yml
# rm -rf ./feeds
# Uncomment a feed source
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# try anthor passwall feed, lack of depandence, cliffman
echo "src-git openclash https://github.com/vernesong/OpenClash.git" >>feeds.conf.default
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git" >>feeds.conf.default
echo "src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git" >>feeds.conf.default
echo "src-git pwpkgs https://github.com/xiaorouji/openwrt-passwall-packages.git" >>feeds.conf.default
# more feeds, compiled ipk only, cliffman
echo "src-git adguardhome https://github.com/rufengsuixing/luci-app-adguardhome.git" >>feeds.conf.default
#echo "src-git wrtbwmon https://github.com/brvphoenix/luci-app-wrtbwmon.git" >>feeds.conf.default
# For passwall
# echo "src-git passwall https://github.com/Boos4721/OpenWrt-Packages.git" >>feeds.conf.default
# For openclash
echo "src-git kenzok8 https://github.com/kenzok8/openwrt-packages.git" >>feeds.conf.default

# not compily with R7800, fail at compile, cliffman
# echo "src-git kenwall https://github.com/kenzok8/wall.git" >>feeds.conf.default
# echo "src-git kensmall https://github.com/kenzok8/small.git" >>feeds.conf.default
# echo "src-git smpackage https://github.com/kenzok8/small-package" >> feeds.conf.default

# cliffman UI DIY
#echo "src-git cliffui https://github.com/cliffmanw/openwrt_diy.git" >>feeds.conf.default
# echo "src-git natelol https://github.com/natelol/natelol.git" >> feeds.conf.default
