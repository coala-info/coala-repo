---
name: megapath
description: MegaPath is a high-performance bioinformatics suite designed to detect pathogens in metagenomic samples by filtering host sequences and aligning reads against pathogen databases. Use when user asks to detect pathogens in NGS data, process metagenomic amplicon sequences, filter human or ribosomal background, or perform de novo assembly for protein-level validation.
homepage: https://github.com/edwwlui/MegaPath
---

# megapath

## Overview

MegaPath is a high-performance bioinformatics suite optimized for the detection of pathogens in metagenomic samples. It provides two primary workflows: a standard metagenomic pipeline for general NGS data and a specialized "Amplicon" module for targeted metagenomic data. The tool handles the entire process from raw read filtering (removing human and ribosomal background) to alignment against comprehensive pathogen databases and optional de novo assembly for protein-level validation.

## Core Workflows

### Standard Metagenomic Detection
Use `runMegaPath.sh` for general metagenomic NGS samples. This script performs alignment and filtering to identify viral and bacterial sequences.

```bash
./runMegaPath.sh -1 <read1.fq> -2 <read2.fq> -d <db_dir> [options]
```

**Key Options:**
- `-t`: Number of threads (default: 24).
- `-c`: NT alignment score cutoff (default: 40).
- `-H`: Skip human filtering (use if the sample is known to be non-human or pre-filtered).
- `-S`: Enable ribosome filtering to reduce noise from rRNA.
- `-A`: Perform assembly and protein alignment (increases sensitivity for novel or highly divergent pathogens).

### Metagenomic Amplicon Filtering
Use `runMegaPath-Amplicon.sh` for amplicon-based metagenomic data, which requires higher memory and specific filtering logic.

```bash
./runMegaPath-Amplicon.sh -1 <read1.fq> -2 <read2.fq> -d <db_dir> -L <max_read_length>
```

## Expert Tips and Best Practices

### Database Performance
For batch processing with MegaPath-Amplicon, use the BWA shared memory feature to avoid reloading large indices for every sample.

```bash
# Load indices into memory
bwa shm <db_path>/GCF_000001405.39_GRCh38.p13_genomic.fna.gz
bwa shm <db_path>/Mycobacterium_tuberculosis_H37Rv_genome_v3.fasta

# Run your samples...

# Unload indices when finished
bwa shm -d
```

### Working with LSAM Format
MegaPath uses an internal format called LSAM (Annotated FASTQ). You can manipulate these files using the provided Perl utilities:

- **Extracting Reads**: Use `extractFromLSAM.pl` to pull specific sequences (e.g., viral reads) from the annotated output.
  ```bash
  perl extractFromLSAM.pl -v in.lsam.id > viral_reads.fq
  ```
- **Cleaning Results**: Use `cleanup.pl` to filter out contaminant taxonomy IDs or homologous sequences.
  ```bash
  perl cleanup.pl -c 9606,32630 in.lsam.id > cleaned.lsam.id
  ```

### Hardware Considerations
- **Standard MegaPath**: Requires ~100GB RAM and 250GB storage.
- **MegaPath-Amplicon**: Requires ~400GB RAM and 450GB storage. Ensure the environment has sufficient swap or physical memory before initiating amplicon runs.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/runMegaPath-Amplicon.sh | Run MegaPath for amplicon sequencing. |
| /usr/local/bin/runMegaPath.sh | Runs the MegaPath pipeline for sequence analysis. |
| bwa | alignment via Burrows-Wheeler transformation |

## Reference documentation
- [MegaPath README](./references/github_com_HKU-BAL_MegaPath_blob_master_README.md)
- [LSAM Format Guide](./references/github_com_HKU-BAL_MegaPath_blob_master_README_LSAM.md)
- [Extraction Utility](./references/github_com_HKU-BAL_MegaPath_blob_master_extractFromLSAM.pl.md)