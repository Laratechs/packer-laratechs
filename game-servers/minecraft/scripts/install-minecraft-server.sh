sudo apt-get install unzip openjdk-17-jre -y

wget https://api.papermc.io/v2/projects/paper/versions/1.20.2/builds/259/downloads/paper-1.20.2-259.jar -O /tmp/server.jar

sudo mv /tmp/server.jar /etc/minecraft/

echo "eula=true" > /tmp/eula.txt

sudo mv /tmp/eula.txt /etc/minecraft/

sudo systemctl daemon-reload
sudo systemctl enable minecraft
