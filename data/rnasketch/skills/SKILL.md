---
name: rnasketch
description: RNAsketch is a toolkit for designing nucleic acid sequences that meet specific structural objectives. Use when user asks to design multistate RNA sequences, create temperature-sensitive switches, engineer ligand-responsive riboswitches, or design sRNA co-folding interactions.
homepage: https://github.com/ViennaRNA/RNAsketch
---

# rnasketch

## Overview
RNAsketch is a specialized toolkit for nucleic acid sequence design, extending the capabilities of the ViennaRNA package. It allows for the engineering of complex RNA devices by optimizing sequences to meet specific structural objectives. This skill provides the procedural knowledge to use its core design scripts for creating bistable molecules, temperature-sensitive switches, and ligand-responsive systems.

## Core Design Workflows

### Multistate Design
Use `design-multistate.py` to create a single RNA sequence capable of folding into multiple distinct conformations (e.g., a bistable switch).

*   **Input**: Provide target structures in dot-bracket notation, separated by newlines.
*   **Command**:
    ```bash
    echo -e '(((((....)))))....\n....(((((....)))))' | design-multistate.py -i -m random -s 500
    ```
*   **Parameters**:
    *   `-i`: Interactive mode/read from stdin.
    *   `-m`: Optimization method (e.g., `random`, `adaptive`).
    *   `-s`: Number of optimization steps.

### Thermoswitch Design
Use `design-thermoswitch.py` to design sequences that change their Minimum Free Energy (MFE) structure based on temperature.

*   **Input**: Structure followed by the target temperature.
*   **Command**:
    ```bash
    echo -e "(((((((((((((....))))))))))))) 5.0\n(((((.....)))))(((((.....))))) 10.0\n(((((.....)))))............... 37.0" | design-thermoswitch.py -m random -s 1000
    ```

### Ligand-Triggered Switches
Use `design-ligandswitch.py` to design riboswitches that respond to small molecules (like theophylline). This utilizes soft constraints to model ligand binding.

*   **Command Pattern**:
    ```bash
    echo -e "TARGET_STRUCTURE_1\nTARGET_STRUCTURE_2\nSEQUENCE_CONSTRAINTS" | design-ligandswitch.py -r 70:30 --ligand "LIGAND_MOTIF;LIGAND_STRUCTURE;ENERGY_CONTRIBUTION"
    ```
*   **Example (Theophylline)**:
    ```bash
    echo -e "(((((...((((((((.....)))))...)))...)))))...\n....(((((((((((......)))))))))))...\nAAGUGAUACCAGCAUCGUCUUGAUGCCCUUGGCAGCACUUCANNNNNN" | design-ligandswitch.py -r 70:30 --ligand "GAUACCAG&CCCUUGGCAGC;(...((((&)...)))...);-9.22"
    ```

### sRNA Co-folding Design
Use `design-cofold.py` to design interactions between two RNA molecules, such as an sRNA binding to a 5'UTR to regulate translation.

*   **Command**:
    ```bash
    echo 'STRUCTURE_A&STRUCTURE_B\nCONSTRAINTS_A&CONSTRAINTS_B' | design-cofold.py -n 1 -s 1000
    ```

## Expert Tips
*   **Sequence Constraints**: Use `N` for any nucleotide, or specific bases (A, C, G, U) in your input strings to preserve functional motifs like Ribosome Binding Sites (RBS) or Start Codons (AUG).
*   **Boltzmann Sampling**: For more advanced sampling that accounts for the ensemble of states rather than just the MFE, use `design-redprint-multistate.py`. This requires the `REDPRINT` environment variable to be set to the RNARedPrint path.
*   **Validation**: Always validate designs using other ViennaRNA tools. For example, use `RNAheat` to verify thermoswitches or `RNAcofold` to check base pair probabilities in designed complexes.
*   **Optimization Steps**: If the design fails to reach the target objective, increase the steps (`-s`) or try different optimization methods (`-m`).



## Subcommands

| Command | Description |
|---------|-------------|
| design-cofold.py | Design a cofold device. |
| design-energyshift.py | Design a multi-stable riboswitch similar using Boltzmann sampling. |
| design-ligandswitch.py | Design a ligand triggered device. |
| design-multistate.py | Design a multi-stable riboswitch similar to Hoehner 2013 paper. |
| design-redprint-multistate.py | Design a multi-stable riboswitch similar using Boltzmann sampling. |
| design-thermoswitch.py | Design a multi-stable thermoswitch as suggested in the Flamm 2001 publication. |

## Reference documentation
- [RNAsketch README and Examples](./references/github_com_ViennaRNA_RNAsketch_blob_master_README.rst.md)
- [RNAsketch Overview](./references/anaconda_org_channels_bioconda_packages_rnasketch_overview.md)