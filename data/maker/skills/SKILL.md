---
name: maker
description: MAKER is an automated pipeline for eukaryotic genome annotation that integrates evidence from EST and protein alignments with gene prediction results. Use when user asks to initialize control files, execute the annotation workflow, run the pipeline in parallel using MPI, or resume a previous run.
homepage: http://www.yandell-lab.org/software/maker.html
metadata:
  docker_image: "quay.io/biocontainers/maker:3.01.04--pl5321h7b50bb2_0"
---

# maker

## Overview
MAKER is a comprehensive pipeline designed to automate the annotation of eukaryotic genomes. It aligns ESTs and proteins to a genome, uses those alignments to train and run gene predictors, and then integrates all evidence into a final set of high-confidence gene models with quality control metrics (AED scores). This skill provides the necessary command-line patterns to initialize, configure, and execute the MAKER workflow.

## Configuration and Initialization
MAKER relies on three primary control files to manage a run. These must be generated in the working directory before execution.

- **Initialize control files**: `maker -CTL`
  This generates:
  - `maker_opts.ctl`: Main configuration for input files (genome, ESTs, proteins) and tool paths.
  - `maker_bopts.ctl`: Settings for BLAST and alignment filtering.
  - `maker_exe.ctl`: Executable paths for underlying tools (RepeatMasker, Exonerate, etc.).

## Common CLI Patterns
- **Standard Run**: `maker`
  Executes the pipeline based on the `.ctl` files in the current directory.
- **Parallel Execution (MPI)**: `mpiexec -n <cpus> maker`
  MAKER is designed for MPI; use this for large genomes to distribute the load across multiple cores or nodes.
- **Resume/Update Run**: `maker`
  MAKER automatically detects existing output and resumes from the last successful step. To force a re-run of specific sections, delete the corresponding datastore directory.
- **Base Log Generation**: `maker -base <name>`
  Useful for organizing multiple runs with different parameter sets within the same directory.

## Expert Tips
- **AED Scores**: Use the Annotation Edit Distance (AED) found in the output GFF3 to evaluate model quality. An AED of 0 indicates perfect agreement with evidence, while 1 indicates no evidence support.
- **Training Predictors**: For optimal results, run MAKER in "evidence-only" mode first, use the results to train SNAP or Augustus, and then provide the HMM/profile in `maker_opts.ctl` for a second pass.
- **Repeat Masking**: Ensure `model_org` or a custom repeat library is specified in `maker_opts.ctl`. MAKER can run RepeatMasker internally if paths are correctly set in `maker_exe.ctl`.
- **Output Management**: Use `gff3_merge` and `fasta_merge` (included with MAKER) to combine the distributed datastore output into single files for downstream analysis.

## Reference documentation
- [MAKER Overview](./references/anaconda_org_channels_bioconda_packages_maker_overview.md)