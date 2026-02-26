---
name: metastudent
description: Metastudent predicts protein function by inferring Gene Ontology terms from annotated sequences using homology-based inference. Use when user asks to predict Molecular Function or Biological Process ontologies, assign functional annotations to protein sequences, or infer GO terms from FASTA files.
homepage: https://github.com/Rostlab/MetaStudent
---


# metastudent

## Overview

Metastudent is a command-line tool designed to predict protein function by inferring Gene Ontology (GO) terms from previously annotated proteins. It specifically targets the Molecular Function Ontology (MFO) and Biological Process Ontology (BPO). By leveraging homology-based inference, it provides a standardized way to assign functional annotations to uncharacterized protein sequences provided in FASTA format.

## Command Line Usage

The primary command for running predictions is `metastudent`.

### Basic Syntax
```bash
metastudent -i <INPUT_FASTA> -o <OUTPUT_PREFIX>
```

### Common Options
- `-i FASTA_FILE`: Input protein sequences. Ensure the file contains at most 500 sequences to manage memory usage.
- `-o PREFIX`: The prefix for output files. The tool generates separate files for each ontology (e.g., `prefix.MFO.txt` and `prefix.BPO.txt`).
- `--ontologies=MFO,BPO`: Specify which ontologies to predict. You can use `MFO`, `BPO`, or both (comma-separated).
- `--silent`: Suppress progress messages, showing only errors.
- `--debug`: Enable detailed debugging output.

## Expert Tips and Best Practices

### Optimizing Performance with Kickstarting
The BLAST phase is the most time-consuming part of the workflow. If you have already run BLAST or need to re-run a prediction with different parameters, use the kickstart option to skip the search phase:
```bash
metastudent -i input.fasta -o output --ontologies=MFO,BPO --blast-kickstart-databases=path/to/mfo.blast,path/to/bpo.blast
```
*Note: The number and order of kickstart files must match the ontologies specified.*

### Data Preparation
- **Clean Sequences**: Remove special characters or internal whitespaces from FASTA sequences before processing to prevent parsing errors.
- **Batching**: If you have more than 500 sequences, split the FASTA file into smaller chunks and process them sequentially to avoid high memory overhead.

### Output Analysis
- **Individual Predictors**: To see the results of individual methods before they are combined into the "meta" prediction, use the `--all-predictions` flag. This generates files with the format `<PREFIX>.<ONTOLOGY>.<METHOD>.txt`.
- **BLAST Results**: Use `--output-blast` to save the raw BLAST output, which is required if you plan to use the kickstart feature later.

### Configuration
Metastudent looks for configuration in several places. You can override defaults by pointing to a custom config file:
```bash
metastudent -i input.fasta -o output --config=/path/to/custom_metastudentrc
```
Default configuration is typically located at `/usr/share/metastudent/metastudentrc.default`.

## Reference documentation
- [MetaStudent README](./references/github_com_Rostlab_MetaStudent.md)
- [MetaStudent Wiki](./references/github_com_Rostlab_MetaStudent_wiki.md)