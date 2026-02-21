---
name: kssd
description: kssd (K-mer Substring Space Decomposition) is a specialized tool for genomic distance estimation and sequence resemblance analysis.
homepage: https://github.com/yhg926/public_kssd
---

# kssd

## Overview
kssd (K-mer Substring Space Decomposition) is a specialized tool for genomic distance estimation and sequence resemblance analysis. It operates by sampling and shuffling k-mer substring spaces to reduce dimensionality, allowing for rapid comparison of massive datasets. It is particularly effective for bacterial genomes, metagenomics, and large-scale sequence searches where traditional alignment is computationally prohibitive.

## Core Workflows

### 1. Dimensionality Reduction (Shuffling)
Before sketching, you must define the k-mer space. While `dist` can generate this automatically, using `shuffle` allows for precise control.

```bash
kssd shuffle -k <half_k> -s <half_sub> -l <level> -o <output.shuf>
```
*   **-k**: Half-length of k-mer (e.g., `-k 8` results in 16-mers).
*   **-s**: Half-length of k-mer substring (default is 6; usually no need to change).
*   **-l**: Dimensionality reduction level ($16^x$).

### 2. Sketching Sequences
To compare sequences, they must first be converted into sketches.

**Sketching References:**
```bash
kssd dist -r <fasta_dir> -L <level_or_shuf_file> -k <half_k> -o <ref_outdir>
```

**Sketching Queries:**
Queries **must** use the same `.shuf` file used for the references to ensure compatibility.
```bash
kssd dist -o <qry_outdir> -L <ref_outdir/default.shuf> <query_fasta_dir>
```

### 3. Distance Estimation
Once sketched, calculate the resemblance or containment.

**Search Queries against References:**
```bash
kssd dist -r <ref_outdir/ref> -o <output_dir> <qry_outdir/qry>
```

**Pairwise Reference Distance:**
```bash
kssd dist -r <ref_outdir/ref> -o <output_dir> <ref_outdir/ref>
```

## Parameter Recommendations
Choose parameters based on the target organism's genome size:

| Organism Type | -k (Half-length) | -L/-l (Level) |
| :--- | :--- | :--- |
| Bacteria | 8 (16-mer) | 3 |
| Mammals | 10 (20-mer) | 4 or 5 |
| Metagenomics | 10 (20-mer) | 4 or 5 |
| Intermediate | 9 (18-mer) | 3 or 4 |

## Expert Tips and Best Practices
*   **Streaming Data**: Use the `--pipecmd` flag to sketch directly from tools like `fastq-dump` without saving intermediate files.
    *   Example: `kssd dist -L my.shuf -o out --pipecmd "fastq-dump -Z" ERR000001`
*   **Set Operations**: Use `kssd set` to perform union (`-u`), intersection (`-i`), or subtraction (`-s`) on existing sketches. This is useful for creating composite metagenomic references.
*   **Output Interpretation**: The primary output `distance.out` includes Jaccard coefficients, Mash distance, and Containment measurements. For highly divergent sequences, focus on `AafD` (AAF distance); for subset analysis, focus on `ContainmentM`.
*   **OS Limitation**: kssd is natively built for Linux. It does not officially support macOS or Windows.
*   **Input Flexibility**: The tool handles both FASTA and FASTQ formats and automatically detects gzipped files (`.gz`).

## Reference documentation
- [kssd - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_kssd_overview.md)
- [GitHub - yhg926/public_kssd: K-mer substring space decomposition](./references/github_com_yhg926_public_kssd.md)