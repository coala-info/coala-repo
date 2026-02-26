---
name: argo
description: Argo is a bioinformatics profiler that provides species-level resolution for antibiotic resistance genes within metagenomes by linking them to microbial hosts using long-read alignment. Use when user asks to profile antibiotic resistance genes, link resistance genes to specific microbial hosts, or calculate gene abundance in copies per genome.
homepage: https://github.com/xinehc/argo
---


# argo

## Overview

Argo is a specialized bioinformatics profiler that provides species-level resolution for antibiotic resistance genes (ARGs) within complex metagenomes. Unlike traditional tools that may only identify the presence of a gene, Argo uses long-read overlapping and base-level alignment (via minimap2 and GTDB) to link ARGs directly to their microbial hosts. It calculates abundance in "copies per genome" (cpg), providing a biologically relevant metric for environmental surveillance.

## Installation and Setup

Install Argo via Conda from the bioconda channel:

```bash
conda create -n argo -c bioconda -c conda-forge argo
conda activate argo
```

### Database Preparation
Argo requires a specific database (defaulting to SARG+) which must be downloaded and indexed before the first run.

1. **Download**: Obtain the database files from the official Zenodo repository.
2. **Index with Diamond**:
   ```bash
   diamond makedb --in database/prot.fa --db database/prot
   diamond makedb --in database/sarg.fa --db database/sarg
   ```
3. **Index with Minimap2**:
   ```bash
   # Index all .fa files in the database directory
   ls database/*.fa | xargs -I {} minimap2 -x map-ont -d {}.mmi {}
   ```

## Command Line Usage

### Basic Profiling
Run Argo on quality-controlled long reads (FASTA or FASTQ, can be gzipped).

```bash
argo input_reads.fa.gz -d path/to/database -o output_directory
```

### Identifying Plasmid-Borne ARGs
To distinguish between chromosomal and plasmid-carried ARGs, use the `--plasmid` flag. This is essential for understanding the horizontal gene transfer potential of the resistome.

```bash
argo input_reads.fa.gz -d database -o output --plasmid
```

### Customizing Alignment Sensitivity
By default, Argo uses an adaptive identity cutoff based on the median sequence divergence of the sample. To override this for specific stringency requirements (e.g., 80% identity and 80% subject coverage):

```bash
argo input_reads.fa.gz -d database -o output -i 80 -s 80
```

## Output Interpretation

Argo generates two primary output files:

1. **`*.sarg.tsv`**: A tabular report containing:
   - **Lineage**: Taxonomic classification of the host.
   - **Type/Subtype**: The specific ARG classification.
   - **Carrier**: Whether the gene is on a chromosome or plasmid.
   - **Abundance**: Expressed as copies per genome (cpg).
2. **`*.sarg.json`**: Detailed annotation metadata for every ARG-containing read, useful for downstream custom analysis or validation of specific hits.

## Best Practices

- **Input Quality**: Ensure reads are quality-controlled (e.g., using Porechop or nanoq) and filtered for non-prokaryotic sequences before running Argo.
- **Resource Management**: For large datasets, adjust threads using `-t [INT]`. If memory issues occur during indexing, set `cpu_count=1`.
- **Adaptive vs. Fixed Cutoffs**: Use the default adaptive cutoff for samples with varying read qualities (e.g., different Nanopore flow cells) to ensure results remain comparable. Use fixed cutoffs (`-i`, `-s`) only when adhering to specific regulatory or publication standards.

## Reference documentation
- [Argo GitHub Repository](./references/github_com_xinehc_argo.md)
- [Argo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_argo_overview.md)