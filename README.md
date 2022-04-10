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
1. Install the [Docker Compose binary](https://github.com/docker/compose)
    - Needed because the `compose` subcommand of the `docker` binary seems to ignore `COMPOSE_FORCE_WINDOWS_HOST` completely
1. Set [`COMPOSE_FORCE_WINDOWS_HOST`](https://docs.docker.com/compose/reference/envvars/#compose_convert_windows_paths) to `1`
    - **Unfortunately** [there is a bug in how version 2 of `docker-compose` handles this](https://github.com/docker/compose/issues/9132#issuecomment-1094378896), so for now use `.env`, set `PWD` to an absolute path and reference it as `- ${PWD}:/app` in bind mount definitions
1. Clone the repository
1. Run `vagrant up` **with administrator privileges** (due to using [SMB synced folders](https://www.vagrantup.com/docs/synced-folders/smb#prerequisites) for better performance)
    - Run `fsmgmt.msc` or use commands like `Get-SmbShare` to manage SMB shares.
1. [Edit your *hosts* file](https://hostsfileeditor.com/) at `C:\Windows\System32\drivers\etc` and add the following entry

    ```txt
    10.0.100.100    docker.local
    ```

1. Set `DOCKER_HOST` environment variable to `tcp://docker.local`
1. Run `docker info` to verify that the Docker client on the Windows host can communicate with the Docker daemon running inside the guest virtual machine

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
