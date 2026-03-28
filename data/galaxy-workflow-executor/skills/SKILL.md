---
name: galaxy-workflow-executor
description: The galaxy-workflow-executor automates the execution of Galaxy workflows from the command line using the Bioblend library. Use when user asks to generate parameter templates, execute workflows with automated data uploads, or resume interrupted workflow runs.
homepage: https://github.com/ebi-gene-expression-group/galaxy-workflow-executor
---


# galaxy-workflow-executor

## Overview

The galaxy-workflow-executor is a specialized toolset designed to bridge the gap between the Galaxy web interface and automated command-line environments. It leverages the Bioblend library to facilitate the execution of complex genomic workflows. This skill should be used when you need to move beyond manual Galaxy interactions into reproducible, scriptable pipelines. It handles the heavy lifting of data uploads, parameter mapping based on workflow labels, and result retrieval, while providing robust state management to recover from connection failures or execution errors.

## Core Workflows

### 1. Preparing the Environment
Before execution, ensure you have a credentials file (typically following the Parsec format) containing your Galaxy API key and the server URL. You must also download your workflow as a JSON file directly from the Galaxy UI using the "Share" -> "Download" option.

### 2. Generating Parameter Templates
To ensure your parameter file matches the specific requirements of a workflow, use the generation script. This script connects to the Galaxy instance, inspects the workflow structure, and creates a template.

**Command Pattern:**
`python generate_params_from_workflow.py -C <credentials_file> -G <instance_name> -W <workflow_json> -o <output_dir>`

*   **Expert Tip**: Ensure all steps in your Galaxy workflow are annotated with labels in the Galaxy UI before downloading the JSON. The executor uses these labels to map parameters; unlabeled steps are difficult to configure via CLI.

### 3. Executing the Workflow
The primary execution script handles data upload, workflow scheduling, and monitoring.

**Command Pattern:**
`python run_galaxy_workflow.py -C <credentials_file> -G <instance_name> -H <history_name> -i <inputs_file> -W <workflow_json> -P <parameters_file>`

*   **Input Mapping**: The inputs file must be a YAML-formatted file where keys correspond to workflow input labels. Values should specify the local file path and file type, or alternatively, a Galaxy `dataset_id` or `library_id` if the data is already on the server.
*   **Parameter Overrides**: The parameters file allows you to set specific tool settings for labeled steps. Simple atomic values in this file are automatically treated as workflow inputs.

## Advanced Usage and Best Practices

### Execution State and Resumption
The executor automatically saves progress in a state file (default: `exec_state.pickle`). 
*   **Resuming**: If a run is interrupted, running the same command in the same directory will attempt to resume from the last successful step.
*   **Isolation**: When running multiple different workflows in the same directory, use the `--state-file` flag to specify unique paths for each to prevent state collisions.

### Result Management
*   **Local Downloads**: By default, results are downloaded to the working directory. Use `-o` to specify a different destination.
*   **Data Libraries**: For production environments, use `-l <library_name>` to upload results directly to a Galaxy Data Library instead of downloading them locally. This requires admin privileges.
*   **Cleanup**: The tool purges histories and workflows from the Galaxy instance upon successful completion to save space. Use `--keep-histories` or `--keep-workflow` if you need to inspect the intermediate steps in the Galaxy UI.

### Error Handling
*   **Allowed Failures**: You can provide a YAML file via the `-a` flag to define specific steps that are permitted to fail (e.g., steps that might fail under certain biological conditions but shouldn't stop the entire pipeline).
*   **Exit Codes**: 
    *   Code 3: History deletion failed (non-critical, results are usually already safe).
    *   Code 4/5: Workflow scheduling was cancelled or failed on the server (critical).



## Subcommands

| Command | Description |
|---------|-------------|
| generate_params_from_workflow.py | Generate parameters from a Galaxy workflow. |
| run_galaxy_workflow.py | Runs a Galaxy workflow based on provided configuration and inputs. |

## Reference documentation
- [Main README](./references/github_com_ebi-gene-expression-group_galaxy-workflow-executor_blob_develop_README.md)
- [Workflow Execution Script](./references/github_com_ebi-gene-expression-group_galaxy-workflow-executor_blob_develop_run_galaxy_workflow.py.md)
- [Parameter Generation Script](./references/github_com_ebi-gene-expression-group_galaxy-workflow-executor_blob_develop_generate_params_from_workflow.py.md)
- [Credentials Sample](./references/github_com_ebi-gene-expression-group_galaxy-workflow-executor_blob_develop_galaxy_credentials.yml.sample.md)