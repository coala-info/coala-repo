---
name: gemini
description: GEMINI is a lightweight database framework that converts VCF files into a relational SQLite database enriched with functional annotations for integrative genetic variation analysis. Use when user asks to load VCF files into a database, query variants using SQL, or identify variants following specific inheritance patterns like autosomal recessive or de novo mutations.
homepage: https://github.com/arq5x/gemini
---

# gemini

## Overview
GEMINI (GEnome MINIing) is a lightweight database framework designed for the integrative exploration of genetic variation. It functions by converting VCF files into a relational SQLite database, which is then enriched with a wide array of functional annotations (e.g., CADD scores, ClinVar, population frequencies). This allows you to move away from complex command-line "one-liners" and instead use the expressive power of SQL and built-in inheritance tools to identify variants of interest in personal or medical genetics studies.

## Core Workflow
1. **Data Preparation**: Ensure your VCF is annotated with either SnpEff or VEP.
2. **Loading**: Use the `load` command to create a GEMINI database from your VCF and an optional PED file for family relationships.
3. **Analysis**: Execute specific inheritance model tools or perform custom SQL queries.

## Common CLI Patterns

### Loading Data
The `load` command is the entry point for all GEMINI analyses.
```bash
# Basic load with SnpEff annotations and multi-core support
gemini load -v input.vcf -t snpEff --cores 4 output.db

# Loading with a PED file to enable inheritance modeling
gemini load -v input.vcf -p family.ped -t VEP output.db
```

### Inheritance Modeling
GEMINI includes pre-defined tools for common inheritance patterns. These require a PED file to have been provided during the `load` step.
```bash
# Find autosomal recessive variants
gemini autosomal_recessive output.db

# Find potential compound heterozygotes
gemini comp_hets output.db

# Find de novo mutations in a trio
gemini de_novo output.db
```

### Custom SQL Queries
The `query` tool allows for arbitrary filtering using SQL syntax.
```bash
# Query specific columns for rare, high-impact variants
gemini query -q "SELECT chrom, start, ref, alt, gene FROM variants WHERE filter IS NULL AND aaf_esp_all < 0.01 AND impact_severity = 'HIGH'" output.db

# Export results to CSV
gemini query -q "SELECT * FROM variants" --header --csv output.db
```

### Statistics and Summaries
```bash
# Get a high-level summary of the variants in the database
gemini stats output.db

# List the samples present in the database
gemini list_samples output.db
```

## Expert Tips
- **Normalization**: Always decompose and normalize your VCF (using tools like `vt` or `bcftools`) before loading into GEMINI to ensure variants are represented consistently.
- **Performance**: For very large datasets (e.g., 1,000+ samples), GEMINI may encounter performance bottlenecks. In these cases, consider using `slivar`, which is the recommended successor for modern rare-disease analysis pipelines.
- **Annotation Versions**: Be mindful of the annotation data versions used during the `gemini_install.py` process, as these will dictate the population frequencies and clinical significance data available in your database.



## Subcommands

| Command | Description |
|---------|-------------|
| gemini actionable_mutations | Query the database for actionable mutations. |
| gemini amend | Amend a Gemini database. |
| gemini annotate | Annotate a gemini database with information from a TABIX'ed BED file. |
| gemini autosomal_dominant | Identify candidate variants for autosomal dominant inheritance. |
| gemini autosomal_recessive | Find autosomal recessive variants. |
| gemini bcolz_index | Index a Gemini database with bcolz. |
| gemini browser | Launch the Gemini browser |
| gemini comp_hets | Find compound heterozygous variants. |
| gemini db_info | Show information about a GEMINI database. |
| gemini de_novo | Find de novo mutations |
| gemini dump | Report all rows/columns from the variants table. |
| gemini fusions | Query the database for fusion events. |
| gemini gene_wise | Perform gene-wise analysis on a GEMINI database. |
| gemini interactions | Query gemini database for interactions |
| gemini lof_interactions | Finds interactions for genes that harbor LoF variants. |
| gemini lof_sieve | Queries the database for LOF variants. |
| gemini mendel_errors | Identify mendelian errors in a family structure. |
| gemini merge_chunks | Merge multiple chunked databases into a single database. |
| gemini pathways | Report pathways for indivs/genes/sites with LoF variants |
| gemini qc | Run quality control tests on a Gemini database. |
| gemini query | Query the GEMINI database. |
| gemini roh | Finds regions of homozygosity (ROH) in a VCF file. |
| gemini set_somatic | Set the is_somatic flag for variants in a gemini database. |
| gemini update | Update GEMINI database and associated tools. |
| gemini windower | Window a database for analysis. |
| gemini x_linked_de_novo | Find X-linked de novo variants |
| gemini x_linked_dominant | Identify candidate variants for X-linked dominant inheritance. |
| gemini x_linked_recessive | Find X-linked recessive variants |
| gemini_burden | Calculate burden statistics for variants in a GEMINI database. |
| gemini_load | Load variants and annotations from a VCF file into a GEMINI database. |
| gemini_load_chunk | Load a VCF file into a GEMINI database. |
| gemini_region | Query regions in a GEMINI database. |
| gemini_stats | Report statistics about variants in a GEMINI database. |

## Reference documentation
- [GEMINI - integrative exploration of genetic variation and genome annotations.](./references/github_com_arq5x_gemini.md)
- [GEMINI load error with MuTect2 vcf 4.2](./references/github_com_arq5x_gemini_issues.md)