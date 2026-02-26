---
name: quantms-rescoring
description: The quantms-rescoring tool annotates peptide-spectrum matches with predicted spectral intensities, retention times, and quality metrics to improve identification confidence. Use when user asks to annotate idXML files with MS2PIP or DeepLC features, calculate spectrum quality metrics, integrate SAGE search results, perform transfer learning for PTM-heavy datasets, or clean PSM features before rescoring.
homepage: https://www.github.com/bigbio/quantms-rescoring
---


# quantms-rescoring

## Overview
The `quantms-rescoring` tool is a specialized utility within the quantms ecosystem designed to bridge the gap between raw search results and high-confidence identifications. It functions by annotating PSMs with predicted spectral intensities and retention times, as well as calculating advanced spectrum quality metrics (like Signal-to-Noise and Spectral Entropy). Use this skill to optimize model selection for fragmentation types, perform transfer learning for PTM-heavy datasets, and prepare idXML files for downstream rescoring engines.

## CLI Usage Patterns

### Feature Annotation
The primary entry point for adding prediction-based features (MS2PIP and DeepLC) to your identification files:
```bash
rescoring msrescore2feature --idxml_path <input.idXML> --spectra_path <input.mzML> --output_path <output.idXML>
```

### Spectrum Quality Metrics
To add signal-to-noise ratios, spectral entropy, and TIC distribution analysis to each PSM:
```bash
rescoring spectrum2feature --idxml <input.idXML> --mzml <input.mzML> --out <output.idXML>
```

### SAGE Integration
If using SAGE as the search engine, incorporate its specific features into the OpenMS-compatible idXML format:
```bash
rescoring add_sage_feature --idxml <input.idXML> --sage_feature <sage_results.tsv> --output <output.idXML>
```

### Model Management and Transfer Learning
For datasets with modifications (PTMs) not well-represented in pretrained models, use transfer learning to fine-tune AlphaPeptDeep:
```bash
# Download models for offline/HPC use
rescoring download_models --output_dir ./models

# Fine-tune AlphaPeptDeep on project-specific data
rescoring transfer_learning --idxml <input.idXML> --spectra <input.mzML> --output_model ./custom_model
```

### Data Cleaning
Before running Percolator, ensure the idXML does not contain PSMs with invalid or missing features:
```bash
rescoring psm_feature_clean --idxml <input.idXML> --output <clean.idXML>
```

## Expert Tips & Best Practices

- **Intelligent Model Selection**: You do not need to manually tune MS2PIP parameters. The tool automatically evaluates fragmentation types and correlation quality, searching for a better alternative if the user-selected model performs poorly.
- **Dynamic Tolerance**: The tool analyzes both reported and predicted tolerances to dynamically adjust MS2 tolerance based on the specific dataset characteristics.
- **Retention Time Calibration**: DeepLC features are automatically calibrated per-run to account for chromatographic drift between different experiments in the same project.
- **Validation**: Always check the Median PCC (Pearson Correlation Coefficient) reported during the run. The tool benchmarks pretrained vs. retrained models and selects the one with the higher correlation for intensity predictions.
- **HPC Environments**: If working on a cluster without internet access, run `download_models` on a login node first to ensure all AlphaPeptDeep and MS2PIP weights are available locally.

## Reference documentation
- [quantms-rescoring GitHub Repository](./references/github_com_bigbio_quantms-rescoring.md)