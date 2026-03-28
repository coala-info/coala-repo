---
name: blobtools
description: BlobTools is a suite for screening genome assemblies to identify and remove contaminants by integrating sequence information, read coverage, and taxonomic assignments. Use when user asks to create a BlobDB, visualize assembly statistics through BlobPlots, assign taxonomy to scaffolds, or filter non-target DNA from genomic data.
homepage: https://blobtools.readme.io/docs/what-is-blobtools
---

# blobtools

## Overview
BlobTools is a specialized suite for screening genome assemblies. It integrates sequence information, read coverage, and taxonomic assignments to help researchers identify the origin of genomic scaffolds. It is particularly effective for detecting horizontal gene transfer or removing non-target (contaminant) DNA from *de-novo* genome projects.

## Core Workflow
The standard BlobTools pipeline follows a "Create -> Add -> View/Plot" logic:

1.  **Initialize**: Create a BlobDB file from a genome assembly.
    ```bash
    blobtools create -i assembly.fasta -o project_name
    ```
2.  **Add Coverage**: Incorporate mapping data (BAM files) to calculate depth.
    ```bash
    blobtools map2cov -i assembly.fasta -b mapping.bam -o project_name.blobDB.json
    ```
3.  **Add Taxonomy**: Import BLAST or Diamond hits to assign taxonomy.
    ```bash
    blobtools taxify -i hits.txt -t nodes.dmp -n names.dmp -o project_name.blobDB.json
    ```
4.  **Visualize**: Generate tabular summaries or graphical plots.
    ```bash
    blobtools view -i project_name.blobDB.json
    ```

## Module Reference
- **create**: Generates the base BlobDB. Requires a FASTA file.
- **view**: Exports a TSV file containing all data (GC content, coverage, taxonomy) for each scaffold.
- **plot**: Generates BlobPlots (scatter plots of GC vs. Coverage, scaled by length and colored by taxonomy).
- **covplot**: Generates read coverage distributions across the assembly.
- **seqfilter**: Filters the original FASTA file based on criteria defined in the BlobDB (e.g., removing scaffolds identified as Proteobacteria).
- **taxify**: Converts external search results (like BLAST outfmt 6) into a format compatible with BlobTools using a TaxID-mapping file.

## Best Practices
- **Taxonomic Rules**: Use the `--taxrule` flag (default: `bestsumorder`) to define how hits are aggregated. `bestsum` is often preferred for high-sensitivity contaminant detection.
- **Nodes and Names**: Ensure you have the NCBI `nodes.dmp` and `names.dmp` files available, as these are required for all taxonomic modules.
- **Filtering**: Use `blobtools view` to identify problematic scaffolds, then use `blobtools seqfilter` with the `--list` option to create a "clean" assembly.



## Subcommands

| Command | Description |
|---------|-------------|
| blobtools bamfilter | Filter BAM files based on contig inclusion/exclusion lists and mapping status. |
| blobtools covplot | Create coverage plots from BlobDB and coverage files. |
| blobtools create | Create a BlobDB from FASTA and associated data files. |
| blobtools seqfilter | Filter sequences from a FASTA file based on a list of headers. |
| blobtools taxify | Assigns taxonomic IDs to sequences based on similarity search results and a taxid mapping file. |
| blobtools view | View and filter a BlobDB database. |
| blobtools_map2cov | Map BAM/CAS files to a FASTA assembly to calculate coverage. |
| blobtools_nodesdb | NCBI nodes.dmp and names.dmp files are required to build the database. |
| blobtools_plot | Plotting tool for BlobDB files. |

## Reference documentation
- [BlobTools Overview](./references/blobtools_readme_io_docs_what-is-blobtools.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_blobtools_overview.md)