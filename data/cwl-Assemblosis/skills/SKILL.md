---
name: assemblosis
description: "This CWL workflow automates the hybrid assembly of eukaryotic genomes using PacBio long-reads and Illumina short-reads through a pipeline of read correction, decontamination, and polishing with tools like Canu and Arrow. Use this skill when you need to generate high-quality de novo genome assemblies for non-model organisms, eliminate redundant haplotypes, and produce masked reference sequences for downstream genomic analysis."
homepage: https://workflowhub.eu/workflows/334
---
# Assemblosis

## Overview

[Assemblosis](https://workflowhub.eu/workflows/334) is a Common Workflow Language (CWL) pipeline designed for the hybrid assembly of haploid or diploid eukaryote genomes, specifically optimized for non-model organisms. It integrates PacBio long-reads and Illumina short-reads to produce high-quality genomic sequences. The workflow is fully automated, leveraging BioConda and DockerHub to manage dependencies, and can be executed using [Cromwell](https://cromwell.readthedocs.io/en/stable) or [cwltool](https://github.com/common-workflow-language/cwltool).

The workflow follows a multi-stage process to ensure assembly accuracy:
*   **Preprocessing:** Long-reads are extracted, corrected, trimmed, and decontaminated using Centrifuge against the NCBI nucleotide database.
*   **Assembly & Polishing:** Decontaminated reads are assembled into a draft genome. This assembly is polished first with raw long-reads (via Arrow) and subsequently with cleaned Illumina short-reads to improve base-level accuracy.
*   **Post-processing:** The final polished assembly is masked for repeats using RepBase and processed to eliminate redundant haplotypes.

The pipeline provides both the final polished assembly and intermediate assemblies from various stages of the process. Users must provide a YAML configuration file specifying local paths for raw data, Illumina adapters, and reference databases. The source code and installation scripts are available in the [Assemblosis GitHub repository](https://github.com/vetscience/Assemblosis).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| pacBioDataDir |  | Directory |  |
| pacBioTmpDir |  | string |  |
| pacBioInBam |  | boolean |  |
| prefix |  | string |  |
| genomeSize |  | string |  |
| minReadLen |  | int |  |
| corMaxEvidenceErate |  | float |  |
| readsPe1 |  | File[] |  |
| readsPe2 |  | File[] |  |
| phredsPe |  | string[] |  |
| slidingWindow |  | assembly-typedef.yml#slidingWindow |  |
| illuminaClip |  | assembly-typedef.yml#illuminaClipping? |  |
| leading |  | int |  |
| trailing |  | int |  |
| minlen |  | int |  |
| threads |  | int |  |
| minThreads |  | int |  |
| canuConcurrency |  | int |  |
| orientation |  | string |  |
| maxFragmentLens |  | int[] |  |
| polishedAssembly |  | string |  |
| diploidOrganism |  | boolean |  |
| fix |  | string |  |
| database |  | Directory |  |
| taxons |  | int[] |  |
| partialMatch |  | int |  |
| repBaseLibrary |  | File |  |
| trueValue |  | boolean |  |
| falseValue |  | boolean |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| cleanIlluminaReads | cleanIlluminaReads |  |
| hdf5check | hdf5check |  |
| correct | correct |  |
| renameReads | renameReads |  |
| classifyReads | classifyReads |  |
| decontaminate | decontaminate |  |
| assemble | assemble |  |
| arrow | arrow |  |
| indexReference | indexReference |  |
| expressionToolBowtie | expressionToolBowtie |  |
| mapIlluminaReads | mapIlluminaReads |  |
| sortMappedReads | sortMappedReads |  |
| indexBamFile | indexBamFile |  |
| expressionToolBam | expressionToolBam |  |
| pilon | pilon |  |
| indexAssembly | indexAssembly |  |
| expressionToolRepeatModeler | expressionToolRepeatModeler |  |
| inferRepeats | inferRepeats |  |
| maskCustomRepeats | maskCustomRepeats |  |
| maskTranspRepeats | maskTranspRepeats |  |
| maskSimpleRepeats | maskSimpleRepeats |  |
| combineCatFiles | combineCatFiles |  |
| haploMerge | haploMerge |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| correctedReads |  | File |  |
| trimmedReads |  | File |  |
| canuAssembly |  | File |  |
| arrowAssembly |  | File |  |
| pilonAssembly |  | File |  |
| trimmedReadFiles1 |  | File[] |  |
| trimmedReadFiles2 |  | File[] |  |
| sortedBamIndexFileOut |  | File[] |  |
| deconReport |  | File |  |
| deconClassification |  | File |  |
| decontaminatedReads |  | File |  |
| contaminatedReads |  | File |  |
| assemblyMasked |  | File |  |
| assemblyMerged |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/334
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
