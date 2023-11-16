if [[ $(dpkg-query -W -f='${Status}' tailscale 2>/dev/null | grep -c "ok installed") -eq 0 ]]; then
    sudo apt-get install apt-transport-https --assume-yes
    curl -fsSL https://pkgs.tailscale.com/stable/raspbian/bullseye.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg > /dev/null
    curl -fsSL https://pkgs.tailscale.com/stable/raspbian/bullseye.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
    sudo apt-get update --assume-yes
    sudo apt-get install tailscale --assume-yes
    sudo tailscale up
fi