---
name: pysftp
description: pysftp provides a wrapper for OpenSSH SFTP to manage secure file transfers through jailing, proxying, or custom storage backends. Use when user asks to jail users in a chroot environment, proxy SFTP traffic to a remote server, or implement custom SFTP storage handlers.
homepage: https://github.com/unbit/pysftpserver
metadata:
  docker_image: "quay.io/biocontainers/pysftp:0.2.9--py27_0"
---

# pysftp

## Overview
This tool provides a robust wrapper for OpenSSH SFTP, allowing for fine-grained control over how SFTP requests are handled on a server. It is primarily used to enhance security by jailing users within a virtual chroot environment or to act as a gateway by proxying SFTP traffic to another destination. Because it is written in Python, it is highly extensible, enabling the creation of custom storage backends (such as MongoDB/GridFS) that conform to the SFTP RFC.

## Installation
Install the base package via pip:
```bash
pip install pysftpserver
```
For proxy functionality, include the optional dependency:
```bash
pip install pysftpserver[pysftpproxy]
```

## Core CLI Tools

### pysftpjail
Used to confine a user to a specific directory (chroot) upon login.
- **Basic Usage**: `pysftpjail /path/to/chroot`
- **Logging**: Use `--logfile /path/to/log` to track activity.
- **Permissions**: Use `--umask 0022` to set the default file creation mask.

### pysftpproxy
Used to forward SFTP requests to a remote server.
- **Basic Usage**: `pysftpproxy user:password@hostname`
- **Identity Keys**: Specify a private key with `-k /path/to/private_key`.
- **SSH Config**: Use `-c /path/to/config` to leverage existing SSH configurations.
- **Security**: Fingerprint checking is enabled by default; use `-d` to disable (not recommended for production).

## Server Integration Patterns

### SSH Authorized Keys (Per-User)
To jail a specific user using their public key, prepend the command in the `~/.ssh/authorized_keys` file:
```text
command="pysftpjail /path/to/jail",no-port-forwarding,no-x11-forwarding,no-agent-forwarding ssh-rsa AAAAB3...
```

### System-wide (sshd_config)
To enforce a jail for a specific user or group regardless of login method, use the `ForceCommand` directive in `/etc/ssh/sshd_config`:
```sshconfig
Match User sftptest
    ForceCommand /usr/local/bin/pysftpjail /tmp
```

## Custom Storage Implementation
To create a custom storage backend (e.g., for database-backed SFTP), subclass `SFTPAbstractServerStorage` and implement the required methods:
- `open(self, filename, flags, mode)`: Return a file handle.
- `read(self, handle, off, size)`: Read data from the handle.
- `write(self, handle, off, data)`: Write data to the handle.
- `close(self, handle)`: Close the handle.
- `stat(self, path)`: Return file attributes.

## Expert Tips
- **Python 3 Compatibility**: When implementing custom storages, ensure filenames are decoded (e.g., `filename.decode()`) as they may arrive as bytes.
- **Proxy Authentication**: `pysftpproxy` can gather missing connection details (port, keys) from the local `~/.ssh/config` if the hostname matches.
- **Virtual Environments**: Always install in a virtualenv when developing custom storage classes to avoid system-level dependency conflicts.

## Reference documentation
- [pysftpserver Main Documentation](./references/github_com_unbit_pysftpserver.md)