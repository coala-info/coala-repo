---
name: fgbio-minimal
description: fgbio-minimal provides core Java-based utilities for processing read-level sequencing data and managing molecular barcodes. Use when user asks to extract UMIs, group reads by molecular coordinates, call consensus reads, or manipulate BAM files for high-fidelity sequencing workflows.
homepage: https://github.com/fulcrumgenomics/fgbio
---


# fgbio-minimal

## Overview
fgbio-minimal is a streamlined version of the Fulcrum Genomics bioinformatics toolkit, providing the core Java-based utilities for read-level data processing. It is the primary toolset for workflows involving molecular barcodes, enabling the transformation of raw, error-prone sequencing data into high-fidelity consensus reads. This skill provides guidance on executing UMI extraction, read grouping, and consensus calling workflows using the native command-line interface.

## Core Workflows and CLI Patterns

### 1. UMI Extraction and BAM Conversion
The first step in most fgbio workflows is converting FASTQ data to an unmapped BAM (uBAM) while extracting UMI sequences.

**Pattern: FastqToBam**
```bash
fgbio FastqToBam \
    --input r1.fq.gz r2.fq.gz \
    --read-structures 5M142T 5M142T \
    --sample SampleA \
    --library Lib1 \
    --output unmapped.bam
```
*   **Expert Tip**: The `--read-structures` argument is critical. `M` denotes UMI bases, `T` denotes template bases, and `S` denotes skipped bases. In the example above, the first 5 bases of both R1 and R2 are treated as UMIs.

### 2. UMI Grouping
After alignment (and typically using `ZipperBams` to merge tags), reads must be grouped by their molecular coordinates and UMI sequence.

**Pattern: GroupReadsByUmi**
```bash
fgbio GroupReadsByUmi \
    --input aligned.bam \
    --output grouped.bam \
    --strategy adjacency \
    --edits 1 \
    --family-size-histogram counts.txt
```
*   **Strategies**: 
    *   `identity`: UMIs must match exactly.
    *   `adjacency`: Allows for errors in UMIs (defined by `--edits`).
    *   `paired`: Uses both ends of a pair to increase grouping confidence.

### 3. Consensus Calling
Generate high-accuracy consensus reads from grouped families.

**Pattern: CallMolecularConsensusReads**
```bash
fgbio CallMolecularConsensusReads \
    --input grouped.bam \
    --output consensus.unmapped.bam \
    --min-reads 1 \
    --min-input-base-quality 20
```
*   **Duplex Sequencing**: For duplex libraries, use `CallDuplexConsensusReads` to combine information from both strands of the original DNA molecule, significantly reducing the false-positive rate.

### 4. BAM Manipulation and Filtering
fgbio provides several utilities for refining BAM files that are often more performant or specific than general-purpose tools.

*   **ClipBam**: Use to hard or soft clip reads, often used to remove adapter sequences or technical sequences at the ends of reads.
*   **FilterBam**: Filter reads based on alignment quality, mapq, or specific tags.
*   **SortBam**: A memory-efficient sorter specifically optimized for the fgbio ecosystem.

### 5. Metadata and Contig Management
When working with data from different sources (e.g., NCBI vs. UCSC), use the `Update...ContigNames` suite.

```bash
fgbio UpdateVcfContigNames \
    --input input.vcf \
    --output output.vcf \
    --assembly-report GCF_000001405.39.txt
```

## Best Practices
*   **Memory Management**: Since fgbio is Java-based, ensure you provide enough heap space for large BAM files using `java -Xmx8g -jar fgbio.jar ...` if not using the bioconda wrapper.
*   **Pipe Efficiency**: Many fgbio tools support streaming. Use `/dev/stdin` and `/dev/stdout` to chain commands and avoid unnecessary disk I/O.
*   **Validation**: Always run `ValidateSamFile` (from Picard, often bundled in genomic environments) on fgbio outputs if you encounter downstream tool failures, as fgbio strictly adheres to SAM specifications.

## Reference documentation
- [fgbio Main Repository and Tool List](./references/github_com_fulcrumgenomics_fgbio.md)
- [fgbio Wiki and Detailed Guides](./references/github_com_fulcrumgenomics_fgbio_wiki.md)
- [fgbio-minimal Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fgbio-minimal_overview.md)