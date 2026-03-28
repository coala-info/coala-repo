---
name: tracknado
description: Tracknado automates the creation of UCSC Genome Browser track hubs by scanning directories for genomic data files and generating the required configuration files. Use when user asks to create a track hub, generate hub configuration files, or validate a local hub directory.
homepage: https://pypi.org/project/tracknado/
---


# tracknado

## Overview
Tracknado is a specialized utility designed to automate the tedious process of building UCSC Genome Browser track hubs. Instead of manually writing configuration files, it scans directories for genomic data files and generates the necessary `hub.txt`, `genomes.txt`, and `trackDb.txt` files. This is particularly useful for researchers managing large-scale sequencing projects who need to quickly visualize their results in a genomic context.

## Usage Guidelines

### Core Command Pattern
The primary way to use tracknado is by pointing it at a directory containing your processed genomic files:
```bash
tracknado [options] <input_directory> <output_directory>
```

### Supported File Types
Tracknado automatically recognizes and categorizes the following formats:
- **BigWig (.bw, .bigWig)**: Continuous signal data (e.g., ChIP-seq coverage).
- **BigBed (.bb, .bigBed)**: Annotated regions or peaks.
- **BAM (.bam)**: Aligned reads (requires corresponding .bai index).
- **VCF (.vcf.gz)**: Variant calls (requires corresponding .tbi index).

### Best Practices
- **Naming Conventions**: Tracknado often uses filenames to determine track labels. Ensure your files are named descriptively (e.g., `CellType_Treatment_Rep1.bw`) before running the tool.
- **Indexing**: Ensure all BAM and VCF files are indexed in the same directory. Tracknado will skip files that lack valid indices.
- **Genome Assembly**: Always specify the correct assembly (e.g., `hg38`, `mm10`) to ensure the track hub coordinates match the browser's reference.
- **Organization**: Group files by experiment or sample type within the input directory to help tracknado create logical track groupings or composite tracks.

### Common CLI Options
- `--genome`: Specify the assembly (e.g., `hg38`).
- `--hub`: Set the name of the track hub.
- `--email`: Provide a contact email (required by UCSC for hub metadata).
- `--public`: Generate a URL-ready structure for hosting on public servers or S3 buckets.



## Subcommands

| Command | Description |
|---------|-------------|
| create | Create a UCSC track hub from a set of files. |
| merge | Merge tracknado configurations or data |
| validate | Validate a local hub directory or hub.txt file. Performs structural checks and uses the UCSC 'hubCheck' tool if available to ensure the hub is correctly formatted and accessible. |

## Reference documentation
- [Tracknado on PyPI](./references/pypi_org_project_tracknado.md)
- [Tracknado Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tracknado_overview.md)