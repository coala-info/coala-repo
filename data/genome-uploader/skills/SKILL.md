---
name: genome-uploader
description: The `genome-uploader` tool is a specialized utility designed to simplify the submission of metagenomic bins and MAGs to the ENA.
homepage: https://github.com/EBI-Metagenomics/genome_uploader
---

# genome-uploader

## Overview

The `genome-uploader` tool is a specialized utility designed to simplify the submission of metagenomic bins and MAGs to the ENA. It automates the generation of required metadata files (XMLs and manifests) and ensures that submitted genomes are correctly linked to the raw data (runs or assemblies) from which they were derived. This tool is particularly useful for researchers who need to adhere to ENA's strict metadata checklists (like ERC000047 or ERC000050) while managing large batches of genomic data.

## Input Preparation

The tool relies on a specific Tab-Separated Values (TSV) file to manage metadata.

### Mandatory TSV Columns
Ensure your input TSV contains the following headers in order:
1.  **genome_name**: Unique string identifier for the genome.
2.  **genome_path**: Local path to the compressed fasta file (.gz).
3.  **accessions**: The INSDC run (ERR/SRR/DRR) or assembly (ERZ/SRZ/DRZ) accession(s) used to generate the genome. Use commas for co-assemblies.
4.  **assembly_software**: Name and version (e.g., `megahit_v1.2.9`).
5.  **binning_software**: Name and version (e.g., `metabat2_v2.12.1`).
6.  **binning_parameters**: Parameters used during binning (or `default`).
7.  **stats_generation_software**: Software used for quality metrics (e.g., `CheckM2_v1.0.1`).
8.  **completeness**: Float value.
9.  **contamination**: Float value.
10. **genome_coverage**: Coverage against raw reads.
11. **metagenome**: Taxonomy string from the ENA metagenome list.
12. **co-assembly**: `True` or `False`.
13. **broad_environment**: Broad ecological context (e.g., `desert`, `coral reef`).
14. **local_environment**: Specific site (e.g., `lake`, `cliff`).
15. **environmental_medium**: Material sampled (e.g., `soil`, `water`).
16. **rRNA_presence**: `True` or `False` (Mandatory for MAGs).
17. **NCBI_lineage**: Full lineage string or TaxIDs separated by semicolons.

## CLI Usage and Best Practices

### Basic Execution
Run the uploader by pointing it to your prepared TSV:
```bash
genome_uploader -i your_input_table.tsv
```

### Handling Private Data
If the source runs or assemblies are still under embargo (private) on ENA, you must use the private flag to allow the tool to fetch the necessary metadata via the ENA API:
```bash
genome_uploader -i your_input_table.tsv --private
```

### Third-Party Annotations (TPA)
If you are uploading TPA genomes, ensure you have contacted ENA support first to register a TPA project, then use the specific flag:
```bash
genome_uploader -i your_input_table.tsv --tpa
```

### Credentials Management
The tool requires ENA Webin credentials. These can be provided via environment variables or a `.env` file in the working directory:
- `WEBIN_USER`: Your Webin submission account ID.
- `WEBIN_PASSWORD`: Your Webin account password.

## Expert Tips

- **Batch Limits**: Do not exceed 5,000 genomes per submission. If you have a larger dataset, split the TSV into multiple files and run the tool for each.
- **Compression**: All fasta files must be compressed (e.g., `.fasta.gz`) before running the script. The tool does not compress files for you.
- **Taxonomy Validation**: Ensure the `metagenome` field matches the ENA taxonomy tree exactly. For host-associated samples, use specific terms like "chicken gut metagenome" rather than generic descriptions.
- **Quality Criteria**: For MAGs, `rRNA_presence` is mandatory and requires detection of 5S, 16S, and 23S genes plus at least 18 tRNA genes to meet high-quality MIMAG standards.
- **Co-assemblies**: The tool currently only supports co-assemblies where all constituent runs belong to the same ENA project.

## Reference documentation
- [Main README and Usage Guide](./references/github_com_EBI-Metagenomics_genome_uploader.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_genome-uploader_overview.md)