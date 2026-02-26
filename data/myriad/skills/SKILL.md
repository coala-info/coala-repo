---
name: myriad
description: Myriad is a lightweight distributed computing library that provides a drop-in replacement for Python's map functions to scale tasks across a master-worker cluster. Use when user asks to distribute Python processing tasks, scale map operations across multiple machines, or manage simple task queues without the overhead of complex frameworks.
homepage: https://github.com/cjw85/myriad
---


# myriad

## Overview

Myriad is a lightweight distributed computing library designed as a drop-in replacement for Python's built-in `map` and `itertools.imap` functions. It operates on a master-worker model where a central server manages task queues and result collection, while distributed clients perform the actual computation. This tool is particularly useful for bioinformaticians or developers who need to scale simple processing tasks across a cluster without the overhead of complex frameworks like Spark or Dask.

## Installation

Install myriad via Conda/Bioconda:

```bash
conda install bioconda::myriad
```

Ensure myriad is installed on all machines participating in the computation (both server and clients).

## Core Workflow

### 1. Server Configuration (Python)
The server acts as the coordinator. You must define a "worker" function that is pickleable.

```python
from myriad.components import MyriadServer
import subprocess

# Configuration
host = '0.0.0.0' # Listen on all interfaces
port = '12345'
key = 'secure_auth_key'

def worker_function(data):
    # Perform computation
    return data * 2

# Initialize server
server = MyriadServer(worker_function, port, key)

# Push jobs to the queue
for i in range(100):
    server.put(i)
```

### 2. Launching Clients (CLI)
Clients connect to the server to pull work. You can launch these via `subprocess` in your script or manually on remote nodes.

```bash
myriad --client --host <server_ip> --port 12345 --key secure_auth_key
```

### 3. Collecting Results
The server object is iterable and will yield results as they are returned by clients.

```python
for result in server:
    print("Received: {}".format(result))
```

## Expert Tips and Best Practices

- **Pickleability**: The worker function and all data sent to `server.put()` must be pickleable. Avoid using lambda functions or local functions defined inside other functions; use top-level module functions instead.
- **Network Security**: Myriad uses an authentication key (`--key`). Ensure this is a strong string, especially if the server is exposed to a network.
- **Firewall Configuration**: Ensure the specified port (default 12345) is open for TCP traffic on the server machine.
- **Scaling**: To scale, simply launch more instances of the `myriad --client` command across different cores or different machines.
- **Unordered Results**: If the order of results does not matter, use the `imap_unordered` method if available in the specific version to potentially improve throughput.
- **Resource Management**: When launching clients via a cluster scheduler (like SLURM or SGE), wrap the `myriad --client` command in your submission script.

## Reference documentation
- [myriad GitHub Repository](./references/github_com_cjw85_myriad.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_myriad_overview.md)