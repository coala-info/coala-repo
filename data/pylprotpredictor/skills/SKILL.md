---
name: pylprotpredictor
description: PylProtPredictor is a specialized bioinformatics pipeline designed to overcome the challenge of identifying proteins containing Pyrrolysine.
homepage: http://bebatut.fr/PylProtPredictor/
---

# pylprotpredictor

## Overview
PylProtPredictor is a specialized bioinformatics pipeline designed to overcome the challenge of identifying proteins containing Pyrrolysine. Standard gene prediction tools often truncate these proteins at the first UAG codon, misinterpreting it as a stop signal. This tool automates a two-step workflow: first, it predicts Coding Sequences (CDS) using Prodigal and identifies those ending in TAG; second, it extends these sequences and validates them against a reference database (like UniRef90) using DIAMOND to determine if the extended version is a more likely biological match than the truncated one.

## Usage Instructions

### Environment Setup
The tool is typically managed via Conda. Ensure the environment is active before execution:
```bash
conda activate PylProtPredictor
```

### Basic Command Line Pattern
To run the full prediction and validation pipeline, provide a genome file and an output directory:
```bash
pylprotpredictor --genome <path_to_genome.fasta> --output <output_directory>
```

### Database Management
The tool requires a reference database for the validation step. By default, it uses UniRef90.
*   **First Run:** If no database is provided, the tool will download and format UniRef90. This requires ~25GB of disk space and significant time.
*   **Using Existing Databases:** To save time and bandwidth, point to existing FASTA or DIAMOND (.dmnd) files:
    ```bash
    pylprotpredictor --genome genome.fasta --output ./results \
      --reference_fasta_db /path/to/uniref90.fasta \
      --reference_dmnd_db /path/to/uniref90.dmnd
    ```

### Output Structure
The tool generates an output directory containing:
1.  Predicted CDS files.
2.  DIAMOND alignment reports.
3.  A final report identifying which TAG-ending sequences were successfully extended and conserved as potential PYL proteins.

## Best Practices and Tips
*   **Disk Space:** Ensure at least 30GB of free space is available if you allow the tool to download the reference database automatically.
*   **Pre-formatting:** If you frequently run the tool, manually format your reference database using `diamond makedb` to ensure the `.dmnd` file is ready, then pass it via the `--reference_dmnd_db` flag.
*   **Input Quality:** Use high-quality contig or full genome sequences in FASTA format. The tool relies on Prodigal for initial CDS detection, so standard genomic FASTA headers are preferred.
*   **Validation Logic:** A sequence is "conserved" as a PYL protein only if the extension results in a lower e-value and a longer alignment compared to the original truncated sequence.

## Reference documentation
- [Usage](./references/bebatut_fr_PylProtPredictor_usage.html.md)
- [Identification of potential PYL proteins](./references/bebatut_fr_PylProtPredictor_pylprotpredictor.html.md)
- [Installation](./references/bebatut_fr_PylProtPredictor_installation.html.md)