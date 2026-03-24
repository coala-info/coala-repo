# ENA Reads and Assembly Submission Workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.elixir-belgium.org/
- **Package**: https://workflowhub.eu/workflows/2008
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/2008/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 163
- **Last updated**: 2025-10-24
- **GitHub**: https://github.com/usegalaxy-eu/ena-upload-cli
- **Stars**: N/A
- **Version**: 1
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ENA_Reads_and_Assembly_Submission_Workflow.ga` (Main Workflow)
- **Project**: ELIXIR Belgium
- **Views**: 1457
- **Creators**: Bert Droesbeke

## Description

# ENA Reads & Assembly Submission Workflow

Originally developed within the [EVORA project](https://evora-project.eu/), this two-step Galaxy workflow streamlines submissions to the [European Nucleotide Archive (ENA)](https://www.ebi.ac.uk/ena). The workflow first submits raw sequencing reads via the **Galaxy ENA upload tool**, then submits assembled sequences using the **Galaxy ENA Webin CLI tool**. The process is fully interactive and GUI-driven while retaining ENA’s required validations leveraging the user-scoped credential management system and the data upload/management from Galaxy.


## Step 1 — Raw reads: Galaxy ENA upload tool

A Galaxy wrapper around the [ENA-upload-cli](https://github.com/usegalaxy-eu/ena-upload-cli) that brings a graphical interface and interactive checks to standard ENA read submissions.

**Key features**

- Raw read submission with  ENA-upload-cli at its core
- Use [tabular or excel sheet templates](https://github.com/ELIXIR-Belgium/ENA-metadata-templates) to easily capture the metadata
- Client side validation using ENA checklists
- Create, add, and modify ENA objects (e.g., studies, experiments, samples, runs)

## Step 2 — Consensus sequences: Galaxy ENA Webin CLI

A Galaxy wrapper around ENA’s [Webin-CLI](https://github.com/enasequence/webin-cli) for interactive submission of consensus sequences, with full checklist coverage.

**Key features**

- Seamless integration with the Galaxy ENA upload tool to fetch and reuse metadata
- Interactive metadata submission and validation
- Support for all assembly levels (contig, scaffold and chromosome)

## Funding

The EVORA project has received funding from the European Union's HORIZON programme under grant agreement No 101131959
