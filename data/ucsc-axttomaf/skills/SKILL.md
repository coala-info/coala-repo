---
name: ucsc-axttomaf
description: This tool converts pairwise alignment data from AXT format to MAF format. Use when user asks to convert AXT files to MAF files or transform pairwise alignment data.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-axttomaf

## Overview
The `axtToMaf` utility is a specialized tool within the UCSC Genome Browser "kent" source tree designed to transform pairwise alignment data. While AXT files are efficient for storing pairwise alignments, the MAF (Multiple Alignment Format) is the standard for representing multiple alignments and is required by many downstream bioinformatics tools. This skill provides the necessary command-line patterns to perform this conversion accurately, ensuring that sequence headers and coordinate systems are preserved.

## Command Line Usage

The basic syntax for `axtToMaf` requires the input alignment file, the chromosome sizes for both the target and query genomes, and the desired output filename.

### Basic Conversion
```bash
axtToMaf input.axt target.chrom.sizes query.chrom.sizes output.maf
```

### Parameters
- **input.axt**: The source pairwise alignment file.
- **target.chrom.sizes**: A tab-separated file containing `<chromName> <size>` for the target genome.
- **query.chrom.sizes**: A tab-separated file containing `<chromName> <size>` for the query genome.
- **output.maf**: The resulting Multiple Alignment Format file.

### Common Options
- **-tPrefix=name.**: Adds a prefix (e.g., "hg38.") to the target sequence names in the MAF file. This is highly recommended for clarity in multi-species alignments.
- **-qPrefix=name.**: Adds a prefix (e.g., "mm39.") to the query sequence names.
- **-scoreScheme=file**: Specifies a custom scoring matrix if the default is not appropriate for your alignment.

## Best Practices and Expert Tips

### 1. Prepare Chromosome Sizes
Before running the conversion, ensure your `.chrom.sizes` files are accurate. You can generate these from 2bit files using `twoBitInfo` or download them directly from the UCSC GoldenPath database. The sequence names in these files must match the names used in the AXT file exactly.

### 2. Use Assembly Prefixes
When working with multiple species, always use the `-tPrefix` and `-qPrefix` flags. MAF files often aggregate alignments from many sources; without prefixes like `hg38.chr1`, it becomes impossible to distinguish between chromosomes of different species that share the same name (e.g., `chr1`).

### 3. Permission Management
If you have just downloaded the binary from the UCSC server, you must grant execution permissions before it will run:
```bash
chmod +x axtToMaf
./axtToMaf
```

### 4. Validation
After conversion, you can verify the integrity of the MAF file using `mafCheck`. This ensures that the coordinates and sequences align with the provided chromosome sizes.

## Reference documentation
- [ucsc-axttomaf overview](./references/anaconda_org_channels_bioconda_packages_ucsc-axttomaf_overview.md)
- [UCSC Admin Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)