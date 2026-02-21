---
name: phigaro
description: Phigaro is a specialized bioinformatics pipeline designed to detect prophage sequences within genomic data.
homepage: https://phigaro.readthedocs.io/
---

# phigaro

## Overview
Phigaro is a specialized bioinformatics pipeline designed to detect prophage sequences within genomic data. It processes FASTA files to locate viral regions, provides taxonomic classifications, and can visualize results through interactive HTML maps. It is particularly effective for large-scale metagenomic datasets where manual annotation is impractical, offering a scalable way to mine prophage regions from complex assemblies.

## Installation and Setup
Before running Phigaro for the first time, you must initialize the environment and download the necessary pVOG databases.

- **Standard Setup**: Run `phigaro-setup` to download databases and configure the tool.
- **Rootless/Conda Setup**: If you do not have sudo privileges or are using a Conda environment, use:
  `phigaro-setup --no-updatedb`
- **Manual Database Path**: If the automatic download fails, download the pVOG database manually and specify the path in the `config.yml` located at `$HOME/.phigaro/config.yml`.

## Common CLI Patterns

### Basic Prophage Prediction
To run a standard analysis on a genome assembly:
`phigaro -f input_assembly.fasta -o output_folder/sample_name`

### Multi-format Output
Phigaro defaults to HTML output. For downstream bioinformatics analysis, it is often necessary to generate GFF or TSV files:
`phigaro -f input.fasta -o output_dir -e html tsv gff bed`

### High-Throughput Metagenomics
When processing large metagenomic files, use these flags to improve performance and relevance:
- `-t [THREADS]`: Increase the number of CPUs (default is 4).
- `-d`: Automatically exclude short sequences (<20,000 bp) which are unlikely to contain full prophages.
- `--not-open`: Prevent the HTML report from automatically opening in a browser.

### Advanced Analysis Modes
Phigaro supports three mathematical modes for prediction:
- `basic`: The default mode, balanced for most use cases.
- `abs`: Uses absolute thresholds.
- `without_gc`: Ignores GC content fluctuations, useful for genomes with highly irregular GC distributions.

Example: `phigaro -f input.fasta -o output_dir -m without_gc`

## Expert Tips
- **Precomputed Data**: If you have already run Prodigal or HMMER on your samples, you can skip these steps in Phigaro to save time using the `-S` flag:
  `phigaro -f input.fasta -S prodigal:path/to/prodigal.out -S hmmer:path/to/hmmer.out`
- **Phage VOGs**: To see which specific Phage Volatile Organic Groups (pVOGs) were detected in each region, add the `-p` flag.
- **Memory Management**: For very large metagenomes (>500MB), ensure you have sufficient RAM for the HMMER search phase, or split the FASTA file into smaller chunks.

## Reference documentation
- [Phigaro Usage](./references/phigaro_readthedocs_io_en_latest_usage.md)
- [Getting Started](./references/phigaro_readthedocs_io_en_latest_getting_started.md)
- [Phigaro Overview](./references/anaconda_org_channels_bioconda_packages_phigaro_overview.md)