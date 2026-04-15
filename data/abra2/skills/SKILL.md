---
name: abra2
description: ABRA2 is a localized assembly-based realigner that improves the accuracy of sequence alignments around insertions and deletions. Use when user asks to perform DNA or RNA realignment, improve indel alignment accuracy, or re-assemble reads in specific genomic regions.
homepage: https://github.com/mozack/abra2
metadata:
  docker_image: "quay.io/biocontainers/abra2:2.24--hdcf5f25_3"
---

# abra2

## Overview

ABRA2 is a localized assembly-based realigner that improves the accuracy of sequence alignments, particularly around insertions and deletions (indels). It functions by re-assembling reads in specific genomic regions to find the most parsimonious alignment, which often corrects errors made by general-purpose aligners like BWA or STAR. This skill provides the necessary command-line patterns and operational requirements to execute ABRA2 for DNA and RNA workflows.

## Operational Requirements

*   **Java Version**: Requires Java 8.
*   **Input Format**: Input BAM files must be coordinate-sorted and indexed.
*   **Memory**: High memory allocation is recommended (e.g., `-Xmx16G` or higher for human genomes).
*   **Temporary Space**: The `--tmpdir` must have sufficient space, typically at least equal to the size of the input BAM files.

## Common CLI Patterns

### DNA Realignment (Tumor/Normal Pair)
For DNA, ABRA2 can process multiple BAMs simultaneously, which is ideal for maintaining consistency across tumor and normal samples.

```bash
java -Xmx16G -jar abra2.jar \
  --in normal.bam,tumor.bam \
  --out normal.abra.bam,tumor.abra.bam \
  --ref reference.fa \
  --threads 8 \
  --targets targets.bed \
  --tmpdir /path/to/large/tmp
```

### RNA Realignment
ABRA2 utilizes junction information to assist in assembly. It is optimized for STAR output.

```bash
java -Xmx16G -jar abra2.jar \
  --in star.bam \
  --out star.abra.bam \
  --ref reference.fa \
  --junctions bam \
  --gtf annotations.gtf \
  --threads 8 \
  --dist 500000 \
  --sua \
  --tmpdir /path/to/large/tmp
```

## Expert Tips and Best Practices

*   **Targeted Realignment**: While the `--targets` argument is optional, providing a BED file of specific regions (e.g., exome targets or known problematic loci) significantly improves processing speed.
*   **Splice Junction Handling**: In RNA mode, using `--junctions bam` allows ABRA2 to identify junctions on the fly. For higher precision, you can provide a specific junction file (like STAR's `SJ.out.tab`).
*   **Known Indels**: Use `--in-vcf` to provide known indels to the realigner. However, do **not** use large, non-specific datasets like dbSNP, as this can degrade performance and accuracy. Use sample-specific or high-confidence indel sets.
*   **BWA Recommendation**: While ABRA2 is aligner-agnostic for DNA, using BWA for the initial alignment is the recommended upstream workflow.
*   **Output Sorting**: ABRA2 produces coordinate-sorted BAM files by default, so additional sorting steps are usually unnecessary before downstream variant calling.
*   **Single-end Unmapped Anchor (SUA)**: When processing RNA, the `--sua` flag is often beneficial for utilizing unmapped reads that may anchor to a localized assembly.

## Reference documentation

- [ABRA2 GitHub Repository](./references/github_com_mozack_abra2.md)
- [ABRA2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_abra2_overview.md)