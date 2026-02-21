---
name: megapath
description: MegaPath is a high-performance bioinformatics pipeline designed for the rapid and sensitive identification of pathogens within metagenomic Next-Generation Sequencing (NGS) datasets.
homepage: https://github.com/edwwlui/MegaPath
---

# megapath

## Overview
MegaPath is a high-performance bioinformatics pipeline designed for the rapid and sensitive identification of pathogens within metagenomic Next-Generation Sequencing (NGS) datasets. It provides two distinct workflows: the standard MegaPath pipeline for general metagenomic samples and MegaPath-Amplicon for specialized filtering of amplicon-based data. The tool is optimized for clinical and environmental surveillance where detecting low-abundance viral or bacterial agents is critical.

## Resource Requirements
MegaPath is resource-intensive. Ensure the environment meets these minimum specifications:
- **MegaPath (Standard):** 100GB RAM, 250GB Storage.
- **MegaPath-Amplicon:** 400GB RAM, 450GB Storage.

## Database Setup
Before running the pipeline, you must download and extract the pre-built databases.
```bash
# Navigate to the MegaPath directory
cd ${MEGAPATH_DIR}

# Download and extract MegaPath standard database
wget -c http://www.bio8.cs.hku.hk/dataset/MegaPath/MegaPath_db.v1.0.tar.gz
tar -xvzf MegaPath_db.v1.0.tar.gz

# Download and extract MegaPath-Amplicon database
wget -c http://www.bio8.cs.hku.hk/dataset/MegaPath/MegaPath-Amplicon_db.v1.0.tar.gz
tar -xvzf MegaPath-Amplicon_db.v1.0.tar.gz
```

## Core CLI Usage

### Standard Pathogen Detection
Use `runMegaPath.sh` for general metagenomic NGS data.
```bash
./runMegaPath.sh -1 read1.fq -2 read2.fq -d /path/to/db -p output_prefix -t 24
```
**Key Options:**
- `-S`: Enable ribosome filtering (recommended for high-host samples).
- `-H`: Skip human filtering (use if host is non-human or reads are pre-filtered).
- `-A`: Perform assembly and protein alignment (increases sensitivity for novel or divergent pathogens).
- `-c [int]`: NT alignment score cutoff (default: 40).

### Amplicon Filtering
Use `runMegaPath-Amplicon.sh` for targeted amplicon datasets.
```bash
./runMegaPath-Amplicon.sh -1 read1.fq -2 read2.fq -d /path/to/db/amplicon -p output_prefix -L 250
```
**Key Options:**
- `-L [int]`: Maximum read length (default: 250 for amplicon).

## Expert Tips and Best Practices

### Batch Processing Optimization
For `MegaPath-Amplicon`, you can significantly speed up batch runs by loading BWA indices into shared memory.
```bash
# Load indices into memory
bwa shm ${DB_PATH}/GCF_000001405.39_GRCh38.p13_genomic.fna.gz &
bwa shm ${DB_PATH}/Mycobacterium_tuberculosis_H37Rv_genome_v3.fasta &

# Run your batch of samples...

# Unload indices when finished
bwa shm -d
```

### Sensitivity Tuning
- If you suspect low-viral load, always use the `-A` flag to trigger `MEGahit` assembly. Assembled contigs often provide better alignment hits than short raw reads.
- Adjust the `-s` (spike filter stdev) and `-o` (spike overlap) parameters if you encounter issues with artificial "spikes" in coverage depth affecting classification.

### Environment Management
If using the Bioconda installation, ensure the `mp` environment is active and the `${CONDA_PREFIX}` variable is correctly set to locate the bundled scripts and default database paths.

## Reference documentation
- [MegaPath GitHub Repository](./references/github_com_HKU-BAL_MegaPath.md)