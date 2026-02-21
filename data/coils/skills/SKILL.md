---
name: coils
description: Coils is a specialized bioinformatics tool used to identify potential coiled-coil regions within protein sequences.
homepage: https://rostlab.org/owiki/index.php/Packages#Package_overview
---

# coils

## Overview
Coils is a specialized bioinformatics tool used to identify potential coiled-coil regions within protein sequences. It compares a target sequence against databases of known coiled-coils using a sliding window approach. This skill enables the prediction of structural motifs characterized by the wrapping of two or more alpha-helices around each other, which is a common feature in many fibrous proteins and transcription factors.

## Usage Guidelines

### Basic Command Structure
The standard execution of coils requires an input protein sequence in FASTA format.
```bash
coils -i <input_file.fasta> -o <output_file>
```

### Key Parameters and Optimization
- **Window Size**: Use the `-w` flag to set the sliding window size. Common values are 14, 21, or 28.
    - Use **14** for detecting short or fragmented coiled-coils.
    - Use **28** for high-confidence identification of long, stable coiled-coil domains.
- **Weighting**: Use the `-c` flag to assign equal weights to all positions in the heptad repeat. By default, positions 'a' and 'd' (the hydrophobic core) are weighted more heavily.
- **Matrix Selection**: Choose the scoring matrix that best fits your organism or protein type. The MTIDK matrix is generally preferred for most applications.

### Interpreting Results
- **Probability Scores**: Coils outputs a probability (0.0 to 1.0). A score above 0.5 is generally considered a potential coiled-coil, while scores above 0.9 indicate high confidence.
- **Heptad Positions**: The output maps residues to the 'abcdefg' heptad repeat positions. Pay close attention to the 'a' and 'd' positions, as these typically contain the hydrophobic residues driving the interaction.

## Best Practices
- **Sequence Filtering**: Before running coils, ensure the input sequence is a protein sequence. Non-protein characters will cause errors.
- **Comparative Analysis**: Always run coils with multiple window sizes (e.g., 14 and 28) to distinguish between short motifs and extended structural domains.
- **False Positives**: Be aware that highly hydrophobic or repetitive sequences may occasionally yield high scores without forming true coiled-coils. Cross-reference results with other structural prediction tools if the protein is poorly characterized.

## Reference documentation
- [coils - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_coils_overview.md)