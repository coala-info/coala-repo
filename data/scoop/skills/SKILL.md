---
name: scoop
description: SCOOP is a distributed task module for executing concurrent parallel Python programs across local workstations and high-performance computing clusters. Use when user asks to parallelize Python code, distribute computations across multiple nodes using a hostfile, or manage hierarchical task execution using the futures API.
homepage: https://github.com/soravux/scoop
---


# scoop

## Overview
SCOOP is a distributed task module designed to make concurrent parallel programming in Python simple and scalable. It allows you to transition from serial code to parallel execution on various environments—ranging from local multi-core workstations to heterogeneous grids and supercomputers—with minimal modifications. It is particularly effective for tasks involving evolutionary algorithms, Monte Carlo simulations, and heavy data processing where subtasks may need to spawn their own tasks.

## Core Usage Patterns

### Launching SCOOPed Programs
Unlike standard Python scripts, SCOOP programs must be launched using the module's launcher to initialize the distributed environment.

- **Local Execution**: Use all available local cores.
  ```bash
  python -m scoop your_script.py
  ```

- **Specific Core Count**: Limit the number of local workers.
  ```bash
  python -m scoop -n 4 your_script.py
  ```

- **Distributed Execution**: Run across multiple nodes defined in a hostfile.
  ```bash
  python -m scoop --hostfile mapfile.txt your_script.py
  ```

### Basic API Implementation
SCOOP follows the PEP-3148 (futures) API, making it a drop-in replacement for many multiprocessing workflows.

```python
from scoop import futures

def work_unit(value):
    return value * 2

if __name__ == "__main__":
    # Parallel map
    results = list(futures.map(work_unit, range(100)))
    
    # Single task submission
    future = futures.submit(work_unit, 10)
    print(future.result())
```

## Expert Tips and Best Practices

- **The Main Guard**: Always wrap your entry point in `if __name__ == "__main__":`. Failing to do so will cause worker nodes to recursively spawn processes, leading to a crash or system hang.
- **Granularity**: Ensure that the computational work in a single task is significant enough to outweigh the overhead of network communication and serialization (pickling).
- **Hostfile Format**: When running on a cluster, your hostfile should list hostnames or IP addresses, one per line. You can specify multiple workers per host by repeating the name or using the `hostname 4` syntax (depending on the environment manager).
- **SSH Configuration**: For distributed runs, ensure passwordless SSH is configured between the launcher node and all worker nodes. You can specify a custom SSH executable using `--ssh-executable`.
- **Handling Subtasks**: SCOOP's unique advantage is the ability to call `futures.map` or `futures.submit` from within a function that is already being executed by a worker. This is ideal for recursive algorithms or hierarchical simulations.

## Common CLI Options
- `-n, --ncpus`: Number of worker processes to spawn.
- `--hostfile`: Path to the file containing the list of remote hosts.
- `--ssh-executable`: Path to a specific SSH binary or wrapper.
- `--tunnel`: Use SSH tunneling to connect to workers (useful for bypassing firewalls).

## Reference documentation
- [SCOOP GitHub Repository](./references/github_com_soravux_scoop.md)
- [Bioconda Scoop Overview](./references/anaconda_org_channels_bioconda_packages_scoop_overview.md)