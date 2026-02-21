---
name: dx-cwl
description: The `dx-cwl` tool acts as a bridge between the Common Workflow Language (CWL) standard and the DNAnexus platform.
homepage: https://github.com/dnanexus/dx-cwl
---

# dx-cwl

## Overview
The `dx-cwl` tool acts as a bridge between the Common Workflow Language (CWL) standard and the DNAnexus platform. It compiles CWL workflow definitions into native DNAnexus workflow objects, allowing bioinformaticians to leverage platform features like secure cloud execution, resource management, and data provenance while maintaining workflow portability.

## CLI Usage Patterns

### Compilation
To transform a local CWL workflow into a DNAnexus workflow, use the `compile-workflow` command. This requires an active DNAnexus API token and a target project.

```bash
python dx-cwl compile-workflow <path_to_local_cwl> --token $TOKEN --project $PROJECT
```

- The tool creates a directory in the target project named after the workflow.
- This directory contains the compiled workflow and the necessary applets/resources for execution.

### Execution
To run a compiled workflow on the platform, use the `run-workflow` command. This assumes the workflow has already been compiled and the input data has been uploaded to DNAnexus.

```bash
python dx-cwl run-workflow <compiled_workflow_path> <input_json_path>
```

- **compiled_workflow_path**: The path to the workflow object on the DNAnexus platform (e.g., `workflow_name/workflow_name`).
- **input_json_path**: The path to the JSON file on the DNAnexus platform containing the input parameters and file links.

## Best Practices
- **Environment Setup**: Ensure `dx-toolkit`, `cwltool`, and `PyYAML` are installed. Use the provided `get-cwltool.sh` script from the repository to ensure compatibility with DNAnexus-specific requirements.
- **Data Locality**: Before running `run-workflow`, ensure all data files referenced in your input JSON are already uploaded to the DNAnexus project.
- **Project Selection**: Always verify your current DNAnexus project context or explicitly provide the `--project` ID during compilation to avoid deploying workflows to the wrong environment.
- **Alpha Status Awareness**: As this tool is in an alpha phase, verify complex workflows with small test datasets before full-scale production runs.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_dnanexus-archive_dx-cwl.md)