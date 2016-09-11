sudo apt-get purge -y mongodb-org
sudo apt-get purge -y mongodb*
sudo apt-get autoremove -ys
sudo rm /etc/apt/sources.list.d/mongodb*.list
sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongodb
sudo rm -r /data/db/
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.com/apt/ubuntu xenial/mongodb-enterprise/stable multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-enterprise.list
sudo apt-get update
sudo apt-get install -y mongodb-enterprise
sudo mkdir -p /data/db


user=$(ls -ld /var/lib/mongodb/ | awk '{split($0, a, " "); print a[3] ":" a[4]}')
echo $user
sudo chmod -R 0755 /data/db/
sudo chown -R $user /data/db/


sudo chmod 0755 /etc/mongod.conf
sudo chown $user /etc/mongod.conf

#sudo cp /lib/systemd/system/mongod.service /lib/systemd/system/mongodb.service


sudo systemctl enable mongod.service
sudo systemctl start mongod


echo "Checking Mongo Runs..."

mongo

