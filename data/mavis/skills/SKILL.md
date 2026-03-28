---
name: mavis
description: MAVIS refines, clusters, and annotates structural variant calls from multiple sources to identify high-confidence genomic rearrangements and gene fusions. Use when user asks to merge structural variant calls, validate breakpoints through local assembly, or annotate the functional impact of variants on protein domains.
homepage: https://github.com/bcgsc/mavis.git
---

# mavis

## Overview
MAVIS (Merging, Annotation, Validation, and Illustration of Structural variants) is a specialized bioinformatics pipeline designed to refine raw structural variant calls. It transforms disparate outputs from various SV callers into a unified, high-confidence set of annotated variants. The tool is particularly effective for identifying gene fusions, determining the functional impact of rearrangements on protein domains, and providing visual evidence for complex genomic events.

## Core Pipeline Stages
The MAVIS workflow typically follows these sequential steps:
1. **Convert**: Standardize outputs from different SV callers into the MAVIS format.
2. **Cluster**: Merge overlapping calls from different libraries or tools into unique events.
3. **Validate**: Perform local de novo assembly of reads to refine breakpoint coordinates.
4. **Annotate**: Determine the effect of the SV on genes, transcripts, and protein domains.
5. **Pairing**: Match events across different libraries (e.g., Tumor vs. Normal or DNA vs. RNA).
6. **Summary**: Consolidate all information into a final prioritized output.

## Command Line Usage
All operations are accessed via the main `mavis` entry point.

### Getting Help
- View main options: `mavis -h`
- View specific step options: `mavis <step> -h` (e.g., `mavis cluster -h`)

### Standard Input Format
If using an unsupported tool, format your input as a tab-delimited file with these required columns:
- `break1_chromosome`, `break1_position_start`, `break1_position_end`
- `break2_chromosome`, `break2_position_start`, `break2_position_end`

### Running via Snakemake (Recommended)
For large-scale processing, use the provided Snakemake workflow:
```bash
pip install mavis_config
snakemake -j <MAX_JOBS> --configfile <YOUR_CONFIG> --use-singularity -s Snakefile
```

## Expert Tips & Best Practices
- **Reference Files**: Ensure `MAVIS_REFERENCE_GENOME` and `MAVIS_ANNOTATIONS` (JSON format) are set in your environment to avoid repetitive CLI arguments.
- **Breakpoint Normalization**: MAVIS aligns deletions to the end of a repeat span (HGVS standard). If your IGV view differs from MAVIS output, check if the event is in a repeat region.
- **Evidence Tracking**: Use the `tracking_id` column to follow specific SV calls through the pipeline, as clustering may collapse or expand original calls.
- **Zero Spanning Reads**: If a call shows 0 spanning reads, check the `call_method`. If the event was called by contig assembly, look at `contig_remapped_reads` for the primary evidence instead.
- **Memory Management**: When using annotation files that include non-coding RNAs, increase the memory allocation for the `annotate` step (e.g., from 12GB to 18GB).
- **Local Execution**: To run without a cluster scheduler, execute scripts in order: `validate` -> `annotate` -> `pairing` -> `summary`. Set `MAVIS_MAX_FILES=1` to prevent the creation of excessive small job files.



## Subcommands

| Command | Description |
|---------|-------------|
| mavis overlay | Draws a gene and its surrounding genomic context, including read depth plots and markers. |
| mavis_annotate | Annotates variants with MAVIS. |
| mavis_cluster | Cluster MAVIS results |
| mavis_convert | Convert structural variant calls from various callers into a common format. |
| mavis_pairing | Mavis pairing tool |
| mavis_setup | Setup Mavis |
| mavis_summary | Summarize MAVIS results. |
| mavis_validate | Validate MAVIS inputs and outputs. |

## Reference documentation
- [MAVIS Input Requirements](./references/mavis_bcgsc_ca_docs_latest_mavis_input.html.md)
- [Help and Frequently Asked Questions](./references/github_com_bcgsc_mavis_wiki_Help-and-Frequently-Asked-Questions.md)
- [MAVIS GitHub Repository](./references/github_com_bcgsc_mavis.md)