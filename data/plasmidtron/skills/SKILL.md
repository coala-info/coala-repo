---
name: plasmidtron
description: PlasmidTron is a comparative genomics tool that isolates and assembles phenotype-specific sequences such as plasmids using a k-mer based approach. Use when user asks to identify sequences correlating with a specific trait, assemble plasmids from trait-positive samples, or perform targeted assembly of mobile genetic elements.
homepage: https://github.com/sanger-pathogens/plasmidtron
---


# plasmidtron

## Overview

PlasmidTron is a comparative genomics tool designed to isolate and assemble sequences—primarily plasmids—that correlate with a specific phenotype. Instead of performing a full de novo assembly of every sample, it utilizes a k-mer based approach to identify sequences present in your "trait" samples but absent or rare in your "non-trait" control samples. It then uses the SPAdes assembler to reconstruct these phenotype-specific sequences. This targeted approach is significantly faster and more resource-efficient than whole-genome comparison for finding mobile genetic elements like plasmids and phages.

## Installation and Setup

The most reliable way to install PlasmidTron is via Bioconda:

```bash
conda install -c bioconda plasmidtron
```

Alternatively, use the official Docker image:
`docker pull sangerpathogens/plasmidtron`

## Core Usage Pattern

PlasmidTron requires two input text files containing the paths to your FASTQ files (one per line).

1. **Prepare input lists:**
   ```bash
   # traits.txt
   /path/to/sample1_R1.fastq.gz
   /path/to/sample1_R2.fastq.gz
   /path/to/sample2_R1.fastq.gz
   /path/to/sample2_R2.fastq.gz

   # controls.txt
   /path/to/control1_R1.fastq.gz
   /path/to/control1_R2.fastq.gz
   ```

2. **Run the analysis:**
   ```bash
   plasmidtron [options] <output_directory> traits.txt controls.txt
   ```

## Command Line Options and Best Practices

### K-mer Selection (`--kmer`, `-k`)
The default k-mer size is 51. 
- For shorter reads (e.g., 75bp), consider lowering this to 33 or 41.
- For longer Illumina reads (150bp+), the default 51 or higher (up to 71) often provides better resolution for repetitive regions.

### Filtering Logic (`--action`, `-a`)
- **union (Default):** Captures k-mers found in *any* of the trait samples that are not in the controls. Use this when the phenotype might be caused by different plasmids across your case group.
- **intersection:** Only captures k-mers found in *all* trait samples. Use this for highly conserved traits where you expect the exact same plasmid to be present in every case.

### Assembly Tuning
- **`--min_contig_len` (-l):** Default is 300bp. Increase this (e.g., 500 or 1000) if you are getting too many small, fragmented contigs.
- **`--min_spades_contig_coverage` (-c):** Default is 5. If your data has high depth, increase this to filter out low-frequency assembly artifacts.
- **`--max_spades_contig_coverage` (-e):** Default is 500. Useful for filtering out extremely high-coverage k-mers that might represent chromosomal repeats rather than plasmids.

### Resource Management
- **RAM:** SPAdes is the primary memory consumer. While PlasmidTron usually requires <1GB, poor quality data can spike usage to 4GB+. 
- **Pre-processing:** Always run `Trimmomatic` or `fastp` on your reads before using PlasmidTron to reduce noise and memory consumption.
- **Threads:** Use `--threads` (-t) to speed up the KMC k-mer counting and SPAdes assembly phases.

## Expert Tips

- **Phage Discovery:** Although named "PlasmidTron," the tool is equally effective at pulling out prophages or lytic phages that differ between sample sets.
- **Intermediate Files:** Use `--keep_files` (-f) if you need to debug the assembly process or inspect the raw k-mer counts. By default, these are deleted to save space.
- **Visualizing K-mers:** Use `--plot_filename` (-p) to generate a k-mer distribution plot, which helps in verifying if the k-mer thresholds (`--min_kmers_threshold`) are appropriate for your sequencing depth.

## Reference documentation
- [PlasmidTron GitHub Repository](./references/github_com_sanger-pathogens_plasmidtron.md)
- [Bioconda PlasmidTron Package](./references/anaconda_org_channels_bioconda_packages_plasmidtron_overview.md)