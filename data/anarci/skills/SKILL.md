---
name: anarci
description: ANARCI (Antibody Numbering and Antigen Receptor ClassIfication) is a specialized bioinformatics tool designed to annotate amino acid sequences of antigen receptors.
homepage: http://opig.stats.ox.ac.uk/webapps/newsabdab/sabpred/anarci/
---

# anarci

## Overview
ANARCI (Antibody Numbering and Antigen Receptor ClassIfication) is a specialized bioinformatics tool designed to annotate amino acid sequences of antigen receptors. It automates the process of identifying variable domains and applying standardized numbering schemes, which is essential for structural modeling, CDR (Complementarity-Determining Region) identification, and comparative immunology.

## Usage Guidelines

### Basic Command Line Usage
The primary command for ANARCI is `ANARCI`. It accepts single sequences or FASTA files.

```bash
# Number a single sequence using the default IMGT scheme
ANARCI -i EVQLVESGGGLVQPGGSLRLSCAASGFTFSSYAMSWVRQAPGKGLEWVSAISGSGGSTYYADSVKGRFTISRDNSKNTLYLQMNSLRAEDTAVYYCAKDGITMVRGVIIDYWGQGTLVTVSS

# Number sequences from a FASTA file
ANARCI -i sequences.fasta -o output_results
```

### Selecting Numbering Schemes
Specify the numbering scheme using the `-s` or `--scheme` flag.
- **IMGT**: `-s imgt` (Default)
- **Kabat**: `-s kabat`
- **Chothia**: `-s chothia`
- **Martin (Enhanced Chothia)**: `-s martin`
- **AHo**: `-s aho`

*Note: TCR sequences are restricted to IMGT or AHo schemes.*

### Output Formats
ANARCI provides two primary output formats:
- **CSV (Horizontal)**: Useful for large-scale data analysis and spreadsheet integration.
- **Text (Vertical)**: Better for human readability and inspecting individual residue assignments.

```bash
# Output to CSV format
ANARCI -i input.fasta --csv
```

### Domain Filtering
By default, ANARCI identifies both antibody and TCR domains. To restrict the search to only immunoglobulin (antibody) domains, use the following flag:
```bash
ANARCI -i input.fasta --restrict ig
```

### Species Identification
ANARCI predicts the species of the input sequence based on the best HMM match. While the web interface is limited to human and mouse, the CLI tool supports a broader range of germlines available in the underlying database.

## Expert Tips
- **Sequence Validation**: Ensure input sequences are amino acids. ANARCI does not translate DNA sequences.
- **Multiple Domains**: ANARCI can identify multiple domains within a single protein chain (e.g., scFv constructs). It will output numbering for each identified domain separately.
- **Bitscore Thresholds**: The tool uses bitscore thresholds to determine domain hits. If a sequence is highly diverged, it may not receive a numbering assignment.

## Reference documentation
- [ANARCI Web App Overview](./references/opig_stats_ox_ac_uk_webapps_sabdab-sabpred_sabpred_anarci.md)
- [Bioconda ANARCI Package Details](./references/anaconda_org_channels_bioconda_packages_anarci_overview.md)