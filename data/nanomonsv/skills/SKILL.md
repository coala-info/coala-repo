---
name: nanomonsv
description: nanomonsv is a specialized suite of Python tools for identifying somatic structural variations (SVs) using long-read nanopore data.
homepage: https://github.com/friend1ws/nanomonsv
---

# nanomonsv

## Overview
nanomonsv is a specialized suite of Python tools for identifying somatic structural variations (SVs) using long-read nanopore data. While short-read technologies often struggle with complex genomic rearrangements and repetitive regions, nanomonsv leverages the length of nanopore reads to characterize SVs with high precision. It is particularly powerful for detecting "Single Breakend" SVs—complex events involving centromeric sequences, LINE-1 mediated retrotransposition, and viral integrations that are often invisible to standard callers.

The tool follows a multi-stage workflow: first parsing alignment files to isolate candidate reads, and then performing local assembly and rigorous filtering against a matched control (and optionally a control panel) to produce high-confidence somatic calls.

## Core Workflow

### 1. Parsing Candidate Reads
The `parse` command identifies and extracts reads that potentially support structural variations. This must be run for both the tumor and the matched control BAM/CRAM files.

```bash
# Parse tumor sample
nanomonsv parse tumor.bam output/tumor_prefix

# Parse control sample
nanomonsv parse control.bam output/control_prefix
```

*   **Input**: BAM files must be aligned using `minimap2`.
*   **Output**: Generates indexed BED and BEDPE files (e.g., `.deletion.sorted.bed.gz`, `.rearrangement.sorted.bedpe.gz`).

### 2. Calling Somatic SVs
The `get` command performs the actual SV calling by comparing the parsed tumor reads against the control data and the reference genome.

```bash
nanomonsv get \
    output/tumor_prefix \
    tumor.bam \
    reference.fa \
    --control_prefix output/control_prefix \
    --control_bam control.bam \
    --use_racon
```

*   **Expert Tip**: Always use the `--use_racon` flag. This utilizes `racon` for generating consensus sequences, which significantly improves breakpoint resolution to single-base accuracy.
*   **Reference**: Ensure the reference FASTA is the same one used for the initial `minimap2` alignment.

### 3. Classifying Insertions (Advanced)
For SVs involving insertions, use the `insert_classify` command to determine if the sequence originates from LINE-1, viruses, or other genomic locations.

```bash
nanomonsv insert_classify tumor.nanomonsv.result.txt reference.fa
```

## Best Practices and Expert Tips

### Noise Reduction with Control Panels
If you are working with low-depth control samples or want to maximize precision, use a "Control Panel." This allows nanomonsv to filter out common artifacts and germline variants found across multiple individuals.
*   Use the `--control_panel_prefix` option in the `get` command.
*   Pre-built control panels (e.g., from HPRC data) are recommended for standard human builds (GRCh38).

### Environment Requirements
*   **Dependencies**: Ensure `htslib` (specifically `tabix` and `bgzip`), `mafft`, and `racon` are installed and available in your system `PATH`.
*   **Alignment**: nanomonsv is optimized for `minimap2` alignments. Using other aligners may lead to suboptimal results or parsing errors.
*   **CRAM Support**: From version 0.7.0 onwards, CRAM files are supported. When using CRAM, always provide the reference genome via the `--reference_fasta` flag during the `parse` step.

### Filtering Results
The primary output is `*.nanomonsv.result.txt`. For high-confidence calls, pay attention to:
*   `MIN_TUMOR_VARIANT_READ_NUM`: Default is often 3; increasing this can reduce false positives in high-depth data.
*   `MAX_CONTROL_VAF`: Use this to strictly filter out potential germline leakage.

## Reference documentation
- [nanomonsv GitHub README](./references/github_com_friend1ws_nanomonsv.md)
- [nanomonsv Wiki and Tutorials](./references/github_com_friend1ws_nanomonsv_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nanomonsv_overview.md)