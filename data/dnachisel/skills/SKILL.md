---
name: dnachisel
description: DNA Chisel optimizes DNA sequences by resolving constraints and improving optimization objectives through a local search algorithm. Use when user asks to optimize DNA sequences, harmonize codon usage, avoid specific patterns, or enforce GC content and translation frames.
homepage: https://github.com/Edinburgh-Genome-Foundry/DnaChisel
---


# dnachisel

## Overview
DNA Chisel is a versatile sequence optimizer that treats DNA design as a constraint-satisfaction problem. It allows you to define "hard" constraints (must-haves) and "optimization objectives" (nice-to-haves). This skill enables the automated refinement of sequences to avoid problematic patterns, harmonize codon usage for specific species, and maintain specific translation frames, ensuring the resulting DNA is both functional and manufacturable.

## CLI Usage Patterns
The command-line interface is the fastest way to process annotated GenBank files where constraints are defined directly within the metadata.

### Basic Optimization
To optimize a sequence defined in a GenBank file and save the result:
```bash
dnachisel input_record.gb optimized_output.gb
```

### Optimization with Comprehensive Reporting
To generate a full optimization report (requires `dnachisel[reports]` installation), which includes a PDF summary and a ZIP of the results:
```bash
# In a Python environment
from dnachisel import DnaOptimizationProblem
problem = DnaOptimizationProblem.from_record("my_record.gb")
problem.optimize_with_report(target="optimization_report.zip")
```

## Python Scripting Workflow
For complex logic or dynamic sequence generation, use the Python API.

### 1. Define the Problem
Initialize a `DnaOptimizationProblem` with a sequence and a list of specifications.
```python
from dnachisel import *

problem = DnaOptimizationProblem(
    sequence="ATGC...", # or random_dna_sequence(length)
    constraints=[
        AvoidPattern("BsaI_site"),
        EnforceGCContent(mini=0.3, maxi=0.7, window=50),
        EnforceTranslation(location=(500, 1400))
    ],
    objectives=[
        CodonOptimize(species='e_coli', location=(500, 1400))
    ]
)
```

### 2. Solve and Export
Always resolve constraints before optimizing objectives to ensure the sequence is valid.
```python
problem.resolve_constraints()
problem.optimize()

# Export as string
final_dna = problem.sequence

# Export as annotated GenBank record
final_record = problem.to_record(with_sequence_edits=True)
```

## Expert Tips
- **Constraint Prefixes**: When annotating GenBank files, use `@` for hard constraints (e.g., `@AvoidPattern(BsaI_site)`) and `~` for optimization objectives (e.g., `~CodonOptimize(e_coli)`).
- **Translation Guard**: Always pair `CodonOptimize` with `EnforceTranslation` for the same location to prevent the optimizer from introducing synonymous mutations that break the reading frame.
- **Local Resolution**: DNA Chisel works by identifying "breaches" and solving them locally. If a problem is "Unsolvable," try relaxing the window size of GC content constraints or checking for conflicting hard constraints in the same region.
- **Species Names**: Use standard TaxID or common names supported by the underlying codon usage database (e.g., 'e_coli', 's_cerevisiae', 'h_sapiens').

## Reference documentation
- [DNA Chisel GitHub Repository](./references/github_com_Edinburgh-Genome-Foundry_DnaChisel.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dnachisel_overview.md)