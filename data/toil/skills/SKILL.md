---
name: toil
description: Toil is a scalable pipeline management system designed to execute complex scientific workflows across distributed computing environments. Use when user asks to optimize autoscaling performance, manage resource reservations, or execute high-throughput processing tasks using CLI best practices.
homepage: https://toil.ucsc-cgl.org/
metadata:
  docker_image: "quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0"
---

# toil

## Overview

Toil is a scalable, efficient, and cross-platform pipeline management system designed for complex scientific workflows. It is particularly effective for handling massive datasets by leveraging distributed computing resources and sophisticated autoscaling algorithms. This skill focuses on the native Toil environment, specifically addressing cluster scaling behavior, resource reservation logic, and command-line optimization for high-throughput processing.

## Expert CLI and Scaling Patterns

### Optimize Autoscaling Performance

Toil's autoscaler uses a bin-packing approach to match job requirements (mem, core, disk) to node shapes. Use these parameters to tune cluster responsiveness:

- **Adjust Parallelization with Alpha**: The `alpha` parameter controls the degree of parallelization. It represents a time factor; the scaler attempts to spawn enough nodes so that all queued jobs start within `alpha` seconds. 
    - Decrease `alpha` for faster, more parallelized runs with more instances.
    - Increase `alpha` to pack more jobs per instance and reduce costs.
- **Manage Fluctuations with Beta**: The `beta` parameter (or `betaInertia`) acts as an exponentially weighted moving average to prevent the autoscaler from "freaking out" when thousands of small jobs are submitted simultaneously. Set this to a higher value to ignore small fluctuations, or 0.0 to make the scaler highly reactive.
- **Set Target Time**: Use `targetTime` to define when jobs ought to start. If a job's estimated `wallTime` is lower than the `targetTime`, Toil will attempt to pack additional jobs into the same resource block.

### Resource Management and Deadlocks

- **Prevent Service Deadlocks**: When running service jobs that must be simultaneous, ensure the `targetTime` is not so high that the autoscaler attempts to pack them serially.
- **Unignore Nodes**: If the scaler hits a state where nodes are being ignored despite a need to scale up, ensure the scaler is configured to "unignore" nodes when changing scaling direction.
- **Monitor Scaler Intervals**: The default scaler interval is 60 seconds. For workflows with many short jobs, consider increasing the scaler interval to prevent the completion rate logic from under-provisioning as the queue shrinks.

### Command Line Best Practices

- **Manage Output Files**: Use the `--moveOutputs` flag to handle final workflow results. Ensure the help text is verified against the version in use, as some versions may have inverted descriptions of this flag's behavior.
- **WDL Integration**: Toil supports WDL (Workflow Description Language) natively. When providing inputs, Toil recognizes Cromwell-style `Left`/`Right` pairs for complex data structures.
- **Slurm Partitioning**: When running on Slurm clusters where users lack permission to view partition information, Toil can still function by bypassing partition metadata requirements.

### Cluster Configuration

- **BinPackedFit Logic**: Jobs (jobShapes) are compared against a sorted list of node shapes (nodeShapes), typically sorted by memory. Toil fits jobs until a resource (CPU, RAM, or Disk) becomes limiting.
- **Node Reservations**: Understand that reservations are time-slices. A single long-running job can "extend" a node reservation, causing the scaler to pack shorter jobs into the projected future window of that node, which can sometimes lead to temporary under-provisioning of new nodes.



## Subcommands

| Command | Description |
|---------|-------------|
| toil | Generate a configuration file for Toil. |
| toil clean | The location of the job store for the workflow. A job store holds persistent information about the jobs, stats, and files in a workflow. |
| toil debug-file | Debug and manage files within a Toil job store. |
| toil debug-job | Debug a job within a Toil workflow by running it or retrieving its task directory. |
| toil destroy-cluster | Destroy a Toil cluster |
| toil kill | Kill a Toil workflow and its associated jobs in the job store. |
| toil launch-cluster | Launch a Toil cluster with a specified provisioner and node types. |
| toil rsync-cluster | Rsync files to or from a Toil cluster leader node. |
| toil ssh-cluster | SSH into a Toil managed cluster |
| toil stats | The location of the job store for the workflow. A job store holds persistent information about the jobs, stats, and files in a workflow. |
| toil status | Report the status of a Toil workflow and its jobs. |

## Reference documentation

- [ClusterScaler.py Overview](./references/github_com_DataBiosphere_toil_wiki_ClusterScaler.py-Overview.md)
- [Draft Changelog](./references/github_com_DataBiosphere_toil_wiki_Draft-Changelog.md)