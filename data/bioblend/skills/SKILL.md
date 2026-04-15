---
name: bioblend
description: BioBlend is a Python library that provides a programmatic interface for interacting with the Galaxy API to automate bioinformatics workflows and data management. Use when user asks to automate Galaxy interactions, manage histories and datasets, run tools, or invoke workflows through Python scripts.
homepage: https://github.com/galaxyproject/bioblend
metadata:
  docker_image: "quay.io/biocontainers/bioblend:1.8.0--pyhdfd78af_0"
---

# bioblend

## Overview
BioBlend is a specialized Python library designed to wrap the Galaxy API, providing a developer-friendly interface for bioinformatics automation. It transforms manual web-based interactions into reproducible scripts, allowing for the management of large-scale data analyses, workflow invocations, and data library administration. It is the standard tool for integrating Galaxy into automated pipelines or external applications.

## Installation and Setup
BioBlend is available via PyPI and Bioconda. It supports Python 3.10 through 3.14 and is compatible with Galaxy release 19.05 and later.

```python
# Installation via pip
pip install bioblend

# Installation via conda
conda install -c bioconda bioblend
```

## Core Usage Patterns

### Initializing the Connection
To interact with a Galaxy server, you must provide the server's URL and your personal API key.

```python
from bioblend.galaxy import GalaxyInstance

gi = GalaxyInstance(url='https://usegalaxy.org', key='your-api-key')
```

### History Management
Histories are the primary containers for datasets in Galaxy.

*   **Create a new history**: `gi.histories.create_history(name="My Analysis")`
*   **List histories**: `gi.histories.get_histories()`
*   **Update history**: Use `gi.histories.update_history(history_id, preferred_object_store_id='store_id')` to specify storage backends in modern Galaxy versions.
*   **Copy history**: Use the `copy_history` method to duplicate existing analysis environments.

### Working with Tools and Workflows
BioBlend allows you to trigger tools and complex workflows programmatically.

*   **Run a tool**: Use `gi.tools.run_tool(history_id, tool_id, tool_inputs)`.
*   **Invoke a workflow**: Use `gi.workflows.invoke_workflow(workflow_id, inputs, history_id=history_id)`.
*   **Rerun invocations**: Use `rerun_invocation(invocation_id)` to retry failed steps with corrected parameters.
*   **Extract Tool Metadata**: You can retrieve a tool's help text or the entire tool source code for inspection using `get_entire_tool_source`.

### Data Handling
*   **Upload local files**: `gi.tools.upload_file(path, history_id)`
*   **Download datasets**: `gi.datasets.download_dataset(dataset_id, file_path)`
*   **Library Management**: For shared data, use `gi.libraries` to create folders and upload datasets to Data Libraries.

## Expert Tips and Best Practices
*   **State Checking**: When running tools or workflows, always implement a polling mechanism to check the state of the job or invocation before attempting to access output datasets.
*   **Pagination**: When dealing with instances containing thousands of histories or datasets, use pagination parameters in `get_` methods to avoid timeouts and high memory usage.
*   **Session Handling**: For long-running scripts, ensure your environment handles session cookies if required by your specific Galaxy configuration.
*   **Error Handling**: Wrap API calls in try-except blocks to catch `bioblend.ConnectionError` for robust pipeline execution.

## Reference documentation
- [BioBlend Overview](./references/anaconda_org_channels_bioconda_packages_bioblend_overview.md)
- [BioBlend GitHub Repository](./references/github_com_galaxyproject_bioblend.md)