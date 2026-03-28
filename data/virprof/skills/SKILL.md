---
name: virprof
description: VirProf is a bioinformatics pipeline that extracts, identifies, and assembles viral signals from host RNA-Seq data. Use when user asks to extract viral signals from host RNA-Seq data, perform host depletion, identify pathogens, or assemble viral genomes.
homepage: https://github.com/seiboldlab/virprof
---

# virprof

## Overview
VirProf is a specialized bioinformatics pipeline designed to extract viral signals from host RNA-Seq data. It automates the process of host depletion, pathogen identification, and genome assembly. It is particularly effective for respiratory virus surveillance but can be applied to any RNA-Seq dataset where microbial or viral presence needs to be quantified. The tool leverages the YMP (Yet another Meta-omics Pipeline) framework and Snakemake to manage complex multi-stage workflows.

## Core Workflows

### Initializing a Project
Before running analysis, initialize the environment and ensure reference databases are linked.
- **Test Initialization**: Run `./virprof_latest.sif init-test --force .` to generate a template directory structure including `test_data/`, `ymp.yml`, and `config.yml`.
- **Database Setup**: VirProf requires the NCBI NT BLAST database. Link your local copy to the `databases/nt` directory:
  ```bash
  cd databases
  ln -s /path/to/your/NT_folder nt
  ```

### Running the Pipeline
VirProf uses a "stage stack" syntax to define the processing steps.
- **Standard Pathogen Detection**:
  ```bash
  ./virprof_latest.sif ymp make <project>.<reference>.rnaseq_salmon.pathogen -j <threads>
  ```
- **Selective Alignment (Salmon SA)**: Use `rnaseq_salmon` for high-accuracy quantification.
- **Rerun Interrupted Jobs**: Always include the `--ri` flag to resume from the last successful checkpoint if a run is aborted.

### Configuration Best Practices
Modify `config.yml` to tune detection sensitivity and filtering:
- **Host Depletion**: Update `bin_prefilter_contigs` (e.g., `Euteleostomi`) and `bin_exclude_taxa` (e.g., `Hominidae`) to ensure host sequences are removed.
- **Detection Thresholds**:
  - `min_bp`: Minimum scaffold length (default 200).
  - `min_reads`: Minimum read count for a hit (default 3).
  - `max_pcthp`: Maximum homopolymer percentage to filter low-complexity sequences (default 12).
- **Whitelist**: Use `respiratory_virus_whitelist.txt` to prioritize specific pathogens in the final summary reports.

## Output Interpretation
Results are aggregated in the `reports/` directory with the naming convention `<project>.<pipeline>.<version>.<result>.<date>.<ext>`.
- **.xlsx / .rds**: Summary reports of identified pathogens. The RDS version is preferred for downstream R analysis (e.g., with DESeq2).
- **genomes/**: Multi-FASTA files containing recovered viral genomes grouped by species.
- **gene_counts.rds**: A `SummarizedExperiment` object containing host gene counts for differential expression analysis.
- **vp_multiqc_report.html**: Quality control metrics specifically for the pathogen detection stages.



## Subcommands

| Command | Description |
|---------|-------------|
| virprof blast-classify | Compute LCA classification from BLAST search result |
| virprof download-genomes | Download genomes from NCBI. |
| virprof export-fasta | Exports blastbin hits in FASTA format |
| virprof fasta-qc | Calculates contig QC values |
| virprof filter-blast | Filter sequences based on blast hits |
| virprof find-bins | Collects recovered sequences into per-species files |
| virprof index-tree | Parse NCBI taxonomy from dump files and write tree to binary |
| virprof init-test | Set up a demo/test directory |
| virprof prepare-phylo | Prepares sequences for phylogenetic analysis |
| virprof_blastbin | Merge and classify contigs based on BLAST search results |
| ymp | Welcome to YMP! |

## Reference documentation
- [VirProf GitHub README](./references/github_com_seiboldlab_virprof_blob_master_README.md)
- [Configuration Guide (config.yml)](./references/github_com_seiboldlab_virprof_blob_master_config.yml.md)
- [Changelog and Version History](./references/github_com_seiboldlab_virprof_blob_master_CHANGELOG.md)