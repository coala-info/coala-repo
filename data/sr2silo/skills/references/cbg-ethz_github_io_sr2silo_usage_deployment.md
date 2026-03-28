[ ]
[ ]

[Skip to content](#multi-virus-deployment-guide)

[![logo](../../assets/logo.svg)](../.. "sr2silo")

sr2silo

Deployment

Initializing search

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [Usage](../configuration/)
* [API Reference](../../api/loculus/)
* [Contributing](../../contributing/)

[![logo](../../assets/logo.svg)](../.. "sr2silo")
sr2silo

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [x]

  Usage

  Usage
  + [Configuration](../configuration/)
  + [Multi-Organism Support](../organisms/)
  + [ ]

    Deployment

    [Deployment](./)

    Table of contents
    - [Overview](#overview)
    - [Directory Structure](#directory-structure)
    - [1. Credential Setup](#1-credential-setup)
    - [2. Running Deployments](#2-running-deployments)

      * [Starting a Daily Cycle](#starting-a-daily-cycle)
      * [Automatic Resubmission](#automatic-resubmission)
      * [Monitoring](#monitoring)
    - [3. Adding a New Virus](#3-adding-a-new-virus)
  + [Resource Requirements](../resource_requirements/)
* [ ]

  API Reference

  API Reference
  + [Loculus Integration](../../api/loculus/)
  + [Processing](../../api/process/)
  + [Data Schemas](../../api/schema/)
  + [V-Pipe Integration](../../api/vpipe/)
* [ ]

  Contributing

  Contributing
  + [Overview](../../contributing/)
  + [Branching Strategy](../../contributing/branching-strategy/)

# Multi-Virus Deployment Guide

This guide explains how to deploy the sr2silo workflow for multiple viruses (e.g., SARS-CoV-2, RSV-A) on the ETH Euler cluster using the shared deployment infrastructure.

## Overview

The deployment system allows you to run independent daily workflows for different viruses using a shared codebase and credential store. Each virus has its own configuration file, but they share the same SLURM submission script and secrets.

## Directory Structure

The deployment configuration is located in the `deployments/` directory:

```
deployments/
├── secrets.py            # Credential loader (Python)
├── secrets/              # Shared Loculus credentials (GPG encrypted)
├── submit-daily.sbatch   # Shared SLURM script
├── _templates/           # Template for new viruses
├── covid/                # SARS-CoV-2 configuration
└── rsva/                 # RSV-A configuration
```

## 1. Credential Setup

We use GPG symmetric encryption to store the shared Loculus credentials (`USERNAME` and `PASSWORD`) securely.

To create or update the encrypted credentials file:

```
# You will be prompted for the passphrase twice
echo -e "USERNAME=vpipe\nPASSWORD=your_actual_password" | gpg --symmetric --cipher-algo AES256 -o deployments/secrets/credentials.enc
```

## 2. Running Deployments

The `deployments/submit-daily.sbatch` script handles the execution and automatic resubmission of the workflow.

### Starting a Daily Cycle

To start the workflow for a specific virus, submit the job with the `VIRUS` and `GPG_PASSPHRASE` variables.

**Example: Start RSV-A immediately**

```
sbatch --job-name=sr2silo-rsva \
       --export=VIRUS=rsva,GPG_PASSPHRASE="your_passphrase" \
       --begin=now \
       deployments/submit-daily.sbatch
```

**Example: Schedule SARS-CoV-2 for 23:00**

```
sbatch --job-name=sr2silo-covid \
       --export=VIRUS=covid,GPG_PASSPHRASE="your_passphrase" \
       --begin=23:00 \
       deployments/submit-daily.sbatch
```

### Automatic Resubmission

The job is configured to automatically resubmit itself for the next day at 23:00 upon successful completion. It preserves the `VIRUS` and `GPG_PASSPHRASE` variables for the next run.

### Monitoring

Jobs will appear in the SLURM queue with descriptive names:

```
squeue -u $USER -o "%.18i %.9P %.20j %.8u %.2t %.10M %.6D %R"
```

Output:

```
JOBID              NAME                 USER    ST      START_TIME
51521886           sr2silo-rsva         koehng  PD      2025-12-12T23:00:00
51522132           sr2silo-covid        koehng  PD      2025-12-12T23:00:00
```

## 3. Adding a New Virus

To deploy the workflow for a new virus:

1. **Create Configuration Directory:**
   Copy the template directory:

   ```
   cp -r deployments/_templates deployments/my-new-virus
   ```
2. **Edit Configuration:**
   Modify `deployments/my-new-virus/config.yaml`:

   * `VIRUS_NAME`: Internal name (used for folder names).
   * `VIRUS_DISPLAY_NAME`: Human-readable name.
   * `ORGANISM`: Must match a supported organism in `sr2silo` (see `src/sr2silo/configs/organisms.py`).
   * `LOCATIONS`: List of location IDs to process.
   * `BASE_SAMPLE_DIR`: Path to V-Pipe output directory.
   * `TIMELINE_FILE`: Path to the timeline metadata file.
3. **Deploy:**
   Submit the job as described in section 2.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)