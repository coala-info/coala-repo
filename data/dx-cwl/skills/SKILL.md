---
name: dx-cwl
description: "dx-cwl compiles Common Workflow Language definitions into DNAnexus-native objects and executes them on the platform. Use when user asks to compile CWL tools or workflows into DNAnexus applets and run CWL workflows on the DNAnexus cloud."
homepage: https://github.com/dnanexus/dx-cwl
---

# dx-cwl

## Overview
`dx-cwl` is a command-line utility designed to bridge the gap between the Common Workflow Language (CWL) standard and the DNAnexus cloud platform. It functions by compiling CWL workflow definitions into DNAnexus-native workflow objects, allowing users to leverage platform-specific features—such as secure execution, cloud scaling, and data management—while maintaining the portability of the CWL specification. This tool is essential for bioinformaticians migrating standardized pipelines to a cloud environment.

## CLI Usage Patterns

### Workflow Compilation
To transform a local CWL definition into a DNAnexus workflow, use the `compile-workflow` command. This requires an active API token and a target project ID where the workflow assets will be stored.

```bash
python dx-cwl compile-workflow <path_to_cwl_file> --token $DX_API_TOKEN --project $DX_PROJECT_ID
```

### Workflow Execution
After compilation, the workflow can be executed on the platform using the `run-workflow` command. This requires the platform path to the compiled workflow and a JSON file mapping the required inputs.

```bash
python dx-cwl run-workflow <compiled_workflow_path> <input_json_file>
```

## Expert Tips and Best Practices

- **Prerequisite Initialization**: Before the first run, execute the `./get-cwltool.sh` script included in the repository. This ensures the environment has the specific version of `cwltool` required for DNAnexus applet compatibility.
- **Token Management**: Ensure your DNAnexus API token is stored in an environment variable (e.g., `$TOKEN`) for secure and easy access during compilation.
- **Project Scoping**: Always verify your project context. The `--project` flag is critical during compilation to ensure all generated applets and resources are bundled within the correct DNAnexus project container.
- **Output Handling**: Compiled workflows generate a directory on the platform containing the workflow object and its dependency applets. Use the `run-workflow` command pointing to the specific workflow object within that generated directory.
- **Tool Dependencies**: Ensure `dx-toolkit`, `cwltool`, and `PyYAML` are installed in your local Python environment before attempting to run the `dx-cwl` script.



## Subcommands

| Command | Description |
|---------|-------------|
| dx-cwl compile-tool | Compile a CWL tool definition file into a DNAnexus applet. |
| dx-cwl compile-workflow | Compile a CWL workflow to a DNAnexus workflow. |
| dx-cwl run-workflow | Runs a CWL workflow on the DNAnexus platform. |

## Reference documentation
- [Main README](./references/github_com_dnanexus-archive_dx-cwl_blob_master_README.md)
- [dx-cwl CLI Entry Point](./references/github_com_dnanexus-archive_dx-cwl_blob_master_dx-cwl.md)