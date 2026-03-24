# CWL + RO-Crate Workflow Descriptions

This repository stores computational workflows described using the **Common Workflow Language (CWL)** and enriched with metadata using **Research Object Crate (RO-Crate)** conforming to the **Workflow Run RO-Crate** profile.

Each workflow is contained in its own directory (e.g., `WF5201`, `WF6101`, ...). Inside each workflow directory you will typically find at least:

- The **CWL workflow definition** (with the same name as the directory, e.g., `WF5201.cwl`).
- The **RO-Crate metadata file** (`ro-crate-metadata.json`).

Additional files supporting the workflow may also be included.

---

## Table of Contents

- [Overview](#overview)
- [Components](#components)
  - [CWL: Common Workflow Language](#cwl-common-workflow-language)
  - [RO-Crate: Research Object Crate](#ro-crate-research-object-crate)
- [Our Approach](#our-approach)
- [Example: DTC52 Workflow](#example-dtc52-workflow)
  - [Workflow Components](#workflow-components)
  - [Top-Level Workflow (`WF5201.cwl`)](#top-level-workflow-wf5201cwl)
  - [Workflow as a Directed Acyclic Graph (DAG)](#workflow-as-a-directed-acyclic-graph-dag)
  - [Sub-workflow (`ST520101.cwl`)](#sub-workflow-st520101cwl)
- [Describing a Workflow using CWL + RO-Crate](#describing-a-workflow-using-cwl--ro-crate)
  - [Defining the CWL Workflow](#defining-the-cwl-workflow)
  - [Defining Workflow Steps](#defining-workflow-steps)
  - [Connecting Steps via Data Dependencies](#connecting-steps-via-data-dependencies)
- [RO-Crate Metadata](#ro-crate-metadata)
  - [RO-Crate Structure](#ro-crate-structure)
  - [Mandatory RO-Crate Objects](#mandatory-ro-crate-objects)
  - [Defining the Workflow Repository](#defining-the-workflow-repository)
  - [Describing the Workflow File](#describing-the-workflow-file)
  - [Formal Parameters](#formal-parameters)
  - [Software and Datasets](#software-and-datasets)
- [Validating Your Workflow and Metadata](#validating-your-workflow-and-metadata)
- [Additional Resources](#additional-resources)

---

## Overview

This document explains how to represent workflows by combining:

- **CWL (Common Workflow Language):** Used to define the computational steps, data flows, and tools.
- **RO-Crate:** Used to capture associated metadata (e.g., authorship, licenses, software, datasets) for the workflow.

By separating the abstract workflow definition from its metadata description, you can leverage existing tools for visualization, editing, and validation of your workflows while maintaining a clear structure.

---

## Components

### CWL: Common Workflow Language

CWL is a standard for describing computational workflows in a portable and scalable fashion. It defines the workflow's:

- **Steps:** The individual operations.
- **Data Flow:** How data moves between steps.
- **Inputs/Outputs:** The variables and data products, which can be of various types (e.g., File, Directory, String).

For more information, consult the [Common Workflow Language website](https://www.commonwl.org/).

### RO-Crate: Research Object Crate

RO-Crate is a standard for packaging research data and metadata using a JSON-LD format. It allows you to embed contextual information such as:

- Authors and licenses.
- Software details.
- Dataset descriptions.

Further details are available on the [Research Object Crate website](https://www.researchobject.org/ro-crate/).

---

## Our Approach

We represent workflows using a combination of CWL and RO-Crate:

- **CWL:** Captures the abstract definition of the workflow, detailing its computational steps, data flows, and the tools utilized. It does not include the implementation details of each operation.
- **RO-Crate:** Provides rich metadata for the overall repository, the workflow file(s), software, and datasets. This metadata allows you to understand the context, provenance, and related details of the workflow components.

This separation provides flexibility by keeping the execution details (CWL) distinct from descriptive metadata (RO-Crate), yet they remain tightly connected.

---

## Example: DTC52 Workflow

Below is an example of a workflow (a semplified version of DTC52) represented using the CWL + RO-Crate format.

### Workflow Components

The example workflow includes the following files:

```
ST520101.cwl
WF5201.cwl
ro-crate-metadata.json
```

- **`WF5201.cwl`**: The top-level workflow file that defines the overall structure.
- **`ST520101.cwl`**: A sub-workflow representing one step that consists of multiple sub-steps.
- **`ro-crate-metadata.json`**: Contains metadata for all components of the workflow, including software, datasets, and individual workflow files.

### Top-Level Workflow (`WF5201.cwl`)

A typical top-level CWL file starts with the version, class, and requirements. It then defines global inputs and outputs, followed by the individual steps:

```yaml
cwlVersion: v1.2
class: Workflow

requirements:
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  DT5210: Directory

outputs:
  DT5201:
    type: File[]
    outputSource:
      - ST520101/DT5201
      - SS5202/DT5201
      - SS5203/DT5201
      - SS5204/DT5201
      - SS5205/DT5201
      - SS5206/DT5201
      - SS5207/DT5201
      - SS5208/DT5201
      - SS5209/DT5201
      - SS5210/DT5201
      - SS5211/DT5201
      - SS5212/DT5201
      - SS5213/DT5201
      - SS5214/DT5201
      - SS5215/DT5201
    linkMerge: merge_flattened
  DT5202:
    type: Directory
    outputSource: SS5204/DT5202
  DT5203:
    type: Directory
    outputSource: SS5205/DT5203
  DT5204:
    type: Directory
    outputSource: SS5206/DT5204
  DT5205:
    type: Directory
    outputSource: SS5209/DT5205
  DT5206:
    type: Directory
    outputSource: SS5210/DT5206
  DT5207:
    type: Directory
    outputSource: SS5211/DT5207
  DT5208:
    type: Directory
    outputSource: SS5213/DT5208
  DT5209:
    type: Directory[]
    outputSource:
      - SS5215/DT5209
      - SS5214/DT5209
    linkMerge: merge_flattened

steps:
  ST520101:
    in:
      DT5202: SS5204/DT5202
      DT5203: SS5205/DT5203
      DT5204: SS5206/DT5204
      DT5205: SS5209/DT5205
      DT5206: SS5210/DT5206
      DT5207: SS5211/DT5207
      DT5210: DT5210
    run: ST520101.cwl
    out:
      - DT5201
  SS5202:
    doc: ST520102
    in:
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5210: Directory
      outputs:
        DT5201: File
    out:
      - DT5201
  SS5203:
    doc: ST520103
    in:
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5210: Directory
      outputs:
        DT5201: File
    out:
      - DT5201
```

Key details include:

- **Global inputs/outputs** are declared at the beginning.
- **Subworkflows:** The `run` attribute can reference another CWL file (e.g., `ST520101.cwl`).
- **Steps:** Each step defines its own inputs, run definition (using a generic `Operation` class when execution details are abstracted), and outputs.

### Workflow as a Directed Acyclic Graph (DAG)

CWL describes workflows as **Directed Acyclic Graphs (DAGs)**:

- **Nodes:** Represent individual steps or subworkflows.
- **Edges:** Represent data dependencies established by connecting outputs from one step to inputs of another.
- **Execution Order:** Inferred from these dependencies, allowing parallel execution of independent steps.

### Sub-workflow (`ST520101.cwl`)

A sub-workflow is defined similarly to the main workflow but represents a component within it. For example:

```yaml
SS5204:
  in:
    DT5210: DT5210
  run:
    class: Operation
    inputs:
      DT5210: Directory
    outputs:
      DT5201: File
      DT5202: Directory
  out:
    - DT5201
    - DT5202
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

Each step specifies its inputs, the operation (abstract or a subworkflow call), and then its outputs, maintaining consistency across the workflow.

---

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

---

## RO-Crate Metadata

Once the CWL workflow is defined, describe its metadata using an RO-Crate file (`ro-crate-metadata.json`).

### RO-Crate Structure

An RO-Crate file is a JSON-LD document. A minimal example structure is:

```json
{
  "@context": "https://w3id.org/ro/crate/1.1/context",
  "@graph": [
    {
      "@id": "ro-crate-metadata.json",
      "@type": "CreativeWork",
      "conformsTo": [
        { "@id": "https://w3id.org/ro/crate/1.1" },
        { "@id": "https://w3id.org/workflowhub/workflow-ro-crate/1.0" }
      ],
      "about": { "@id": "./" }
    },
    {
      "@id": "https://w3id.org/ro/wfrun/process/0.4",
      "@type": "CreativeWork",
      "name": "Process Run Crate",
      "version": "0.4"
    }
    // ... additional objects
  ]
}
```

- The **`@context`** sets the standard RO-Crate context.
- The **`@graph`** array contains objects that describe the workflow repository, individual files, software, datasets, etc.

### Mandatory RO-Crate Objects

At minimum, include the following objects to define the RO-Crate domain and profiles:

```json
{
  "@id": "ro-crate-metadata.json",
  "@type": "CreativeWork",
  "conformsTo": [
    { "@id": "https://w3id.org/ro/crate/1.1" },
    { "@id": "https://w3id.org/workflowhub/workflow-ro-crate/1.0" }
  ],
  "about": { "@id": "./" }
},
{
  "@id": "https://w3id.org/workflowhub/workflow-ro-crate/1.0",
  "@type": "CreativeWork",
  "name": "Workflow RO-Crate",
  "version": "1.0"
}
```

### Defining the Workflow Repository

Describe the overall repository (or dataset) for the workflow:

```json
{
  "@id": "./",
  "@type": "Dataset",
  "name": "Volcanic ash dispersal and deposition",
  "datePublished": "2025-01-01",
  "description": "N/A",
  "license": "https://spdx.org/licenses/GPL-3.0-or-later.html",
  "author": { "@id": "https://orcid.org/0000-0002-0677-6366" },
  "conformsTo": [
    { "@id": "https://w3id.org/ro/wfrun/process/0.4" },
    { "@id": "https://w3id.org/ro/wfrun/workflow/0.4" },
    { "@id": "https://w3id.org/workflowhub/workflow-ro-crate/1.0" }
  ],
  "hasPart": [
    { "@id": "WF5201.cwl" },
    { "@id": "DT5210/" },
    { "@id": "DT5212/" },
    // ... other parts of the workflow
    { "@id": "ST520101.cwl" }
  ],
  "mainEntity": { "@id": "WF5201.cwl" }
}
```

- **`hasPart`:** Lists all files and components (workflow files, datasets, software, etc.).
- **`mainEntity`:** Points to the main workflow file.

### Describing the Workflow File

A workflow file is documented with details specific to computational workflows:

```json
{
  "@id": "WF5201.cwl",
  "@type": ["File", "SoftwareSourceCode", "ComputationalWorkflow"],
  "name": "Volcanic ash dispersal and deposition",
  "author": { "@id": "https://orcid.org/0000-0002-0677-6366" },
  "programmingLanguage": {
    "@id": "https://w3id.org/workflowhub/workflow-ro-crate#cwl"
  },
  "input": [
    { "@id": "#DT5210->WF5201" }
    // ... other inputs
  ],
  "output": [
    { "@id": "#WF5201->DT5201" },
    { "@id": "#WF5201->DT5202" }
    // ... other outputs
  ]
}
```

This includes metadata such as the programming language and connections to formal parameters for inputs/outputs.

### Formal Parameters

Inputs and outputs for the workflow are defined as **FormalParameters**. For example:

```json
{
  "@id": "#WF5201->DT5201",
  "@type": "FormalParameter",
  "additionalType": "Dataset",
  "conformsTo": {
    "@id": "https://bioschemas.org/profiles/FormalParameter/1.0-RELEASE"
  },
  "workExample": { "@id": "DT5201/" },
  "name": "DT5201",
  "valueRequired": true
}
```

- The ID format (e.g., `#WF5201->DT5201`) indicates the relationship between the workflow and this parameter.
- **`workExample`** provides an example reference of the dataset.

### Software and Datasets

Include metadata for software and datasets used in the workflow:

**Software Example:**

```json
{
  "@id": "SS5214",
  "@type": "SoftwareSourceCode",
  "name": "Postp",
  "description": "Calls different microservices to postprocess the FALL3D results",
  "author": { "@id": "https://orcid.org/0000-0002-0677-6366" },
  "license": "GPL-3.0-or-later",
  "programmingLanguage": "Python",
  "url": "TODO: add the url to the software definition from the EPOS APIs"
}
```

**Dataset Example:**

```json
{
  "@id": "DT5202/",
  "@type": "Dataset",
  "name": "Global Forecast System (GFS)",
  "url": "https://ics-c.epos-ip.org/development/k8s-epos-deploy/dt-geo/api/v1/resources/details/90ac6544-573c-4611-9ea5-0deb7f8b524a"
}
```

> [IMPORTANT]
>
> - The dataset ID **MUST** have a trailing `/` to be valid.
> - The `url` attribute should point to the EPOS API URL for that specific resource.

Both software and datasets can include additional metadata as required by the official vocabularies.

---

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
