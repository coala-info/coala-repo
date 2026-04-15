---
name: metamlst
description: MetaMLST performs in-silico reconstruction of Multi-Locus Sequence Typing loci directly from raw shotgun metagenomic sequencing reads for high-resolution strain tracking. Use when user asks to identify known microbial strains, detect novel sequence types, or prepare concatenated loci sequences for phylogenomic studies.
homepage: https://github.com/SegataLab/metamlst
metadata:
  docker_image: "quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0"
---

# metamlst

## Overview

MetaMLST is a computational pipeline designed for high-resolution strain tracking within metagenomic datasets. Unlike traditional methods that require isolate cultivation or metagenomic assembly, MetaMLST performs in-silico reconstruction of MLST loci directly from raw shotgun sequencing reads. Use this skill to identify known microbial strains, detect novel sequence types (STs), and prepare data for downstream phylogenomic studies. It is specifically applicable to shotgun metagenomics and cannot be used with 16S rRNA amplicon data.

## Core Workflow

### 1. Database and Index Preparation
Before processing samples, you must prepare the MetaMLST database and a corresponding Bowtie2 index. MetaMLST automatically handles the download of the default database (e.g., metamlstDB_2021) if a custom one is not provided.

**Build the Bowtie2 index:**
```bash
metamlst-index.py -i <index_prefix>
```

**Create a custom database (Optional):**
If using specific sequences or typing files from PubMLST:
```bash
# Initialize DB with sequences and types
metamlst-index.py -s sequences.fasta -t typings.txt -d custom_db.db

# Build index from the custom DB
metamlst-index.py -i custom_index -d custom_db.db
```

### 2. Read Mapping
Map raw FASTQ reads against the MetaMLST index. MetaMLST requires specific Bowtie2 settings to ensure sensitive alignment of loci.

```bash
bowtie2 --very-sensitive-local -a --no-unal -x <index_prefix> -U <input.fastq> | samtools view -bS - > <sample_alignments.bam>
```
*Note: Use `-1` and `-2` for paired-end reads if applicable.*

### 3. Loci Reconstruction
Process the resulting BAM file to detect microbial species and reconstruct sample-specific MLST sequences.

```bash
metamlst.py <sample_alignments.bam> -o ./out_directory/
```
*Expert Tip: Run this command for every sample in your study, directing all outputs to the same parent directory for easier merging.*

### 4. Multi-Sample Merging and ST Calling
Aggregate results from all processed samples to call Sequence Types and generate comparative reports.

```bash
metamlst-merge.py ./out_directory/
```

**Advanced Merging Options:**
*   **Metadata Integration:** Add external metadata to the final report.
    ```bash
    metamlst-merge.py --meta metadata.txt ./out_directory/
    ```
*   **Phylogenetic Output:** Generate concatenated loci sequences in FASTA format for tree building (e.g., with RAxML).
    ```bash
    metamlst-merge.py --outseqformat A ./out_directory/
    ```

## Best Practices and Interpretation

*   **Novel ST Identification:** MetaMLST labels novel loci or new combinations of known loci with IDs starting at 100001. Treat these as potentially new strains unique to your dataset.
*   **Sensitivity:** Always use the `--very-sensitive-local` flag in Bowtie2. MLST loci reconstruction depends on capturing as many relevant reads as possible, even those with minor variations.
*   **Output Files:**
    *   `*_report.txt`: Summary of detected species and their assigned STs.
    *   `*_ST.txt`: Updated typing table including newly identified profiles.
    *   `*_sequences.fna`: Reconstructed sequences (if requested via `--outseqformat`).
*   **Database Updates:** Use `metamlst-index.py` to incorporate results from previous runs back into your master database to maintain consistency across longitudinal studies.



## Subcommands

| Command | Description |
|---------|-------------|
| metamlst.py | Reconstruct the MLST loci from a BAMFILE aligned to the reference MLST loci |
| metamlst_metamlst-index.py | Builds and manages the MetaMLST SQLite Databases |
| metamlst_metamlst-merge.py | Detects the MLST profiles from a collection of intermediate files from MetaMLST.py |

## Reference documentation
- [MetaMLST Wiki Home](./references/github_com_SegataLab_metamlst_wiki.md)
- [metamlst-index Documentation](./references/github_com_SegataLab_metamlst_wiki_metamlst-index.md)
- [metamlst Sample Processing](./references/github_com_SegataLab_metamlst_wiki_metamlst.md)
- [metamlst-merge Comparative Analysis](./references/github_com_SegataLab_metamlst_wiki_metamlst-merge.md)
- [MetaMLST Usage Examples](./references/github_com_SegataLab_metamlst_wiki_Examples.md)