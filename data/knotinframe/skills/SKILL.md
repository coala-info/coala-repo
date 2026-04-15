---
name: knotinframe
description: knotinframe detects -1 programmed ribosomal frameshifting signals by identifying slippery sites and evaluating the thermodynamic stability of downstream pseudoknots. Use when user asks to find frameshifting sites, detect -1 PRF signals, or analyze sequences for stimulatory pseudoknot structures.
homepage: https://bibiserv.cebitec.uni-bielefeld.de/knotinframe
metadata:
  docker_image: "quay.io/biocontainers/knotinframe:2.3.2--h9948957_2"
---

# knotinframe

## Overview

knotinframe is a specialized bioinformatics pipeline designed to detect -1 programmed ribosomal frameshifting (-1 PRF) signals. It operates by scanning sequences for a consensus slippery site (XXXYYYZ) and then evaluating the thermodynamic stability of the downstream region. It compares the minimal free energy (MFE) of a forced pseudoknot structure against a standard nested structure to determine the likelihood of a frameshift event. This tool is highly efficient, capable of scanning a 5MB genome in under two hours.

## Usage and Best Practices

### Basic Execution
The tool reads from standard input and accepts FASTA formatted DNA or RNA sequences.

```bash
knotinframe < input.fasta
```

### Common CLI Patterns

*   **Increase Result Visibility**: By default, the tool shows the top 10 candidates. For long sequences with many potential sites, increase this limit:
    ```bash
    knotinframe --numberOutputs 50 < input.fasta
    ```

*   **Adjusting Search Windows**: The default downstream analysis window is 120 nucleotides. If you suspect longer stimulatory structures, adjust the window size (must be a multiple of the increment):
    ```bash
    knotinframe --windowSize 180 --windowIncrement 30 < input.fasta
    ```

*   **Thermodynamic Tuning**: If working with thermophilic organisms, adjust the temperature (default is 37°C), though results become less reliable as you move further from the default:
    ```bash
    knotinframe --temperature 65 < input.fasta
    ```

### Expert Tips

*   **Slippery Site Consensus**: The tool looks for the pattern `X XXY YYZ`.
    *   `XXX`: Any three identical nucleotides.
    *   `YYY`: Either `AAA` or `UUU`/`TTT`.
    *   `Z`: Any nucleotide.
    *   **Spacer**: The tool expects a spacer of 1 to 12 nucleotides between the slippery site and the pseudoknot.
*   **Filtering Logic**: Candidates are filtered based on `minEnergyDifference` (default -8.71 kcal/mol). If the nested structure is significantly more stable than the knotted one, the candidate is discarded. If you are getting too many false positives, consider making this value more negative.
*   **Stability Threshold**: The default `minKnottedEnergy` is -7.4 kcal/mol. Pseudoknots weaker than this are generally not considered stable enough to induce a frameshift.
*   **Output Interpretation**:
    *   **Deltarel**: Represents the normalized dominance of the pseudoknot.
    *   **Structure**: Provided in Vienna dot-bracket notation, where `[]` and `{}` represent the pseudoknot interactions.

## Reference documentation
- [KnotInFrame In-/Output and Parameters](./references/bibiserv_cebitec_uni-bielefeld_de_knotinframe_3.md)
- [KnotInFrame Overview and Methodology](./references/bibiserv_cebitec_uni-bielefeld_de_knotinframe.md)