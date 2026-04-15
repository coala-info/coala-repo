---
name: snpsift
description: SnpSift is a command-line utility used to filter, annotate, and manipulate VCF files containing genetic variants. Use when user asks to filter variants using logical expressions, annotate VCFs with external databases, extract specific fields into tabular format, or perform case-control association studies.
homepage: http://snpeff.sourceforge.net/SnpSift.html
metadata:
  docker_image: "quay.io/biocontainers/snpsift:5.4.0a--hdfd78af_0"
---

# snpsift

## Overview
SnpSift is a powerful command-line utility designed to process VCF files post-annotation (typically after SnpEff). It excels at "VCF-arithmetic"—allowing you to sift through thousands of variants using logical expressions, intersect data with genomic intervals, and convert messy VCF data into clean, analysis-ready tables. It is the standard tool for downstream bioinformatic filtering of annotated genetic variants.

## Core Workflows

### 1. Filtering Variants (SnpSift filter)
The most common task is extracting variants that meet specific biological criteria.
- **Basic syntax**: `java -jar SnpSift.jar filter "EXPRESSION" input.vcf > output.vcf`
- **Common Expressions**:
    - Quality and Depth: `"(QUAL > 30) & (DP > 10)"`
    - Effect Impact: `"(ANN[*].IMPACT = 'HIGH') | (ANN[*].IMPACT = 'MODERATE')"`
    - Allele Frequency: `"(AF < 0.01) & (isHom(GEN[0]))"` (Rare homozygous variants in the first sample)
    - Multiple Effects: Use `ANY` or `ALL` for array fields: `"(ANY ANN[*].EFFECT has 'missense_variant')"`

### 2. Annotating with External Databases (SnpSift annotate)
Add information from a database VCF (e.g., dbSNP) to your query VCF.
- **Command**: `java -jar SnpSift.jar annotate database.vcf input.vcf > output.vcf`
- **Tip**: Ensure the database VCF is indexed (using `tabix`) for significantly faster performance.

### 3. Extracting Fields to Tab (SnpSift extractFields)
Convert VCF data into a TSV format for R, Excel, or Python analysis.
- **Command**: `java -jar SnpSift.jar extractFields input.vcf CHROM POS REF ALT "ANN[*].GENE" "GEN[*].GT"`
- **Note**: Use `ANN[*].GENE` to get all gene names in an effect array, or `ANN[0].GENE` for just the primary effect.

### 4. Intervals and Intersections (SnpSift intervals)
Filter variants that fall within specific genomic regions (BED files).
- **Command**: `java -jar SnpSift.jar intervals regions.bed input.vcf > output.vcf`
- **Requirement**: The VCF must be sorted by chromosome and position.

### 5. Case-Control Studies (SnpSift caseControl)
Identify variants associated with a phenotype by comparing groups.
- **Command**: `java -jar SnpSift.jar caseControl "CC+CC+CC-CC-" input.vcf > output.vcf`
- **Logic**: The string `CC+CC+CC-CC-` defines the status of samples in the VCF (e.g., first two are cases '+', next two are controls '-').

## Expert Tips
- **Memory Management**: For large VCFs, always allocate enough heap space to the JVM: `java -Xmx4g -jar SnpSift.jar ...`
- **Piping**: SnpSift is designed for streaming. Chain commands to avoid intermediate files:
  `cat input.vcf | java -jar SnpSift.jar filter "..." | java -jar SnpSift.jar annotate ... > final.vcf`
- **Handling Multiple Effects**: Remember that `ANN` is an array. If a variant has multiple transcripts, `ANN[*].FEATURE` will return a list. Use specific indices if you only care about the "best" effect.

## Reference documentation
- [SnpSift Official Documentation](./references/snpeff_sourceforge_net_SnpSift.html.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_snpsift_overview.md)