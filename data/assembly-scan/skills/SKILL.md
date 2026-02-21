---
name: assembly-scan
description: `assembly-scan` is a lightweight utility designed to provide immediate insights into the quality and composition of genomic assemblies.
homepage: https://github.com/rpetit3/assembly-scan
---

# assembly-scan

## Overview
`assembly-scan` is a lightweight utility designed to provide immediate insights into the quality and composition of genomic assemblies. It serves as a fast alternative to complex perl scripts, offering a streamlined way to extract critical metrics like N50, total assembly length, and nucleotide percentages directly from FASTA files. It is particularly useful for bioinformaticians needing to validate assembly integrity or prepare summary data for downstream reporting.

## Installation
The recommended way to install `assembly-scan` is via Bioconda:
```bash
conda install -c conda-forge -c bioconda assembly-scan
```

## Common CLI Patterns

### Basic Usage
Generate a tab-delimited summary of an assembly:
```bash
assembly-scan input_assembly.fasta
```

### Readable Terminal Output
Use the `--transpose` flag to flip the output into a vertical key-value format, which is much easier to read in a terminal window:
```bash
assembly-scan input_assembly.fasta --transpose
```

### JSON for Downstream Automation
For integration with Python scripts or command-line JSON processors like `jq`, use the `--json` flag:
```bash
assembly-scan input_assembly.fasta --json
```

### Handling Compressed Files
The tool natively supports gzip-compressed FASTA files. You do not need to decompress them first:
```bash
assembly-scan assembly.fasta.gz --json
```

### Customizing Sample IDs
By default, the tool uses the file's basename as the sample ID. Use `--prefix` to provide a specific identifier for your reports:
```bash
assembly-scan assembly.fasta --prefix "Patient_A_Primary"
```

## Expert Tips

### Batch Processing
`assembly-scan` processes one file at a time. To process multiple assemblies and combine them into a single TSV, use a simple loop:
```bash
for f in *.fasta; do assembly-scan "$f"; done > all_stats.tsv
```

### Quality Control Thresholds
When evaluating assembly quality, focus on these specific metrics provided in the output:
- **n50_contig_length**: The standard metric for assembly contiguity.
- **l50_contig_count**: The smallest number of contigs whose lengths sum to 50% of the assembly.
- **contig_percent_n**: High percentages of 'N's may indicate poor scaffolding.
- **num_contig_non_acgtn**: Useful for identifying files with unexpected IUPAC ambiguity codes or formatting errors.

### Integration with jq
If using JSON output, you can quickly extract specific metrics across multiple samples:
```bash
assembly-scan sample.fasta --json | jq '.n50_contig_length'
```

## Reference documentation
- [assembly-scan GitHub Repository](./references/github_com_rpetit3_assembly-scan.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_assembly-scan_overview.md)