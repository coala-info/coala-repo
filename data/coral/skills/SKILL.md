---
name: coral
description: Coral bridges the gap between paired-end RNA-seq mates to infer the full alignment of the intervening sequence. Use when user asks to bridge paired-end reads, resolve full fragment structures, or improve transcript assembly accuracy using coordinate-sorted BAM files.
homepage: https://github.com/Shao-Group/coral
---


# coral

## Overview
The `coral` skill (implementing the `rnabridge-align` tool) provides a specialized workflow for bridging the gap between paired-end RNA-seq mates. While standard aligners map the two ends of a fragment independently, `coral` uses an efficient algorithm to infer the most likely alignment of the entire intervening sequence. This process improves the accuracy of downstream transcript assembly and quantification by resolving the full fragment structure, including splice junctions, based on both the read alignments and optional reference transcriptomes.

## Installation and Setup
The tool is available via Bioconda. Ensure dependencies like `htslib` and `Boost` are available if compiling from source.

```bash
# Installation via Conda
conda install bioconda::coral
```

## Core Workflow
The primary executable is `rnabridge-align`. The tool requires a coordinate-sorted BAM file as input.

### 1. Prepare Input
Ensure your BAM file is sorted by coordinate. If it is not, use `samtools`:
```bash
samtools sort input.bam > input.sort.bam
```

### 2. Basic Execution
Run the bridging algorithm by specifying the input and output BAM files:
```bash
rnabridge-align -i input.sort.bam -o output_bridged.bam
```

### 3. Using a Reference Transcriptome
To significantly improve bridging accuracy, especially in complex splicing regions, provide a reference GTF:
```bash
rnabridge-align -i input.sort.bam -r reference.gtf -o output_bridged.bam
```

## Expert Tips and Parameters

### Library Type Selection
Specifying the `--library_type` is highly recommended to ensure correct strand interpretation.
- `unstranded`: Standard non-strand-specific libraries.
- `first`: Equivalent to Illumina `fr-firststrand` (e.g., dUTP method).
- `second`: Equivalent to Illumina `fr-secondstrand`.

If the library type is unknown, use the `--preview` flag to let the tool infer it from the XS tags in the BAM file:
```bash
rnabridge-align -i input.sort.bam --preview
```

### Tuning Bridging Sensitivity
- **Bridging Score**: Adjust `--min_bridging_score` (default 0.5) to control the stringency of fragment reconstruction. Higher values increase confidence but may reduce the number of bridged fragments.
- **Splice Support**: Use `--min_splice_boundary_hits` (default 1) to filter out junctions with low read support.
- **Complexity Management**: If processing reads with extremely complex CIGAR strings, use `--max_num_cigar` (default 1000) to ignore problematic reads that may slow down the algorithm.

### Output Interpretation
The resulting `output.bam` contains the alignments of the entire fragments. This file can be used directly in transcript assemblers or for visualizing full-length fragment evidence in genome browsers like IGV.

## Reference documentation
- [rnabridge-align GitHub Repository](./references/github_com_Shao-Group_rnabridge-align.md)
- [Bioconda Coral Overview](./references/anaconda_org_channels_bioconda_packages_coral_overview.md)