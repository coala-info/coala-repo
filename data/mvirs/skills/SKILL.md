---
name: mvirs
description: mVIRs identifies the genomic coordinates of inducible prophages by detecting structural evidence such as outward-oriented paired-end reads and soft-clipped alignments in NGS data. Use when user asks to locate active prophage regions, identify inducible viral elements, or extract circularized viral sequences from a host genome.
homepage: https://github.com/SushiLab/mVIRs
metadata:
  docker_image: "quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0"
---

# mvirs

## Overview

mVIRs (inducible VIRuses) is a specialized bioinformatics tool designed to pinpoint the exact genomic coordinates of prophages that have been induced into a circular or concatenated form. Unlike tools that rely solely on sequence composition, mVIRs identifies structural evidence of induction by detecting Outward-Oriented paired-end Reads (OPRs) and soft-clipped alignments. This makes it particularly effective for identifying active, inducible viral elements within a lysogenic host's NGS data.

## Core Workflow

The mVIRs workflow consists of two primary stages: indexing the reference genome and performing the alignment-based prophage detection.

### 1. Reference Indexing
Before running the analysis, you must generate a BWA index for your host reference genome.

```bash
mvirs index -f reference.fasta
```

### 2. Prophage Localization (oprs)
The `oprs` command performs the alignment and identifies potential prophage regions based on OPR coverage and clipped read positions.

```bash
mvirs oprs -f forward_reads.fq.gz -r reverse_reads.fq.gz -db reference.fasta -o output_prefix
```

**Key Parameters:**
- `-ml`: Minimum sequence length for extraction (default: 4000 bp).
- `-ML`: Maximum sequence length for extraction (default: 800,000 bp).
- `-m`: Flag to allow reporting of full contigs if OPRs/clipped reads are found at the very ends of the sequence.
- `-t`: Number of threads for BWA alignment.

## Output Files

The tool generates several files using the specified `-o` prefix:
- `.fasta`: The extracted sequences of potential prophage regions.
- `.oprs`: Tab-separated file containing the positions of outward-oriented reads.
- `.clipped`: Tab-separated file containing soft-clipped alignment positions.
- `.bam`: The raw alignment file used for the analysis.

## Expert Tips and Best Practices

- **Input Quality**: Ensure your input is paired-end data. The tool's logic specifically relies on the orientation and distance of read pairs to identify circularized DNA.
- **Downstream Validation**: mVIRs provides the genomic segments, but it is best practice to pipe the resulting `.fasta` output into viral prediction tools like VirSorter2, VIBRANT, or CheckV to confirm the viral nature and quality of the extracted segments.
- **Reference Selection**: Use the most complete version of the host genome available. If the prophage is split across contigs in a highly fragmented assembly, use the `-m` flag to ensure these terminal regions are captured.
- **Testing**: If you are unsure about the environment setup or tool behavior, run `mvirs test -o test_results/` to execute a standardized run on a public dataset.



## Subcommands

| Command | Description |
|---------|-------------|
| mvirs | Localisation of inducible prophages using NGS data |
| mvirs | Localisation of inducible prophages using NGS data |
| mvirs | Localisation of inducible prophages using NGS data |
| mvirs index | Localisation of inducible prophages using NGS data |
| mvirs oprs | Localisation of inducible prophages using NGS data |

## Reference documentation

- [mVIRs GitHub README](./references/github_com_SushiLab_mVIRs_blob_clipped_reads_README.md)
- [Conda Environment Specification](./references/github_com_SushiLab_mVIRs_blob_clipped_reads_conda_env_mvirs.yaml.md)