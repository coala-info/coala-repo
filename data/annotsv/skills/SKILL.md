---
name: annotsv
description: AnnotSV provides functional annotation and clinical ranking for structural variations by integrating multiple data sources. Use when user asks to annotate structural variants from VCF or BED files, rank variants according to ACMG guidelines, or interpret the functional impact of deletions, duplications, and translocations.
homepage: https://github.com/lgmgeo/AnnotSV
metadata:
  docker_image: "quay.io/biocontainers/annotsv:3.5.3--py313hdfd78af_0"
---

# annotsv

## Overview

AnnotSV is a comprehensive tool designed for the functional annotation and clinical ranking of structural variations. It streamlines the process of interpreting SVs by integrating multiple annotation sources into a single output, allowing researchers and clinicians to identify pathogenic variants efficiently. The tool supports various SV types, including deletions, duplications, inversions, and translocations, and provides specific ranking scores based on ACMG guidelines.

## Installation and Setup

Install AnnotSV via Bioconda for the most stable environment:
```bash
conda install -c bioconda annotsv
```

Before running annotations, you must download and install the required annotation databases using the provided setup script:
```bash
# Navigate to the AnnotSV installation directory or use the absolute path
./INSTALL_annotations.sh
```

## Common CLI Patterns

### Basic Annotation
Annotate a VCF file using a specific genome build (e.g., GRCh38):
```bash
AnnotSV -SVinput input.vcf -genomeBuild GRCh38 -outputFile annotated_variants.tsv
```

### Using BED Input
AnnotSV accepts BED files for SV coordinates. Ensure the BED file follows the standard format (chrom, start, end):
```bash
AnnotSV -SVinput variants.bed -genomeBuild GRCh37 -outputFile output.tsv
```

### Handling Missing Genotypes
To control how samples with missing alleles (e.g., `./.`) are reported in the `Samples_ID` field, use the following flag:
```bash
AnnotSV -SVinput input.vcf -missingGTinSamplesid 0  # 0 to hide, 1 to show
```

### CHM13 Support
For T2T-CHM13 genome builds, ensure you specify the build correctly to trigger the appropriate liftover and annotation logic:
```bash
AnnotSV -SVinput input.vcf -genomeBuild CHM13 -outputFile chm13_annotations.tsv
```

## Expert Tips and Best Practices

- **ACMG Ranking**: AnnotSV provides automated ranking based on ACMG criteria. Always review the `AnnotSV_ranking_criteria` column in the output to understand which rules (e.g., 4O, 40) were triggered for a specific variant.
- **VCF Compatibility**: Ensure your VCF follows the 4.2 specification. For complex variants like translocations (BND), AnnotSV relies on standard square-bracket notation.
- **Memory Management**: When processing very large VCFs with coupled breakends (BNDs), increase the available system memory, as the variant-extractor component can be resource-intensive.
- **External Tool Integration**:
    - **Exomiser**: To use Exomiser scores, ensure the `application.properties` file in the Exomiser directory is correctly configured and accessible to AnnotSV.
    - **PhenoGenius**: Use the `-phenogenius` flag if you have HPO terms available for the sample to improve prioritization.
- **Output Interpretation**: AnnotSV produces two types of lines in the TSV output:
    - **"full"**: One line per SV, providing a global view.
    - **"split"**: One line per gene overlapped by the SV, providing detailed gene-level context.

## Reference documentation
- [AnnotSV GitHub Repository](./references/github_com_lgmgeo_AnnotSV.md)
- [Bioconda AnnotSV Overview](./references/anaconda_org_channels_bioconda_packages_annotsv_overview.md)
- [AnnotSV Commit History (Feature Updates)](./references/github_com_lgmgeo_AnnotSV_commits_master.md)