#!/bin/bash
cd

sudo apt update
sudo apt upgrade -y
sudo apt install -y vim git tmux curl xorg chromium python3-pip

pip3 install pynput gpiozero

git clone https://github.com/Amplus2/collatz-collection.git

sudo adduser --gecos '' kekw-admin

cat > .xinitrc <<EOF
#!/bin/sh

python3 /home/pi/collatz-collection/computer/keyboard_driver.py &

exec chromium https://amplus2.github.io/collatz-collection/ --kiosk \
              --start-fullscreen --fast --noerrdialogs --fast-start \
              --disable-infobars --disable-features=TranslateUI \
              --disable-translate
EOF

cat > .profile <<EOF
#!/bin/sh
exec startx
EOF
