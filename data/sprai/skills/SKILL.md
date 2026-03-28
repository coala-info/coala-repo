---
name: sprai
description: "Sprai corrects high error rates in PacBio single-pass reads to improve the continuity of de novo assemblies. Use when user asks to correct PacBio sequencing errors, perform de novo assembly of long reads, or generate consensus sequences for improved assembly contiguity."
homepage: http://zombie.cb.k.u-tokyo.ac.jp/sprai/
---

# sprai

## Overview
Sprai is a specialized tool designed to correct the high error rates (typically ~15%) found in PacBio single-pass reads. Unlike tools that prioritize absolute per-read accuracy, Sprai focuses on improving the continuity of de novo assemblies. It functions by generating multiple alignments and consensus sequences, leveraging the random nature of PacBio sequencing errors. The workflow typically involves error correction followed by assembly via the Celera Assembler (wgs-assembler).

## Core Workflow

### 1. Data Preparation
Sprai requires **subreads** in FASTQ format. Raw reads containing adapters must be processed first.
- Combine all input FASTQ files: `cat *.fastq > all.fq`
- Ensure you have `ec.spec` (Sprai parameters) and `pbasm.spec` (Celera Assembler parameters) in your working directory.

### 2. Configuration (ec.spec)
Key parameters to set in `ec.spec`:
- `input_fastq`: Path to your combined FASTQ file.
- `estimated_genome_size`: Target genome size (use `1e12` if unknown).
- `estimated_depth`: Coverage depth (use `0` if unknown).
- `partition`: Number of CPU cores to utilize.
- `ca_path`: Full path to the Celera Assembler `bin` directory.

### 3. Execution Modes

**Standard Pipeline (Correction + Assembly):**
Runs the full pipeline on a single node using multiple cores.
```bash
ezez_vx1.pl ec.spec pbasm.spec > log.txt 2>&1 &
```

**Error Correction Only:**
Use this if you plan to use a different assembler (e.g., Canu, Flye) after correction.
```bash
ezez_vx1.pl ec.spec -ec_only > log.txt 2>&1 &
```

**Restartable Make Mode:**
Recommended for long-running jobs to allow resuming from failures.
```bash
ezez4makefile_v4.pl ec.spec pbasm.spec
make -j <threads> -f Makefile > log.txt 2>&1 &
```

**Cluster Mode (SGE/UGE):**
Submits jobs to a grid engine.
```bash
ezez4qsub_vx1.pl ec.spec pbasm.spec > log.txt 2>&1 &
```

## Expert Tips & Best Practices
- **High Core Counts:** If using >1000 processors, use the `pre_partition` parameter in `ec.spec` to manage job distribution effectively.
- **Output Files:** 
  - Corrected reads: `c01.fin.idfq.gz`
  - Assembled contigs: `CA/9-terminator/asm.ctg.fasta`
- **Memory Management:** For large genomes (>400Mbp), you can often achieve high-quality results with 30x-40x coverage. Depths above 200x rarely provide additional benefits and increase computational load.
- **Hybrid Assembly:** Sprai does not support Illumina reads directly. To perform hybrid assembly, correct the PacBio reads with Sprai first, then feed the output `idfq.gz` file into an assembler that supports mixed technologies.



## Subcommands

| Command | Description |
|---------|-------------|
| check_circurarity.pl | Check for circularity in a FASTA assembly. |
| runCA | CA formatted fragment file |
| sprai_ezez4qsub_vx1.pl | Error correction and assembly pipeline |
| sprai_ezez_vx1.pl | Error correction and assembly tool |

## Reference documentation
- [Sprai README](./references/kasahara-lab_github_io_sprai_doc_README.html.md)
- [Sprai Example Workflow](./references/kasahara-lab_github_io_sprai_doc_Example.html.md)
- [Sprai FAQ](./references/kasahara-lab_github_io_sprai_doc_FAQ.html.md)