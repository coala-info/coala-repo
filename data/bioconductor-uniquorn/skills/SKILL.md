---
name: bioconductor-uniquorn
description: Uniquorn identifies cancer cell lines by comparing somatic mutations in VCF files against a reference database of known cell line profiles. Use when user asks to identify a cell line from a VCF file, initialize external databases like CCLE or COSMIC, or manage custom cell line entries in the reference database.
homepage: https://bioconductor.org/packages/release/bioc/html/Uniquorn.html
---

# bioconductor-uniquorn

## Overview

The `Uniquorn` package identifies cancer cell lines (CCLs) by comparing the somatic mutations found in a user's VCF file against a large reference database of known cell line profiles. It is particularly useful for quality control to ensure that the cell lines used in an experiment are not misidentified or contaminated. While it comes with a default set of 60 CellMiner lines, it can be expanded to include over 2000 samples from CCLE and COSMIC.

## Core Workflow

### 1. Identifying a Cell Line from a VCF
The primary function is `identify_vcf_file`. It compares the mutations in your VCF against the internal database.

```r
library(Uniquorn)

# Path to your VCF file
vcf_path <- "path/to/your_sample.vcf"

# Identify the cell line (specify reference genome: "GRCH37" or "GRCH38")
ident_result <- identify_vcf_file(vcf_path, ref_gen = "GRCH37")

# View top candidates
head(ident_result)
```

The resulting table includes:
- **CCL**: The name of the matching Cancer Cell Line.
- **Matches**: Number of matching mutations.
- **P-value**: Statistical significance of the match.
- **Library**: The source database (e.g., CellMiner, CCLE).

### 2. Initializing External Databases
Due to licensing, CCLE and COSMIC data must be downloaded manually and then imported into Uniquorn to expand the identification power.

```r
# After downloading required files from DepMap and COSMIC:
initiate_canonical_databases(
    cosmic_file = 'CosmicCLP_MutantExport.tsv',
    ccle_file = 'CCLE_mutations.csv',
    ccle_sample_file = 'sample_info.csv',
    ref_gen = 'GRCH38'
)
```

### 3. Managing Custom Cell Lines
You can add your own sequenced cell lines to the reference database to use them as training data for future identifications.

```r
# Add a custom VCF to the database
add_custom_vcf_to_database("my_private_cell_line.vcf", ref_gen = "GRCH37")

# Remove a custom entry
remove_custom_vcf_from_database("my_private_cell_line")
```

### 4. Database Exploration
Use these utility functions to inspect what is currently stored in the Uniquorn environment:

- `show_contained_cls(ref_gen = "GRCH37")`: Lists all available cell lines.
- `show_contained_mutations_for_cl("CELL_LINE_NAME")`: Shows specific mutations associated with a line.

## Tips for Success

- **Reference Genomes**: Ensure the `ref_gen` parameter matches the genome version used to align your VCF (GRCh37/hg19 vs GRCh38/hg38). Mixing these will result in zero or random matches.
- **Output Files**: By default, the tool creates a `.tab` file and BED files for IGV visualization in the same directory as the input VCF. Disable BED creation with `output_bed_file = FALSE` in `identify_vcf_file`.
- **Heterogeneity**: Not all mutations will match perfectly between different versions of the same cell line (e.g., CCLE vs. CellMiner) due to different filtering pipelines. Focus on the p-value and the relative number of matches rather than an absolute 1:1 mutation overlap.

## Reference documentation
- [Uniquorn vignette](./references/Uniquorn.md)