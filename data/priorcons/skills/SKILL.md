---
name: priorcons
description: priorcons generates high-quality viral consensus sequences by filling gaps in mapping-based assemblies with evolutionary-verified sequences. Use when user asks to build evolutionary priors from a multiple sequence alignment, integrate consensus sequences to fill gaps, or refine viral genome assemblies using statistical models of genetic variation.
homepage: https://github.com/GERMAN00VP/priorcons
---


# priorcons

## Overview
priorcons is a specialized bioinformatics tool designed to produce high-quality viral consensus sequences. It addresses the common issue of missing data in mapping-based assemblies by strategically filling gaps with sequences from ABACAS. Unlike simple merging, priorcons uses a sliding-window approach to verify the evolutionary likelihood of the filler sequence against empirical priors (statistical models of expected genetic variation). This prevents the incorporation of low-quality or biologically improbable fragments into the final genome.

## Installation
The tool can be installed via Bioconda or pip:
```bash
conda install bioconda::priorcons
# OR
pip install priorcons
```

## Core Workflows

### 1. Building Evolutionary Priors
Before integrating sequences, you must generate a priors table from a large multiple sequence alignment (MSA) of related sequences. This models the "normal" variation for each genomic window.

```bash
priorcons build-priors \
  --input sequences.fasta \
  --ref REFERENCE_ID \
  --output priors.parquet \
  --win 100 \
  --overlap 10
```
- **Expert Tip**: Use a diverse but representative MSA to ensure the negative log-likelihood (nLL) thresholds accurately reflect the expected variation of your target sample.

### 2. Integrating Consensus Sequences
This is the main refinement step. It requires a three-sequence alignment file.

```bash
priorcons integrate-consensus \
  --input sample_alignment.aln \
  --ref REFERENCE_ID \
  --prior priors.parquet \
  --output_dir results_folder
```

**Critical Requirement**: The input `.aln` file must contain sequences in this exact order:
1. Reference sequence
2. Mapping consensus sequence (the baseline)
3. ABACAS consensus sequence (the source for gap-filling)

## Output Analysis
The tool generates three primary files in the output directory:
- **`<basename>-INTEGRATED.fasta`**: The final refined consensus.
- **`windows_trace.csv`**: A per-window log showing which regions passed QC and why ABACAS fragments were accepted or rejected (based on `WINDOW_SCORE_nLL` vs `WINDOW_PRIOR_nLL_p95`).
- **`qc.json`**: Summary metrics comparing the mapping baseline to the final integrated sequence, including coverage gains and substitution counts.

## Best Practices
- **Window Fragmentation**: priorcons rejects ABACAS windows if they are too fragmented (typically > 3 fragments). If you see many "False" decisions in the trace file due to fragmentation, check the quality of your de novo assembly.
- **Reference Consistency**: Ensure the `REFERENCE_ID` used in `build-priors` matches the reference sequence ID used in the integration alignment.
- **Insertion Handling**: The tool automatically restores mapping-specific insertions into the final integrated consensus to maintain consistency with the baseline mapping.

## Reference documentation
- [PriorCons GitHub Repository](./references/github_com_GERMAN00VP_PriorCons.md)
- [priorcons Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_priorcons_overview.md)