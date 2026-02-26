---
name: ipython-cluster-helper
description: ipython-cluster-helper automates the setup and management of IPython Parallel clusters for distributed task execution on batch schedulers. Use when user asks to run Python functions in parallel, distribute tasks across a compute cluster, or manage temporary IPython profiles for SLURM, LSF, or SGE.
homepage: https://github.com/roryk/ipython-cluster-helper
---


# ipython-cluster-helper

## Overview

The `ipython-cluster-helper` library provides a simplified interface for running parallel Python tasks on distributed infrastructure. It automates the complex "plumbing" of IPython Parallel by creating temporary profiles, launching engines on cluster nodes via a batch scheduler, and ensuring all processes are cleaned up after the task completes. This tool is particularly useful for bioinformatics and data science workflows where long-running functions need to be mapped over large datasets across multiple compute nodes.

## Installation

Install the package via the bioconda channel:

```bash
conda install bioconda::ipython-cluster-helper
```

## Core Usage Pattern

The primary way to use this tool is through the `cluster_view` context manager. This ensures that the IPython cluster is shut down and the temporary profile is deleted automatically.

```python
from cluster_helper.cluster import cluster_view

# Define your heavy computation
def analyze_sample(sample_name):
    # ... perform work ...
    return result

if __name__ == "__main__":
    samples = ["sample1", "sample2", "sample3"]
    
    # Initialize the cluster
    with cluster_view(scheduler="slurm", queue="standard", num_jobs=3) as view:
        # Use view.map to distribute the function across the jobs
        results = view.map(analyze_sample, samples)
```

## Supported Schedulers

When calling `cluster_view`, use the following strings for the `scheduler` parameter:

- **SLURM**: `"slurm"`
- **LSF**: `"lsf"`
- **Sun Grid Engine**: `"sge"`
- **Torque**: `"torque"`
- **PBSPro**: `"pbspro"`

## Expert Tips and Best Practices

### Local Testing
Before submitting jobs to a production queue, test your logic locally using the `run_local` parameter. This simulates the parallel environment on your current machine.

```python
with cluster_view(scheduler=None, queue=None, num_jobs=2, extra_params={"run_local": True}) as view:
    view.map(my_function, my_data)
```

### Handling Environment Variables
If your workers require specific environment variables (like `PYTHONPATH`), be aware that some schedulers or Python configurations (using `-E`) might strip them. Ensure your environment is correctly inherited or explicitly set within the function being mapped.

### Resource Optimization
- **num_jobs**: This defines how many worker engines to start. Match this to the number of independent tasks or chunks in your data.
- **extra_params**: Use this dictionary to pass scheduler-specific flags, such as memory requirements or account strings (e.g., `{"resources": "mem=4g"}`).

### Troubleshooting
- **Profile Persistence**: If a script crashes hard, check for orphaned IPython profiles in your `IPYTHONDIR` (usually `~/.ipython`).
- **Connection Issues**: On clusters with complex networking (multiple interfaces), the tool attempts to resolve the controller IP using the fully qualified domain name (FQDN). Ensure your head node can resolve its own hostname.

## Reference documentation
- [github_com_roryk_ipython-cluster-helper.md](./references/github_com_roryk_ipython-cluster-helper.md)
- [anaconda_org_channels_bioconda_packages_ipython-cluster-helper_overview.md](./references/anaconda_org_channels_bioconda_packages_ipython-cluster-helper_overview.md)