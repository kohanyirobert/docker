compose_version=2.4.1
compose_os=linux
compose_arch=$(arch)
compose_binary=docker-compose-$compose_os-$compose_arch
plugins_dir=$HOME/.docker/cli-plugins
plugin_path=$plugins_dir/docker-compose
mkdir -p $plugins_dir
cd $plugins_dir
wget \
  --timestamping \
  https://github.com/docker/compose/releases/download/v$compose_version/$compose_binary
chmod +x $compose_binary
ln -sf $compose_binary docker-compose
cd ~
