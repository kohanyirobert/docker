# Installs the Docker engine and configures it to be accessible via TCP without TLS.
# Also configures that a registry at http://docker.local could be accessed without TLS too.
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
# https://docs.docker.com/registry/insecure/#deploy-a-plain-http-registry
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
ExecStart=/usr/bin/dockerd \
  --containerd=/run/containerd/containerd.sock \
  --host=fd:// \
  --host=tcp://0.0.0.0:2375 \
  --insecure-registry=docker.local
EOF
  sudo systemctl daemon-reload
  sudo systemctl restart docker
fi
sudo apt-get update
