---
name: rnasketch
description: rnasketch is a toolkit for RNA sequence design that facilitates the inverse folding problem by connecting sequence sampling engines with energy evaluation tools. Use when user asks to design multistate RNA molecules, create temperature-dependent thermoswitches, develop ligand-triggered riboswitches, or engineer sRNA-mediated cofolding interactions.
homepage: https://github.com/ViennaRNA/RNAsketch
---


# rnasketch

## Overview

`rnasketch` is a specialized toolkit for RNA sequence design that acts as a "glue" between sequence sampling engines (like RNAblueprint and RNARedPrint) and energy evaluation tools (like ViennaRNA, Nupack, and pKiss). It is designed to solve the inverse folding problem—finding a sequence that fits a desired secondary structure—especially for complex cases where a single molecule must transition between multiple stable states.

## Common CLI Patterns

The toolkit provides several specialized scripts for different design objectives. Most scripts accept structural constraints via standard input.

### Multistate Design
To design a sequence that can fold into multiple target structures (e.g., a bistable molecule), use `design-multistate.py`.
```bash
echo -e '(((((....)))))....\n....(((((....)))))' | design-multistate.py -i -m random -s 500
```
*   `-m`: Optimization method (e.g., `random`).
*   `-s`: Number of optimization steps or samples.

### Thermoswitch Design
Design molecules that change their Minimum Free Energy (MFE) structure based on temperature.
```bash
echo -e "((((((((((((....))))))))))))) 5.0\n(((((.....)))))(((((.....))))) 10.0\n(((((.....)))))............... 37.0" | design-thermoswitch.py -m random -s 1000
```
Input format: `Structure Temperature`.

### Ligand-Triggered Switches
Design riboswitches that respond to ligand binding (e.g., theophylline) using soft-constraints.
```bash
echo -e "STABLE_STRUCT\nLIGAND_COMPETENT_STRUCT\nSEQUENCE_CONSTRAINTS" | design-ligandswitch.py -r 70:30 --ligand "MOTIF_SEQ&MOTIF_SEQ;STRUCTURE_CONSTRAINT;ENERGY"
```
*   `-r`: Target ratio between the ligand-competent state and alternative states.
*   `--ligand`: Defines the aptamer motif and binding energy.

### sRNA Mediated Regulation (Cofolding)
Design a 5'UTR and an sRNA that interacts to control translation (e.g., sequestering an RBS).
```bash
echo 'STRUCTURE_COMPLEX&STRUCTURE_COMPLEX\nSTRUCTURE_FREE&STRUCTURE_FREE\nSEQUENCE_CONSTRAINTS' | design-cofold.py -n 1 -s 1000
```

### Advanced Sampling with RNARedPrint
For more uniform sampling of the sequence space, use the RedPrint-based scripts. These require the `REDPRINT` environment variable to be set.
```bash
export REDPRINT=/path/to/redprint/
echo -e "STRUCT1\nSTRUCT2" | design-redprint-multistate.py -i -n 10
```
*   `design-redprint-multistate.py`: Aims for equal energies across target structures.
*   `design-energyshift.py`: Allows specifying specific target energies (e.g., `-e 40,40,20`).

## Expert Tips

1.  **Optimization vs. Sampling**: While `RNARedPrint` provides Boltzmann-weighted sampling (finding sequences that fit the energy profile), you should often follow it with an optimization step (using the `-s` flag) to maximize the occupancy of the target structures in the ensemble.
2.  **Visualizing Results**: After designing a multistate sequence, use the `barriers` program (from the ViennaRNA package) to visualize the energy landscape and confirm that the desired states are indeed deep local minima.
3.  **Sequence Constraints**: You can provide IUPAC nucleotide codes (like `N`, `R`, `Y`) in the input to restrict the sequence space (e.g., forcing a specific Start Codon or Ribosome Binding Site).
4.  **Environment Setup**: Ensure that the underlying engines (ViennaRNA, RNARedPrint, etc.) are in your `$PATH`. For `design-redprint` scripts, the `REDPRINT` variable must point to the directory containing the `RedPrint` executable.

## Reference documentation
- [GitHub Repository and Usage Examples](./references/github_com_ViennaRNA_RNAsketch.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_rnasketch_overview.md)