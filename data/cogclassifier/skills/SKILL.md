---
name: cogclassifier
description: The cogclassifier tool automates the functional annotation of microbial protein sequences by searching them against the COG database using RPS-BLAST. Use when user asks to classify prokaryotic proteins into functional categories, perform COG database searches, or generate visual summaries of metabolic roles.
homepage: https://github.com/moshi4/COGclassifier/
metadata:
  docker_image: "quay.io/biocontainers/cogclassifier:2.0.0--pyhdfd78af_0"
---

# cogclassifier

## Overview
The `cogclassifier` tool automates the functional annotation of microbial genes by searching query sequences against the COG database using RPS-BLAST. It streamlines the workflow from raw protein sequences to categorized functional assignments, providing both tabular data and visual summaries. Use this skill when you need to determine the metabolic, cellular, or information processing roles of a set of prokaryotic proteins.

## Installation
Ensure `ncbi-blast+` (specifically `rpsblast`) is installed on the system.
```bash
# Via Bioconda
conda install -c conda-forge -c bioconda cogclassifier

# Via PyPI
pip install cogclassifier
```

## Core Usage Patterns

### Basic Classification
To run a standard classification on a protein FASTA file:
```bash
COGclassifier -i input_proteins.faa -o output_directory
```

### Performance Optimization
For large datasets, utilize multiple CPU cores to speed up the RPS-BLAST search:
```bash
COGclassifier -i input.faa -o output_dir -t 8
```

### Adjusting Search Sensitivity
The default E-value threshold is 0.01. For more stringent annotations, lower the E-value:
```bash
COGclassifier -i input.faa -o output_dir -e 1e-5
```

## Output Interpretation
The tool generates several key files in the output directory:
- `rpsblast.tsv`: Raw RPS-BLAST results (outfmt 6).
- `cog_classify.tsv`: The primary mapping of query sequences to COG IDs and functional categories.
- `cog_category_count.tsv`: Summary counts for each functional category.
- `cog_barchart.png` / `cog_piechart.png`: Visual representations of the functional distribution.

## Expert Tips
- **Database Caching**: By default, COG and CDD resources are downloaded to `~/.cache/cogclassifier_v2`. If working in an environment with restricted internet or shared resources, use `-d` to specify a pre-populated directory.
- **Multiple Categories**: If a protein matches a COG with multiple functional letters (e.g., "KTN"), `cogclassifier` treats the first letter as the primary category for classification purposes.
- **Input Requirements**: Ensure input files are protein sequences (FAA), not nucleotide sequences (FNA), as the tool relies on RPS-BLAST which compares protein queries against PSSMs.

## Reference documentation
- [COGclassifier GitHub README](./references/github_com_moshi4_COGclassifier.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cogclassifier_overview.md)