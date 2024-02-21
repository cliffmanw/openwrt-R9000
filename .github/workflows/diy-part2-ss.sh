#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)

git clone --depth 1 --branch master --single-branch --no-tags --recurse-submodules https://github.com/fantastic-packages/packages package/fantastic-packages

# for R9000 drivers and system
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

# partly success after run this. stopped at toolchain compile before. cliffman
# make menuconfig
# R9000 requires ends.


# Tested working Modifys of Settings like default IP etc. cliffman moded
# sed -i 's/192.168.1.1/192.168.1.10/g' package/base-files/files/bin/config_generate
#sed -i "s/hostname='.*'/hostname='OP'/g" package/base-files/files/bin/config_generate
#sed -i 's/luci-theme-bootstrap/luci-theme-argone/g' feeds/luci/collections/luci/Makefile
#sed -i "s/%D %V, %C/OpenWrt %C $(date +'%y.%m.%d') Compiled by Cliff/g" package/base-files/files/etc/banner

# set wireless.radio off as default, tested OK
#sed -i 's#/set wireless.radio${devidx}.disabled/d#s/set wireless.radio${devidx}.disabled=0/set wireless.radio${devidx}.disabled=1/g#g' package/lean/default-settings/files/zzz-default-settings
#sed -i '/etc\/config\/wireless/d' package/lean/default-settings/files/zzz-default-settings
#sed -i 's/wireless.radio${devidx}.disabled=0/wireless.radio${devidx}.disabled=1/g'  package/kernel/mac80211/files/lib/wifi/mac80211.sh

#修正连接数（by ベ七秒鱼ベ）
#sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# themes添加（svn co 命令意思：指定版本如https://github）cliffman moded
# git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
# git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
# git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages

#添加额外软件包
# Checked, author feed with depandance incomplete, by cliffman
# no space for all, setup in feeds
# git clone https://github.com/vernesong/OpenClash.git package/luci-app-openclash
# git clone https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
# git clone https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2
# git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus

# To be verify ***** check befor use!
# git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
# git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
# git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
# git clone https://github.com/kiddin9/luci-app-dnsfilter.git package/luci-app-dnsfilter
# git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
# git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
# git clone https://github.com/zzsj0928/luci-app-pushbot.git package/luci-app-pushbot
# git clone https://github.com/riverscn/openwrt-iptvhelper.git package/openwrt-iptvhelper
#添加smartdns
# git clone https://github.com/pymumu/openwrt-smartdns package/smartdns
# git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns
#sirpdboy, cliffman moded not needed, as kenzok8 provideed
# git clone https://github.com/sirpdboy/sirpdboy-package.git package/sirpdboy-package
# git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
# git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
# git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
# git clone https://github.com/sirpdboy/luci-app-netdata.git package/luci-app-netdata
# git clone https://github.com/sirpdboy/luci-app-poweroffdevice.git package/luci-app-poweroffdevice
# git clone https://github.com/sirpdboy/luci-app-autotimeset.git package/luci-app-autotimeset
