---
name: funcannot
description: This tool annotates genetic variants in a VCF file with functional information like cDNA, protein, and mutation types. Use when user asks to annotate variants in a VCF file with functional information.
homepage: https://github.com/BioTools-Tek/funcannot
metadata:
  docker_image: "quay.io/biocontainers/funcannot:v2.8--0"
---

# funcannot

funcannot/
├── SKILL.md
└── references/
    ├── anaconda_org_channels_bioconda_packages_funcannot_overview.md
    └── github_com_mtekman_funcannot.md
```

SKILL.md:
```yaml
name: funcannot
description: Annotates cDNA, protein, mutation type, and other functional changes to variants in a VCF file using pre-existing gene annotations. Use when you have a VCF file containing genetic variants and need to enrich it with functional annotations derived from gene information. This is particularly useful for understanding the potential impact of variants on genes, proteins, and cDNA sequences.
```
## Overview
The `funcannot` tool is designed to enrich Variant Call Format (VCF) files with functional annotations. It leverages pre-existing gene annotations to determine the cDNA, protein, and mutation types associated with genetic variants. This process helps in understanding the biological significance of variants found in sequencing data.

## Usage Instructions

`funcannot` operates by taking a VCF file as input and annotating it with functional information. The primary requirement is a VCF file and a gene annotation database.

### Core Command Structure

The basic command structure involves specifying the input VCF file and the output file.

```bash
funcannot -i <input.vcf> -o <output.vcf> [options]
```

### Key Options and Best Practices

*   **`-i <input.vcf>` / `--input <input.vcf>`**: Specifies the input VCF file. Ensure this file is correctly formatted.
*   **`-o <output.vcf>` / `--output <output.vcf>`**: Specifies the output VCF file where annotations will be written.
*   **Gene Annotation Database**: `funcannot` relies on a gene annotation database. The documentation implies this is handled by `genepender`. Ensure `genepender` is installed and configured correctly, as `funcannot` likely uses its output or integrates with it. The exact method of specifying the gene annotation source might be implicit through `genepender`'s setup or require a specific flag not detailed in the provided snippets.
*   **Mutation Type Annotation**: The tool is designed to annotate mutation types (e.g., missense, silent, frameshift). This is a core function.
*   **cDNA and Protein Annotation**: It annotates changes at the cDNA and protein levels, providing detailed functional context for each variant.

### Expert Tips

*   **VCF Quality**: Always ensure your input VCF file is properly sorted and filtered before running `funcannot`. This can improve annotation accuracy and processing speed.
*   **`genepender` Integration**: Familiarize yourself with `genepender`'s requirements and output, as `funcannot`'s functionality is tightly coupled with it. If `funcannot` is not producing expected results, troubleshooting `genepender`'s setup is often the first step.
*   **Output Verification**: After running `funcannot`, carefully inspect the output VCF file. Check the INFO field for new annotation tags related to cDNA, protein, and mutation type.

## Reference documentation
- [Overview of funcannot](./references/anaconda_org_channels_bioconda_packages_funcannot_overview.md)
- [funcannot GitHub Repository](./references/github_com_mtekman_funcannot.md)