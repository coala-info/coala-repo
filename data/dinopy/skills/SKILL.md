---
name: dinopy
description: dinopy is a bioinformatics library for efficient sequence I/O and high-performance k-mer manipulation using Cython. Use when user asks to read FASTA or FASTQ files, perform random access on indexed genomic regions, or generate solid and gapped q-grams.
homepage: https://bitbucket.org/HenningTimm/dinopy
metadata:
  docker_image: "quay.io/biocontainers/dinopy:3.0.0--py310h184ae93_2"
---

# dinopy

## Overview
dinopy is a specialized library designed for bioinformatics workflows that require efficient sequence I/O and k-mer manipulation. It bridges the gap between ease of use in Python and the performance of Cython, making it ideal for processing large genomic datasets where standard parsers might be too slow. Use this skill to implement sequence reading pipelines, create k-mer profiles, or handle indexed genomic regions.

## Core Functionality

### Sequence Reading (FASTA/FASTQ)
Use `dinopy.FastaReader` or `dinopy.FastqReader` for memory-efficient iteration over sequences.
- **FASTA**: Iterates over `(sequence, name)` tuples.
- **FASTQ**: Iterates over `(sequence, name, quality)` tuples.
- **Best Practice**: Use context managers (`with` statements) to ensure file handles are closed properly.

### Indexed Access (FastaIndex)
For random access to large genomes, use `dinopy.FastaIndex`. This requires a `.fai` file (compatible with samtools).
- Use `get_sequence(chrom, start, end)` for specific coordinate retrieval.
- Efficient for extracting specific genes or genomic windows without loading the entire chromosome into memory.

### Q-gram (K-mer) Generation
dinopy excels at generating q-grams (k-mers) from sequences.
- **Solid q-grams**: Standard contiguous k-mers.
- **Gapped q-grams**: Non-contiguous k-mers defined by a shape string (e.g., "11011" for a weight-4 q-gram with a central gap).
- **Encoding**: Use `dinopy.qgrams` to convert sequences into numerical representations (integers) for fast comparisons or machine learning features.

## Expert Tips
- **Cython Integration**: If writing Cython extensions, dinopy provides headers for direct C-level access to sequence buffers, significantly reducing Python overhead.
- **Memory Mapping**: For extremely large files, dinopy utilizes memory mapping where possible to keep the memory footprint low.
- **Data Types**: Be mindful that sequences are typically returned as `bytes` or `bytearray` objects to preserve performance; decode to `utf-8` only if string manipulation is strictly necessary.

## Reference documentation
- [dinopy Overview](./references/anaconda_org_channels_bioconda_packages_dinopy_overview.md)
- [dinopy Repository and Documentation](./references/bitbucket_org_HenningTimm_dinopy.md)