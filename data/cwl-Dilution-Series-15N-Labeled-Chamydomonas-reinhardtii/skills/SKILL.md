---
name: dilution-series-15n-labeled-chamydomonas-reinhardtii
description: "This CWL workflow utilizes the ProteomIQon toolset to perform peptide identification and labeled quantification on mass spectrometry data from 15N labeled and unlabeled Chlamydomonas reinhardtii dilution series. Use this skill when you need to quantify protein abundance ratios in stable isotope labeled experiments or characterize the proteomic response of Chlamydomonas reinhardtii across varying isotopic enrichment levels."
homepage: https://workflowhub.eu/workflows/2052
---
# Dilution Series 15N Labeled Chamydomonas reinhardtii

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/2052) workflow is designed for the quantitative analysis of proteomics data derived from *Chlamydomonas reinhardtii*. It specifically processes mass spectrometry datasets from experiments using 15N metabolic labeling, where labeled and unlabeled samples are compared across a range of dilution ratios.

The pipeline utilizes the [ProteomIQon](https://github.com/CSBiology/ProteomIQon) toolset to execute a comprehensive suite of proteomics operations. The workflow automates the transition from raw data to biological insights through several key stages:
*   **Identification:** Mapping mass spectrometry spectra to peptide and protein sequences.
*   **Quantification:** Performing labeled quantification to calculate the relative abundance of 15N-labeled versus unlabeled proteins.

By standardizing these computational biology tasks, the workflow ensures reproducible protein quantification for complex labeling experiments. It is licensed under CC-BY-4.0 and serves as a reference implementation for bioinformatics researchers working with stable isotope labeling in mass spectrometry.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| #main/cores | CPU cores | int | Number of CPU cores to use for processing |
| #main/inputMzML | MzML input directory | Directory | Input directory containing mzML files |
| #main/inputPeptideDB | Peptide database file | File | Input peptide database file |
| #main/outputAlignment | Alignment output directory | Directory | Output directory for alignment results |
| #main/outputAlignmentQuant | Alignment quantification output directory | Directory | Output directory for alignment-based quantification |
| #main/outputAlignmentStats | Alignment statistics output directory | Directory | Output directory for alignment statistics |
| #main/outputDB | Database output directory | Directory | Output directory for database files |
| #main/outputLabeledProt | Labeled protein output directory | Directory | Output directory for labeled protein quantification |
| #main/outputMzML | MzML conversion output directory | Directory | Output directory for mzLite files |
| #main/outputPSM | PSM output directory | Directory | Output directory for peptide-spectrum match files |
| #main/outputPSMStats | PSM statistics output directory | Directory | Output directory for PSM statistics |
| #main/outputProt | Protein output directory | Directory | Output directory for protein identification results |
| #main/outputProtDeduced | Deduced protein output directory | Directory | Output directory for deduced protein results |
| #main/outputQuant | Quantification output directory | Directory | Output directory for quantification results |
| #main/outputQuantAndProt | Combined quantification and protein output directory | Directory | Output directory for combined quantification and protein results |
| #main/paramsAlignmentBasedQuant | Alignment-based quantification parameters | File | Parameter file for alignment-based quantification |
| #main/paramsAlignmentBasedQuantStats | Alignment quantification statistics parameters | File | Parameter file for alignment-based quantification statistics |
| #main/paramsDB | Database parameters | File | Parameter file for database creation |
| #main/paramsLabeledProteinQuant | Labeled protein quantification parameters | File | Parameter file for labeled protein quantification |
| #main/paramsMzML | MzML parameters | File | Parameter file for mzML processing |
| #main/paramsPSM | PSM parameters | File | Parameter file for PSM analysis |
| #main/paramsPSMBasedQuant | PSM-based quantification parameters | File | Parameter file for PSM-based quantification |
| #main/paramsPSMStats | PSM statistics parameters | File | Parameter file for PSM statistics |
| #main/paramsProt | Protein inference parameters | File | Parameter file for protein inference |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| #main/Workflow | ProteomIQon | The ProteomIQon is a collection of open source computational proteomics tools to build pipelines for the evaluation of MS derived proteomics data written |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| #main/alignment | Alignment results | Directory | Feature alignment results across samples |
| #main/alignmentQuant | Alignment-based quantification | Directory | Quantification results based on feature alignment |
| #main/alignmentStats | Alignment statistics | Directory | Statistical analysis of alignment-based quantification |
| #main/db | Database files | Directory | Created database |
| #main/labeledProteins | Labeled protein quantification | Directory | Labeled protein quantification results |
| #main/mzml | mzLite files | Directory | Processed mzLite files |
| #main/prot | Protein identification results | Directory | Protein inference and identification results |
| #main/protDeduced | Deduced proteins | Directory | Deduced protein results from alignment-based quantification |
| #main/psm | Peptide-spectrum matches | Directory | Peptide-spectrum match results |
| #main/psmstats | PSM statistics | Directory | Statistical analysis of peptide-spectrum matches |
| #main/quant | Quantification results | Directory | PSM-based quantification results |
| #main/quantAndProt | Combined quantification and protein results | Directory | Combined quantification and protein inference results |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/2052
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
