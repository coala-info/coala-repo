---
name: kbo-cli
description: kbo-cli is a high-performance command-line interface for rapid approximate genomic alignment and analysis. Use when user asks to call variants, search for sequence segments, or perform reference-based mapping.
homepage: https://docs.rs/kbo
---


# kbo-cli

## Overview

kbo-cli is a high-performance command-line interface for the kbo local aligner. It specializes in "approximate" alignment, which allows for rapid analysis of genomic data by converting matching statistics into character representations of alignments. Unlike many traditional aligners, kbo-cli can operate directly on raw or compressed sequence files without pre-building an index, though it supports indexing for specific search optimizations. Use this tool when you need a lightweight alternative to tools like Snippy, SKA, or BLAST for variant detection and sequence localization.

## Core Commands and Usage

### Variant Calling (kbo call)
Use this to identify single/multi-base substitutions, insertions, and deletions.
- **Basic Command**: `kbo call --reference <ref.fasta> <query.fasta.gz> > variants.vcf`
- **Output**: Standard VCF v4.4 format.
- **Tip**: This is the preferred command for generating input for downstream phylogenetic or mutational analysis.

### Sequence Searching (kbo find)
Use this to locate local alignment segments, similar to a BLAST search.
- **Basic Command**: `kbo find --reference <target_genes.fasta> <genome.fasta>`
- **Detailed Output**: Add the `--detailed` flag to include specific contig names and product descriptions in the output table instead of generic IDs.
- **Gap Management**: Use `--max-gap-len <int>` to control the maximum length of a single gap segment before the tool splits an alignment.

### Reference-Based Mapping (kbo map)
Use this to map a query against a reference and generate a nucleotide sequence relative to that reference.
- **Basic Command**: `kbo map --reference <ref.fasta> <query.fasta>`
- **Functionality**: It masks characters not present in the query with a `-`, providing a clear view of conservation and gaps relative to the reference.

## Expert Tips and Best Practices

- **K-mer Selection**: The default k-mer size is often 31. For highly divergent sequences, decreasing `k` may increase sensitivity but will introduce more noise. For very similar sequences, a larger `k` improves speed and specificity.
- **Handling Noise**: Use the `--max-error-prob` parameter to filter out random matches. Matches with a probability higher than this threshold are treated as noise and discarded.
- **Memory Management**: When using `kbo build` for large datasets, use the `--mem-gb` flag to specify available RAM, which helps the Spectral Burrows-Wheeler Transform (SBWT) construction algorithm optimize performance.
- **Direct Compression Support**: kbo-cli natively reads DEFLATE formats (gzip, zlib). You do not need to decompress files before running `call`, `find`, or `map`.
- **Indexing Strategy**: While kbo-cli can run without an index, use `kbo build` when performing multiple `find` operations against the same large reference to save time on subsequent runs.

## Reference documentation
- [kbo-cli Overview](./references/anaconda_org_channels_bioconda_packages_kbo-cli_overview.md)
- [kbo Crate Documentation](./references/docs_rs_kbo_latest_kbo.md)
- [Build Options Reference](./references/docs_rs_kbo_latest_kbo_struct.BuildOpts.html.md)
- [Find Options Reference](./references/docs_rs_kbo_latest_kbo_struct.FindOpts.html.md)