---
name: pass
description: PASS performs de novo assembly of short and long peptide fragments into protein sequences. Use when user asks to assemble peptide reads, perform de novo protein assembly, or conduct targeted assembly using seed sequences.
homepage: https://github.com/bcgsc/PASS
metadata:
  docker_image: "quay.io/biocontainers/pass:0.3.1--hdfd78af_0"
---

# pass

## Overview
PASS (Protein Assembler with Short Sequences) is a specialized tool for the de novo assembly of peptide fragments. Derived from the SSAKE genomic assembly algorithm, it is designed to handle millions of very short (starting at 6 amino acids) to long peptide sequences. It works by populating a hash table of unique reads, sorting them by abundance to minimize the impact of sequencing errors, and progressively extending seed sequences through k-mer overlap analysis and consensus building.

## Installation
The most efficient way to install PASS is via Bioconda:
```bash
conda install bioconda::pass
```

## Command Line Usage

### Basic Assembly
To run a standard de novo assembly with a minimum depth of coverage:
```bash
PASS -f peptide_reads.fa -w 1 -b assembly_results
```

### Targeted Assembly
If you have specific sequences to use as seeds for recruitment:
```bash
PASS -f peptide_reads.fa -s seeds.fa -i 1 -b targeted_assembly
```

### Parameter Tuning
*   **Overlap Sensitivity**: Use `-m` to set the minimum number of overlapping amino acids required to extend a contig (default is 10).
*   **Consensus Stringency**: 
    *   `-o`: Minimum number of peptide reads needed to call an amino acid during extension (default is 2).
    *   `-r`: Minimum ratio required to accept a consensus amino acid (default is 0.7).
*   **Memory Management**: Use `-h 1` to ignore read headers/names, which significantly reduces RAM usage when processing millions of reads.

### Common CLI Flags
| Flag | Description | Default |
| :--- | :--- | :--- |
| `-f` | Input FASTA file containing peptide reads (Required) | N/A |
| `-w` | Minimum depth of coverage allowed for contigs | Required |
| `-b` | Basename for output files | N/A |
| `-m` | Minimum overlapping amino acids for extension | 10 |
| `-o` | Min reads to call an amino acid | 2 |
| `-r` | Min ratio for consensus amino acid | 0.7 |
| `-i` | Independent (de novo) assembly (1=yes, 0=no) | 1 |
| `-c` | Track amino acid coverage and read position | 0 |
| `-v` | Verbose mode | 0 |

## Best Practices
*   **Input Formatting**: Ensure peptide sequences are in standard FASTA format. PASS v0.3.1+ supports MS-DOS/Windows formatted FASTA files.
*   **Error Mitigation**: PASS automatically sorts reads by decreasing abundance. This heuristic assumes that reads containing errors are less frequent than error-free counterparts.
*   **Contig Merging**: For complex datasets, the resulting contigs may benefit from a secondary Multiple Sequence Alignment (MSA) step using tools like T-Coffee, Clustal, or MUSCLE to merge overlapping contigs into larger scaffolds.
*   **Tie-Breaking**: If the assembly stalls due to ties in consensus calling, use `-q 1` to pick a random amino acid and attempt to continue the extension.

## Reference documentation
- [github_com_bcgsc_PASS.md](./references/github_com_bcgsc_PASS.md)
- [anaconda_org_channels_bioconda_packages_pass_overview.md](./references/anaconda_org_channels_bioconda_packages_pass_overview.md)