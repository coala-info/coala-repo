---
name: perl-cg-pipeline
description: The perl-cg-pipeline (CG-Pipeline) is a specialized computational genomics suite for bacterial genome sequencing projects.
homepage: https://github.com/lskatz/CG-Pipeline
---

# perl-cg-pipeline

## Overview
The perl-cg-pipeline (CG-Pipeline) is a specialized computational genomics suite for bacterial genome sequencing projects. It provides a modular infrastructure to handle the transition from raw sequencing reads to fully annotated genomes. The pipeline is structured into three core functional stages—assembly, prediction, and annotation—which can be executed as a single end-to-end process or as individual components for greater control over the bioinformatics workflow.

## Core CLI Usage

### Unified Pipeline Execution
The `run_pipeline` command is the primary entry point for executing the full workflow.

```bash
run_pipeline [stage] [-p project_name] -i target.sff [-r reference.fasta] [-t tag_prefix] [-e expectedGenomeSize]
```

Valid stages include:
- `build` / `create`: Initialize the project environment.
- `assemble`: Perform genome assembly.
- `predict`: Execute feature prediction.
- `annotate`: Perform functional annotation.

### Individual Stage Commands
For more granular control, use the specific stage scripts:

**1. Assembly**
Processes raw .sff files into contigs.
```bash
run_assembly input.sff [, input2.sff, ...] [-R references.mfa]
```

**2. Prediction**
Identifies genomic features from assembled multi-FASTA files.
```bash
run_prediction input.mfa -strain_name=NAME [-tag_prefix=PREFIX] [-classification=TAXONOMY] [-R references.mfa] [-o output.gb]
```

**3. Annotation**
Performs functional annotation on predicted features (GenBank input).
```bash
run_annotation input.gb
```

## Configuration and Customization

### Configuration Files
CG-Pipeline uses a hierarchical configuration system:
- **Global Defaults**: Located in `cg_pipeline/conf/cgpipelinerc`.
- **User Overrides**: Create a file at `${HOME}/.cgpipelinerc` to customize parameters like CPU usage, algorithm paths, or default thresholds without modifying the global installation.

### Best Practices
- **Project Organization**: Always use the `-p` flag in `run_pipeline` to keep intermediate files and logs organized within a specific project directory.
- **Reference-Guided Workflows**: When available, provide a reference genome using `-r` (for the full pipeline) or `-R` (for individual stages) to improve assembly and prediction accuracy.
- **Resource Management**: By default, many scripts may default to a single CPU. Check your `.cgpipelinerc` to ensure the `cpus` parameter matches your environment's capabilities.
- **Input Formats**: While the pipeline is optimized for `.sff` files (454 sequencing), ensure your reference files are in standard FASTA/Multi-FASTA format.

## Reference documentation
- [Bioconda perl-cg-pipeline Overview](./references/anaconda_org_channels_bioconda_packages_perl-cg-pipeline_overview.md)
- [CG-Pipeline GitHub Repository](./references/github_com_lskatz_CG-Pipeline.md)