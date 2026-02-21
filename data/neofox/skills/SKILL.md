---
name: neofox
description: Neofox (NEOantigen Feature tOolboX) is a specialized tool designed to characterize neoantigen candidates by calculating a comprehensive suite of published and novel descriptors.
homepage: https://github.com/tron-bioinformatics/neofox
---

# neofox

## Overview
Neofox (NEOantigen Feature tOolboX) is a specialized tool designed to characterize neoantigen candidates by calculating a comprehensive suite of published and novel descriptors. It integrates multiple external prediction tools—such as netMHCpan, BLAST, and MixMHCpred—into a unified workflow to help researchers identify the most immunogenic peptide sequences for personalized medicine applications.

## Core CLI Usage
The primary interface for neofox is the command line. It requires an input file of candidates and a corresponding patient data file containing HLA information.

### Basic Execution
```bash
neofox --input-file neoantigens.tsv \
       --patient-data patient_metadata.txt \
       --output-folder ./results \
       --organism human
```

### Common Parameters
- `--input-file`: Path to a TSV or JSON file containing mutated peptide sequences.
- `--patient-data`: Path to a TSV file containing patient-specific metadata (specifically HLA alleles).
- `--organism`: Set to `human` (default) or `mouse`.
- `--rank-mhci-threshold`: Threshold for filtering MHC-I epitopes (e.g., `2.0`).
- `--num-cpus`: Number of threads to use for parallel processing.
- `--verbose`: Enables detailed logging for troubleshooting.

## Input Data Requirements
For tabular input (.tsv or .txt), the following columns are essential:
- **gene**: The HGNC gene symbol.
- **mutatedXmer**: The mutated amino acid sequence. Standard practice is a 27-mer with the mutation at the center (flanked by 13 amino acids on each side).
- **wildTypeXmer**: The non-mutated reference sequence of the same length.
- **patientIdentifier**: A unique ID that must match the identifier in the patient data file.

## Dependency Configuration
Neofox relies on several external bioinformatic tools. If these are not in your system PATH, you must provide a configuration file using the `--config` flag. The config file should define paths as follows:

```text
NEOFOX_BLASTP=/path/to/blastp
NEOFOX_NETMHCPAN=/path/to/netMHCpan
NEOFOX_NETMHC2PAN=/path/to/netMHCIIpan
```

## Best Practices and Tips
- **Sequence Length**: Ensure your `mutatedXmer` and `wildTypeXmer` are of equal length and that the mutation is correctly centered to allow for proper sliding window epitope extraction.
- **Mouse Data Limitations**: Be aware that certain features, such as PHBR-I/II, MixMHCpred, and Recognition Potential, are currently only supported for human data.
- **Memory Management**: When processing large datasets with `--with-all-neoepitopes`, ensure the machine has sufficient memory, as this flag generates annotations for every possible MHC-I and MHC-II neoepitope across all provided HLA alleles.
- **Thresholding**: Use `--rank-mhci-threshold` and `--rank-mhcii-threshold` to reduce output noise by excluding weak binders early in the annotation process.

## Reference documentation
- [NeoFox GitHub Repository](./references/github_com_TRON-Bioinformatics_neofox.md)