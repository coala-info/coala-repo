---
name: cromwell-tools
description: Cromwell-tools is a utility suite for interacting with the Cromwell workflow execution engine to manage and monitor WDL-based workflows. Use when user asks to submit workflows, check workflow status, abort runs, query workflow metadata, or wait for workflow completion.
homepage: http://github.com/broadinstitute/cromwell-tools
---


# cromwell-tools

## Overview
`cromwell-tools` is a utility suite designed to streamline interactions with the Cromwell workflow execution engine. It provides a consistent interface for both command-line users and Python developers to manage the lifecycle of workflows—from submission to completion—while handling authentication and metadata retrieval efficiently. It is particularly useful for bioinformaticians and data engineers who need to automate workflow management or extract performance metrics from Cromwell instances.

## CLI Usage Patterns
The command-line interface mirrors the Cromwell REST API but simplifies authentication and parameter passing.

### Workflow Submission
To submit a new workflow, you must provide the WDL file and its associated inputs.
`cromwell-tools submit --wdl workflow.wdl --inputs inputs.json --options options.json --dependencies deps.zip`

### Monitoring and Control
- **Check Status**: Retrieve the current state of a workflow.
  `cromwell-tools status --uuid <WORKFLOW_ID>`
- **Wait for Completion**: Block the terminal until a workflow finishes.
  `cromwell-tools wait --uuid <WORKFLOW_ID>`
- **Abort a Run**: Stop a running workflow.
  `cromwell-tools abort --uuid <WORKFLOW_ID>`
- **Server Health**: Verify the Cromwell server is responsive.
  `cromwell-tools health`

### Querying Workflows
Search for workflows based on specific criteria like name or status:
`cromwell-tools query --name <WORKFLOW_NAME> --status Succeeded`

## Python API Integration
For complex automation, the Python API is the preferred method.
```python
import cromwell_tools.api as cwt
# Example: Checking status
response = cwt.status(uuid='your-uuid-here', auth=my_auth_object)
```

## Best Practices and Expert Tips
- **Authentication Consistency**: Use the tool's built-in authentication handlers to ensure consistent access across different Cromwell deployments (e.g., local vs. cloud-based).
- **Long-running Jobs**: Be aware that OAuth tokens may expire during the `wait` command for very long-running workflows. For production pipelines, use service account credentials where possible.
- **Metadata Retrieval**: Use the `metadata` sub-command to get detailed JSON logs of a run, which is essential for debugging failed tasks or calculating costs.
- **Environment Management**: Always install `cromwell-tools` in a dedicated Python 3 virtual environment to avoid conflicts with other genomic processing tools.
- **Resource Monitoring**: Leverage the accessory scripts provided in the repository to monitor resource usage and visualize benchmarking metrics for your WDL tasks.

## Reference documentation
- [Cromwell-tools GitHub Repository](./references/github_com_broadinstitute_cromwell-tools.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cromwell-tools_overview.md)