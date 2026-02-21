---
name: desalt
description: deSALT is a specialized alignment tool designed for long-read RNA-seq data.
homepage: https://github.com/ydLiu-HIT/
---

# desalt

## Overview
deSALT is a specialized alignment tool designed for long-read RNA-seq data. It utilizes a two-pass alignment strategy and a De Bruijn graph-based index to achieve high sensitivity in exon identification and splice junction recovery. Use this skill when you need to map long transcriptome reads to a reference genome with high accuracy, especially when dealing with complex splicing patterns or large eukaryotic genomes.

## Installation and Setup
The most reliable way to install deSALT is via Bioconda:
```bash
conda install -c bioconda desalt
```

### Reference Preparation
deSALT requires the reference FASTA to have a fixed line width of no more than 500bp. If your reference does not meet this requirement, use the provided utility script:
```bash
python changelinewidth.py input_genome.fa formatted_genome.fa 80
```

## Core Workflow

### 1. Indexing the Reference
Indexing is a one-time, resource-intensive process. For a human genome, it requires approximately 73GB of RAM and several hours.
```bash
deSALT index <ref.fa> <index_route>
```
*   `<ref.fa>`: The formatted reference genome.
*   `<index_route>`: The directory where the index files will be stored.

### 2. Aligning Reads
Perform the alignment using the generated index.
```bash
deSALT aln <index_route> <read.fq/fa> -t <threads> -o <output.sam>
```

## Common CLI Patterns and Options

### Parallel Execution
If running multiple deSALT instances simultaneously on the same machine, you must specify a unique temporary file for each instance using the `-f` flag to avoid conflicts:
```bash
deSALT aln -f temp_instance_1 <index_route> reads_1.fq
deSALT aln -f temp_instance_2 <index_route> reads_2.fq
```

### Performance Tuning
*   **Threads (`-t`)**: Increase the number of threads to speed up the alignment process (default is 4).
*   **Intron Length (`-I`)**: The default maximum intron length is 200,000 bp. Adjust this if working with species known for exceptionally large introns.
*   **Seed Step (`-s`)**: Controls the interval of seeding (default is 5). Decreasing this may increase sensitivity at the cost of speed.
*   **Batch Size (`-B`)**: Adjust the number of reads processed in one loop (default 655,350) to manage memory usage during the alignment phase.

## Expert Tips
*   **Memory Management**: While alignment requires ~35GB for the human genome, the indexing phase requires significantly more (~73GB). Ensure your environment has sufficient overhead before starting the `index` command.
*   **Strand Specificity**: If you need to enforce transcript strand detection, use the `-d` (strand difference) option to set the minimal DP score difference required to determine the strand.
*   **Secondary Alignments**: Use the `-p` option to control the secondary-to-primary alignment score ratio if you are interested in multi-mapping reads.

## Reference documentation
- [deSALT GitHub Repository](./references/github_com_ydLiu-HIT_deSALT.md)
- [Bioconda deSALT Overview](./references/anaconda_org_channels_bioconda_packages_desalt_overview.md)