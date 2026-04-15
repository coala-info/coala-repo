---
name: igdtools
description: This tool converts VCF files to the Indexable Genotype Data (IGD) format and processes IGD files. Use when user asks to convert VCF to IGD, extract allele frequencies, view variant statistics, restrict variants by range or frequency, or filter samples.
homepage: https://aprilweilab.github.io/
metadata:
  docker_image: "quay.io/biocontainers/igdtools:2.6--py312h5e9d817_0"
---

# igdtools

Tools for converting VCF files to the Indexable Genotype Data (IGD) format and processing them.
  Use when you need to efficiently store, access, or analyze genetic variation data, especially for large-scale genomic datasets.
  This skill is particularly useful for converting VCF or VCF.GZ files into the more compact and faster-to-access IGD format, or for performing operations directly on IGD files.
body: |
  ## Overview
  The `igdtools` utility, part of the `picovcf` library, provides efficient tools for managing genetic variation data. Its primary function is to convert standard VCF (Variant Call Format) files, including compressed `.vcf.gz` files, into the Indexable Genotype Data (IGD) format. IGD is designed for speed and reduced memory footprint, making it ideal for large genomic datasets. The tool also supports direct processing and conversion of IGD files.

  ## Usage

  The `igdtools` command-line interface offers various functionalities for VCF to IGD conversion and IGD file manipulation.

  ### Core Functionality: VCF to IGD Conversion

  To convert a VCF or VCF.GZ file to the IGD format:

  ```bash
  igdtools <input_vcf_file> -o <output_igd_file>
  ```

  *   Replace `<input_vcf_file>` with the path to your VCF or VCF.GZ file.
  *   Replace `<output_igd_file>` with the desired name for the output IGD file.

  ### Processing IGD Files

  `igdtools` can also be used to process existing IGD files, such as extracting statistics or converting between formats.

  #### Extracting Allele Frequencies

  To pipe allele frequencies to a file:

  ```bash
  igdtools <input_igd_file> -a > allele.freq.tsv
  ```

  #### Viewing Variant/Sample Statistics and Header Information

  To display statistics and header information from an IGD file:

  ```bash
  igdtools <input_igd_file> --stats --info
  ```

  #### Restricting Variants by Base-Pair Range

  To focus on variants within a specific genomic range (e.g., base pairs 10000 to 20000):

  ```bash
  igdtools <input_igd_file> --range 10000-20000
  ```

  #### Restricting Variants by Frequency

  To filter variants based on their allele frequency (e.g., greater than or equal to 0.01):

  ```bash
  igdtools <input_igd_file> --frange 0.01-1.0
  ```

  #### Copying and Filtering IGD Files

  You can copy an IGD file to a new file while applying filters:

  ```bash
  igdtools <input_igd_file> -o <output_igd_file> --range 100000-500000 --frange 0.01-0.5
  ```
  This command copies the input IGD to the output IGD, including only variants within the specified range and frequency.

  ### Advanced Options

  *   **Force Ploidy**: Use `--force-ploidy <N>` to specify the ploidy for unphased data, where `<N>` is the ploidy number.
  *   **Sample Filtering**: Use `-S` or `--samples` followed by a list of individual IDs to keep only those samples during conversion. This is analogous to `bcftools`'s sample filtering.

  ### Command-Line Help

  For a comprehensive list of all available options and their descriptions, run:

  ```bash
  igdtools --help
  ```

  ## Expert Tips

  *   **Compression and Speed**: IGD is significantly smaller and faster to read than compressed VCF files (`.vcf.gz`). For large datasets, converting to IGD first can dramatically improve subsequent analysis speed and reduce storage requirements.
  *   **Tabix Integration**: The `picovcf` library, which `igdtools` is part of, supports Tabix indexes. This allows for rapid seeking to specific regions within VCF files, which can be leveraged for parallel processing of VCF data. While `igdtools` itself might not directly expose all Tabix functionalities in its CLI, understanding this underlying support is key for optimizing VCF processing workflows.
  *   **Parallel Processing**: Recent versions of `igdtools` support parallel processing for VCF.GZ to IGD conversion and metadata export, significantly speeding up these operations on multi-core systems.

  ## Reference documentation
  - [igdtools overview on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_igdtools_overview.md)
  - [picovcf GitHub repository README](./references/github_com_aprilweilab_picovcf.md)