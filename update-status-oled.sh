#../ssd1306_linux/ssd1306_bin -n1 -I 128x64

SEASTREAM_STATE=`systemctl show seastream-out -P ActiveState`

WIFI_NAME=`iwgetid -r`

../ssd1306_linux/ssd1306_bin -n1 -r 180 -c -m "\nseastream: $SEASTREAM_STATE\nwifi: $WIFI_NAME"
