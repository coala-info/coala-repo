---
name: primedrpa
description: PrimedRPA is a specialized bioinformatic tool designed to automate and refine the selection of oligonucleotides for RPA.
homepage: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA/
---

# primedrpa

## Overview
PrimedRPA is a specialized bioinformatic tool designed to automate and refine the selection of oligonucleotides for RPA. Unlike standard PCR, RPA has specific requirements for primer length and sequence composition to ensure efficient recombinase loading and strand displacement. This skill assists in executing the PrimedRPA workflow, which integrates sequence alignment via Clustal Omega and cross-reactivity screening using BLASTn and Samtools to produce optimized RPA-specific primer and probe sets.

## Usage Patterns

### Installation and Environment
PrimedRPA is best managed within a dedicated Conda environment to handle its dependencies (Clustal Omega, BLAST+, and Samtools).

```bash
# Create and activate the environment
conda create -n rpa_design -c bioconda primedrpa
conda activate rpa_design
```

### Running the Tool
The tool is typically invoked as a Python module or via the installed entry point. It supports two primary methods for parameter input: direct command-line arguments or a configuration file.

**Method 1: Parameter File (Recommended)**
Using a parameter file ensures reproducibility and allows for complex configurations.
```bash
PrimedRPA --parameters PrimedRPA_Parameters.txt
```

**Method 2: Command Line Arguments**
For quick runs or simple overrides, parameters can be passed directly.
```bash
PrimedRPA --input sequences.fasta --run_id experiment_01 --output ./results
```

### Key Output Files
After a successful run, the tool generates three core CSV files prefixed with your `[RunID]`:
1. **Alignment Summary**: Details the consensus and conservation of the input sequences.
2. **Oligo Binding Sites**: Lists all potential primer and probe locations identified across the target.
3. **Output Sets**: Provides the final recommended combinations of forward primers, reverse primers, and internal probes.

## Best Practices
- **Sequence Diversity**: When designing for multiple strains, ensure your input FASTA contains a representative set of sequences; PrimedRPA uses Clustal Omega to find conserved regions suitable for RPA.
- **Cross-Reactivity**: Ensure `blastn` is in your system PATH. PrimedRPA uses it to check for off-target binding, which is critical for RPA due to the lower temperature (37-42°C) compared to PCR.
- **Parameter Tuning**: If the tool returns zero sets, consider relaxing the "Advanced Cross Reactivity Percentage" or adjusting the target amplicon length (typically 100-200bp for RPA).

## Reference documentation
- [PrimedRPA GitHub Repository](./references/github_com_MatthewHiggins2017_bioconda-PrimedRPA.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_primedrpa_overview.md)
- [PrimedRPA Wiki Landing Page](./references/github_com_MatthewHiggins2017_bioconda-PrimedRPA_wiki.md)