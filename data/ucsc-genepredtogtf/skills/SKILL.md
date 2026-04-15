---
name: ucsc-genepredtogtf
description: This tool converts gene models from UCSC genePred format to GTF format. Use when user asks to convert gene models from genePred format to GTF, transform gene annotation files, or convert gene tracks.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-genepredtogtf:482--h0b57e2e_0"
---

# ucsc-genepredtogtf

## Overview
The `genePredToGtf` utility is a specialized tool from the UCSC Kent toolkit used to transform gene models from the UCSC-specific `genePred` format into the standard GTF format. This is a critical step in bioinformatics workflows when you have downloaded gene tracks (like RefSeq, GENCODE, or UCSC Genes) directly from the UCSC Table Browser or MySQL database and need to use them with software that requires GTF input.

## Installation
The tool is most easily installed via Bioconda:
```bash
conda install bioconda::ucsc-genepredtogtf
```

## Common CLI Patterns

### Basic File Conversion
To convert a standalone `.gp` (genePred) file to GTF:
```bash
genePredToGtf input.gp output.gtf
```

### Converting Extended genePred Files
If your input file is in the "extended" genePred format (which includes gene names and other metadata), use the `file` argument:
```bash
genePredToGtf file input.gp output.gtf
```

### Direct Database Conversion
If you have a local `.hg.conf` file configured to connect to the UCSC MySQL server, you can convert a table directly:
```bash
genePredToGtf hg38 refGene output.gtf
```

## Expert Tips and Best Practices

### 1. Handling Source Labels
By default, the tool may use "genePred" as the source column in the GTF. Use the `-source` flag to provide a more descriptive label (e.g., "RefSeq" or "GENCODE") for better compatibility with downstream tools:
```bash
genePredToGtf -source=MyAnnotation input.gp output.gtf
```

### 2. Preserving Gene Names
Standard genePred files often use transcript IDs in the first column. If you are using an extended genePred file that contains a separate gene name column, ensure you are using the `file` mode to correctly populate the `gene_id` and `transcript_id` attributes in the GTF.

### 3. Permission Errors
If you download the binary directly from the UCSC server instead of using Conda, you must grant execution permissions before use:
```bash
chmod +x ./genePredToGtf
./genePredToGtf input.gp output.gtf
```

### 4. Validation
Before conversion, it is recommended to validate the integrity of your input file using `genePredCheck` (another UCSC utility) to ensure there are no coordinate overflows or structural errors that could lead to a malformed GTF.

### 5. GTF Compatibility
The output of this tool is a standard GTF. However, always check if your downstream tool requires specific attributes (like `gene_biotype`). `genePredToGtf` provides a clean, standard conversion, but it does not "invent" metadata not present in the source genePred file.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-genepredtogtf_overview.md)
- [UCSC Executable Directory Guide](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)