# https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
if ! docker --version
then
  curl -fsSL https://get.docker.com | sudo sh
  sudo groupadd docker
  sudo usermod -aG docker $USER
  # https://unix.stackexchange.com/q/398540/45810
  sudo mkdir -p /etc/systemd/system/docker.service.d
  cat << EOF | sudo tee /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375 --containerd=/run/containerd/containerd.sock
EOF
  sudo systemctl daemon-reload
  sudo systemctl restart docker
fi
sudo apt-get update
