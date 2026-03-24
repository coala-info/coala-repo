# [DTC-V3] WF5301: Lava flow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://dtgeo.eu/
- **Package**: https://workflowhub.eu/workflows/1786
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1786/ro_crate?version=1
- **Source repository (git):** https://github.com/common-workflow-language/cwltool
- **Conda**: N/A
- **Total Downloads**: 310
- **Last updated**: 2025-07-01
- **GitHub**: https://github.com/common-workflow-language/cwltool
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `DTC53/WF5301/WF5301.cwl` (Main Workflow)
- **Project**: WP5 - Volcanoes
- **Views**: 1008

## Description

# CWL + RO-Crate Workflow Descriptions

This repository stores computational workflows described using the **Common Workflow Language (CWL)** and enriched with metadata using **Research Object Crate (RO-Crate)** conforming to the **Workflow Run RO-Crate** profile.

Each workflow is contained in its own directory (e.g., `WF5201`, `WF6101`, ...). Inside each workflow directory you will typically find at least:

- The **CWL workflow definition** (with the same name as the directory, e.g., `WF5201.cwl`).
- The **RO-Crate metadata file** (`ro-crate-metadata.json`).

Additional files supporting the workflow may also be included.

## Overview

This document explains how to represent workflows by combining:

- **CWL (Common Workflow Language):** Used to define the computational steps, data flows, and tools.
- **RO-Crate:** Used to capture associated metadata (e.g., authorship, licenses, software, datasets) for the workflow.

By separating the abstract workflow definition from its metadata description, you can leverage existing tools for visualization, editing, and validation of your workflows while maintaining a clear structure.

## Our Approach

We represent workflows using a combination of CWL and RO-Crate:

- **CWL:** Captures the abstract definition of the workflow, detailing its computational steps, data flows, and the tools utilized. It does not include the implementation details of each operation.
- **RO-Crate:** Provides rich metadata for the overall repository, the workflow file(s), software, and datasets. This metadata allows you to understand the context, provenance, and related details of the workflow components.

This separation provides flexibility by keeping the execution details (CWL) distinct from descriptive metadata (RO-Crate), yet they remain tightly connected.

## Describing a Workflow using CWL + RO-Crate

To fully describe a workflow, you must separate the **workflow definition** (using CWL) from the **metadata description** (using RO-Crate).

### Defining the CWL Workflow

1. **Identify Global Inputs and Outputs:**  
   Decide on the data that enters the workflow (inputs) and the final results (outputs). Optionally, include intermediate outputs if they are of interest.

2. **Create the CWL File:**  
   Write a CWL file in YAML format. Start with file metadata such as:

   ```yaml
   cwlVersion: v1.2
   class: Workflow

   requirements:
     MultipleInputFeatureRequirement: {}
     SubworkflowFeatureRequirement: {}
   ```

   > [NOTE]
   > The `requirements` section may vary depending on your workflow. For example, if you use sub-workflows, you must include the `SubworkflowFeatureRequirement`.

3. **Declare Global Inputs and Outputs:**

   ```yaml
   inputs:
     DT5210: Directory
     DT5211: Directory

   outputs:
     DT5208:
       type: Directory
       outputSource: SS5213/DT5208
   ```

   > [NOTE]
   > Although `Directory` is commonly used to represent a dataset, you might choose a different type. Refer to the CWL documentation for additional types.

### Defining Workflow Steps

Each workflow step (or subworkflow) follows a consistent structure:

```yaml
SS5205:
  in:
    DT5210: DT5210
  run:
    class: Operation
    inputs:
      DT5210: Directory
    outputs:
      DT5201: File
      DT5203: Directory
  out:
    - DT5201
    - DT5203
```

Key elements are:

- **`in`:** Defines which data this step requires.
- **`run`:**
  - For operations: Uses the `Operation` class to abstract away the underlying execution details.
  - For subworkflows: Points to another CWL file.
- **`out`:** Lists the output data produced by the step.

### Connecting Steps via Data Dependencies

CWL does not require an explicit execution order. Instead, dependencies are determined by connecting outputs to inputs:

```yaml
ST520102:
  in:
    DT5201: ST520101/DT5201
  run: ST520102.cwl
  out:
    - DT5255
```

This connection means `ST520102` depends on the output (`DT5201`) of `ST520101` and will execute after it, while still allowing independent steps to run in parallel.

## Validating Your Workflow and Metadata

- **CWL Validation:**  
  Use [cwltool](https://github.com/common-workflow-language/cwltool) to check your CWL files for syntax errors and to generate a graphical visualization (using Graphviz `dot` format) for verifying the workflow structure.

- **RO-Crate Validation:**  
  Validate your `ro-crate-metadata.json` file with tools such as the [RO-Crate Validator](https://github.com/crs4/rocrate-validator) and explore your RO-Crate interactively with [ro-crate-html-js](https://github.com/Language-Research-Technology/ro-crate-html-js).

---

## Additional Resources

- [CWL Official Guide and Getting Started](https://www.commonwl.org/getting-started/)
- [CWL User Guide](https://www.commonwl.org/user_guide/)
- [RO-Crate Official Documentation](https://www.researchobject.org/ro-crate/)
