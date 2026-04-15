---
name: genomicassertions
description: genomicassertions is a Python testing framework that provides specialized unittest assertions for validating genomic data in VCF and BAM files. Use when user asks to verify variants at specific coordinates, check sample genotypes, validate BAM header metadata, or confirm read coverage levels.
homepage: https://github.com/ClinSeq/genomicassertions
metadata:
  docker_image: "quay.io/biocontainers/genomicassertions:0.2.5--pyh864c0ab_3"
---

# genomicassertions

## Overview

genomicassertions is a Python-based testing framework that extends the standard `unittest` library with specialized assertions for genomic data. It allows developers and bioinformaticians to write robust tests for the output of variant callers and alignment tools. By using mixin classes, it provides a declarative way to check for the existence of variants at specific coordinates, verify sample genotypes (calls), and validate BAM header metadata or read coverage. This tool is essential for regression testing in bioinformatics pipelines where file integrity and data accuracy are paramount.

## Installation and Requirements

Install the package via pip:
```bash
pip install genomicassertions
```

### File Preparation
The tool relies on random access for performance. Files must meet the following criteria:
- **VCF files**: Must be compressed with `bgzip` and indexed with `tabix`.
- **BAM files**: Must be indexed (e.g., using `samtools index`).

## Core Usage Patterns

To use the assertions, inherit from `unittest.TestCase` and the appropriate mixin class.

### VCF Validation (VariantAssertions)
Import `VariantAssertions` to test VCF files.

- **Basic Existence**: `assertVcfHasVariantAt(vcf_path, chrom, pos)`
- **Specific Alleles**: `assertVcfHasVariantWithChromPosRefAlt(vcf_path, chrom, pos, ref, alt)`
- **Sample Presence**: `assertVcfHasSample(vcf_path, sample_name)`
- **Genotype/Call Details**: `assertVcfHasVariantWithCall(vcf_path, chrom, pos, sample, call)`
  - The `call` parameter is a dictionary of fields to check (e.g., `{'GT': '1/1', 'DP': 20}`). It does not need to be exhaustive.

### BAM Validation (ReadAssertions)
Import `ReadAssertions` to test alignment files.

- **Coverage Checks**: `assertBamHasCoverageAt(bam_path, coverage, chrom, pos)`
- **Header Metadata**: 
  - `assertBamHasHeaderElement(bam_path, header_element)` (e.g., check for "HD")
  - `assertBamHeaderElementEquals(bam_path, element_name, value_dict)` (e.g., check if `SO` is `coordinate`)

## Execution via CLI

Since genomicassertions is a library for `unittest`, you execute your tests using the standard Python test runners:

```bash
# Run all tests in a file
python -m unittest test_genomics_outputs.py

# Run using pytest (if installed)
pytest test_genomics_outputs.py
```

## Expert Tips and Best Practices

1. **Partial Call Matching**: When using `assertVcfHasVariantWithCall`, only include the fields critical to your test case in the dictionary. This makes tests more resilient to changes in secondary attributes like `GQ` or `AD` if you only care about the `GT`.
2. **Coordinate Systems**: Ensure you are using the coordinate system expected by the underlying libraries (typically 1-based for VCF assertions in this package, matching the VCF format itself).
3. **Performance**: Always index your files. The tool is designed to use the index for "random access," which prevents the need to parse the entire file, significantly speeding up CI/CD loops.
4. **Integration**: Use these assertions in your pipeline's integration test suite to catch regressions in variant calling logic or alignment parameters.

## Reference documentation
- [genomicassertions README](./references/github_com_ClinSeq_genomicassertions.md)