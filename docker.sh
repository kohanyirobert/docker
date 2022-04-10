# https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
if ! docker --version
then
  curl -fsSL https://get.docker.com | sudo sh
  sudo groupadd docker
  sudo usermod -aG docker $USER
fi
sudo apt-get update
