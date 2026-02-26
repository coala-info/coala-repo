---
name: metacompass
description: MetaCompass is a reference-guided assembly pipeline for reconstructing genomes from metagenomic sequencing data. Use when user asks to perform reference-guided metagenomic assembly, recover low-coverage genomes from metagenomic samples, or combine reference-based and de novo assembly workflows.
homepage: https://github.com/marbl/MetaCompass
---


# metacompass

## Overview

MetaCompass is a specialized pipeline for the reference-guided assembly of metagenomic data. Unlike traditional de novo assemblers that rely solely on read overlaps, MetaCompass utilizes a "reference-first" approach. It identifies closely related reference genomes from a database using marker genes, maps reads to these references, and constructs contigs based on these alignments. This method is specifically designed to recover genomes from species present at low coverage that might otherwise be fragmented or lost in de novo workflows. The pipeline concludes by performing de novo assembly on any remaining unmapped reads to ensure a comprehensive reconstruction of the metagenomic sample.

## Installation and Setup

MetaCompass is primarily distributed via Bioconda or as a Nextflow pipeline from its GitHub repository.

**Conda Installation:**
```bash
conda install bioconda::metacompass
```

**Manual Setup (Recommended for latest features):**
1. Clone the repository: `git clone https://github.com/marbl/MetaCompass.git`
2. Create the environment: `conda env create -f metacompass_environment.yml`
3. Activate the environment: `conda activate metacompass`

## Core Usage Patterns

The modern version of MetaCompass (v2.0+) is executed as a Nextflow script.

### Standard Paired-End Run
The most common workflow requires a reference database path and your forward/reverse FASTQ files.

```bash
nextflow run metacompass2.nf \
  --reference_db "/path/to/ref_db" \
  --forward "sample_R1.fastq" \
  --reverse "sample_R2.fastq" \
  -output-dir "assembly_results" \
  --threads 16
```

### Key Parameters
- `--reference_db`: Path to the pre-built reference database (NCBI RefSeq based).
- `--forward` / `--reverse`: Paths to the input sequencing reads.
- `-output-dir`: Destination for results (defaults to "results").
- `--threads`: Number of threads for Pilon and other alignment steps (default is 16).
- `-with-timeline`: Generates a visual execution report (useful for debugging performance).

## Expert Tips and Best Practices

### 1. Reference Database Management
The quality of the assembly is highly dependent on the reference database. You can use the provided NCBI RefSeq collection or generate a custom one. Ensure the `ref_db_path` contains the necessary marker gene indexes required for the initial taxonomic profiling step.

### 2. Resource Configuration
MetaCompass uses Nextflow's `nextflow.config` to manage execution. If running on a local machine with limited RAM, edit the `nextflow.config` file to reduce the `queueSize` or adjust the executor parameters to prevent system crashes during the Pilon error-correction phase.

### 3. Handling Unmapped Reads
MetaCompass automatically passes reads that do not map to any reference to MEGAHIT for de novo assembly. If your output contains many small contigs in the de novo section, it may indicate that your sample contains novel organisms not well-represented in your reference database.

### 4. Output Interpretation
- **Contigs:** The primary output consists of polished contigs.
- **Trace File:** Use `--trace_file_name "trace.txt"` to get a detailed breakdown of each step in the pipeline, which is essential for identifying bottlenecks in the reference selection or mapping stages.

## Reference documentation
- [MetaCompass GitHub Repository](./references/github_com_marbl_MetaCompass.md)
- [MetaCompass Wiki](./references/github_com_marbl_MetaCompass_wiki.md)
- [Bioconda MetaCompass Overview](./references/anaconda_org_channels_bioconda_packages_metacompass_overview.md)