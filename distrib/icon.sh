mkdir vwd.iconset
sips -z 16 16     icon/vwd_icn.png --out vwd.iconset/icon_16x16.png
sips -z 32 32     icon/vwd_icn.png --out vwd.iconset/icon_16x16@2x.png
sips -z 32 32     icon/vwd_icn.png --out vwd.iconset/icon_32x32.png
sips -z 64 64     icon/vwd_icn.png --out vwd.iconset/icon_32x32@2x.png
sips -z 128 128   icon/vwd_icn.png --out vwd.iconset/icon_128x128.png
sips -z 256 256   icon/vwd_icn.png --out vwd.iconset/icon_128x128@2x.png
sips -z 256 256   icon/vwd_icn.png --out vwd.iconset/icon_256x256.png
sips -z 512 512   icon/vwd_icn.png --out vwd.iconset/icon_256x256@2x.png
sips -z 512 512   icon/vwd_icn.png --out vwd.iconset/icon_512x512.png
cp icon/vwd_icn.png vwd.iconset/icon_512x512@2x.png
iconutil -c icns vwd.iconset
rm -R vwd.iconset