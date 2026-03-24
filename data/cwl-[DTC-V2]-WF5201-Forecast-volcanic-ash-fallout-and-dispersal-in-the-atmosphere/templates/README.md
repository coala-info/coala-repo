# Workflow Templates Guide

This directory contains two template files designed to help you get started with describing your computational workflows using CWL and RO-Crate. These templates follow our repository’s guide and format, ensuring consistency and proper structure.

## Templates Overview

- **CWL Workflow Template**  
  This template provides a starting point for defining your workflow in **Common Workflow Language (CWL)**. It includes sections for declaring global inputs and outputs as well as the individual workflow steps. Each step is set up to either run an abstract operation or a sub-workflow, with clear data dependency connections. Use this template to:

  - Define the computational steps and their data flows.
  - Ensure that global parameters and step-specific details are correctly referenced.
  - Maintain compatibility with CWL validation tools.

- **RO-Crate Metadata Template**  
  This template is designed to capture the rich metadata associated with your workflow following the **RO-Crate** standard. It describes the workflow repository, the main workflow file, and formal parameters for inputs and outputs. The template ensures that you include all mandatory objects such as:

  - The repository (Dataset) object.
  - The main workflow file (with its type and programming language details).
  - Formal parameters linking the CWL inputs and outputs to their metadata representations.

  Use this template to provide context, provenance, and additional information (e.g., authorship, licenses, software, and datasets) for your workflow components.

## How to Use These Templates

1. **Customize the Identifiers:**  
   Replace the placeholder names (e.g., `YOUR_WORKFLOW_NAME`, `INPUT_DIR`, `OUTPUT_DIR`) with your actual workflow identifiers.

2. **Adjust Descriptions and Metadata:**  
   Update the descriptions, dates, license information, and author details to match your workflow’s specifics.

3. **Expand as Needed:**  
   Both templates are minimal starting points. Add additional steps, datasets, or software objects as your workflow requires.
