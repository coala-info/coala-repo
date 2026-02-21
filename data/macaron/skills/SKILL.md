---
name: macaron
description: MACARON (Multi-bAse Codon-Associated variant Re-annotatiON) is a specialized genomic framework designed to solve the "phased variant" problem in functional annotation.
homepage: https://github.com/waqasuddinkhan/MACARON-GenMed-LabEx
---

# macaron

## Overview
MACARON (Multi-bAse Codon-Associated variant Re-annotatiON) is a specialized genomic framework designed to solve the "phased variant" problem in functional annotation. Standard variant callers often annotate adjacent SNVs independently, leading to incorrect amino acid change predictions. MACARON identifies these clusters, merges the alternative alleles within the same codon, and provides a corrected functional annotation. It is particularly useful for researchers working with WGS/WES data who require high-precision protein-level effect predictions.

## Core Workflows

### Basic Execution
The primary entry point is the `MACARON` Python script. It requires an input VCF and produces a tab-delimited re-annotation file.

```bash
# Basic usage (assuming dependencies are in $PATH)
python MACARON -i input.vcf -o reannotated_output.txt
```

### GATK4 Integration
Modern workflows using GATK 4.x require specific flags. If using a version older than 4.1.4.1, you must use the `previous` flag due to changes in indexing commands.

```bash
# Standard GATK4 usage
python MACARON -i input.vcf --GATK /path/to/gatk-package.jar --gatk4

# For GATK versions between 4.0 and 4.1.4.1
python MACARON -i input.vcf --gatk4_previous
```

### Advanced Annotation Fields
To preserve or include specific annotations from other tools like VEP or SnpEff in the final output, use the `-f` flag.

```bash
# Include VEP CSQ fields or SnpEff EFF fields
python MACARON -i input.vcf -f CSQ
python MACARON -i input.vcf -f EFF
```

## Tool-Specific Best Practices

### Dependency Management
*   **Java Version**: Ensure OpenJDK 1.8 is available, as MACARON relies on GATK and SnpEff, which are Java-based.
*   **Path Resolution**: If `gatk` and `snpEff` are in your system `$PATH`, MACARON will detect them automatically. Otherwise, you must provide absolute paths via `--GATK` and `--SNPEFF`.
*   **SnpEff Wrappers**: MACARON can handle both the direct `.jar` files and the bioconda-style wrappers. It determines which to use based on the file extension (or lack thereof) provided in the path.

### Input Requirements & Compatibility
*   **Chromosome Notation**: The `chr` prefix (e.g., `chr22` vs `22`) must be consistent across the input VCF, the Reference Genome fasta, and the SnpEff database.
*   **Reference Consistency**: Always use the exact same reference genome assembly (e.g., GRCh38) that was used for the initial alignment and variant calling.
*   **Annotation Matching**: Ensure the SnpEff database version matches your reference (e.g., `GRCh38.86` for hg38).

### Validation of Co-occurrence
Identifying a pcSNV in a VCF doesn't guarantee the variants are on the same physical chromosome (cis). Use the included validation script to check read-level evidence.

```bash
# Validate that SNVs exist on the same reads
./MACARON_validate.sh <params>
```

## Expert Tips
*   **Eco-friendly Mode**: Use `-c` or `--eco-friendly` to disable the CLI animations. This is recommended for HPC environments or when redirecting logs to a file to avoid cluttering the output with progress characters.
*   **Temporary Files**: By default, MACARON cleans up its `macaron_tmp` directory. If a run fails, use `--keep_temp` to inspect intermediate files for debugging.
*   **Memory Allocation**: Since MACARON calls GATK and SnpEff, ensure your environment has sufficient heap space allocated for Java operations.

## Reference documentation
- [MACARON User Guide](./references/github_com_waqasuddinkhan_MACARON-GenMed-LabEx.md)
- [Interpretation of MACARON Output](./references/github_com_waqasuddinkhan_MACARON-GenMed-LabEx_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_macaron_overview.md)