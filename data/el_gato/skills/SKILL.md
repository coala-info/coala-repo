---
name: el_gato
description: el_gato determines the Sequence Type of Legionella pneumophila from NGS reads or genome assemblies by analyzing seven specific loci against the ESGLI database. Use when user asks to perform multilocus sequence typing for Legionella, identify allele numbers from sequencing data, or determine the ST of a Legionella sample.
homepage: https://github.com/appliedbinf/el_gato
metadata:
  docker_image: "quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0"
---

# el_gato

## Overview

The `el_gato` (Epidemiology of Legionella: Genome-bAsed Typing) tool is a specialized utility for determining the Sequence Type (ST) of *Legionella pneumophila*. It replaces traditional Sanger-based sequencing methods by analyzing seven specific loci (*flaA*, *pilE*, *asd*, *mip*, *mompS*, *proA*, and *neuA/neuAh*) from Next-Generation Sequencing (NGS) data. The tool compares sequences against the curated ESGLI database to assign allele numbers and derive a final ST.

## Usage Instructions

### Core Command Patterns

**1. Using Paired-End Reads (Recommended)**
Read-based typing is more reliable than assembly-based typing as it utilizes a mapping/alignment approach.
```bash
el_gato.py --read1 sample_R1.fastq.gz --read2 sample_R2.fastq.gz --out output_folder/
```

**2. Using Genome Assemblies**
If raw reads are unavailable, `el_gato` uses a combination of BLAST and in silico PCR.
```bash
el_gato.py --assembly genome_assembly.fasta --out output_folder/
```

### Optimization and Best Practices

*   **Prioritize Reads**: Always prefer raw Illumina paired-end reads over assemblies when available. The mapping approach used for reads provides higher confidence in allele calling.
*   **Performance**: Use the `--threads` or `-t` flag to speed up alignment and BLAST operations.
*   **Depth Thresholds**: The default minimum depth for identifying loci in reads is 10x. For low-coverage samples, you can adjust this with `--depth`, though lower values may decrease typing confidence.
*   **Output Management**: Use `--overwrite` or `-w` if you are re-running an analysis on the same sample to avoid errors regarding existing directories.
*   **Reporting**: To include column headers in the resulting table (useful for downstream parsing), add the `--header` or `-e` flag.
*   **Troubleshooting**: Use `--verbose` to monitor the specific steps (mapping, BLAST, or PCR) the script is performing. If you need to inspect the alignments, use `--samfile` to retain the SAM file in the output directory.

### Common CLI Arguments

| Argument | Description | Default |
| :--- | :--- | :--- |
| `--read1`, `-1` | Forward fastq file | Required (if no assembly) |
| `--read2`, `-2` | Reverse fastq file | Required (if no assembly) |
| `--assembly`, `-a` | Fasta assembly file | Required (if no reads) |
| `--out`, `-o` | Output directory | `out` |
| `--threads`, `-t` | Number of CPU threads | 1 |
| `--depth`, `-d` | Minimum depth for loci | 10 |
| `--kmer-size`, `-k` | Minimap2 kmer size (max 28) | 21 |
| `--header`, `-e` | Include headers in output | False |

## Reference documentation
- [el_gato Overview](./references/anaconda_org_channels_bioconda_packages_el_gato_overview.md)
- [el_gato GitHub Repository](./references/github_com_appliedbinf_el_gato.md)