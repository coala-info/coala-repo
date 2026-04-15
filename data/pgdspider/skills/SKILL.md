---
name: pgdspider
description: pgdspider is a universal data converter for various population genetics and genomics file formats. Use when user asks to convert genomic data files, transform NGS data between different formats, or prepare input files for population genetics programs like Arlequin and STRUCTURE.
homepage: http://www.cmpg.unibe.ch/software/PGDSpider/
metadata:
  docker_image: "quay.io/biocontainers/pgdspider:2.1.1.5--hdfd78af_1"
---

# pgdspider

## Overview
pgdspider is a Java-based utility designed to bridge the gap between various population genetics and genomics software programs. It acts as a universal converter for over 30 different file formats, including DNA sequences, SNPs, microsatellites, and NGS data. While it features a GUI, its command-line interface (CLI) is the primary method for integration into automated bioinformatics pipelines. It is particularly useful for preparing data for programs like Arlequin, STRUCTURE, and MIGRATE-n.

## Command Line Usage
The CLI version of pgdspider requires a configuration file (SPID file) that defines the parameters for the conversion.

### Basic Execution
To run a conversion from the terminal, use the following syntax:
```bash
java -Xmx1024m -Xms512m -jar PGDSpider3-cli.jar -inputfile <input_path> -inputformat <FORMAT> -outputfile <output_path> -outputformat <FORMAT> -spid <settings_file.spid>
```

### Key Arguments
- `-inputfile`: Path to the source data.
- `-inputformat`: The format of the source data (e.g., VCF, GENEPOP).
- `-outputfile`: Path where the converted file will be saved.
- `-outputformat`: The target format (e.g., ARLEQUIN, STRUCTURE).
- `-spid`: Path to the Structure Parameter Identification (SPID) file containing specific conversion settings.

## Best Practices and Expert Tips
- **Memory Management**: pgdspider loads the entire input file into RAM. For large NGS files (like VCFs), increase the Java heap size using `-Xmx` (e.g., `-Xmx4G` or higher) to avoid `OutOfMemoryError`.
- **Generating SPID Files**: The most efficient way to create a `.spid` file is to use the PGDSpider GUI once on a local machine, configure the specific conversion options (e.g., ploidy, locus types, population definitions), and save the settings. This file can then be used in headless CLI environments.
- **Genomic Subsetting**: If a file is too large for the available RAM, use pgdspider's ability to convert specific subsets or regions of NGS files to perform sliding window analyses or targeted conversions.
- **Intermediate Format**: Since version 3.0, pgdspider uses an internal PGD object for conversion. If you encounter errors in direct conversion, ensure your SPID file is updated to the version 3.x standard.
- **External Dependencies**: Conversions involving BAM, SAM, BCF, or VCF formats may require `samtools` or `bcftools` to be present in the system PATH.

## Reference documentation
- [PGDSpider Overview](./references/software_bioinformatics_unibe_ch_pgdspider.md)
- [Bioconda PGDSpider Package](./references/anaconda_org_channels_bioconda_packages_pgdspider_overview.md)