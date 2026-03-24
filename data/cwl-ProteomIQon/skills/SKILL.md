---
name: proteomiqon
description: "This CWL workflow processes mass spectrometry-derived proteomics data using the ProteomIQon toolset to perform peptide identification, signal detection, and protein quantification. Use this skill when you need to characterize protein expression levels, compare proteomes across different biological samples, or perform high-throughput identification and quantification of peptide ions."
homepage: https://workflowhub.eu/workflows/2051
---
# ProteomIQon

## Overview

ProteomIQon is a modular [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/2051) pipeline designed for the comprehensive analysis of mass spectrometry-based proteomics data. Written in F#, this collection of open-source tools facilitates a flexible end-to-end workflow covering signal detection, peptide identification, and protein quantification.

The workflow processes raw data through several key stages: converting MzML files to mzLite, creating peptide databases, and performing peptide spectrum matching (PSM). It incorporates machine learning and statistical methods for FDR control and PSM validation to ensure high-confidence identifications.

For quantification, the pipeline supports both label-free and labeled (isotope-coded) approaches using PSM-based and alignment-based statistics. The final stages join quantified peptide ions with their respective proteins to perform protein inference and labeled protein quantification, providing a complete proteomic profile.

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
| #main/AddDeducedPeptides | Add deduced peptides | Assigns protein inference information to peptides quantified via alignment, creating updated protein inference results for each quantification file |
| #main/AlignmentBasedQuantStatistics | Alignment-based quantification statistics | Computes statistics and quality metrics for alignment-based quantification results |
| #main/AlignmentBasedQuantification | Alignment-based quantification | Quantifies peptides transferred from other runs using alignment predictions with local dynamic time warping refinement and XIC extraction |
| #main/JoinQuantPepIonsWithProteins | Join quantified peptide ions with proteins | Combines peptide quantification information with detailed protein inference results including q-values |
| #main/LabeledProteinQuantification | Labeled protein quantification | Aggregates peptide-level quantification to protein-level, calculating ratios between light and heavy labeled peptides with optional charge and modification aggregation |
| #main/MzMLToMzlite | MzML to mzLite conversion | Converts mzML files to mzLite format with optional peak picking and filtering of mass spectra |
| #main/PSMBasedQuantification | PSM-based quantification | Performs XIC extraction and quantification of identified peptide ions using wavelet-based peak detection and Gaussian peak fitting, supporting both label-free and labeled quantification |
| #main/PSMStatistics | PSM statistics and FDR control | Uses semi-supervised machine learning to integrate search engine scores into a consensus score and calculates local and global false discovery rates |
| #main/PeptideDB | Peptide database creation | Creates a peptide database by in silico digestion of proteins from FASTA format, storing peptide-protein relationships in SQLite |
| #main/PeptideSpectrumMatching | Peptide spectrum matching | Identifies MS/MS spectra by comparing them against peptides in the reference database using SEQUEST, Andromeda, and XTandem scoring |
| #main/ProteinInference | Protein inference | Maps identified peptides to protein groups, handling one-to-many peptide-protein relationships and reporting peptide evidence classes |
| #main/QuantBasedAlignment | Quantification-based alignment | Performs run alignment using smoothing splines to map retention times between source and target runs, enabling peptide ion transfer across runs |

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

- WorkflowHub: https://workflowhub.eu/workflows/2051
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
