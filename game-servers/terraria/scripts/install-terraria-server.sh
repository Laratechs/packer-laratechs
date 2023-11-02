sudo apt-get install unzip

wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-1449.zip -O /tmp/terraria-server.zip 

unzip /tmp/terraria-server.zip -d /tmp/terraria-server

sudo mkdir -p /etc/terraria

sudo mv /tmp/terraria-server/1449/Linux/* /etc/terraria

sudo chmod u+x /etc/terraria/TerrariaServer.bin.x86_64

sudo touch /etc/terraria/banlist.txt

sudo systemctl daemon-reload
sudo systemctl enable terraria
