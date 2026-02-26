---
name: linearfold
description: "LinearFold predicts RNA secondary structures in linear time using beam search heuristics. Use when user asks to predict RNA secondary structures, analyze long RNA sequences, incorporate SHAPE reactivity data, or perform constrained folding."
homepage: https://github.com/LinearFold/LinearFold
---


# linearfold

## Overview
LinearFold is the first RNA secondary structure prediction tool to achieve linear-time complexity, making it the preferred choice for analyzing long RNA sequences such as viral genomes or long non-coding RNAs. While standard tools scale cubically with sequence length, LinearFold uses a beam search heuristic to maintain efficiency without significant loss in accuracy. It offers two primary models: LinearFold-C (the default, based on CONTRAfold machine-learning parameters) and LinearFold-V (based on ViennaRNA thermodynamic parameters).

## Installation and Setup
The tool is available via Bioconda or can be compiled from source.

```bash
# Install via Conda
conda install bioconda::linearfold

# Or compile from source
make
```

## Core CLI Patterns

### Basic Structure Prediction
LinearFold accepts input via standard input (stdin). By default, it uses the CONTRAfold model (LinearFold-C).

```bash
# Predict using default CONTRAfold parameters
echo "GGGCUCGUAGAUCAGCGGUAGAUCGCUUCCUUCGCAAGGAAGCCCUGGGUUCAAAUCCCAGCGAGUCCACCA" | ./linearfold

# Predict using ViennaRNA parameters (LinearFold-V)
echo "SEQUENCE" | ./linearfold -V

# Process a FASTA file
cat sequence.fasta | ./linearfold --fasta
```

### Adjusting Search Accuracy
The `--beamsize` (or `-b`) parameter controls the trade-off between speed and accuracy. The default is 100.

```bash
# Increase beam size for higher accuracy on complex structures
echo "SEQUENCE" | ./linearfold -b 200

# Use infinite beam size (equivalent to exact search, but slower)
echo "SEQUENCE" | ./linearfold -b 0
```

### Constrained Folding
You can provide structural constraints using a specific notation sequence of the same length as the RNA.
- `?`: Unknown (no constraint)
- `.`: Must be unpaired
- `(`: Must be paired (left)
- `)`: Must be paired (right)

```bash
# Example with constraints (Sequence on line 1, Constraints on line 2)
echo -e "GAACCCCGUCAGGUCCGGAAGGAAGCAGCGGUAAGU\n??????????????????(????????????????)" | ./linearfold --constraints
```

### Suboptimal Structures
To explore the structural landscape beyond the Minimum Free Energy (MFE) structure, use the Zuker suboptimal structure mode.

```bash
# Output suboptimal structures within 2.0 kcal/mol of the optimum
echo "SEQUENCE" | ./linearfold -V --zuker --delta 2.0
```

### SHAPE-Guided Prediction
Integrate SHAPE (Selective 2'-hydroxyl acylation analyzed by primer extension) reactivity data to improve prediction accuracy.

```bash
# Use SHAPE data from a file
cat sequence.fasta | ./linearfold --shape sample.shape
```

## Expert Tips and Best Practices

- **Model Selection**: Use `-V` (LinearFold-V) if you need to compare results with traditional thermodynamic tools like `RNAfold`. Use the default (LinearFold-C) for potentially better performance on sequences where machine-learning parameters excel.
- **Dangling Ends**: Use the `-d` or `--dangles` flag to control dangling end energy treatment. Only `0` (ignore) or `2` (add energies for bases adjacent to helices on both sides) are supported. The default is `2`.
- **Memory Management**: For extremely long sequences (>30,000 nt), monitor RAM usage. While time is linear, memory usage still scales with the beam size and sequence length.
- **Visualization**: LinearFold includes a utility for circular plots. Pipe a file containing the sequence and structure into the visualizer:
  ```bash
  cat result.txt | ./draw_circular_plot
  ```

## Reference documentation
- [LinearFold GitHub Repository](./references/github_com_LinearFold_LinearFold.md)
- [Bioconda LinearFold Package](./references/anaconda_org_channels_bioconda_packages_linearfold_overview.md)