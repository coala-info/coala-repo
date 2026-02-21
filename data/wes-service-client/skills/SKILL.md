---
name: wes-service-client
description: The `wes-service-client` is a specialized tool for managing computational workflows on remote execution engines that implement the GA4GH WES standard.
homepage: https://github.com/common-workflow-language/workflow-service
---

# wes-service-client

## Overview
The `wes-service-client` is a specialized tool for managing computational workflows on remote execution engines that implement the GA4GH WES standard. It acts as a bridge between a user's local environment and high-performance computing backends, allowing for standardized workflow submission, tracking, and log management without needing to interact directly with complex REST APIs.

## Configuration
The client must be pointed to a valid WES endpoint. You can configure connection details using either command-line flags or environment variables.

### Connection Parameters
| Feature | CLI Flag | Environment Variable |
| :--- | :--- | :--- |
| Server Host | `--host` | `WES_API_HOST` |
| Protocol | `--proto` | `WES_API_PROTO` (e.g., http or https) |
| Authentication | `--auth` | `WES_API_AUTH` |

**Authentication Formatting**:
- To send a specific header: `--auth "Header-Name: value"`
- To send a value in the default Authorization header: `--auth "value"`

## Core CLI Usage

### Service Information
To verify the connection and see what the remote service supports:
`wes-client --info`

### Submitting a Workflow Run
To initiate a workflow, you must provide the path to the workflow file and the input parameters file. If the workflow requires local files to be uploaded to the server, use the `--attachments` flag.

`wes-client --host <host> --proto <proto> --attachments="file1.ext,file2.ext" <workflow_file> <input_json>`

### Managing Runs
Once a workflow is submitted, use the returned `run_id` for management:

- **List all runs**: `wes-client --list`
- **Check status**: `wes-client --get <run-id>`
- **Retrieve stderr logs**: `wes-client --log <run-id>`

## Expert Tips
- **Persistent Configuration**: Set `WES_API_HOST` and `WES_API_AUTH` in your environment to simplify commands and avoid exposing credentials in shell history.
- **Attachment Handling**: The `--attachments` flag accepts a comma-separated list. Ensure all files are accessible from the current working directory or provide absolute paths.
- **Automation**: When scripting, capture the output of the submission command to extract the `run_id` for downstream polling logic.

## Reference documentation
- [WES Service Client Overview](./references/anaconda_org_channels_bioconda_packages_wes-service-client_overview.md)
- [Workflow Service README](./references/github_com_common-workflow-language_workflow-service.md)