compose_version=2.4.1
compose_os=linux
compose_arch=$(arch)
compose_binary=docker-compose-$compose_os-$compose_arch
compose_url=https://github.com/docker/compose/releases/download/v$compose_version/$compose_binary
plugins_dir=$HOME/.docker/cli-plugins
plugin_path=$plugins_dir/docker-compose
mkdir -p $plugins_dir
cd $HOME/.cache
wget \
  --no-verbose \
  --timestamping \
  $compose_url
chmod +x $compose_binary
ln -srf $compose_binary $plugin_path
cd ~
