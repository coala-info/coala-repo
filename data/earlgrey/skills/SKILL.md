---
name: earlgrey
description: Earl Grey is a fully automated pipeline for identifying, curating, and annotating transposable elements in genome assemblies. Use when user asks to identify transposable elements, construct de novo repeat libraries, annotate genome assemblies, or visualize repeat landscapes.
homepage: https://github.com/TobyBaril/EarlGrey
---


# earlgrey

## Overview

Earl Grey is a comprehensive, fully automated pipeline designed to identify, curate, and annotate transposable elements (TEs) in genome assemblies. It integrates industry-standard tools like RepeatModeler and RepeatMasker with a specialized consensus elongation process (BEAT) to refine de novo consensus sequences. This tool is particularly effective for non-model organisms where existing repeat libraries may be insufficient. It produces detailed GFF outputs, summary tables, and "Repeat Landscape" plots to visualize TE divergence and genomic impact.

## Core Workflows

### Initial Configuration
After installation, you must configure the Dfam and/or RepBase partitions. Earl Grey will generate a configuration script upon its first run.
- **Action**: Run the generated script to specify which taxonomic partitions to include.
- **Tip**: Choose partitions carefully; including too many irrelevant partitions can increase runtime and lead to false positives, while too few may result in under-annotation.

### Main Pipeline Execution
The primary command for a full run (library construction + annotation) is `earlGrey`.

```bash
# Basic execution pattern
earlGrey -g genome.fasta -s species_name -o output_dir -t threads
```

### Specialized Sub-pipelines
- **Library Construction Only**: Use `earlGreyLibConstruct` when you only need to generate a de novo TE library for a genome without performing the full annotation.
- **Annotation Only**: Use `earlGreyAnnotationOnly` if you already have a curated TE library (e.g., from a previous run or a related species) and want to mask a new assembly.

## Resource Management and Performance

Earl Grey is highly resource-intensive. Follow these guidelines to prevent job failures:

- **RAM Requirements**: Allocate at least **3GB of RAM per thread**. For a 16-thread run, ensure at least 48GB of available RAM.
- **Runtime Expectations**: 
    - Small genomes (~40Mb): Hours to 1 day.
    - Medium genomes (~400Mb): 4-5 days.
    - Large genomes (~3Gb): ~1 week.
    - Very large genomes (>20Gb): Several weeks.
- **Checkpointing**: The pipeline uses checkpoints for each step. If a run is interrupted (e.g., due to server limits or OOM errors), resubmit the exact same command to resume from the last successful step.
- **OpenBLAS Errors**: If you see `pthread_create failed` or `Resource temporarily unavailable` errors, reduce the thread count or set the environment variable: `export OPENBLAS_NUM_THREADS=1`.

## Interpreting Results (Version 7.0+)

Version 7 introduced significant changes to how nested TEs are handled:

- **Nested TEs**: Identified iteratively and labeled in the GFF with `nested=FULLY_NESTED`.
- **Coverage Calculations**: Nested TEs are excluded from the primary "Total Interspersed Repeat" percentage in pie charts to prevent double-counting genomic space.
- **Summary Tables**: Look for `-nested` categories (e.g., `LINE-nested`) in the summary files to see the specific base-pair contribution of nested elements.
- **Repeat Landscapes**: Use the generated plots to analyze TE divergence. Version 7.0.2+ includes specific landscapes for Penelope-like elements and SINEs.

## Best Practices

- **Input Cleaning**: Ensure your input FASTA headers are simple and do not contain special characters or spaces that might break downstream tools like RepeatMasker.
- **SINE Detection**: In v7.0.2+, the `-norna` option is no longer default, improving the detection of small tRNA-derived SINEs. Do not manually add `-norna` unless you specifically wish to ignore these elements.
- **Monitoring**: Check logs frequently for "OOM" (Out of Memory) errors, especially during the `TEstrainer` and divergence calculation steps.

## Reference documentation
- [Earl Grey Main Documentation](./references/github_com_TobyBaril_EarlGrey.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_earlgrey_overview.md)