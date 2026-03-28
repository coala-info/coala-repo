---
name: cromwell-tools
description: Cromwell-tools provides a Python library and command-line interface for interacting with the Cromwell REST API to manage bioinformatics workflows. Use when user asks to submit WDL workflows, authenticate with Cromwell instances, monitor workflow status, or query workflow metadata.
homepage: http://github.com/broadinstitute/cromwell-tools
---

# cromwell-tools

## Overview

The `cromwell-tools` skill provides a streamlined interface for managing bioinformatics workflows on Cromwell instances. It abstracts the complexities of the Cromwell REST API into a consistent Pythonic library and command-line tool. This skill is essential for automating workflow submissions, handling various authentication schemes (including Google Cloud OAuth for CaaS), and implementing robust polling logic to wait for workflow completion.

## Authentication Patterns

Cromwell-tools supports multiple authentication methods. The recommended approach is using the standardized credential harmonizer.

### Python API Authentication
```python
from cromwell_tools.cromwell_auth import CromwellAuth

# Recommended: Harmonized method
auth = CromwellAuth.harmonize_credentials(
    url='https://cromwell.your-org.org',
    username='user',
    password='password'
)

# OAuth for Cromwell-as-a-Service (CaaS)
auth_caas = CromwellAuth.harmonize_credentials(
    service_account_key='path/to/key.json',
    url='https://cromwell.caas-prod.broadinstitute.org'
)
```

### CLI Authentication
The CLI shares a common set of arguments across sub-commands:
- `--url`: The Cromwell server endpoint.
- `--secrets-file`: Path to a JSON containing `url`, `username`, and `password`.
- `--service-account-key`: Path to Google Service Account JSON for OAuth.

## Workflow Submission

### CLI Submission
You can submit workflows using local paths or remote URLs.
```bash
cromwell-tools submit \
    --url "https://cromwell.server.org" \
    --wdl "https://raw.githubusercontent.com/user/repo/main/workflow.wdl" \
    --inputs-files "inputs.json" \
    --deps-file "dependencies.zip" \
    --label-file "labels.json"
```

### Python Submission
```python
from cromwell_tools import api

response = api.submit(
    auth=auth,
    wdl_file='workflow.wdl',
    inputs_files=['inputs.json'],
    dependencies=['sub_workflow.wdl'],
    on_hold=False
)
workflow_id = response.json()['id']
```

## Monitoring and Management

### Waiting for Completion
The `wait` command is highly efficient for automation scripts as it handles polling logic internally.
- **CLI**: `cromwell-tools wait --poll-interval-seconds 60 <workflow-uuid>`
- **Python**: `api.wait(workflow_ids=[uuid], auth=auth, poll_interval_seconds=60)`

### Querying Workflows
Use the `query` method to filter workflows by status, name, or labels.
```python
query_dict = {
    'status': ['Running', 'Submitted'],
    'name': 'MyWorkflowName',
    'additionalQueryResultFields': ['labels']
}
response = api.query(query_dict=query_dict, auth=auth)
```

## Expert Tips

1. **Remote Assets**: Use URLs for `--wdl-file` and `--inputs-files` in the CLI to avoid local file management overhead; `cromwell-tools` handles the download and composition automatically.
2. **Dependency Zipping**: When using the Python API, you can pass a list of file paths to the `dependencies` argument, and the tool will automatically create the required zip archive in memory.
3. **CaaS Collections**: When interacting with Cromwell-as-a-Service, always specify the `--collection-name` (CLI) or `collection_name` (API) to ensure workflows are associated with the correct SAM collection.
4. **On-Hold Workflows**: Use `on_hold=True` during submission for complex CI/CD pipelines where you need a UUID generated but want to delay execution until external data validation is complete. Use `release_hold` to start the run.



## Subcommands

| Command | Description |
|---------|-------------|
| cromwell-tools abort | Request Cromwell to abort a running workflow by UUID. |
| cromwell-tools health | Check that cromwell is running and that provided authentication is valid. |
| cromwell-tools metadata | Retrieve the workflow and call-level metadata for a specified workflow by UUID. |
| cromwell-tools query | Query for workflows. |
| cromwell-tools release_hold | Request Cromwell to release the hold on a workflow. |
| cromwell-tools status | Get the status of one or more workflows. |
| cromwell-tools submit | Submit a WDL workflow on Cromwell. |
| cromwell-tools task_runtime | Output tsv breakdown of task runtimes by execution event categories |
| cromwell-tools wait | Wait for one or more running workflow to finish. |

## Reference documentation
- [Cromwell-tools Python API Quickstart](./references/cromwell-tools_readthedocs_io_en_latest_Tutorials_Quickstart_api_quickstart.html.md)
- [Cromwell-tools Command Line Interface Quickstart](./references/cromwell-tools_readthedocs_io_en_latest_Tutorials_Quickstart_cli_quickstart.html.md)
- [API Documentation Reference](./references/cromwell-tools_readthedocs_io_en_latest_API_index.html.md)