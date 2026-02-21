---
name: mapcaller
description: MapCaller is a high-performance tool that integrates NGS short-read alignment with variant identification.
homepage: https://github.com/hsinnan75/MapCaller
---

# mapcaller

## Overview
MapCaller is a high-performance tool that integrates NGS short-read alignment with variant identification. Unlike traditional workflows that separate mapping (e.g., BWA) from calling (e.g., GATK), MapCaller collects alignment information, position frequency matrices, and breakpoint data during the mapping phase to deduce variants. It supports germline and somatic mutation detection, interleaved or separate paired-end reads, and produces standard VCF and BAM outputs.

## Core Workflows

### 1. Reference Indexing
Before mapping, you must index the reference genome.
```bash
MapCaller index reference.fa index_prefix
```

### 2. Standard Variant Calling
For paired-end reads in separate files:
```bash
MapCaller -i index_prefix -f reads_1.fq -f2 reads_2.fq -vcf output.vcf -bam output.bam
```

For interleaved paired-end reads:
```bash
MapCaller -i index_prefix -f interleaved_reads.fq -p -vcf output.vcf
```

### 3. One-Step Execution (Temporary Index)
If you do not want to maintain index files, you can build a temporary index from the FASTA file directly:
```bash
MapCaller -r reference.fa -f reads_1.fq -f2 reads_2.fq -vcf output.vcf
```

## Parameter Optimization

| Task | Parameter | Recommendation |
| :--- | :--- | :--- |
| **Performance** | `-t INT` | Set to available CPU cores (default is 16). |
| **Somatic Calling** | `-somatic` | Enable when comparing tumor/normal or looking for low-frequency variants. |
| **Ploidy** | `-ploidy INT` | Adjust for non-diploid organisms (default is 2). |
| **PCR Duplicates** | `-dup INT` | Maximum allowed PCR duplicates (default 5). Increase for high-amplification libraries. |
| **Sensitivity** | `-ad INT` | Minimal ALT allele count to trigger a call (default 3). Lower for very low coverage. |
| **GVCF Output** | `-gvcf` | Use for cohort-level merging later. |

## Expert Tips
- **Memory Management**: MapCaller is efficient, but indexing large genomes (like human) requires significant RAM. Ensure your environment has at least 16-32GB for mammalian genomes.
- **Algorithm Selection**: Use `-alg ksw2` for potentially better gapped alignments in complex regions, though the default `nw` (Needleman-Wunsch) is robust for standard short reads.
- **Input Formatting**: Ensure FASTA headers in your reference do not contain complex characters. For FASTA reads, sequences must be on a single line (no wrapping).
- **Quality Scores**: MapCaller focuses on the alignment matrix and breakpoints; it does not heavily weight FASTQ quality scores for the calling algorithm.

## Reference documentation
- [MapCaller GitHub Repository](./references/github_com_hsinnan75_MapCaller.md)
- [Bioconda MapCaller Overview](./references/anaconda_org_channels_bioconda_packages_mapcaller_overview.md)