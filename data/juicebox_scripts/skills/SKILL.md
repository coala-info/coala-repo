---
name: juicebox_scripts
description: The `juicebox_scripts` suite provides essential utilities for bioinformaticians working with Hi-C data to curate genome assemblies.
homepage: https://github.com/phasegenomics/juicebox_scripts
---

# juicebox_scripts

## Overview

The `juicebox_scripts` suite provides essential utilities for bioinformaticians working with Hi-C data to curate genome assemblies. It bridges the gap between the Juicebox visualization tool and standard genomic file formats. Use this skill to translate manual edits made in Juicebox (such as contig breaks, joins, or reorientations) back into updated FASTA, AGP, and BED files, or to prepare initial assembly files from existing genomic data.

## Core Workflows and CLI Usage

### 1. Post-Juicebox Assembly Conversion
After modifying an assembly in Juicebox and exporting a `.assembly` file, use `juicebox_assembly_converter.py` to generate updated genomic files.

**To generate new scaffold-level files:**
This produces outputs matching the scaffolding represented in Juicebox.
```bash
python juicebox_assembly_converter.py -a <modified_assembly> -f <original_fasta> -p <output_prefix>
```

**To generate contig-only files:**
Use this if you only want to reflect contig breaks made in Juicebox without applying the scaffolding.
```bash
python juicebox_assembly_converter.py -a <modified_assembly> -f <original_fasta> -c
```

### 2. Preparing Juicebox Inputs
Before visualization, you may need to convert existing assembly descriptions into the Juicebox-compatible `.assembly` format.

**Convert AGP to Assembly:**
```bash
python agp2assembly.py <input_agp> <output_assembly>
```

**Convert FASTA to AGP:**
```bash
python makeAgpFromFasta.py <input_fasta> <output_agp>
```

### 3. Handling Gap Contigs
If `juicebox_assembly_converter.py` fails because gaps are explicitly included as contigs in your `.assembly` file, use `degap_assembly.py` to clean the file.
```bash
python degap_assembly.py <has_gaps.assembly> > <no_gaps.assembly>
```

## Expert Tips and Best Practices

- **File Consistency**: Always ensure that the `.hic` file and the `.assembly` file used together in Juicebox were generated from the same source. Mismatches in contig names or lengths between these files will lead to errors during conversion.
- **Contig Breaks**: When using Juicebox to identify misjoins, the `-c` (contig mode) in the converter is the safest way to obtain a "cleaned" set of contigs for a subsequent round of scaffolding.
- **Output Prefixing**: Use the `-p` flag in the converter to keep your workspace organized, as the tool generates multiple files (FASTA, AGP, BED, and a break report) simultaneously.
- **Dependency Note**: These scripts are designed to work within a pipeline that often includes `matlock` and `3d-dna`. If generating a `.hic` file from a BAM, ensure you use `matlock bam2 juicer` followed by a coordinate sort before running the assembly visualizer.

## Reference documentation
- [Juicebox Scripts Overview](./references/anaconda_org_channels_bioconda_packages_juicebox_scripts_overview.md)
- [Juicebox Utilities and Workflows](./references/github_com_phasegenomics_juicebox_scripts.md)