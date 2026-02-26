---
name: vuegen
description: VueGen automates the compilation of bioinformatics data components into unified reports based on directory structure. Use when user asks to generate HTML reports, create Streamlit dashboards, generate presentations, documents, notebooks, or PDF reports.
homepage: https://github.com/Multiomics-Analytics-Group/vuegen
---


# vuegen

## Overview

VueGen is a reporting automation tool designed to bridge the gap between bioinformatics data generation and result communication. By scanning a structured input directory, it automatically identifies sections and subsections based on folder hierarchy and compiles various components—such as plots, tables, networks, and Markdown text—into a unified report. This allows for rapid iteration of scientific documentation without requiring manual report assembly or custom coding for each new dataset.

## Installation and Environment Setup

VueGen relies on Quarto for document generation. Ensure your environment is properly configured:

*   **Installation**: Install via pip (`pip install vuegen`) or Conda (`conda install -c bioconda -c conda-forge vuegen`).
*   **Dependency Validation**: Run `quarto check` to ensure the underlying engine is available.
*   **PDF Requirements**: For PDF output, a LaTeX distribution is required. You can install a lightweight version via Quarto: `quarto install tinytex`.
*   **Automated Checks**: Use the `--quarto_checks` flag during execution to have VueGen automatically verify and attempt to install missing dependencies.

## Core CLI Usage

The primary interface for VueGen is the command line. The tool requires an input directory and a target report format.

### Basic Report Generation
Generate a standard HTML report from a data directory:
`vuegen --directory ./results_folder --report_type html`

### Interactive Web Applications
To create an interactive Streamlit dashboard and launch it immediately:
`vuegen --directory ./results_folder --report_type streamlit --streamlit_autorun`

### Presentation and Document Formats
VueGen supports various professional formats:
*   **Slides**: `vuegen --directory ./data --report_type pptx` (PowerPoint) or `revealjs` (HTML slides).
*   **Documents**: `vuegen --directory ./data --report_type docx` or `odt`.
*   **Notebooks**: `vuegen --directory ./data --report_type ipynb`.

### Managing Outputs
By default, reports are generated in the current working directory. Use the output flag to organize your files:
`vuegen --directory ./data --report_type pdf --output_directory ./final_reports`

## Directory Structure Best Practices

VueGen uses your filesystem as the blueprint for the report structure. Organize your input directory to control the flow of the final document:

*   **Sections**: First-level folders within the input directory become the main report sections.
*   **Subsections**: Second-level folders become subsections.
*   **Components**: Files within these folders (images, tables, text) become the content.
*   **Automatic Overview**: If component files are placed directly in a first-level folder, VueGen automatically creates an "Overview" subsection for them.
*   **Naming**: Titles for sections and components are extracted directly from folder and file names; use descriptive naming conventions for your directories.

## Supported Component Types

VueGen recognizes and renders a wide variety of bioinformatics outputs:
*   **Tables**: `.tsv`, `.csv`, `.xls`, `.xlsx`.
*   **Images**: `.png`, `.jpg`, `.jpeg`, `.svg`.
*   **Interactive Plots**: `.json` (Plotly).
*   **Networks**: `.graphml`.
*   **Text**: `.md` (Markdown) and `.html` snippets.

## Reference documentation
- [VueGen GitHub Repository](./references/github_com_Multiomics-Analytics-Group_vuegen.md)
- [VueGen Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vuegen_overview.md)