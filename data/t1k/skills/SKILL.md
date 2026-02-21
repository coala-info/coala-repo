---
name: t1k
description: T1K is a specialized computational tool designed to accurately identify alleles for complex, polymorphic gene families like HLA and KIR.
homepage: https://github.com/mourisl/T1K
---

# t1k

## Overview

T1K is a specialized computational tool designed to accurately identify alleles for complex, polymorphic gene families like HLA and KIR. Unlike general-purpose aligners, T1K calculates allele abundances based on read alignments to specific reference sequences, making it highly effective for both bulk and single-cell sequencing data. It is the preferred tool when standard genotyping methods struggle with the high sequence variability found in immunological gene clusters.

## Core Workflow

### 1. Reference Index Building
Before genotyping, you must generate the allele reference sequences. Use the `t1k-build.pl` script to download and index the necessary databases.

```bash
# Build HLA index
perl t1k-build.pl -o hlaidx --download IPD-IMGT/HLA

# Build KIR index
perl t1k-build.pl -o kiridx --download IPD-KIR
```

### 2. Running Genotyping
The main execution is handled by `run-t1k`. You must provide the read files and the reference file generated in the previous step.

**Common CLI Patterns:**

*   **HLA Genotyping (RNA-seq):**
    ```bash
    ./run-t1k -1 read_1.fq -2 read_2.fq --preset hla -f hlaidx/hlaidx_rna_seq.fa -o output_prefix
    ```

*   **KIR Genotyping (WGS):**
    ```bash
    ./run-t1k -1 read_1.fq -2 read_2.fq --preset kir-wgs -f kiridx/kiridx_dna_seq.fa -o output_prefix
    ```

*   **BAM Input (Requires Coordinates):**
    If starting from a BAM file, you must provide a gene coordinate file (`-c`).
    ```bash
    ./run-t1k -b input.bam -c hlaidx/hlaidx_dna_coord.fa -f hlaidx/hlaidx_dna_seq.fa
    ```

### 3. Preset Selection
Always use the `--preset` flag to optimize parameters for your specific data type:
- `hla`: Standard HLA genotyping (typically RNA-seq).
- `hla-wgs`: HLA genotyping for Whole Genome Sequencing.
- `kir-wgs`: KIR genotyping for Whole Genome Sequencing.
- `kir-wes`: KIR genotyping for Whole Exome Sequencing.

## Expert Tips and Best Practices

*   **Reference File Matching**: Ensure the reference file type matches your data. Use `*_rna_seq.fa` for RNA-seq data and `*_dna_seq.fa` for WGS or WES data.
*   **Quality Thresholds**: In the `t1k_genotype.tsv` output, the quality score is a critical metric. It is highly recommended to **ignore any alleles with a quality score of 0 or less**.
*   **Abundance Filtering**: Use the `--frac` parameter (default 0.15) to filter out low-abundance alleles that may be noise. If you suspect low-expression alleles are being missed in RNA-seq, consider slightly lowering this value.
*   **Performance**: Use the `-t` flag to specify the number of threads. T1K is thread-efficient and benefits significantly from multi-core environments.
*   **Coordinate Generation**: If you need a coordinate file for BAM input and don't have one, generate it using:
    `perl t1k-build.pl -o output_dir -d database.dat -g gencode.gtf`

## Output Interpretation
The primary output is `[prefix]_genotype.tsv`.
- **Columns 3-5 & 6-8**: Represent the first and second alleles with their respective abundance and quality scores.
- **Placeholder Values**: If an allele is missing or the gene is homozygous, T1K uses `. 0 -1` as a placeholder.
- **Secondary Alleles**: The final column contains alleles that passed abundance filters but were excluded during tie-breaking.

## Reference documentation
- [T1K GitHub Repository](./references/github_com_mourisl_T1K.md)
- [T1K Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_t1k_overview.md)