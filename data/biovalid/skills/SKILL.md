---
name: biovalid
description: Biovalid is a lightweight Python utility used to validate the structural integrity and format compliance of genomic data files. Use when user asks to validate bioinformatics files, check for formatting errors in FASTA or VCF files, or perform pre-flight checks on genomic data.
homepage: https://github.com/RIVM-bioinformatics/biovalid
metadata:
  docker_image: "quay.io/biocontainers/biovalid:0.4.0--pyhdfd78af_0"
---

# biovalid

## Overview
Biovalid is a lightweight, dependency-free Python utility designed for the rapid validation of genomic data files. It functions as a robust gatekeeper in bioinformatics workflows, verifying that files are structurally sound and adhere to format-specific standards (such as proper header sequences in FASTA or correct column counts in VCF). By performing these checks before resource-intensive downstream analysis, users can catch common formatting errors early.

## Installation
Install biovalid via Conda or Pip:
```bash
conda install bioconda::biovalid
# OR
pip install biovalid
```

## CLI Usage Patterns
The tool is invoked as a Python module.

### Basic Validation
Validate a single file to check for integrity and format compliance:
```bash
python3 -m biovalid -i path/to/sample.fasta
```

### Batch Directory Validation
Point the tool at a directory to validate all supported bioinformatics files within that folder:
```bash
python3 -m biovalid -i ./raw_data/
```

### Scripting and Automation Mode
Use the boolean mode (`-b`) when integrating biovalid into shell scripts. This returns a simple True/False result instead of raising detailed exceptions, making it easier to handle in conditional logic:
```bash
python3 -m biovalid -i sample.bam -b
```

### Detailed Logging
For troubleshooting complex file errors, enable verbose output and redirect logs to a specific file:
```bash
python3 -m biovalid -i sample.vcf -v -l validation_report.log
```

## Library Usage
Biovalid can be imported directly into Python scripts for programmatic validation.

```python
from biovalid import BioValidator

# Initialize the validator
validator = BioValidator(file_paths="/path/to/data.fastq", verbose=True)

# Execute validation
# Returns True if valid, or raises an exception (unless bool_mode is set)
is_valid = validator.validate_files()
```

## Best Practices
- **Pre-flight Check**: Always run biovalid immediately after data transfer or demultiplexing and before starting long-running alignment or assembly tasks.
- **Index Verification**: The tool supports `.bai` files; ensure your BAM indices are validated alongside the primary BAM files to prevent "index not found" or "index mismatch" errors in genome browsers.
- **Format Support**: Use biovalid specifically for BAM, FASTA, FASTQ, VCF, GFF, and BAI. For other formats like SAM or BCF, convert to a supported format or use specialized tools like `samtools quickcheck`.

## Reference documentation
- [biovalid Overview](./references/anaconda_org_channels_bioconda_packages_biovalid_overview.md)
- [biovalid GitHub Repository](./references/github_com_RIVM-bioinformatics_biovalid.md)