---
name: knock-knock
description: knock-knock is a bioinformatic pipeline that deconstructs and classifies complex genome editing outcomes by aligning sequencing reads to target loci, donors, and the genome. Use when user asks to analyze genome editing results, classify repair outcomes, build alignment indices for editing targets, or process sequencing data to identify precise repair architectures.
homepage: https://github.com/jeffhussmann/knock-knock
---

# knock-knock

## Overview
knock-knock is a specialized bioinformatic pipeline designed to deconstruct the complex results of genome editing. Unlike standard aligners that assume a linear reference, knock-knock uses a "parsimonious subset" approach to local alignments. It attempts to cover every part of a sequencing read by looking at all relevant sequences in the edited cell—including the target locus, donor templates, and the rest of the genome—to classify the precise architecture of the repair outcome.

## Project Setup and Initialization
All knock-knock operations revolve around a central `PROJECT_DIR`.

- **Initialize with Example Data**: To understand the required directory structure, run:
  `knock-knock install_example_data PROJECT_DIR`
- **Directory Structure**: Ensure your project directory follows this schema:
  - `data/`: Contains subdirectories for `illumina/` or `pacbio/` fastq files and their respective `sample_sheet.csv`.
  - `targets/`: Contains `targets.csv`, `sgRNAs.csv`, `donors.csv`, and `amplicon_primers.csv`.
  - `indices/`: Stores reference genomes and alignment indices.

## Reference Management
knock-knock requires specific indices for STAR, minimap2, and BLAST.

- **Automated Build**: For standard organisms (hg38, mm10, e_coli), use the built-in downloader:
  `knock-knock build-indices PROJECT_DIR ORGANISM --num-threads 8`
- **Custom Indices**: If you already have indices, create an `index_locations.yaml` file in the `PROJECT_DIR` pointing to the absolute paths of your fasta and index files to avoid redundant builds.

## Target Specification
Targets are defined by combining a genomic locus with an optional HDR donor.

- **Defining Targets**: Edit `PROJECT_DIR/targets/targets.csv`. Each row must link a unique name to a specific `sgRNA`, `forward_primer`, `reverse_primer`, and `donor` defined in the auxiliary CSV files.
- **Coordinate Precision**: Ensure the protospacer sequence in `sgRNAs.csv` is exact; knock-knock uses this to define the expected cut site for alignment categorization.

## Data Processing Workflow
Once the project directory is populated and indices are built, execute the analysis:

1. **Process Samples**: Run the main pipeline to align and classify reads.
   `knock-knock process PROJECT_DIR [--sample SAMPLE_NAME] [--num-threads 16]`
   - Use `--sample` to process a specific entry from the sample sheet; otherwise, it processes all samples.
2. **Generate Summaries**: After processing, aggregate the results into interactive tables and plots.
   `knock-knock generate-tables PROJECT_DIR`

## Expert Tips and Best Practices
- **Sequencing Platforms**: Use PacBio CCS data for large amplicons (kb range) to capture long-range rearrangements. Use paired-end Illumina for high-resolution analysis of small indels or short HDR integrations.
- **Parallelization**: knock-knock relies on GNU Parallel. Ensure your environment has sufficient memory when using high `--num-threads` counts, especially during the STAR alignment phase.
- **Validation**: Before running a full cohort, use `install_example_data` and run the pipeline on the provided BCAP31 or CLTA samples to verify that all non-Python dependencies (blastn, minimap2, samtools, STAR) are correctly in your PATH.
- **Visualization**: The output of `generate-tables` includes a `results` folder with HTML summaries. Open these in a browser to view outcome-stratified length distributions, which are critical for identifying large deletions or insertions that might be missed by simple count tables.



## Subcommands

| Command | Description |
|---------|-------------|
| knock-knock | A tool for analyzing genomic data, with various subcommands for different tasks. |
| knock-knock | A tool for analyzing knock-knock sequences. |
| knock-knock build-indices | Build indices for a genome. |
| knock-knock build-strategies | Builds strategies for a project. |
| knock-knock download-genome | Download a genome and its associated annotations. |
| knock-knock install-example-data | Installs example data for a knock-knock project. |
| knock-knock parallel | Run knock-knock in parallel across multiple samples. |
| knock-knock process-sample | Process a sample using knock-knock. |
| knock-knock table | Generates a table of knock-knock results. |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_jeffhussmann_knock-knock.md)
- [Installation and Getting Started](./references/github_com_jeffhussmann_knock-knock_blob_master_README.md)
- [Visualization Guide](./references/github_com_jeffhussmann_knock-knock_blob_master_docs_visualization.md)