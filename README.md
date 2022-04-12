# About

An alternative solution to run Linux containers on Windows without Hyper-V.

## Versions

### Host

```pwsh
> docker --version
Docker version 20.10.9, build c2ea9bc
> docker compose version
Docker Compose version v2.3.3
> docker-compose version
Docker Compose version v2.4.1
```

### Guest

```sh
$ dockerd --version
Docker version 20.10.14, build 87a90dc
$ docker --version
Docker version 20.10.14, build a224086
```

## Usage

1. Install the [Docker client binary](https://docs.docker.com/engine/install/binaries/#install-server-and-client-binaries-on-windows)
1. Clone the repository
1. Run `vagrant up` **with administrator privileges** (due to using [SMB synced folders](https://www.vagrantup.com/docs/synced-folders/smb#prerequisites) for better performance)
    - Run `fsmgmt.msc` or use commands like `Get-SmbShare` to manage SMB shares.
1. [Edit your *hosts* file](https://hostsfileeditor.com/) at `C:\Windows\System32\drivers\etc` and add the following entry

    ```txt
    10.0.100.100    docker.local
    ```

1. Set `DOCKER_HOST` environment variable to `tcp://docker.local`
1. Run `docker info` to verify that the Docker client on the Windows host can communicate with the Docker daemon running inside the guest virtual machine
1. For best result SSH into the machine with `ssh docker.local` and work there as if you were on a Linux box

### Bind Mounts

When using bind mounts directly from the host machine (Windows) the Docker host path must be specified as a quasi-unix path, e.g. `C:\Users\username\Downloads` must be specified as `/c/Users/username/Downloads` (due to the preconfigured SMB synced folders). To avoid this, simply SSH into the machine and work as if you were on Linux - this saves a lot of trouble.

Docker Compose (the standalone binary and not the `docker` binary *subcommand*) seems to obey [`COMPOSE_FORCE_WINDOWS_HOST`](https://docs.docker.com/compose/reference/envvars/#compose_convert_windows_paths) environment variable to some extent, but it still [fails to convert relative paths like `.` or `./`](https://github.com/docker/compose/issues/9132#issuecomment-1094378896) to be in quasi-unix format.

For now, specify absolute paths instead of `.` when using `docker run` and with `docker compose` [use `.env`](https://docs.docker.com/compose/environment-variables/#the-env-file) and set `PWD` to an absolute path and reference it in bind mount definitions, e.g. `${PWD}:/app`.

### Extra

To allow connecting to the virtual machine from any location configure `~/.ssh/config` and add a similar entry as below

```txt
Host docker.local
    User vagrant
    IdentityFile ~/<your/repo/path>/.vagrant/machines/default/virtualbox/private_key
    StrictHostKeyChecking no
```

Setting `DOCKER_HOST` to `ssh://docker.local` at this point would also allow connections to the Docker daemon, however TCP is faster, albeit insecure.

**Note**: make sure to replace `<your/repo/path>` with your own repository's absolute path.

## Motivation

- To use Docker Desktop for Windows Hyper-V must be enabled
- Running other virtual machines in Oracle VirtualBox (while possible) suffer severe performance degradation
- There is an alternative solution called *Docker Toolbox* but it's deprecated
- Enabling Hyper-V is already a minor performance hit to running simply just the main Windows operating system
