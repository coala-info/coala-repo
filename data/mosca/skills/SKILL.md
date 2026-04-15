---
name: mosca
description: MOSCA is an automated pipeline that integrates metagenomic, metatranscriptomic, and metaproteomic data to characterize the taxonomy and functional pathways of microbial communities. Use when user asks to perform multi-omics integration, assemble and bin microbial reads, annotate genes using UniProt, or visualize metabolic pathways.
homepage: https://github.com/iquasere/MOSCA
metadata:
  docker_image: "quay.io/biocontainers/mosca:2.3.0--hdfd78af_0"
---

# mosca

## Overview

MOSCA (Meta-Omics Software for Community Analysis) is an automated pipeline designed to integrate multiple "omics" data types to characterize microbial communities. It streamlines the path from raw sequencing reads (DNA/RNA) or mass spectrometry spectra (Proteins) to functional insights. The tool handles complex bioinformatic tasks including quality control, iterative co-assembly, taxonomic binning, functional annotation via UniProt and reCOGnizer, and metabolic pathway visualization using KEGGCharter.

## Workflow Configuration

MOSCA relies on a JSON configuration file to define the execution environment and experimental design.

### Defining Experiments
The `experiments` object is the core of the configuration. Each entry must specify:
- **Files**: Path to input data. For paired-end short reads, use a comma-separated string (e.g., `"file_R1.fastq.gz,file_R2.fastq.gz"`).
- **Data type**: Use `dna` for metagenomics, `mrna` for metatranscriptomics, or `protein` for metaproteomics.
- **Sample**: Datasets sharing the same "Sample" value are co-assembled and binned together. Use this to group replicates or related time-points to improve assembly quality.
- **Condition**: Used for differential expression analysis (DESeq2). Replicates should share the same condition string.

### Essential Performance Parameters
- **threads**: Set the maximum number of CPU cores available.
- **max_memory**: Set the memory limit in Gb (e.g., `64`).
- **resources_directory**: Specify a persistent folder to store large databases (UniProt, CDD) to avoid re-downloading in future runs.

## Tool-Specific Best Practices

### Assembly and Binning
- **Assembler Selection**: Use `metaspades` for most community samples; `megahit` is preferred for very large datasets or memory-constrained environments.
- **Error Models**: When calling genes with FragGeneScan without assembly, match the `error_model` to your technology (e.g., `illumina_10` for Illumina reads with a 10% expected error rate). Set to `complete` if assembly was performed.
- **Markerset**: Use `107` for Bacteria-only studies or `40` if Archaea are expected to be significant members of the community.

### Functional Annotation
- **UniProt Integration**: Set `upimapi_check_db` to `true` on the first run to download the UniProtKB database. Subsequent runs should set this to `false` to save time.
- **Taxonomy IDs**: Provide a comma-separated list of Tax IDs in `upimapi_taxids` to restrict the search space and improve annotation speed if the community composition is partially known.
- **Disk Space**: If running out of space during DIAMOND searches, increase the `split_gene_calling` integer to process the data in smaller chunks.

### Metaproteomics (MP) Optimization
- **Reference Proteomes**: Set `metaproteomics_add_reference_proteomes` to `true` to automatically augment your search database with sequences from identified taxa.
- **Contaminants**: Always keep `use_crap` as `true` to filter common laboratory contaminants (keratins, trypsin) from your results.

## Execution Tips
- **Dry Runs**: Since MOSCA is Snakemake-based, ensure your JSON is valid before execution.
- **Output Management**: MOSCA creates an `output` directory. If a run is interrupted, MOSCA can typically resume from the last successful checkpoint if the output directory is preserved.
- **Visualization**: To get metabolic maps, ensure `keggcharter_maps` contains a list of valid KEGG map IDs (e.g., `["00010", "00020"]`).



## Subcommands

| Command | Description |
|---------|-------------|
| mosca | MOSCA's main script |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |

## Reference documentation
- [Configure and run MOSCA](./references/github_com_iquasere_MOSCA_wiki_Configure-and-run-MOSCA.md)
- [The MOSCA project](./references/github_com_iquasere_MOSCA_wiki_The-MOSCA-project.md)
- [Access MOSCA online](./references/github_com_iquasere_MOSCA_wiki_Access-MOSCA-online-_F0_9F_8C_90.md)