---
name: gottcha
description: GOTTCHA is a signature-based metagenomic tool used for taxonomic profiling and classification of sequencing reads. Use when user asks to perform taxonomic profiling, classify metagenomic reads, or characterize community compositions from clinical or environmental samples.
homepage: https://github.com/poeli/GOTTCHA
metadata:
  docker_image: "quay.io/biocontainers/gottcha:1.0--pl526_2"
---

# gottcha

## Overview

GOTTCHA (Genomic Origin Through Taxonomic CHAllenge) is a signature-based metagenomic taxonomic profiling tool. Unlike many tools that rely on marker genes, GOTTCHA utilizes a hierarchical suite of unique genomic signatures to classify reads, which significantly reduces false discovery rates (FDR). It is designed to be computationally efficient enough for laptop use while maintaining superior performance in characterizing complex community compositions from clinical or environmental samples.

## Installation and Database Setup

Before running GOTTCHA, ensure the environment is prepared with Perl v5.8+ and the necessary dependencies (BWA, D compiler).

1.  **Install GOTTCHA**:
    ```bash
    git clone https://github.com/LANL-Bioinformatics/GOTTCHA.git gottcha
    cd gottcha
    ./INSTALL.sh
    ```
2.  **Download Required Databases**:
    GOTTCHA requires both a taxonomic lookup table and a specific signature database (e.g., Bacteria or Viruses).
    ```bash
    # Download lookup table
    wget ftp://ftp.lanl.gov/public/genome/gottcha/latest/GOTTCHA_lookup.tar.gz
    # Download a specific database (e.g., Bacteria species-level)
    wget ftp://ftp.lanl.gov/public/genome/gottcha/latest/GOTTCHA_BACTERIA_c4937_k24_u30_xHUMAN3x.species.tar.gz
    
    # Unpack
    tar -zxvf GOTTCHA_lookup.tar.gz
    tar -zxvf GOTTCHA_BACTERIA_c4937_k24_u30_xHUMAN3x.species.tar.gz
    ```

## Common CLI Patterns

### Basic Taxonomic Profiling
To profile a single FASTQ file using a pre-computed database:
```bash
bin/gottcha.pl \
  --threads 8 \
  --input input_file.fastq \
  --database database/GOTTCHA_BACTERIA_c4937_k24_u30_xHUMAN3x.species \
  --outdir ./output_folder
```

### Handling Multiple Inputs
GOTTCHA v1.0b+ supports multiple input files in a single command:
```bash
bin/gottcha.pl --input file1.fq --input file2.fq --database path/to/db --outdir ./results
```

### Advanced Filtering and Output
*   **Exclude Plasmids**: To remove hits recruited to plasmids (requires the `.parsedGOTTCHA.dmp` file in the database):
    ```bash
    bin/gottcha.pl --input input.fq --database path/to/db --noPlasmidHit --outdir ./
    ```
*   **Export Alignments**: To save the mapping results in SAM format for downstream inspection:
    ```bash
    bin/gottcha.pl --input input.fq --database path/to/db --dumpSam --outdir ./
    ```

## Visualization with Krona

To generate interactive pie charts, you must run GOTTCHA in "all" mode to produce the necessary lineage files.

1.  **Run GOTTCHA in all mode**:
    ```bash
    bin/gottcha.pl --mode all --input input.fq --database path/to/db --outdir ./results
    ```
2.  **Generate Krona Chart**:
    Use the `.lineage.tsv` file found in the `_temp` directory:
    ```bash
    ktImportText results_temp/input.lineage.tsv -o results.krona.html
    ```

## Expert Tips and Best Practices

*   **Database Integrity**: Always download the corresponding `.md5` files for databases to verify integrity, as signature databases can be several gigabytes in size.
*   **Abundance Estimation**: By default, GOTTCHA uses "rolled up" depth of coverage at the strain level to calculate relative abundance. This is more accurate for organisms with low coverage (<1x).
*   **Memory Management**: While laptop-deployable, ensure at least 8GB of RAM is available. For very large databases or high-thread counts, monitor memory usage as BWA-MEM mapping can be intensive.
*   **Output Interpretation**: Focus on the `LINEAR_DOC` (Linear Depth of Coverage) and `NORM_COV` columns in the `*.gottcha.tsv` file. `LINEAR_DOC` represents the total bases mapped divided by the number of non-overlapping signature bases, providing a robust metric for presence.



## Subcommands

| Command | Description |
|---------|-------------|
| gottcha.pl | Genomic Origin Through Taxonomic CHAllenge (GOTTCHA) is an annotation-independent and signature-based metagenomic taxonomic profiling tool that has significantly smaller FDR than other profiling tools. This Perl script is a wrapper to run the GOTTCHA profiling tool with pre-computed signature databases. The procedure includes 3 major steps: split-trimming the input data, mapping reads to a GOTTCHA database using BWA, profiling/filtering the result. |
| splitrim | Splits a FASTA/FASTQ file into smaller files based on sequence names. |

## Reference documentation
- [GOTTCHA Main Documentation](./references/lanl-bioinformatics_github_io_GOTTCHA.md)
- [GOTTCHA GitHub Repository](./references/github_com_poeli_GOTTCHA.md)