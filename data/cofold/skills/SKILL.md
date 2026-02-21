---
name: cofold
description: CoFold is a specialized RNA secondary structure prediction tool derived from the ViennaRNA package.
homepage: https://github.com/jujubix/cofold
---

# cofold

## Overview
CoFold is a specialized RNA secondary structure prediction tool derived from the ViennaRNA package. Unlike standard thermodynamic-only models, CoFold incorporates a distance-based model to simulate the kinetic effects of co-transcriptional folding. It is primarily a modification of the `RNAfold` algorithm, allowing users to predict structures that are more biologically representative of how RNA folds as it emerges from the RNA polymerase.

## CLI Usage and Patterns

### Basic Execution
CoFold reads from standard input and writes to standard output. It typically expects sequences in FASTA format.

```bash
CoFold < input_sequence.fasta
```

### Co-transcriptional Parameters
The core of CoFold's unique logic lies in two parameters. Adjusting these can significantly alter the predicted structure based on the assumed speed of transcription and the distance between interacting bases.

*   `--distAlpha`: Sets the alpha parameter (range 0 to 1). The authors' recommended optimal value is `0.5`.
*   `--distTau`: Sets the tau parameter (must be > 0). The authors' recommended optimal value is `640`.

```bash
CoFold --distAlpha 0.5 --distTau 640 < sequence.fasta
```

### Common RNAfold Inherited Options
Since CoFold is built on ViennaRNA 2.0.4, it supports several standard folding parameters:

*   **Temperature**: Change the temperature (default is 37°C).
    ```bash
    CoFold -T 30 < sequence.fasta
    ```
*   **Dangling Ends**: Control how "dangling end" energies are treated (0, 1, 2, or 3; default is 2).
    ```bash
    CoFold -d 2 < sequence.fasta
    ```
*   **Avoid PostScript**: Use `--noPS` to prevent the generation of PostScript drawing files if you only need the text-based dot-bracket notation.
    ```bash
    CoFold --noPS < sequence.fasta
    ```
*   **Maximum Expected Accuracy (MEA)**: Calculate the MEA structure instead of MFE.
    ```bash
    CoFold --MEA=1.0 < sequence.fasta
    ```

### Using Specific Energy Parameters
You can provide custom energy parameter files (e.g., Turner 1999 or 2004) using the `-P` flag.

```bash
CoFold -P rna_turner2004.par < sequence.fasta
```

## Best Practices
*   **Input Formatting**: Ensure your input file follows the FASTA format strictly. If passing a raw sequence string, use `echo "SEQUENCE" | CoFold`.
*   **Constraint Handling**: Use the `--noLP` flag if you want to produce structures without "lonely pairs" (helices of length 1), which are often thermodynamically unstable and considered noise in some analyses.
*   **GU Base Pairs**: If your specific biological context requires strict Watson-Crick pairing, use `--noGU` to disallow G-U pairs, or `--noClosingGU` to disallow them specifically at the ends of helices.

## Reference documentation
- [Cofold README](./references/github_com_jujubix_cofold.md)