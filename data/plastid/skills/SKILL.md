---
name: plastid
description: The `plastid` library is designed to bridge the gap between raw sequencing alignments and functional biological insights by treating multi-segment features (like spliced transcripts) as unified objects.
homepage: http://plastid.readthedocs.io/en/latest/
---

# plastid

## Overview
The `plastid` library is designed to bridge the gap between raw sequencing alignments and functional biological insights by treating multi-segment features (like spliced transcripts) as unified objects. It is particularly powerful for assays where the exact position of a read (e.g., the ribosomal P-site) carries specific biological meaning. Use this skill to streamline the conversion of BAM/BigWig files into position-specific count vectors and to perform feature-centric genomic arithmetic.

## Core Workflows and Best Practices

### Read Mapping and P-site Offset
The most critical step in `plastid` is defining how a read alignment represents a biological event.
- **Ribosome Profiling**: Use the `center` or `fivep` mapping rules with specific offsets to identify the P-site.
- **DMS-seq**: Use mapping rules that highlight the nucleotide modification site (typically the 5' end of the fragment).
- **Quantitative Analysis**: Always convert alignments to `numpy` arrays using `plastid`'s internal mapping functions to enable high-performance vector operations.

### Coordinate Conversions
`plastid` excels at "un-splicing" coordinates.
- Use the `Transcript` and `SegmentChain` objects to move between **genomic coordinates** (e.g., chr1:1000-1200) and **transcript coordinates** (e.g., position 50 of the mRNA).
- When working with spliced genes, always use `SegmentChain` to ensure that introns are handled automatically during distance calculations.

### Common CLI Patterns
While `plastid` is a library, it provides several high-utility scripts:
- `metagene`: Use this to generate aggregate profiles of reads around start and stop codons. It is the standard way to quality-control Ribo-seq data and determine P-site offsets.
- `phase_by_size`: Use this to check for 3-nucleotide periodicity in Ribo-seq data, which confirms that the fragments are protected by ribosomes.
- `counts_in_region`: Use this for rapid quantification of reads over specific genomic features.

### Expert Tips
- **Memory Management**: When processing large BAM files, use the `BAMGenomeArray` class to lazily load data, preventing memory exhaustion.
- **Data Representation**: `plastid` separates the data (the counts) from the representation (the GTF/GFF file). Ensure your annotation files are well-formatted (standard GTF2.2 or GFF3) to avoid parsing errors during `Transcript` object creation.
- **Custom Mapping**: If a standard mapping rule (5', 3', center) doesn't fit your assay, you can define a custom mapping function in Python and pass it to `plastid`'s array classes.

## Reference documentation
- [Welcome! — plastid documentation](./references/plastid_readthedocs_io_en_latest.md)
- [plastid - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_plastid_overview.md)