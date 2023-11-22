# Install samba
sudo apt-get install samba
sudo cp smb.conf /etc/samba/smb.conf
echo "Enter pi password"
sudo smbpasswd -a pi
sudo systemctl restart smbd