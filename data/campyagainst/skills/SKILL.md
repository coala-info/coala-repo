---
name: campyagainst
description: This tool taxonomically classifies *Campylobacter* genomic data by comparing query genomes against reference centroids using fastANI. Use when user asks to classify Campylobacter isolates, assign genomes to species clusters, or identify potentially novel genomic species.
homepage: https://github.com/LanLab/campyagainst
metadata:
  docker_image: "quay.io/biocontainers/campyagainst:0.1.0--pyhdfd78af_0"
---

# campyagainst

## Overview
The campyagainst skill (utilizing the campygstyper tool) provides a specialized workflow for taxonomically classifying Campylobacter genomic data. By comparing query genomes against a curated set of reference centroids using fastANI, it assigns genomes to known species clusters or flags them as potentially novel if they fall below the 94.2% ANI threshold. This is essential for researchers working with Campylobacter isolates that require higher resolution than standard 16S rRNA sequencing can provide.

## Installation
The tool is available via Bioconda. Ensure `fastANI` is installed in your environment as it is a required dependency.

```bash
conda install bioconda::campyagainst
```

## Command Line Usage
The primary command used by this skill is `campygstyper`. It processes a directory of FASTA files and produces a summary table.

### Basic Syntax
```bash
campygstyper -i <input_folder> -o <output_file.tsv> -t <threads>
```

### Parameters
- `-i, --query`: Path to the folder containing input genomes. All files must have the `.fasta` extension.
- `-o, --output`: Path for the resulting tab-delimited classification file.
- `-t, --thread`: Number of CPU threads for fastANI (default is 4).

## Best Practices and Tips
- **File Extensions**: The tool strictly looks for the `.fasta` suffix. If your files end in `.fa`, `.fna`, or `.fastq`, you must rename or symlink them to `.fasta` before running the analysis.
- **ANI Threshold**: The tool uses a 94.2% ANI cutoff. If the "Possible Novel genomic species" column returns `True`, the genome did not match any known centroid at this level. While the highest match is still reported in the output, it should be considered unreliable for species-level assignment.
- **Performance**: Since the tool relies on fastANI for many-to-many or many-to-one comparisons, increasing the thread count (`-t`) significantly reduces processing time for large datasets.
- **Interpreting Results**:
    - **Highest ANI Value**: Indicates the similarity to the closest reference.
    - **Campylobacter Genomic Species**: The formal name assigned to the matching cluster.
    - **ANI cluster number**: Useful for tracking internal consistency across different runs.

## Reference documentation
- [CampyGStyper GitHub Repository](./references/github_com_LanLab_campygstyper.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_campyagainst_overview.md)