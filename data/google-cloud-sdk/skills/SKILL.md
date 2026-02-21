---
name: google-cloud-sdk
description: The `google-cloud-sdk` skill provides the necessary procedural knowledge to manage Google Cloud resources directly from the command line.
homepage: https://cloud.google.com/sdk/
---

# google-cloud-sdk

## Overview
The `google-cloud-sdk` skill provides the necessary procedural knowledge to manage Google Cloud resources directly from the command line. It focuses on the `gcloud` CLI tool, which serves as the primary interface for authentication, configuration, and resource management across the GCP ecosystem. Use this skill to automate infrastructure tasks, script cloud workflows, and set up local emulators for services like Pub/Sub and Spanner.

## Core CLI Patterns

### Authentication and Configuration
Before interacting with GCP, you must initialize the environment and manage active accounts.
- **Initialize SDK**: `gcloud init` (sets up default configuration, account, and project).
- **Login**: `gcloud auth login` to authenticate a user account.
- **Set Project**: `gcloud config set project [PROJECT_ID]` to switch the active project context.
- **List Configurations**: `gcloud config configurations list` to see multiple environment setups.

### Resource Management
Common patterns for managing core GCP services:
- **Compute Engine**: 
  - Create VM: `gcloud compute instances create [INSTANCE_NAME] --zone=[ZONE] --machine-type=[TYPE]`
  - List VMs: `gcloud compute instances list`
- **Kubernetes Engine (GKE)**:
  - Get Credentials: `gcloud container clusters get-credentials [CLUSTER_NAME] --zone=[ZONE]`
- **Cloud Storage (gsutil)**:
  - Upload: `gsutil cp [LOCAL_FILE] gs://[BUCKET_NAME]/`
  - Sync: `gsutil rsync -r [LOCAL_DIR] gs://[BUCKET_NAME]/`

### Local Development and Emulators
Accelerate development without incurring cloud costs by using local emulators:
- **Pub/Sub**: `gcloud beta emulators pubsub start --project=[PROJECT_ID]`
- **Bigtable**: `gcloud beta emulators bigtable start`
- **Spanner**: `gcloud emulators spanner start`

## Expert Tips
- **Filtering and Formatting**: Use the `--format` and `--filter` flags to parse output efficiently.
  - Example: `gcloud compute instances list --filter="status=RUNNING" --format="table(name, zone, status)"`
- **Quiet Mode**: Use `-q` or `--quiet` in scripts to disable interactive prompts.
- **Component Management**: Keep your SDK updated with `gcloud components update` and install additional tools like `kubectl` via `gcloud components install kubectl`.
- **Help Access**: Append `--help` to any command to see detailed flag documentation and examples.

## Reference documentation
- [Cloud SDK - Libraries and Command Line Tools](./references/cloud_google_com_sdk.md)
- [google-cloud-sdk - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_google-cloud-sdk_overview.md)