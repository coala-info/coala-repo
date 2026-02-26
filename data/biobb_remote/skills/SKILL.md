---
name: biobb_remote
description: This tool manages SSH credentials, transfers data bundles, and executes commands on remote computing resources. Use when user asks to manage remote credentials, transfer files via SFTP, or execute bioinformatics tasks on high-performance computing clusters.
homepage: https://github.com/bioexcel/biobb_remote
---


# biobb_remote

## Overview
The `biobb_remote` module acts as a bridge between local environments and remote computing resources. It provides a programmatic way to manage SSH credentials, transfer data bundles, and execute commands on remote hosts. This is particularly useful for offloading computationally intensive bioinformatics tasks from a local machine to a high-performance computing (HPC) cluster or a remote server while maintaining a seamless Python-based workflow.

## Core Components and Usage

### 1. SSH Credential Management
Before executing remote tasks, you must establish secure access. The `SSHCredentials` class automates key generation and installation.

```python
from biobb_remote.ssh_credentials import SSHCredentials

# Initialize credentials
credentials = SSHCredentials(host='remote.server.edu', userid='username', generate_key=True)

# Install the public key on the remote host (requires initial password access)
credentials.install_host_auth()

# Save credentials for future sessions
credentials.save(output_path='my_remote_creds.pk')
```

### 2. Secure File Operations (SFTP)
Use `SSHSession` for direct file manipulation and command execution without the overhead of a full task object.

*   **Upload/Download**: Use `put` to send local files and `get` to retrieve remote results.
*   **Remote Listing**: Use `listdir` to verify file existence on the server.
*   **Direct Creation**: Use `create` to write a string directly to a remote file path.

```python
from biobb_remote.ssh_session import SSHSession

session = SSHSession(credentials_path='my_remote_creds.pk')

# Upload a structure file
session.run_sftp('put', 'input.pdb', 'remote_input.pdb')

# Run a remote command
output = session.run_command('ls -l')
print(output)
```

### 3. Data Bundling for Tasks
When dealing with multiple input files, use the `DataBundle` class to organize them. This ensures all dependencies are tracked and transferred together.

*   **Add Files**: Use `add_file(path)` for individual files.
*   **Add Directories**: Use `add_dir(path)` to include entire folders of parameters or structures.

### 4. Remote Task Execution
The `Task` class (and its implementations) manages the lifecycle of a remote job.

*   **Environment Setup**: Use `prep_remote_workdir(base_path)` to create a unique task directory on the remote host.
*   **Resource Allocation**: Use `prep_auto_settings` to configure MPI, OpenMP, or GPU requirements for the remote scheduler.
*   **Persistence**: Use `task.save('status.json')` to store the state of a running task, allowing you to reconnect and check status later if the local session is interrupted.

## Best Practices
*   **Key Security**: Always use a password to encrypt private keys when calling `credentials.save()` if the environment is shared.
*   **Connection Debugging**: If connections fail, initialize the task with `debug_ssh=True` to see the underlying SSH handshake and error logs.
*   **Cleanup**: Use `remove_host_auth()` when a remote resource is no longer needed to maintain security hygiene.
*   **Relative Paths**: When using `DataBundle`, ensure local paths are relative to the script execution point to maintain portability across different local environments.

## Reference documentation
- [Biobb_remote GitHub README](./references/github_com_bioexcel_biobb_remote.md)
- [Biobb_remote Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_biobb_remote_overview.md)