---
name: metaphlan
description: "MetaPhlAn profiles the composition of microbial communities from metagenomic shotgun sequencing data. Use when user asks to profile microbial communities, identify microbial taxa, or perform strain-level analysis."
homepage: https://github.com/biobakery/metaphlan
---


# metaphlan

metaphlan/SKILL.md
```yaml
name: metaphlan
description: |
  Profiles the composition of microbial communities (Bacteria, Archaea, Eukaryotes, and Viruses) from metagenomic shotgun sequencing data with species-level resolution. Use when analyzing metagenomic data to identify microbial taxa present in a sample. Also supports strain-level identification and tracking with StrainPhlAn.
```
## Overview
This skill provides instructions for using MetaPhlAn, a powerful command-line tool for analyzing metagenomic sequencing data. MetaPhlAn excels at identifying the microbial species present in a sample, offering species-level resolution for bacteria, archaea, eukaryotes, and viruses. It also includes StrainPhlAn for more granular strain-level analysis. Use this skill when you need to understand the taxonomic composition of a microbial community from shotgun sequencing data.

## Usage Instructions

MetaPhlAn is primarily used via its command-line interface. The core functionality involves providing input sequences and specifying output formats.

### Basic Usage: Species Profiling

The most common use case is to profile the species composition of a metagenomic sample.

```bash
metaphlan <input_sequences> --input_type <type> -o <output_file>
```

*   `<input_sequences>`: Path to your input file (e.g., FASTQ, FASTA).
*   `--input_type <type>`: Specifies the format of the input file. Common types include `fastq`, `fasta`, `bowtie2out`, `unmapped`.
*   `-o <output_file>`: Specifies the output file name. The default output format is tab-separated values (TSV).

**Example:**

```bash
metaphlan reads.fastq --input_type fastq -o profile.txt
```

### Output Formats

MetaPhlAn supports various output formats to suit different downstream analyses.

*   **TSV (default):** Tab-separated values, providing taxonomic assignments and relative abundances.
*   **BIOM:** For compatibility with tools like QIIME 2. Use the `--biom` flag.
*   **JSON:** For programmatic parsing. Use the `--json` flag.
*   **NCL:** Newick format for phylogenetic trees. Use the `--ncl` flag.

**Example (BIOM output):**

```bash
metaphlan reads.fastq --input_type fastq --biom profile.biom
```

### Strain-Level Analysis with StrainPhlAn

StrainPhlAn is a companion tool for identifying and tracking microbial strains. It typically requires pre-aligned reads or consensus genomes.

```bash
strainphlan <input_files> --output_dir <output_directory>
```

*   `<input_files>`: Paths to input files (e.g., BAM files, FASTA consensus genomes).
*   `--output_dir <output_directory>`: Directory to store StrainPhlAn results.

**Note:** StrainPhlAn usage is more complex and often involves pre-processing steps. Refer to the StrainPhlAn documentation for detailed instructions.

### Key Command-Line Options and Tips

*   **`--bowtie2out <output_file>`**: Output alignments in Bowtie2 format. Useful for subsequent analyses.
*   **`--unmapped <output_file>`**: Save unmapped reads to a file.
*   **`--nreads <number>`**: Limit the number of reads to process. Useful for testing or large datasets.
*   **`--nproc <number>`**: Number of parallel processes to use.
*   **`--force`**: Overwrite output files if they already exist.
*   **`--verbose`**: Increase output verbosity for debugging.
*   **Database Selection**: MetaPhlAn uses a built-in database. For specific needs, ensure you are using the appropriate version or consider custom database options if available.

### Common Workflows

1.  **Species Profiling:**
    ```bash
    metaphlan sample1.fastq.gz --input_type fastq -o sample1_profile.tsv
    metaphlan sample2.fastq.gz --input_type fastq -o sample2_profile.tsv
    ```
2.  **Comparing Profiles:** After generating TSV profiles, you can use tools like `merge_metaphlan_tables.py` (often distributed with MetaPhlAn or bioBakery) to combine and compare profiles across multiple samples.

## Reference documentation
- [MetaPhlAn documentation](./references/github_com_biobakery_metaphlan_wiki.md)