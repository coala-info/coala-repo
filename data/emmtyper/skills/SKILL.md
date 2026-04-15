---
name: emmtyper
description: emmtyper identifies the emm gene type from Streptococcus pyogenes genomic assemblies for subtyping and surveillance. Use when user asks to identify emm types, subtype Streptococcus pyogenes, or perform genomic surveillance on assembly files.
homepage: https://github.com/MDUPHL/emmtyper
metadata:
  docker_image: "quay.io/biocontainers/emmtyper:0.2.0--py_0"
---

# emmtyper

## Overview
The emmtyper tool is a specialized command-line utility designed for the genomic surveillance of Streptococcus pyogenes. It automates the process of identifying the emm gene type, which is the primary subtyping method for this pathogen. By analyzing genomic assemblies, it provides rapid, reproducible typing results essential for clinical microbiology and epidemiological investigations.

## Usage Guidelines

### Basic Command Pattern
The primary workflow involves passing a FASTA assembly file to the tool.
```bash
emmtyper <assembly.fasta>
```

### Common CLI Operations
- **Single Assembly**: Run `emmtyper isolate_assembly.fasta` to get the emm type for a specific sample.
- **Batch Processing**: Use shell loops to process multiple assemblies in a directory:
  ```bash
  for f in *.fasta; do emmtyper "$f" >> results.tsv; done
  ```
- **Output Handling**: The tool typically outputs results to STDOUT. Redirect to a file (e.g., `> output.txt`) for downstream analysis.

### Best Practices
- **Input Quality**: Ensure the input FASTA files are high-quality assemblies (e.g., from SPAdes or SKESA). Fragmented assemblies may lead to partial emm gene detection.
- **Species Verification**: Only use this tool for Streptococcus pyogenes. Using it on other species will result in no hits or false positives.
- **Version Consistency**: When reporting types for longitudinal studies, ensure the same version of emmtyper is used to maintain consistency in subtype nomenclature.

## Reference documentation
- [emmtyper Overview](./references/anaconda_org_channels_bioconda_packages_emmtyper_overview.md)