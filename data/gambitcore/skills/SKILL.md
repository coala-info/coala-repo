---
name: gambitcore
description: `gambitcore` is a specialized bioinformatics tool designed for the taxonomic identification and quality assessment of bacterial genome assemblies.
homepage: https://github.com/gambit-suite/gambitcore
---

# gambitcore

## Overview
`gambitcore` is a specialized bioinformatics tool designed for the taxonomic identification and quality assessment of bacterial genome assemblies. It functions by comparing the k-mer profile of an input assembly against a reference database of species-specific core genomes. Beyond simple identification, it provides a quantitative "completeness" metric, allowing researchers to determine if an assembly represents a full core genome or if it is missing critical genomic content due to sequencing gaps or assembly errors.

## Command Line Usage
The tool requires a GAMBIT database directory and one or more FASTA files (which can be gzipped).

`gambitcore [options] <gambit_directory> <fasta_filenames>`

### Common CLI Patterns
- **Standard Analysis**: Run with default settings to get a full report including species ID, completeness percentage, and QC status.
  `gambitcore /path/to/gambit_db/ sample.fasta`
- **Batch Processing**: Process multiple assemblies simultaneously.
  `gambitcore /path/to/gambit_db/ assemblies/*.fasta`
- **Concise Output**: Use the `-e` flag for a tab-delimited summary (Filename, Species, Completeness) ideal for downstream scripting.
  `gambitcore -e /path/to/gambit_db/ sample.fasta`
- **Multi-threading**: Speed up processing for large datasets by specifying CPU cores.
  `gambitcore -p 8 /path/to/gambit_db/ *.fasta`

## Expert Tips and Best Practices
- **Database Requirements**: Ensure your `gambit_directory` contains at least one file ending in `.gdb` and one ending in `.gs`. The tool relies on these specific file extensions to locate the database and signatures.
- **K-mer Constraints**: Avoid modifying the `--kmer` (-k) or `--kmer_prefix` (-f) parameters. These must match the parameters used to build the GAMBIT signatures file; changing them will result in incorrect or null matches.
- **Interpreting the Assembly QC (RAG Status)**:
  - **Green**: The assembly k-mer count is within 2 standard deviations of the species mean. This indicates a high-quality, expected genome size.
  - **Amber**: The count is between 2 and 3 standard deviations. This suggests a potential issue with fragmentation or minor contamination.
  - **Red**: The count is more than 3 standard deviations from the mean. This usually indicates significant contamination (if too high) or severe assembly failure/missing data (if too low).
- **Core Proportion Tuning**: The default `--core_proportion` is 0.98 (98%). If you are working with highly divergent strains or very "open" pangenomes, you may need to slightly lower this value to see core k-mers, though this is rarely necessary for standard pathogen identification.
- **Handling Identification Failures**: If the underlying GAMBIT tool cannot make a confident species or subspecies level call, `gambitcore` will skip the completeness calculation. Ensure your database is comprehensive for the taxa you are investigating.

## Reference documentation
- [Bioconda gambitcore Overview](./references/anaconda_org_channels_bioconda_packages_gambitcore_overview.md)
- [GAMBITcore GitHub Repository](./references/github_com_gambit-suite_gambitcore.md)