---
name: google-cloud-sdk
description: The Google Cloud SDK provides a command-line interface and tools for managing Google Cloud Platform resources and services. Use when user asks to manage GCP resources, authenticate via gcloud, deploy applications, or use local service emulators.
homepage: https://cloud.google.com/sdk/
---


# google-cloud-sdk

## Overview
The Google Cloud SDK is the primary toolkit for managing GCP services. It includes the `gcloud` command-line interface, service emulators for local testing, and client libraries for various programming languages. This skill helps you navigate resource management, authentication, and automation workflows within the Google Cloud ecosystem.

## Core CLI Patterns

### Initialization and Auth
- **Setup**: Run `gcloud init` to perform initial setup, including authentication and project selection.
- **Auth**: Use `gcloud auth login` for user credentials or `gcloud auth activate-service-account` for automated environments.
- **Application Default Credentials (ADC)**: Use `gcloud auth application-default login` to provide credentials for local development with client libraries.

### Resource Management
- **Compute Engine**:
  - Create VM: `gcloud compute instances create [INSTANCE_NAME] --zone=[ZONE] --machine-type=[TYPE]`
  - SSH into VM: `gcloud compute ssh [INSTANCE_NAME] --zone=[ZONE]`
- **Kubernetes Engine (GKE)**:
  - Get credentials: `gcloud container clusters get-credentials [CLUSTER_NAME] --region=[REGION]`
- **App Engine**:
  - Deploy: `gcloud app deploy`
  - View logs: `gcloud app logs tail -s default`

### Configuration and Filtering
- **Project Switching**: `gcloud config set project [PROJECT_ID]`
- **Output Formatting**: Use `--format` to transform output (e.g., `json`, `table`, `value(field_name)`).
- **Filtering**: Use `--filter` to narrow results (e.g., `gcloud compute instances list --filter="status=RUNNING"`).

## Local Development & Emulators
Accelerate development without incurring costs by using local emulators:
- **Pub/Sub**: `gcloud beta emulators pubsub start`
- **Spanner**: `gcloud emulators spanner start`
- **Bigtable**: `gcloud beta emulators bigtable start`
- **Datastore**: `gcloud beta emulators datastore start`

## Expert Tips
- **Beta/Alpha Commands**: Many new features are under `gcloud beta` or `gcloud alpha`. Install them via `gcloud components install beta`.
- **Quiet Mode**: Use the `-q` or `--quiet` flag in scripts to disable interactive prompts.
- **Cloud Shell**: For a pre-configured environment without local installation, use the browser-based Cloud Shell.



## Subcommands

| Command | Description |
|---------|-------------|
| gcloud | manage Google Cloud Platform resources and developer workflow |
| gsutil | Google Cloud Storage utility |

## Reference documentation
- [Cloud SDK Overview](./references/cloud_google_com_sdk.md)