---
name: elasticluster
description: ElastiCluster automates the provisioning and configuration of compute clusters on cloud infrastructure. Use when user asks to start or stop clusters, list cluster templates, scale nodes, or configure software stacks like Slurm and Spark.
homepage: https://github.com/elasticluster/elasticluster
---


# elasticluster

## Overview

ElastiCluster is a command-line tool designed to transform raw cloud infrastructure into functional, application-ready compute clusters. It automates the entire lifecycle of a cluster—from provisioning virtual machines on providers like Amazon EC2 or Google Compute Engine to configuring the software stack using Ansible playbooks. This skill is ideal for deploying specialized environments for batch queuing (Slurm), distributed storage (GlusterFS, Ceph), or big data processing (Spark, Hadoop) without manual intervention.

## Core CLI Workflows

### Installation and Setup
The recommended way to run ElastiCluster is via its Docker wrapper to avoid dependency conflicts.

*   **Download the wrapper**: `curl -O https://raw.githubusercontent.com/gc3-uzh-ch/elasticluster/master/elasticluster.sh && chmod +x elasticluster.sh`
*   **Initialize configuration**: Run `elasticluster list-templates` for the first time to generate a template configuration file at `~/.elasticluster/config`.

### Cluster Management
*   **List available templates**: `elasticluster list-templates`
    *   Use this to verify your INI configuration file is being parsed correctly.
*   **Start a cluster**: `elasticluster start <cluster_template_name> -n <cluster_name>`
    *   This provisions the VMs and immediately begins the Ansible setup phase.
*   **Stop/Terminate a cluster**: `elasticluster stop <cluster_name>`
    *   Shuts down all instances and releases cloud resources.
*   **Check cluster status**: `elasticluster list-nodes <cluster_name>`
    *   Provides IP addresses and roles (master/worker) for all nodes in a running cluster.

### Configuration and Provisioning
*   **Re-run configuration**: `elasticluster setup <cluster_name>`
    *   Use this if the initial Ansible run failed or if you have manually modified the playbooks/configuration and need to apply changes to a running cluster.
*   **Scale a cluster**:
    *   **Add nodes**: `elasticluster add-nodes <cluster_name> <node_group> <number>`
    *   **Remove nodes**: `elasticluster remove-nodes <cluster_name> <node_group> <number>`

## Best Practices and Expert Tips

*   **Configuration Location**: By default, ElastiCluster looks for its configuration in `~/.elasticluster/config`. You can specify a custom path using the `-c` or `--config` flag.
*   **SSH Access**: ElastiCluster manages SSH keys for you. Use `elasticluster ssh <cluster_name>` to jump directly into the master node of your cluster.
*   **Ansible Customization**: Since ElastiCluster uses Ansible under the hood, you can extend its functionality by adding your own playbooks to the `examples/` directory or modifying the default roles for Slurm, Spark, etc.
*   **GPU Support**: When deploying HPC clusters, ensure your configuration specifies CUDA-enabled images if you intend to use the automated GPU setup features.
*   **Troubleshooting**: If a cluster starts but the software setup fails, use the `-v` (verbose) flag with the `setup` command to see the detailed Ansible output: `elasticluster -v setup <cluster_name>`.

## Reference documentation
- [ElastiCluster Main Repository](./references/github_com_elasticluster_elasticluster.md)
- [Documentation Overview](./references/github_com_elasticluster_elasticluster_tree_master_docs.md)