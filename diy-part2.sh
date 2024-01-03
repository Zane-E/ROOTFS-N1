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
#
# 回退
# git reset --hard a2a0e5b9f6ce420398487ea29a85b0b0c49c9087

# openssl-1.1.1
rm -rf package/libs/openssl
svn co https://github.com/istoreos/istoreos/trunk/package/libs/openssl package/libs/openssl

# 修改默认IP
sed -i 's/192.168.1.1/192.168.1.110/g' package/base-files/files/bin/config_generate

# poweroff
git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff

#主题
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/kenzo/luci-app-argon-config
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/applications/luci-app-argon-config

rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/kenzo/luci-theme-argon
git clone -b 18.06 https://github.com/SpeedPartner/luci-theme-argon-18.06-patch.git feeds/luci/themes/luci-theme-argon
sed -i '41,59d' feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon

# 修改主题背景
cp -f $GITHUB_WORKSPACE/bg1.jpg feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg


./scripts/feeds update -a
./scripts/feeds install -a
