---
name: args_oap
description: args_oap identifies and quantifies antibiotic resistance genes from metagenomic data using a standardized bioinformatics pipeline. Use when user asks to identify ARGs, normalize ARG abundance to 16S rRNA or cell counts, or compare resistance profiles across metagenomic samples.
homepage: https://github.com/xinehc/args_oap
---


# args_oap

## Overview
The ARGs-OAP (Antibiotic Resistance Genes Online Analysis Pipeline) skill enables the identification and quantification of ARGs from metagenomic data. It automates a complex bioinformatics workflow that includes sequence alignment, filtering, and normalization. This skill is essential when you need to compare ARG profiles across different environmental or clinical samples by providing standardized metrics such as "copies per 16S rRNA gene" or "copies per cell."

## Core Workflow

The pipeline is executed in two primary stages.

### Stage One: Pre-processing and Metadata Generation
This stage identifies 16S rRNA genes and essential single-copy marker genes to estimate the total cell count in your samples.

```bash
args_oap stage_one -i <input_dir> -o <output_dir> -f <format> -t <threads>
```

- **-i**: Directory containing input sequence files.
- **-f**: Input format (e.g., `fa`, `fq`, `fa.gz`, `fq.gz`).
- **-t**: Number of threads for parallel processing.
- **Output**: Generates a `metadata.txt` file in the output directory containing `nRead`, `n16S`, and `nCell` estimates.

### Stage Two: ARG Identification and Normalization
This stage identifies ARG-like sequences and performs normalization based on the metadata from Stage One.

```bash
args_oap stage_two -i <stage_one_output_dir> -t <threads>
```

- **Normalization Results**: Look for files named `normalized_cell.type.txt` or `normalized_16S.type.txt`.
- **Hierarchy**: Results are typically categorized by `type` (e.g., aminoglycoside), `subtype`, and `gene`.

## Expert Tips and Best Practices

### File Naming for Paired-End Data
For paired-end reads to be recognized as a single sample, they must follow specific suffix patterns before the file extension:
- `_1` and `_2`
- `_R1` and `_R2`
- `_fwd` and `_rev`
*Example: `SampleA_R1.fq.gz` and `SampleA_R2.fq.gz`*

### De-contamination
Always perform de-contamination before running `stage_one`. Remove host genomic sequences (e.g., human, plant) and fungal sequences. This is critical because the cell number calculation relies on single-copy marker genes; non-prokaryotic DNA can bias these estimates.

### Using Customized Databases
If you need to search for specific genes not in the default SARG database (e.g., heavy metal resistance genes):
1. **Prepare the DB**: `args_oap make_db -i custom_db.fasta`
2. **Run Stage One**: Add `--database custom_db.fasta`
3. **Run Stage Two**: Add `--database custom_db.fasta --structure1 custom_structure.txt`
   - The structure file must be tab-separated, mapping sequence IDs to their hierarchical categories.

### Resource Management
- **Memory**: For very large metagenomes, ensure you are using the latest version (3.2.3+) which includes optimizations for reduced memory usage.
- **Threads**: Scaling threads (`-t`) significantly improves performance during the alignment phases of both stages.

## Reference documentation
- [ARGs-OAP GitHub Repository](./references/github_com_xinehc_args_oap.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_args_oap_overview.md)