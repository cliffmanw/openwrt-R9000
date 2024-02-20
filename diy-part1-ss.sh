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
echo "src-git wrtbwmon https://github.com/brvphoenix/luci-app-wrtbwmon.git" >>feeds.conf.default
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
