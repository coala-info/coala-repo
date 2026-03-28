---
name: cfm
description: CFM-ID uses a probabilistic generative model to predict mass spectrometry fragmentation patterns and identify unknown metabolites. Use when user asks to predict MS/MS spectra, rank candidate molecules for metabolite identification, annotate experimental peaks with fragment structures, or generate fragment graphs.
homepage: https://sourceforge.net/p/cfm-id/wiki/Home/
---

# cfm

## Overview
This skill provides procedural knowledge for using the CFM-ID (Competitive Fragmentation Modeling for Metabolite Identification) suite of command-line tools. CFM-ID uses a probabilistic generative model to simulate the fragmentation of molecules in Electrospray Ionization (ESI) and Electron Ionization (EI) mass spectrometry. It is primarily used for identifying unknown metabolites by comparing experimental spectra against predicted spectra of candidate structures.

## Core CLI Utilities

### 1. Spectrum Prediction (`cfm-predict`)
Predicts the MS/MS spectrum for a given structure.
- **Basic Usage**: `cfm-predict.exe <smiles_or_inchi> <prob_thresh> <param_file> <config_file> <annotate_fragments> <output_file>`
- **Batch Mode**: Pass a `.txt` file containing `id smiles` pairs to process multiple molecules.
- **Post-processing**: By default, it applies a filter to keep the top 80% energy (min 5 peaks) or the highest 30 peaks. Set `apply_postproc` to `0` to see all possible fragments.

### 2. Metabolite Identification (`cfm-id`)
Ranks candidate molecules by comparing their predicted spectra to an experimental spectrum.
- **Basic Usage**: `cfm-id.exe <spectrum_file> <id> <candidate_file> <num_highest> <ppm_mass_tol> <abs_mass_tol> <prob_thresh> <param_file> <config_file> <score_type>`
- **Scoring**: Supports `Jaccard` (default) and `DotProduct`.
- **Energy Levels**: ESI models usually expect three energy levels (low, medium, high). If you only have one experimental spectrum, replicate it for all three energy levels in the input file to ensure compatibility with the model.

### 3. Peak Annotation (`cfm-annotate`)
Assigns fragment structures to peaks in an experimental spectrum.
- **Usage**: `cfm-annotate.exe <smiles_or_inchi> <spectrum_file> <id> <ppm_mass_tol> <abs_mass_tol> <param_file> <config_file>`
- **Output**: Returns the original spectrum with fragment IDs appended to matching peaks, followed by the fragment graph connections.

### 4. Fragment Generation (`fraggraph-gen`)
Generates a complete list of feasible fragments without applying the probabilistic model.
- **Usage**: `fraggraph-gen.exe <smiles_or_inchi> <max_depth> <ionization_mode> <fullgraph_or_fragonly>`
- **Ionization Modes**: `+` (ESI Positive [M+H]), `-` (ESI Negative [M-H]), `*` (EI Positive [M+]).

## Expert Tips & Best Practices

- **Model Selection**:
    - **EI-MS (GC-MS)**: Use the `ei_ms_model`.
    - **ESI-MS/MS (Positive)**: Use `metab_ce_cfm` or `metab_se_cfm`.
    - **ESI-MS/MS (Negative)**: Use `negative_metab_se_cfm`.
- **Required Assets**: Ensure `ISOTOPE.DAT` is in the working directory; otherwise, the tools will fail with an "Error opening ISOTOPE.DAT" message.
- **Mass Tolerance**: The tools use the higher of the two resulting tolerances from `ppm_mass_tol` and `abs_mass_tol`. For high-resolution data, 10ppm and 0.01 Da are standard starting points.
- **Input Formatting**: InChI strings must start with `InChI=`. SMILES are detected automatically.



## Subcommands

| Command | Description |
|---------|-------------|
| cfm-id.exe | Predicts candidate structures for a given spectrum and list of candidates. |
| cfm_predict.exe | Predicts mass spectra for a given chemical structure. |
| fraggraph-gen.exe | Generates a fragmentation graph from a molecule. |

## Reference documentation
- [CFM-ID Wiki Home](./references/sourceforge_net_p_cfm-id_wiki_Home.md)