---
name: eigenstratdatabasetools
description: This suite provides Python-based utilities for managing, subsetting, and analyzing genomic data in EigenStrat format. Use when user asks to extract or remove specific individuals, check for duplicate samples between databases, calculate SNP coverage statistics, or rename SNPs based on reference coordinates.
homepage: https://github.com/TCLamnidis/EigenStratDatabaseTools
---


# eigenstratdatabasetools

## Overview

The `eigenstratdatabasetools` suite provides a set of Python-based utilities for managing EigenStrat format genomic data. It is designed for bioinformaticians who need to subset datasets by individual, verify sample overlaps between different databases, or generate coverage reports for quality control. The toolset simplifies common data cleaning tasks that would otherwise require manual parsing of `.geno`, `.snp`, and `.ind` files.

## CLI Usage Patterns

### Individual Manipulation and Comparison
Use `eigenstrat_database_tools.py` to manage samples within a database.

*   **Check for duplicate individuals between two databases:**
    ```bash
    eigenstrat_database_tools.py -i <input_prefix> -C <second_ind_file>
    ```
    *Note: This checks individual names only and is case-sensitive.*

*   **Extract specific individuals to a new database:**
    ```bash
    # Using a list file
    eigenstrat_database_tools.py -i <input_prefix> -E -L <sample_list.txt> -o <output_prefix>

    # Specifying individuals directly
    eigenstrat_database_tools.py -i <input_prefix> -E -S Ind1 -S Ind2 -o <output_prefix>
    ```

*   **Remove specific individuals from a database:**
    ```bash
    eigenstrat_database_tools.py -i <input_prefix> -R -L <sample_list.txt> -o <output_prefix>
    ```

### SNP Coverage Statistics
Use `eigenstrat_snp_coverage.py` to calculate the number of covered and total reads for each individual.

*   **Generate a coverage table:**
    ```bash
    eigenstrat_snp_coverage.py -i <input_prefix> -o coverage_stats.txt
    ```

*   **Generate JSON formatted output for downstream pipelines:**
    ```bash
    eigenstrat_snp_coverage.py -i <input_prefix> --json coverage_stats.json
    ```

### SNP Renaming
Use `eigenstrat_rename_snps.py` to update SNP identifiers based on genetic coordinates from a reference file.

*   **Rename SNPs using an EigenStrat reference:**
    ```bash
    eigenstrat_rename_snps.py -i <input.snp> -n <reference.snp> -f EIGENSTRAT
    ```

*   **Rename SNPs using a Plink reference:**
    ```bash
    eigenstrat_rename_snps.py -i <input.snp> -n <reference.bim> -f PLINK
    ```

## Expert Tips and Best Practices

*   **Input Prefixes:** Most tools in this suite expect an input prefix (`-i`) and will automatically look for the associated `.geno`, `.snp`, and `.ind` files. Ensure all three files are present in the same directory.
*   **Case Sensitivity:** Individual names are case-sensitive during duplicate checks (`-C`) and extraction/removal (`-E`/`-R`). Verify your sample list matches the `.ind` file exactly.
*   **Performance:** The removal function (`-R`) is optimized for speed. If you need to filter out a large number of individuals from a massive database, using `-R` with a list file is significantly faster than manual filtering.
*   **SNP Identity:** The renaming tool uses genetic coordinates (chromosome and position) to determine SNP identity. Ensure your reference file uses the same genome assembly (e.g., hg19 vs hg38) as your input file to avoid incorrect renaming.
*   **Standard Streams:** If the output path (`-o`) is omitted in the coverage tool, results are printed to `stdout`, which is useful for quick inspections or piping to other CLI utilities like `grep` or `column`.

## Reference documentation
- [EigenStratDatabaseTools README](./references/github_com_TCLamnidis_EigenStratDatabaseTools_blob_master_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_eigenstratdatabasetools_overview.md)