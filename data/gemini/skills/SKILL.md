---
name: gemini
description: GEMINI (GEnome MINIing) is a specialized framework for exploring genetic variation in personal and medical genetics.
homepage: https://github.com/arq5x/gemini
---

# gemini

## Overview
GEMINI (GEnome MINIing) is a specialized framework for exploring genetic variation in personal and medical genetics. It integrates VCF files with a wide array of genome annotations into a unified SQLite database. By transforming flat VCF files into a relational structure, it enables the use of expressive SQL queries and built-in tools to identify variants of interest, particularly those following specific inheritance patterns in family-based studies.

## Core Workflows and CLI Patterns

### Installation and Setup
The preferred method for installation is via Bioconda or the dedicated automated script.
- **Conda**: `conda install bioconda::gemini`
- **Automated Script**: Use `gemini_install.py` to install the tool along with required third-party dependencies and large annotation data files.

### Loading Data
To begin analysis, you must load a VCF file into a GEMINI database. It is highly recommended to provide a PED file during this step to enable family-based analysis.
- **Basic Load**: `gemini load -v input.vcf -t <annotation_tool> output.db`
- **Parallel Loading**: Use the `--cores` flag to speed up the process for large datasets.
- **Annotation Types**: Specify the tool used for VCF annotation (e.g., `snpEff` or `VEP`) using the `-t` flag.
- **Example**: `gemini load --cores 4 -t snpEff -v my_variants.vcf my_variants.db`

### Querying the Database
The `query` command is the primary interface for extracting specific variants using SQL syntax.
- **Basic Query**: `gemini query -q "SELECT chrom, start, end, ref, alt FROM variants WHERE is_coding = 1" my_variants.db`
- **Filtering by Frequency**: `gemini query -q "SELECT * FROM variants WHERE aaf_esp_all < 0.01" my_variants.db`

### Inheritance Pattern Analysis
GEMINI includes dedicated modules for common inheritance models. These tools automatically utilize the family relationships defined in the PED file.
- **Autosomal Recessive**: `gemini autosomal_recessive my_variants.db`
- **Autosomal Dominant**: `gemini autosomal_dominant my_variants.db`
- **De Novo Mutations**: `gemini de_novo my_variants.db`
- **Compound Heterozygotes**: `gemini comp_hets my_variants.db`

## Expert Tips
- **Normalization**: Ensure your VCF is normalized (e.g., using `vt` or `bcftools`) before loading to ensure consistent representation of indels.
- **PED Files**: Always include a PED file if you have sample metadata or family structures; without it, the inheritance-based tools will not function.
- **Performance**: For very large datasets, GEMINI may experience performance bottlenecks. In such cases, consider the tool `slivar` as a more modern, high-performance alternative for filtering.
- **CADD Scores**: GEMINI supports CADD scores for functional prediction, but ensure you have the appropriate license for commercial applications.

## Reference documentation
- [GEMINI Overview](./references/anaconda_org_channels_bioconda_packages_gemini_overview.md)
- [GitHub Repository README](./references/github_com_arq5x_gemini.md)
- [Issue Tracker CLI Examples](./references/github_com_arq5x_gemini_issues.md)