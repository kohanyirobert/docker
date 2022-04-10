# About

An alternative solution to run Linux containers on Windows without Hyper-V.

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
