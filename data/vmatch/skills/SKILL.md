---
name: vmatch
description: vmatch is a high-performance suite for large-scale sequence matching and repeat analysis.
homepage: http://www.vmatch.de/
---

# vmatch

## Overview

vmatch is a high-performance suite for large-scale sequence matching and repeat analysis. Unlike many alignment tools, it operates on a "persistent index" (enhanced suffix array) model, where sequence data is preprocessed once and then queried multiple times. This makes it exceptionally fast for finding exact or near-exact matches across massive datasets. It is alphabet-independent, supporting DNA, protein, and custom symbol mappings, and excels at identifying complex structural elements like branching tandem repeats and unique substrings.

## Core Workflow

The vmatch workflow typically involves two distinct steps: index construction and matching/querying.

### 1. Index Construction (`mkvtree`)
Before searching, you must create an index of your reference sequences.
- **Basic Index**: `mkvtree -db genome.fasta -indexname myindex -dna`
- **Protein Index**: `mkvtree -db proteins.fasta -indexname protindex -protein`
- **Six-Frame Translation**: Use `mkdna6idx` to construct an index for DNA translated into all six reading frames for protein-level matching.

### 2. Matching and Searching (`vmatch`)
Once the index is built, use the `vmatch` command to perform searches.
- **Find Exact Repeats**: `vmatch -l 50 -p myindex` (finds all repeats of length $\ge$ 50).
- **Find Supermaximal Repeats**: `vmatch -l 100 -supermax myindex`.
- **Query a Sequence**: `vmatch -q query.fasta myindex`.
- **Approximate Matching**: Use `-e` (max errors) or `-h` (hamming distance) to allow mismatches.
- **DNA vs. Protein**: Match DNA queries against a protein index using `-db6frame`.

## Advanced Features and Postprocessing

vmatch includes specialized tools for handling match results without requiring manual parsing:

- **Match Selection**: Use `vmatchselect` to filter and sort matches based on length, E-value, or identity scores.
- **Chaining**: Use `chain2dim` to find the optimal non-overlapping subset of matches (useful for synteny or genome alignment).
- **Clustering**: Use `matchcluster` to group sequences or matches based on similarity.
- **Masking**: Use the `-mask` option within `vmatch` to produce a version of the sequence where matches are obscured (useful for repeat masking).
- **Inverse Output**: Use `-v` to report only the regions of the sequence that *do not* contain matches.

## Expert Tips

- **Memory Management**: The 64-bit version is required for processing datasets larger than 400 million symbols.
- **Alphabet Independence**: You can define custom symbol mappings for specialized tasks (e.g., grouping chemically similar amino acids) using the `-smap` option.
- **Persistent Indices**: Keep your index files (`.prj`, `.tis`, `.lcp`, etc.) in the same directory. vmatch only loads the specific parts of the index required for the current task, making it very memory efficient for targeted queries.
- **Compressed Input**: vmatch natively accepts gzipped Fasta files, saving disk space during the initial indexing phase.

## Reference documentation

- [The Vmatch large scale sequence analysis software](./references/www_vmatch_de_index.md)
- [vmatch - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_vmatch_overview.md)