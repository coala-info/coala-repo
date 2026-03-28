---
name: shiver
description: shiver is a bioinformatic pipeline that assembles accurate viral genomes by constructing custom references for each sample from their own contigs. Use when user asks to assemble HIV or other viral genomes, align contigs to a reference set, or map reads to a sample-specific reference for consensus calling.
homepage: https://github.com/ChrisHIV/shiver
---


# shiver

## Overview

shiver (Sequences from HIV Easily Reconstructed) is a bioinformatic pipeline designed to assemble viral genomes with high accuracy. Unlike standard mapping approaches that use a single global reference, shiver constructs a custom reference for every sample using the sample's own contigs. This process significantly reduces the biased loss of information that occurs when a sample differs substantially from a standard reference. While optimized for HIV-1, the tool is functionally agnostic and can be applied to other viruses.

## Core Workflow

The shiver pipeline consists of three primary stages. All commands require a configuration file (typically `config.sh`) to define parameters and dependency paths.

### 1. Initialization
Before processing samples, you must initialize a directory with the necessary reference data. This is a one-off command for a specific study or virus type.

```bash
shiver_init.sh <init_dir> <config_file> <reference_alignment.fasta> <adapters.fasta> <primers.fasta>
```
*   **Reference Alignment**: A curated alignment (e.g., LANL HIV-1 compendium) encompassing the expected diversity.
*   **Adapters/Primers**: Sequences specific to your library preparation and sequencing protocol.

### 2. Contig Alignment and Correction
This step takes de novo assembled contigs, identifies viral sequences, removes contamination, and aligns them to the reference set.

```bash
shiver_align_contigs.sh <init_dir> <config_file> <sample_contigs.fasta> <output_id>
```
*   **Output**: Produces `<output_id>_cut_wRefs.fasta`, which contains corrected contigs aligned to the references.
*   **Tip**: Inspect this alignment manually if the virus is highly recombinant or the automated alignment appears fragmented.

### 3. Read Mapping and Consensus Calling
The final stage builds a mapping reference tailored to the sample, pre-processes the raw reads (trimming/cleaning), maps them, and calls the consensus.

```bash
shiver_map_reads.sh <init_dir> <config_file> <sample_contigs.fasta> <output_id> \
    <blast_file> <alignment_from_step2.fasta> <reads_1.fastq> <reads_2.fastq>
```

## Expert Tips and Best Practices

### Configuration Management
The `config.sh` file is the central hub for pipeline behavior. Key variables to monitor include:
*   `MinContigLength`: Default is 300. Contigs shorter than this are discarded.
*   `TrimToKnownGenome`: Set to `true` to trim contig overhangs that extend beyond the known reference alignment.
*   `CleanReads`: Set to `true` to remove potential contaminant read pairs.
*   `Mapper`: Choose between `smalt` (default), `bwa`, or `bowtie2`.

### Handling Dependencies
shiver relies on several external tools. Ensure the following are in your `$PATH` or explicitly defined in `config.sh`:
*   **Alignment**: `mafft`
*   **Search**: `blastn` (version >= 2.2.28 is required for proper contig correction)
*   **Processing**: `samtools`, `biopython`
*   **Trimming**: `trimmomatic` (for quality/adapters) and `fastaq` (for primers)

### Input Requirements
*   **Contigs**: You must provide contigs already assembled from your reads (e.g., using SPAdes or Velvet). shiver does not perform the initial de novo assembly itself.
*   **Virus Diversity**: Ensure your initial reference alignment (`shiver_init.sh`) is comprehensive. If a sample is a rare subtype not present in your reference set, the custom reference construction may be suboptimal.



## Subcommands

| Command | Description |
|---------|-------------|
| shiver_shiver_align_contigs.sh | Aligns contigs to references based on blast hits. In normal usage this script requires 4 arguments: the initialisation directory, the configuration file, a fasta file of contigs, and a sample ID for naming output. Alternatively, it can be called with '--test' and a configuration file to test the configuration. |
| shiver_shiver_init.sh | Initialises shiver files. |
| shiver_shiver_map_reads.sh | Maps reads to contigs, potentially using reference alignments. |

## Reference documentation
- [shiver GitHub README](./references/github_com_ChrisHIV_shiver_blob_master_README.md)
- [shiver Configuration Guide](./references/github_com_ChrisHIV_shiver_blob_master_bin_config.sh.md)
- [Installation and Dependencies](./references/github_com_ChrisHIV_shiver_blob_master_docs_InstallationNotes.sh.md)