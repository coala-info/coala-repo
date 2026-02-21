---
name: wtdbg
description: The `wtdbg2` toolset (also known as Redbean) is designed for rapid de novo assembly of long, noisy genomic reads.
homepage: https://github.com/ruanjue/wtdbg-1.2.8
---

# wtdbg

## Overview
The `wtdbg2` toolset (also known as Redbean) is designed for rapid de novo assembly of long, noisy genomic reads. Unlike traditional OLC (Overlap-Layout-Consensus) or De Bruijn graph assemblers, it uses a fuzzy Bruijn graph that permits mismatches and gaps, making it exceptionally fast for large genomes (e.g., Human or Axolotl). The workflow typically involves two primary steps: generating a contig layout with `wtdbg2` and deriving a consensus sequence with `wtpoa-cns`.

## Core Workflow

### 1. Assembly (wtdbg2)
The first step generates the assembly graph and layout. You must specify the genome size (`-g`) and the sequencing technology (`-x`).

```bash
# Basic assembly command
wtdbg2 -x <tech> -g <size> -t <threads> -i <reads.fa.gz> -fo <prefix>
```

**Technology Presets (`-x`):**
- `rs`: PacBio RSII (Recommended: add `-L 5000` for better results)
- `sq`: PacBio Sequel
- `ccs`: PacBio CCS (HiFi) reads
- `ont`: Oxford Nanopore

### 2. Consensus (wtpoa-cns)
The assembler produces a `.ctg.lay.gz` file. Use the consensus tool to generate the final FASTA.

```bash
wtpoa-cns -t <threads> -i <prefix>.ctg.lay.gz -fo <prefix>.ctg.fa
```

## Advanced Usage & Optimization

### Parameter Tuning for Low Coverage
If the default settings produce a fragmented assembly, adjust the following:
- **K-mer Sampling (`-S`):** Default is 4 (samples 1/4 of k-mers). Decrease to `2` or `1` to increase sensitivity for low coverage, though this significantly increases memory usage.
- **Edge Coverage (`-e`):** Default is 3. For very low coverage data, reduce this to `2`.
- **Alignment Sensitivity (`-A`):** Enable this flag to improve assembly in low-coverage regions at the cost of speed.

### Polishing the Assembly
While `wtpoa-cns` provides an initial consensus, accuracy can be improved by re-mapping reads:

1. **Long-read polishing:**
   ```bash
   minimap2 -t 16 -ax map-pb -r2k <raw.fa> <reads.fa.gz> | samtools sort -@4 > <mapped.bam>
   samtools view -F0x900 <mapped.bam> | wtpoa-cns -t 16 -d <raw.fa> -i - -fo <polished.fa>
   ```

2. **Short-read polishing (Illumina):**
   Use `bwa mem` to align short reads to the long-read consensus, then pipe the SAM output into `wtpoa-cns` using `-x sam-sr`.

## Expert Tips & Limitations
- **Input Order:** If mixing FASTQ and FASTA files, always list FASTQ files first in the command line.
- **Memory Requirements:** For a human genome (~3Gb), expect to need ~220GB of RAM.
- **Nanopore Caution:** Assemblies for ONT data may occasionally be smaller than the actual genome size; verify completeness with BUSCO or similar tools.
- **Speed:** `wtdbg2` is significantly faster than Canu or Falcon; it is the preferred choice when computational time or resources are limited for large-scale assemblies.

## Reference documentation
- [Wtdbg2 GitHub Repository](./references/github_com_ruanjue_wtdbg2.md)