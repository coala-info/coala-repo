---
name: clermontyping
description: ClermonTyping determines the evolutionary phylogroup of *Escherichia* samples by performing digital PCR assays on whole-genome sequencing data. Use when user asks to identify the phylogroup of an E. coli strain, perform digital Clermont PCR assays, or analyze the evolutionary lineage of genomic assemblies.
homepage: https://github.com/happykhan/ClermonTyping
---

# clermontyping

## Overview
ClermonTyping is a specialized bioinformatics tool designed to replicate the Clermont PCR assays in a digital environment. It processes whole-genome sequencing (WGS) data—specifically FASTA contig files—to determine the evolutionary lineage (phylogroup) of an *Escherichia* sample. This is essential for epidemiological studies, as different phylogroups are often associated with specific ecological niches, hosts, or pathogenic potentials. The tool combines BLAST-based detection of specific marker genes (arpA, chuA, yjaA, and TspE4.C2) with Mash-based genomic distance estimation to provide a highly accurate classification.

## Usage Guidelines

### Primary Workflow
The standard entry point is the `clermonTyping.sh` wrapper script, which automates the BLAST and Mash steps.

```bash
# Analyze a single FASTA file
clermonTyping.sh --fasta /path/to/strain.fasta --name my_analysis

# Analyze multiple files simultaneously (use @ as a separator)
clermonTyping.sh --fasta strain1.fasta@strain2.fasta@strain3.fasta
```

### Key Parameters
- `--threshold <int>`: Filters out contigs smaller than the specified size. Use this to improve accuracy by ignoring small, potentially noisy fragments.
- `--minimal`: Reduces output clutter by generating only the essential result files.
- `--fastafile <file>`: Instead of listing files on the CLI, provide a text file containing one absolute path per line.

### Advanced/Modular Execution
If you need to bypass the R-based reporting or Mash analysis, you can run the components independently:

1.  **BLAST Preparation**: Format your assembly and search against the internal primer database.
    ```bash
    makeblastdb -in strain.fasta -dbtype nucl -out strain_db
    blastn -query ./data/primers.fasta -db strain_db -outfmt 5 -out strain.xml
    ```
2.  **Phylogroup Assignment**: Run the Python logic directly on the BLAST XML.
    ```bash
    bin/clermont.py -x strain.xml -s [min_size_threshold]
    ```

### Interpreting Results
- **analysis_phylogroups.txt**: The primary TSV output.
    - **Column 2**: Genes detected (e.g., `['trpA', 'trpBA']`).
    - **Column 3**: The Quadruplex status (presence/absence of arpA, chuA, yjaA, TspE4.C2).
    - **Column 5**: The final phylogroup conclusion.
- **analysis.html**: A visual summary table comparing the Clermont PCR logic against the Mash-based prediction.

## Expert Tips
- **Concordance**: The tool maintains ~99% concordance with in vitro PCR. If a discrepancy occurs between the "Phylogroup" and "Mash" columns in the HTML report, investigate potential horizontal gene transfers or SNPs in the primer binding sites.
- **Input Quality**: Ensure your FASTA files are assemblies (contigs/scaffolds). Raw reads must be assembled before using ClermonTyping.
- **Dependencies**: Ensure `blastn`, `mash`, `Biopython`, and `R` (with `dplyr`/`tidyr`) are in your environment path for the full wrapper script to function.



## Subcommands

| Command | Description |
|---------|-------------|
| blastn | Nucleotide-Nucleotide BLAST 2.5.0+ |
| clermontyping_clermonTyping.sh | Missing the contigs file. Option --fasta or --fastafile |
| makeblastdb | Application to create BLAST databases, version 2.5.0+ |

## Reference documentation
- [ClermonTyping README](./references/github_com_happykhan_ClermonTyping_blob_master_README.md)
- [ClermonTyping Shell Script Reference](./references/github_com_happykhan_ClermonTyping_blob_master_clermonTyping.sh.md)