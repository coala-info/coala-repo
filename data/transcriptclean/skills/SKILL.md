---
name: transcriptclean
description: TranscriptClean corrects errors in long-read RNA-seq data by comparing mapped reads to a reference genome. Use when user asks to clean long-read RNA-seq data, correct sequencing errors, refine splice junctions, preserve known variants, analyze indels, or filter transcripts.
homepage: https://github.com/mortazavilab/TranscriptClean
metadata:
  docker_image: "biocontainers/transcriptclean:v2.0.2_cv1"
---

# transcriptclean

## Overview

TranscriptClean is a specialized tool for post-alignment processing of long-read RNA-seq data. It addresses the high error rates inherent in technologies like PacBio and Oxford Nanopore by comparing mapped reads against a reference genome. The tool is essential for researchers who need to distinguish between technical sequencing artifacts and true biological variation, particularly around splice sites. It produces "cleaned" SAM and Fasta files suitable for downstream isoform analysis.

## Usage Guidelines

### Basic Command Structure
The core execution requires a SAM file (aligned with a splice-aware aligner) and the corresponding reference genome FASTA.

```bash
transcriptclean --sam transcripts.sam --genome hg38.fa --outprefix output_name
```

### Performance Optimization
*   **Sorting**: Always sort your input SAM file before running TranscriptClean to significantly improve processing speed.
*   **Multithreading**: Use the `-t` or `--threads` flag to utilize multiple CPU cores.
*   **Memory Management**: If working on a cluster, use `--tmpDir` to point to local node storage (e.g., `/scratch`) to reduce I/O overhead.

### Common CLI Patterns

**Variant-Aware Correction**
To prevent the tool from "correcting" known SNPs or mutations back to the reference sequence, provide a VCF file:
```bash
transcriptclean -s input.sam -g genome.fa -v known_variants.vcf -o cleaned_variants
```

**Splice Junction Refinement**
To correct noncanonical splice junctions using high-confidence data (typically derived from Illumina short-reads via STAR), use the `-j` flag:
```bash
transcriptclean -s input.sam -g genome.fa -j SJ.out.tab -o cleaned_sj
```

**Discovery Mode (Dry Run)**
Before committing to a full run, use `--dryRun` to generate an inventory of all indels. This helps in determining appropriate values for `--maxLenIndel` and `--maxSJOffset`.
```bash
transcriptclean -s input.sam -g genome.fa --dryRun
```

### Expert Tips and Constraints
*   **CIGAR Compatibility**: TranscriptClean currently requires SAM files to use the `M` operator in the CIGAR string. It does not support the `X` (mismatch) or `=` (match) operators. If your aligner produces `X/=`, you must convert them to `M` first.
*   **Indel Thresholds**: The default maximum indel size for correction is 5bp. If your data has larger systematic artifacts, increase `--maxLenIndel`.
*   **Filtering Output**: Use `--primaryOnly` to automatically strip unmapped and multi-mapped reads from the final output, and `--canonOnly` to restrict output to transcripts that are either canonical or match your provided splice junction file.
*   **Log Analysis**: Always inspect the `.TE.log` (Transcript Error log) and `.log` files. These provide a per-transcript breakdown of what was corrected and, more importantly, why certain errors were left untouched.

## Reference documentation
- [TranscriptClean Main Repository](./references/github_com_mortazavilab_TranscriptClean.md)
- [TranscriptClean Wiki and Tutorials](./references/github_com_mortazavilab_TranscriptClean_wiki.md)