---
name: snpeff
description: SnpEff is a genomic variant annotation and effect prediction tool.
homepage: http://snpeff.sourceforge.net/
---

# snpeff

## Overview
SnpEff is a genomic variant annotation and effect prediction tool. It processes VCF (Variant Call Format) files to determine how specific genetic variations affect known genes and protein sequences. It is essential for prioritizing variants in clinical genomics, population genetics, and evolutionary biology by categorizing mutations based on their predicted functional impact (HIGH, MODERATE, LOW, or MODIFIER).

## Core CLI Patterns

### Basic Annotation
The primary command for annotating a VCF file.
```bash
# Basic usage: snpEff [database_name] [input.vcf] > [output.vcf]
snpEff GRCh38.105 input.vcf > annotated_output.vcf
```

### Database Management
SnpEff requires a specific database for the organism/genome build being analyzed.
```bash
# List all available databases
snpEff databases | grep -i "human"

# Download a specific database
snpEff download GRCh38.105
```

### Common Options and Flags
- `-stats [file.html]`: Generates a detailed HTML report containing summary statistics (transition/transversion ratios, variant counts by type).
- `-noStats`: Disables report generation to speed up processing.
- `-csvStats [file.csv]`: Outputs statistics in CSV format for downstream automated analysis.
- `-canon`: Only use canonical transcripts for annotation (reduces output complexity).
- `-ud [distance]`: Set the upstream/downstream interval size (default is 5000 bases).

## Expert Tips & Best Practices

### Memory Management
SnpEff is Java-based and can be memory-intensive for large genomes. If running via a wrapper or directly via JAR:
- Use `-Xmx8g` (or higher) to allocate sufficient heap space.
- Example: `java -Xmx8g -jar snpEff.jar GRCh38.105 input.vcf > output.vcf`

### Handling Multiple Annotations
By default, SnpEff provides annotations for all overlapping transcripts. To simplify downstream filtering:
1. Use the `-canon` flag to focus on the most biologically relevant transcript.
2. Use the `-onePerLine` flag to output one effect per line in the VCF (useful for simple parsing).

### Integration with SnpSift
SnpEff is often used in tandem with **SnpSift** to filter the resulting VCF.
- **Filter by Impact**: `cat annotated.vcf | SnpSift filter "( ANN[*].IMPACT = 'HIGH' )"`
- **Filter by Gene**: `cat annotated.vcf | SnpSift filter "( ANN[*].GENE = 'BRCA1' )"`

### VCF Versioning
Ensure your input VCF coordinates match the database version exactly (e.g., do not use a GRCh38 database for a hg19/GRCh37 VCF).

## Reference documentation
- [SnpEff Overview](./references/anaconda_org_channels_bioconda_packages_snpeff_overview.md)
- [SnpEff Documentation](./references/snpeff_sourceforge_net_index.md)