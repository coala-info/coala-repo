---
name: samsifter
description: samsifter is a command-line tool for defining and managing bioinformatics workflows. Use when user asks to define, edit, or manage bioinformatics workflows.
homepage: https://anaconda.org/channels/bioconda/packages/samsifter/overview
---


# samsifter

yaml
name: samsifter
description: Workflow editor for metagenomic analysis. Use when Claude needs to define, edit, or manage complex bioinformatics workflows, particularly for metagenomic data processing, using its command-line interface.
---
## Overview
samsifter is a command-line tool designed to facilitate the creation and management of complex bioinformatics workflows, with a specific focus on metagenomic analysis. It allows users to define, edit, and orchestrate multi-step analysis pipelines.

## Usage

samsifter operates via its command-line interface. The primary function is to edit or create workflow definition files.

### Core Commands

The most common usage involves editing an existing workflow file or creating a new one.

*   **Editing a workflow:**
    ```bash
    samsifter edit <workflow_file.yaml>
    ```
    This command opens the specified workflow file in your default text editor (or the editor configured via environment variables like `EDITOR`). You can then make modifications to the workflow steps, parameters, and dependencies.

*   **Creating a new workflow:**
    While `samsifter` doesn't have a direct "create new" command that generates a blank file, you would typically start by copying an existing template or a minimal example and then using `samsifter edit` to populate it.

### Workflow File Structure (Conceptual)

samsifter workflows are typically defined in YAML format. Key components include:

*   **Steps:** Individual processing units within the workflow. Each step usually corresponds to a specific tool or command.
*   **Parameters:** Inputs and configurations for each step.
*   **Dependencies:** The order in which steps should be executed, defining the data flow between them.

### Expert Tips

*   **Leverage `EDITOR` environment variable:** Ensure your `EDITOR` environment variable is set to your preferred text editor for a seamless editing experience.
*   **Version Control:** Always store your `samsifter` workflow files under version control (e.g., Git). This allows you to track changes, revert to previous versions, and collaborate effectively.
*   **Modular Workflows:** Break down complex analyses into smaller, manageable workflow files. This improves readability, maintainability, and reusability.
*   **Parameterization:** Make your workflows flexible by heavily parameterizing them. This allows you to reuse the same workflow for different datasets or experimental conditions without modification.

## Reference documentation
- [Overview](./references/anaconda_org_channels_bioconda_packages_samsifter_overview.md)