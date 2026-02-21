---
name: campygstyper
description: The `campygstyper` tool is a Python-based utility designed for the high-resolution taxonomic classification of *Campylobacter* species.
homepage: https://github.com/LanLab/campygstyper
---

# campygstyper

## Overview
The `campygstyper` tool is a Python-based utility designed for the high-resolution taxonomic classification of *Campylobacter* species. It automates the process of comparing query assemblies against a curated set of centroid genomes using `fastANI`. By applying a specific ANI threshold (94.2%), it determines whether an isolate belongs to a known genomic species or potentially represents a novel lineage.

## Installation and Dependencies
The tool is primarily distributed via Bioconda. It requires `fastANI` to be installed and available in your system's PATH.

```bash
conda install -c bioconda campygstyper
```

## Command Line Usage
The tool processes a directory of genomes and produces a single tabular report.

### Basic Command
```bash
campygstyper -i <INPUT_FOLDER> -o <OUTPUT_FILE> -t <THREADS>
```

### Arguments
- `-i, --query`: Path to the folder containing input genomes. **Note**: Files must have a `.fasta` extension to be recognized.
- `-o, --output`: Path for the resulting tab-delimited classification file.
- `-t, --thread`: Number of threads for `fastANI` execution (default: 4).

## Best Practices and Expert Tips
- **File Extensions**: Ensure your assembly files end strictly in `.fasta`. The tool filters for this specific suffix; files ending in `.fa`, `.fna`, or `.fasta.gz` will be ignored unless renamed or decompressed.
- **Novelty Detection**: Pay close attention to the `Possible Novel genomic species` column. If this is `True`, the highest ANI match was below 94.2%, suggesting the isolate may belong to a species not represented in the current centroid database.
- **Performance**: Since the tool relies on `fastANI` for many-to-many or many-to-one comparisons, increasing the thread count (`-t`) is highly recommended when processing large datasets (e.g., >50 genomes).
- **Reliability**: While the tool provides the "Matching centroid genome" even for novel species, these assignments are not taxonomically reliable if the ANI value is below the 94.2% threshold.

## Output Column Reference
The output TSV contains the following key fields:
1. **Query Genome**: Filename of the input genome.
2. **Highest ANI Value**: The top identity score found.
3. **Matching centroid genome**: Accession of the closest reference.
4. **Campylobacter Genomic Species**: The assigned species name.
5. **Possible Novel genomic species**: Boolean flag (True/False) indicating if the match is below the species-level threshold.

## Reference documentation
- [Bioconda campygstyper Overview](./references/anaconda_org_channels_bioconda_packages_campygstyper_overview.md)
- [CampyGStyper GitHub Repository](./references/github_com_LanLab_campygstyper.md)