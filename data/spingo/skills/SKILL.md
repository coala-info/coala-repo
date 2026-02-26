---
name: spingo
description: Spingo is an orchestration toolset that automates the deployment and management of Spinnaker on Google Cloud Platform using Terraform, Bash, and HashiCorp Vault. Use when user asks to deploy Spinnaker on GCP, manage deployment secrets via Vault, or configure Spinnaker infrastructure using Halyard.
homepage: https://github.com/homedepot/spingo
---


# spingo

## Overview

Spingo is a specialized orchestration toolset designed to simplify the deployment of Spinnaker on GCP. It integrates Terraform for infrastructure as code and Bash scripts for automated configuration, utilizing HashiCorp Vault to securely manage sensitive credentials like OAuth secrets and Slack tokens. This skill guides you through the end-to-end lifecycle—from environment preparation and secret injection to monitoring the deployment via a dedicated Halyard management VM.

## Environment Preparation

Before initiating the deployment, ensure the local environment meets these requirements:

- **Vault**: Install Vault and set the `VAULT_ADDR` environment variable. If a server is not available, initialize a local instance using `scripts/local-vault-setup.sh`.
- **GCP SDK**: Authenticate and set the target project:
  - `gcloud auth login`
  - `gcloud config set project <YOUR_PROJECT_ID>`
- **Permissions**: Ensure the authenticated user has Owner permissions on the GCP project to allow Terraform to create service accounts and IAM bindings.

## Core Workflow

### Initial Deployment
1. Clone the Spingo repository or generate a new one from the template.
2. Execute the primary setup script: `./quickstart.sh`.
3. Follow the interactive prompts to provide Google OAuth credentials and Slack integration tokens.
4. Capture the `halyard_command` output provided by Terraform upon completion.

### Secret Management via Vault
Spingo expects secrets to be stored in Vault under paths specific to your GCP project. Use the following patterns to write required credentials:

- **Google OAuth**:
  `vault write secret/$(gcloud config list --format 'value(core.project)' 2>/dev/null)/gcp-oauth "client-id=YOUR_ID" "client-secret=YOUR_SECRET"`
- **Slack Integration**:
  `vault write secret/$(gcloud config list --format 'value(core.project)' 2>/dev/null)/slack-token "value=YOUR_TOKEN"`

### Halyard VM Operations
Once the infrastructure is provisioned, manage the Spinnaker lifecycle from the ephemeral Halyard VM:

- **Access**: Run the `halyard_command` string provided by the quickstart output to SSH into the VM.
- **Monitor Progress**: Run `showlog` to tail the setup logs and verify dependency installation.
- **Administrative Access**: Run `spingo` to switch to the shared service account user for configuration tasks.
- **Verification**: Check the "Workloads" page in the GCP Console to confirm Kubernetes deployments are active across clusters.

## Expert Tips

- **DNS Propagation**: When using Managed DNS, Terraform outputs `google_dns_managed_zone_nameservers`. You must update your domain registrar with these specific nameservers to enable Let's Encrypt SSL certificate validation.
- **RBAC Setup**: Note the `spinnaker_fiat_account_unique_id` output. This ID must be configured as the "Client Name" in your Google Workspace domain-wide delegation to enable group-based authorization.
- **Cleanup**: To remove all provisioned resources and avoid ongoing costs, execute the teardown procedures provided in the repository scripts.

## Reference documentation
- [Spingo Architecture and Quickstart](./references/github_com_homedepot_spingo.md)
- [Issue Tracking and Known Limitations](./references/github_com_homedepot_spingo_issues.md)