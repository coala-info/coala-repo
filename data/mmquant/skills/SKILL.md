---
name: mmquant
description: mmquant is a read counting tool that resolves multi-mapping ambiguities by grouping overlapping genomic features into meta-features. Use when user asks to count transcriptomic reads, handle multi-mapping or ambiguous reads, and quantify gene expression.
homepage: https://bitbucket.org/mzytnicki/multi-mapping-counter/
---


# mmquant

## Overview

mmquant is a specialized read counting tool that addresses the "multi-mapping" problem in transcriptomics. Unlike standard counters that often discard reads mapping to multiple genomic locations or overlapping multiple genes, mmquant uses a merging strategy. It groups overlapping features that share reads into "meta-features," ensuring that every read is accounted for without over-counting or losing data from ambiguous mappings. This makes it particularly effective for quantifying expression in complex loci or organisms with many paralogs.

## Usage Patterns

### Basic Quantification
The most common use case involves providing a coordinate-sorted alignment file and a functional annotation file.

```bash
mmquant -a annotation.gtf -r alignment.bam -o counts.txt
```

### Handling Multi-mapping Reads
mmquant's primary strength is its logic for ambiguous reads. You can tune how it handles overlaps:

- **Default behavior**: It creates a cluster of genes if a read maps to multiple features.
- **Library Type**: Specify the strandedness to improve accuracy.
  - `-s 0`: Unstranded (default)
  - `-s 1`: Stranded
  - `-s 2`: Reversely stranded (common for Illumina TruSeq)

### Performance Optimization
For large datasets, use multi-threading to speed up the counting process:

```bash
mmquant -a annotation.gtf -r alignment.bam -o counts.txt -t 8
```

## Best Practices

- **Input Preparation**: Ensure your BAM files are sorted by position. While some counters require name-sorting for paired-end data, mmquant generally performs best with position-sorted indexed files.
- **Annotation Consistency**: Use the same genome assembly for both the alignment (mapping) and the annotation (GTF/GFF) to avoid coordinate mismatches.
- **Output Analysis**: The output file contains a header and a matrix. Note that some rows may represent "clusters" of genes (joined by a comma or pipe) if those genes could not be statistically separated due to overlapping reads.
- **Memory Management**: If processing very large BAM files on a machine with limited RAM, monitor usage as mmquant builds an in-memory representation of the annotation and read overlaps.

## Reference documentation

- [mmquant Overview](./references/anaconda_org_channels_bioconda_packages_mmquant_overview.md)
- [Multi-mapping Counter Repository](./references/bitbucket_org_mzytnicki_multi-mapping-counter.md)