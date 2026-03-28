---
name: kssd
description: kssd performs rapid genomic sequence analysis and evolutionary distance estimation using k-mer substring space sampling to create dimensionality-reduced sketches. Use when user asks to estimate evolutionary distances, create sequence sketches, build reference databases, or perform set operations on genomic datasets.
homepage: https://github.com/yhg926/public_kssd
---

# kssd

## Overview
kssd (K-mer substring space sampling/shuffling Decomposition) is a high-performance tool designed for the rapid analysis of massive genomic datasets. It utilizes a unique dimensionality-reduction approach based on k-mer substring space shuffling to create "sketches" of sequences. These sketches allow for the estimation of evolutionary distances and containment metrics without the computational overhead of full sequence alignment. It is particularly effective for building reference databases and searching queries against them at scale.

## Core Workflows

### 1. K-mer Substring Space Shuffling
Before sketching, you must define the k-mer space. You can either provide a dimensionality-reduction level directly to the `dist` command or pre-generate a `.shuf` file.

```bash
# Generate a custom shuffled space file
kssd shuffle -k <half_kmer_len> -s <half_sub_len> -l <level> -o <output.shuf>
```
*   **-k**: Half-length of k-mer (Total length = 2x). Use 8 for bacteria (k=16), 10 for mammals (k=20).
*   **-l**: Reduction level. Expected rate is $16^x$. Use 3 for bacteria, 4-5 for mammals.
*   **-s**: Half-length of substring. Default is 6; rarely needs changing.

### 2. Sketching and Indexing
To compare sequences, you must first decompose them into sketches.

**Sketching References:**
```bash
kssd dist -r <fasta_dir> -L <level_or_shuf_file> -k <half_kmer_len> -o <ref_outdir>
```
*   This creates a reference database in the output directory.

**Sketching Queries:**
Queries must use the **exact same** `.shuf` file used for the references to ensure compatibility.
```bash
kssd dist -L <ref_outdir/default.shuf> -o <qry_outdir> <query_fasta_dir>
```

### 3. Distance Estimation
Once sketches are created, perform the comparison:

```bash
# Search queries against reference database
kssd dist -r <ref_outdir/ref> -o <output_dir> <qry_outdir/qry>

# Pairwise distance of all references
kssd dist -r <ref_outdir/ref> -o <output_dir> <ref_outdir/ref>
```

### 4. Set Operations
Manipulate sketches to find shared or unique genomic content.

*   **Union**: `kssd set -u -o <union_out> <sketches_dir>`
*   **Intersection**: `kssd set -i <union_dir> -o <intersect_out> <sketches_dir>`
*   **Subtraction**: `kssd set -s <union_dir> -o <subtract_out> <sketches_dir>`

## Expert Tips and Best Practices
*   **Data Streaming**: Use the `--pipecmd` flag to sketch directly from SRA or other streams without saving intermediate FASTQ files (e.g., `--pipecmd "fastq-dump -Z" ERR000001`).
*   **Memory Management**: For large mammalian genomes, ensure you increase the dimensionality-reduction level (`-L 4` or `5`) to keep sketch sizes manageable.
*   **Output Interpretation**: The `distance.out` file provides multiple metrics. Use `MashD` for evolutionary distance and `ContainmentM` for identifying if a small sequence (like a plasmid or virus) is present within a larger metagenomic sample.
*   **Gzipped Files**: kssd natively handles `.gz` files; do not decompress them beforehand to save disk I/O.



## Subcommands

| Command | Description |
|---------|-------------|
| kssd composite | The composite doc prefix. |
| kssd dist | The dist doc prefix. |
| kssd set | The set doc prefix. |
| kssd shuffle | The shuffle doc prefix. |
| kssd_reverse | The reverse doc prefix. |

## Reference documentation
- [Kssd GitHub README](./references/github_com_yhg926_public_kssd_blob_master_README.md)
- [Kssd Main Repository Overview](./references/github_com_yhg926_public_kssd.md)