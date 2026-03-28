---
name: pbstarphase
description: pbstarphase is a pharmacogenomic diplotyper that uses phased PacBio HiFi sequencing data to accurately assign star-allele nomenclature to genes. Use when user asks to call PGx diplotypes, identify star alleles from long-read data, or generate PharmCAT-compatible outputs.
homepage: https://github.com/PacificBiosciences/pb-StarPhase
---


# pbstarphase

## Overview

`pbstarphase` is a specialized pharmacogenomic diplotyper designed specifically for PacBio HiFi sequencing data. It addresses the challenges of PGx analysis by being "phase-aware," using the long-range information inherent in PacBio reads to accurately assign variants to specific haplotypes. This is particularly critical for complex genes like *CYP2D6*, where structural variations, gene conversions, and pseudogenes often confound short-read or non-phased callers. The tool supports a wide range of genes defined by CPIC and PharmVar, providing standardized star-allele nomenclature and outputs compatible with downstream tools like PharmCAT.

## Tool Usage and Best Practices

### Database Management

The tool relies on a JSON-formatted database containing allele definitions. While pre-built databases are provided, you can generate or update them using the `build` command.

- **Update with API Keys**: When running `pbstarphase build`, provide a PharmVar API key via `--api-keys {JSON}` to ensure the latest sub-allele definitions are included. Without this, PharmVar-specific gene queries may be skipped.
- **Verify Database Integrity**: Use the `db-stat` sub-command to inspect a database file. This provides high-level summaries of gene, allele, and variant counts, which is useful for verifying that specific genes of interest (e.g., *NAT2*, *CYP2C19*) are present.

### Diplotyping Workflow

The primary function of `pbstarphase` is to call diplotypes from aligned PacBio data.

- **Input Requirements**: Provide high-quality phased VCFs (from callers like DeepVariant or SmallVar) and, if applicable, structural variant (SV) VCFs.
- **Sample Handling**: If working with multi-sample VCFs, explicitly specify the target sample using the `--sample-name` flag. Ensure that if both a small-variant VCF and an SV VCF are provided, they use the same sample name.
- **Structural Variants**: For genes with known large deletions or duplications (like *CYP2D6* or *DPYD*), ensure SV calling is performed and the results are passed to the tool. The `--max-sv-length` parameter defaults to 1 Mbp, which is sufficient for most PGx applications.

### Interpreting Outputs

The tool produces a primary JSON output containing the diplotype calls.

- **Exact vs. Inexact Matches**: 
    - The `diplotypes` field contains exact matches to the database. 
    - If no exact match is found, check the `inexact_diplotypes` field. This reports the closest matching allele combinations, which is vital for identifying novel or rare variants not yet codified in star-allele databases.
- **Sub-allele Resolution**: In version 2.0+, the tool prioritizes PharmVar sub-alleles (e.g., `*2.001`) if they can be uniquely identified on both haplotypes. If ambiguity exists at the sub-allele level, it falls back to the core allele (e.g., `*2`).
- **PharmCAT Integration**: The tool generates a PharmCAT-compatible TSV file. Note that this file typically contains only core alleles to maintain compatibility with PharmCAT's interpretation engine.
- **Debugging Complex Loci**: For *CYP2D6* analysis, use the `--output-debug` flag to generate a specialized VCF (`cyp2d6_alleles.vcf.gz`). This file treats each identified *CYP2D6* allele as a separate sample, allowing for manual inspection of the phased variants contributing to the call.

### Performance and Constraints

- **Targeted vs. WGS**: The tool is optimized for both targeted (amplicon) and whole-genome sequencing. For targeted data, ensure the alignment covers the full gene body and flanking regions required for phasing.
- **HLA Calling**: The tool supports *HLA-A* and *HLA-B*. If HLA results are unexpected, consult the `hla_debug.json` for internal consensus mapping statistics.



## Subcommands

| Command | Description |
|---------|-------------|
| build | Download and build the database for StarPhase |
| db-stat | Generate statistics about a database file |
| diplotype | Run the diplotyper on a dataset |

## Reference documentation

- [pb-StarPhase README](./references/github_com_PacificBiosciences_pb-StarPhase_blob_main_README.md)
- [User Guide](./references/github_com_PacificBiosciences_pb-StarPhase_blob_main_docs_user_guide.md)
- [Database Guide](./references/github_com_PacificBiosciences_pb-StarPhase_blob_main_docs_database.md)
- [Changelog and Version History](./references/github_com_PacificBiosciences_pb-StarPhase_blob_main_CHANGELOG.md)