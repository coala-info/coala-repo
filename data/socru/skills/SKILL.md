---
name: socru
description: socru describes and compares the macro-structure of bacterial genomes by using ribosomal operons as genomic landmarks to determine the order and orientation of intervening sequences. Use when user asks to characterize genomic rearrangements, determine the structural profile of a complete assembly, or identify novel chromosomal orientations.
homepage: https://github.com/quadram-institute-bioscience/socru
---


# socru

## Overview
The `socru` tool provides a standardized way to describe and compare the macro-structure of bacterial genomes. By using ribosomal operons as stable genomic landmarks, it defines the "order and orientation" of the intervening sequences. This is particularly valuable when working with long-read sequencing data (PacBio/Oxford Nanopore) where complete, single-contig assemblies allow for the exploration of large-scale rearrangements that are often invisible in short-read draft assemblies.

## Usage Patterns

### Basic Workflow
1. **Identify the Database**: Check if your species is supported by the bundled databases.
   ```bash
   socru_species
   ```
2. **Run Analysis**: Execute the main script against a complete assembly (FASTA format).
   ```bash
   socru <species_name> <assembly.fasta>
   ```
   *Example*: `socru Escherichia_coli K12.fasta`

### Common CLI Options
- **Multi-threading**: Use up to 4 threads for optimal performance; benefits diminish beyond this point.
  ```bash
  socru <species> <assembly.fasta> --threads 4
  ```
- **Non-circular Genomes**: If the assembly is linear or not fully circularized, use the `-c` flag.
  ```bash
  socru <species> <assembly.fasta> --not_circular
  ```
- **Custom Databases**: Point to a specific directory containing custom species databases.
  ```bash
  socru <species> <assembly.fasta> --db_dir /path/to/custom_dbs/
  ```

## Expert Tips and Best Practices

### Input Requirements
- **Complete Assemblies Only**: `socru` is designed for complete chromosomes (usually 1 contig). Do not use it on short-read draft assemblies, as these cannot resolve the large repeats (rrn regions) necessary for structural determination.
- **Gzipped Inputs**: The tool natively supports `.fasta.gz` files, saving disk space.

### Interpreting Results
- **Standard Output**: The output typically follows the format: `Filename Profile_ID Fragment_Order`.
- **Novel Profiles**: If the output contains a `0` in the fragment order, it indicates a novel arrangement. Check the file specified by `--novel_profiles` (default: `profile.txt.novel`) to investigate whether this is a legitimate biological variant or an assembly error.
- **Unclassified Fragments**: Fragments that cannot be classified are written to the file specified by `--new_fragments`. These should be checked for potential contamination or highly divergent sequences.

### Database Management
- Use `socru_create` to build a new species database if your target organism is not bundled.
- If you encounter a novel but legitimate reorientation (indicated by an integer of 1 or more in the novel profile file), you can manually update the `profile.txt` in your database directory to include it.

## Reference documentation
- [socru GitHub Repository](./references/github_com_quadram-institute-bioscience_socru.md)
- [socru Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_socru_overview.md)