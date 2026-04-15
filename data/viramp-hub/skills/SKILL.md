---
name: viramp-hub
description: VirAmp-Hub converts viral amplicon primer scheme file formats. Use when user asks to convert viral amplicon primer schemes between formats, generate BEDPE schemes, generate amplicon info files, or handle nested primer schemes.
homepage: https://github.com/wm75/viramp-hub
metadata:
  docker_image: "quay.io/biocontainers/viramp-hub:0.1.0--pyhdfd78af_0"
---

# viramp-hub

## Overview

VirAmp-Hub is a specialized utility for handling the non-standardized file formats used to describe viral amplicon schemes. It facilitates the conversion of primer data between formats such as BED, BEDPE, and amplicon-info TSV files. This tool is particularly useful for researchers working with tiled-amplicon sequencing data (e.g., ARTIC network protocols) who need to ensure their primer schemes are compatible with specific analysis suites.

## Common CLI Patterns

The primary command for this tool is `scheme-convert`.

### Format Conversions

**Convert a standard BED scheme for use with ivar:**
```bash
scheme-convert primer_scheme.bed --to bed --bed-type ivar -o ivar.bed
```

**Generate an amplicon insert scheme for cojac:**
```bash
scheme-convert primer_scheme.bed --to bed --bed-type cojac -o cojac_insert.bed
```

**Generate a BEDPE format scheme:**
```bash
scheme-convert primer_scheme.bed --to bedpe -o scheme.bedpe
```

### Generating Amplicon Info Files

Amplicon info files are tab-separated files that group primers contributing to the same amplicon.

**Basic TSV generation:**
```bash
scheme-convert primer_scheme.bed --to amplicon-info -o info.tsv
```

**Handling nested primer schemes:**
For schemes with multiple primers per amplicon side, specify which primers to include in the info file:
*   **Inner primers only:** `scheme-convert primer_scheme.bed --to amplicon-info -r inner -o info.tsv`
*   **Outer primers only:** `scheme-convert primer_scheme.bed --to amplicon-info -r outer -o info.tsv`

## Expert Tips and Best Practices

### Overriding Autodetection
VirAmp-Hub uses a regular expression to automatically assign primers to amplicons based on their names:
`r'(?P<prefix>(.*_)*)(?P<num>\d+).*_(?P<name>L(?:EFT)?|R(?:IGHT)?)'`

If your primer naming convention does not match this pattern, autodetection will fail. In these cases, provide a manual amplicon info file using the `-a` flag to guide the conversion:
```bash
scheme-convert primer_scheme.bed -a manual_amplicon_info.tsv --to bed --bed-type cojac -o cojac_insert.bed
```

### Tool-Specific BED Types
When converting to BED format, always specify the `--bed-type` if the target tool is `ivar` or `cojac`. These tools expect specific column configurations and naming conventions that differ from standard 6-column BED files.

### Verification
After conversion, verify that the number of amplicons in the output matches your expectations, especially when using the `-r` (reporting) flag for nested schemes, as this filters the primer set.

## Reference documentation
- [VirAmp-Hub GitHub Repository](./references/github_com_wm75_viramp-hub.md)
- [VirAmp-Hub Bioconda Package](./references/anaconda_org_channels_bioconda_packages_viramp-hub_overview.md)