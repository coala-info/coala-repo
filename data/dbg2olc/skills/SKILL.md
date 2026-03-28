---
name: dbg2olc
description: DBG2OLC is a hybrid assembly framework that combines short-read contigs with long, noisy reads to efficiently assemble large genomes. Use when user asks to perform hybrid genome assembly, bridge short-read and long-read sequencing data, or generate a consensus backbone from de Bruijn graph contigs and long reads.
homepage: https://github.com/yechengxi/DBG2OLC
---

# dbg2olc

## Overview
DBG2OLC (De Bruijn Graph to Overlap-Layout-Consensus) is a hybrid assembly framework that bridges the gap between short-read and long-read sequencing technologies. Instead of using raw short reads directly, it utilizes pre-assembled contigs from a de Bruijn Graph (DBG) assembler as "anchors" to organize and layout long, noisy reads. This approach significantly reduces the computational complexity and time required for large genome assemblies compared to pure long-read OLC methods.

## Core Workflow

### Step 1: Generate Initial Contigs
Before running DBG2OLC, you must generate accurate, raw contigs using a DBG assembler like `SparseAssembler`.
**Critical:** Do not use gap-closing or scaffolding features in the DBG step, as heuristics can introduce errors that propagate through the hybrid pipeline.

```bash
# Example using SparseAssembler
./SparseAssembler k 51 g 15 NodeCovTh 1 EdgeCovTh 0 GS 12000000 f short_reads.fastq
```

### Step 2: Overlap and Layout (DBG2OLC)
Feed the resulting `Contigs.txt` and your long reads into DBG2OLC.

```bash
./DBG2OLC k 17 AdaptiveTh 0.0001 KmerCovTh 2 MinOverlap 20 RemoveChimera 1 Contigs Contigs.txt f long_reads.fasta
```

### Step 3: Consensus Calling
The output `backbone_raw.fasta` requires consensus polishing. Use tools like `Sparc` or `pbdagcon` along with `blasr` to generate the final assembly.

## Parameter Tuning Guide

The quality of the assembly (N50) is highly sensitive to three primary parameters:

| Parameter | Description | Suggested Range (10x-20x) | Suggested Range (50x-100x) |
| :--- | :--- | :--- | :--- |
| `KmerCovTh` | Fixed k-mer matching threshold for anchors. | 2 - 5 | 2 - 10 |
| `MinOverlap` | Minimum overlap score between long read pairs. | 10 - 30 | 50 - 150 |
| `AdaptiveTh` | Adaptive matching threshold (M < AdaptiveTh * Length). | 0.001 - 0.01 | 0.01 - 0.02 |

### Expert Tips
- **K-mer Size (`k`)**: A value of 17 is generally optimal for most datasets.
- **Chimeras**: Always set `RemoveChimera 1` if your long-read coverage is >10x.
- **High Coverage (>100x)**: Increase `ChimeraTh` and `ContigTh` to 2 to apply more stringent filtering during multiple alignment.
- **Iterative Loading**: Use `LD 1` to load previously computed compressed/anchored reads to save time while fine-tuning parameters.

## Common CLI Patterns

**For Low Coverage PacBio (10x-20x):**
```bash
./DBG2OLC k 17 AdaptiveTh 0.001 KmerCovTh 2 MinOverlap 20 RemoveChimera 1 Contigs Contigs.txt f reads.fasta
```

**For High Coverage PacBio (50x+):**
```bash
./DBG2OLC k 17 AdaptiveTh 0.01 KmerCovTh 5 MinOverlap 100 RemoveChimera 1 ChimeraTh 2 ContigTh 2 Contigs Contigs.txt f reads.fasta
```



## Subcommands

| Command | Description |
|---------|-------------|
| DBG2OLC | DBG2OLC is a tool for correcting long reads using a de Bruijn graph. |
| Sparc | dbg2olc_Sparc tool for generating consensus sequences. |
| dbg2olc_SelectLongestReads | Selects the longest reads from a FASTA/FASTQ file based on total length. |
| dbg2olc_SparseAssembler | Sparse assembler for long reads. |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_yechengxi_DBG2OLC.md)
- [Anaconda Bioconda Package](./references/anaconda_org_channels_bioconda_packages_dbg2olc_overview.md)