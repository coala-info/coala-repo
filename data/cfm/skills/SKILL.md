---
name: cfm
description: The cfm toolset models small molecule fragmentation to predict mass spectra and identify unknown metabolites. Use when user asks to compute fragmentation graphs, generate predicted MS/MS spectra, or rank candidate structures against experimental mass spectrometry data.
homepage: https://sourceforge.net/p/cfm-id/wiki/Home/
---


# cfm

## Overview
The `cfm` toolset provides a computational framework for modeling the fragmentation of small molecules in electrospray ionization (ESI) and electron ionization (EI) mass spectrometry. This skill enables the systematic breaking of molecular bonds to identify feasible fragments, the generation of predicted spectra at multiple energy levels, and the identification of unknown metabolites from a list of candidates.

## Command Line Utilities

### Fragmentation Graph Generation
Use `fraggraph-gen` to compute all possible fragments for a given structure.

```bash
fraggraph-gen <smiles_or_inchi> <max_depth> <ionization_mode> <output_type> [output_file]
```
- **Ionization Modes**: `+` (Positive ESI [M+H]), `-` (Negative ESI [M-H]), `*` (Positive EI [M+]).
- **Max Depth**: Typically 2 or 3. Higher depth increases computation time exponentially.
- **Output Type**: `fullgraph` (includes transitions/neutral losses) or `fragonly` (unique fragments and masses).

### Spectrum Prediction
Use `cfm-predict` to generate a predicted MS/MS spectrum for a molecule.

```bash
cfm-predict <input> <prob_thresh> <param_file> <config_file> <annotate> <output> [apply_postproc]
```
- **Input**: A SMILES/InChI string or a `.txt` file containing `id structure` pairs for batch processing.
- **Probability Threshold**: Default is `0.001`. Lowering this includes more low-intensity peaks.
- **Post-processing**: Set to `1` to filter for the top 80% energy or highest 30 peaks.

### Metabolite Identification
Use `cfm-id` to rank candidate structures against an experimental spectrum.

```bash
cfm-id <spectrum_file> <id> <candidate_file> <num_highest> <ppm_tol> <abs_tol> <prob_thresh> <param_file> <config_file> <score_type>
```
- **Spectrum File**: Supports `.msp` or simple text files with `mass intensity` pairs.
- **Candidate File**: A list of `id structure` pairs to be ranked.
- **Mass Tolerance**: Uses the higher of `ppm_tol` (default 10) or `abs_tol` (default 0.01 Da).

## Expert Tips and Best Practices

- **Input Formatting**: Ensure InChI strings start with `InChI=`. For SMILES, ensure the string is quoted if it contains special characters.
- **Energy Levels**: If you have a single experimental spectrum but the model expects three (low, medium, high), replicate your spectrum for all three energy levels or place it in the level that most closely matches your collision energy.
- **Model Selection**: Always ensure the `param_file` and `config_file` match. Using a model trained on ESI+ for an ESI- spectrum will yield incorrect results.
- **Batch Processing**: For large-scale identification, use the file input option in `cfm-predict` rather than looping individual CLI calls to reduce overhead.
- **Memory Management**: When running `fraggraph-gen` on large molecules (e.g., lipids), keep `max_depth` at 2 to avoid memory exhaustion.

## Reference documentation
- [CFM-ID Wiki Home](./references/sourceforge_net_p_cfm-id_wiki_Home.md)
- [Bioconda CFM Overview](./references/anaconda_org_channels_bioconda_packages_cfm_overview.md)