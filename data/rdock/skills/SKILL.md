---
name: rdock
description: rdock tunnels a remote Docker socket over SSH to allow local Docker CLI commands to execute on a remote host. Use when user asks to connect to a remote Docker engine, run Docker commands on a remote server, or set up an SSH tunnel for the Docker daemon.
homepage: https://github.com/dvddarias/rdocker
metadata:
  docker_image: "quay.io/biocontainers/rdock:2013.1-0"
---

# rdock

## Overview

The rdock (rdocker) skill enables seamless interaction with a remote Docker engine by tunneling the Docker socket over SSH. It automates the process of finding available ports, setting up SSH forwarding, and configuring the local `DOCKER_HOST` environment variable. This allows you to use your local Docker CLI as if it were connected directly to the remote host, providing a secure and configuration-free alternative to exposing the Docker API over the network.

## Installation and Setup

To use this tool, the `rdocker.sh` script must be available on your path.

- **System-wide install**: `curl -L https://github.com/dvddarias/rdocker/raw/master/rdocker.sh > /usr/local/bin/rdocker && chmod +x /usr/local/bin/rdocker`
- **Remote Requirements**: The remote user must have permissions to access `/var/run/docker.sock` (usually by being in the `docker` group). The remote host requires `python`, `bash`, and `ssh`.

## Common CLI Patterns

### Interactive Remote Session
To start a new shell session where all subsequent `docker` commands target the remote host:
```bash
rdocker user@remote-server.com
```
Once inside the session, verify the connection:
```bash
docker info
```
To end the session and close the tunnel, type `exit` or press `Ctrl+D`.

### Direct Command Execution
You can run specific Docker commands on the remote host without entering an interactive shell:
```bash
rdocker user@remote-server.com docker logs container_name -f --tail 10
```

### Specifying a Local Port
If you need to avoid port conflicts or want to keep the tunnel open for use in other terminal windows:
```bash
rdocker user@remote-server.com 9000
```
In a separate terminal, you can then target this daemon using the `-H` flag:
```bash
docker -H localhost:9000 images
```

## Expert Tips and Workflows

### Remote Build, Local Save
A powerful workflow for creating images on high-performance remote servers and retrieving them locally:
1. Connect: `rdocker user@remote-server.com`
2. Build: `docker build -t my-app .`
3. Save to local: `docker save -o my-app.tar my-app` (Note: Since the session maps the daemon, the output file will be on the remote host unless you pipe it).
4. **Better approach for local retrieval**: `rdocker user@remote-server.com "docker save my-app" > my-app.tar`

### Troubleshooting Connection Errors
If you encounter "An error occurred trying to connect," check the following:
- **Permissions**: Run `ssh user@remote-server.com 'groups'` to ensure the user is in the `docker` group.
- **Socket Path**: The tool assumes the socket is at `/var/run/docker.sock`.
- **Dependencies**: Ensure `python` (2 or 3) is installed on the remote machine, as it is used for the forwarding script.

### Handling SSH Keys
Since rdock uses standard SSH, it respects your `~/.ssh/config`. If you use a non-standard key or port, define a host alias in your config file to simplify the rdock command:
```text
Host my-remote
    HostName remote-server.com
    User developer
    IdentityFile ~/.ssh/custom_key
    Port 2222
```
Then simply run: `rdocker my-remote`

## Reference documentation
- [rdocker README](./references/github_com_dvddarias_rdocker_blob_master_README.md)