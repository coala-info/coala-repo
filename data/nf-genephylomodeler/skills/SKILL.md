---
name: genephylomodeler
description: This pipeline fits evolutionary models and performs hypothesis testing on multiple sequence alignments of coding genes using a samplesheet containing alignment files and phylogenetic trees to produce results in JSON and text formats. Use when detecting signatures of selection, estimating evolutionary rates, or identifying recombination using tools from the HyPhy suite such as aBSREL, BUSTED, or MEME.
homepage: https://github.com/nf-core/genephylomodeler
---

# genephylomodeler

## Overview
nf-core/genephylomodeler is a bioinformatics pipeline designed to automate the application of evolutionary models to multiple sequence alignments of coding genes. It facilitates complex phylogenetic analyses such as detecting episodic diversifying selection, site-specific selection, and the relaxation or intensification of selection pressures across different branches of a tree.

The pipeline streamlines the execution of various methods from the HyPhy software package. By providing gene alignments and corresponding phylogenetic trees, users can generate statistical evidence for evolutionary hypotheses in standardized formats suitable for downstream interpretation and visualization.

## Data preparation
The pipeline requires a comma-separated (CSV) samplesheet specified with the `--input` parameter. This file defines the genes to be analyzed and the specific tools to be applied to each.

The samplesheet must contain the following columns:
- `gene_name`: A unique identifier for the gene (cannot contain spaces).
- `alignment`: Path to the multiple sequence alignment file. Supported extensions include `.fna`, `.faa`, `.fasta`, `.fa`, `.fas`, `.nex`, `.nxs`, `.phy`, and `.aln`.
- `tree`: Path to the phylogenetic tree file. Supported extensions include `.tree`, `.tre`, `.nwk`, `.newick`, `.nex`, and `.nxs`.
- `suite`: The software suite to use (currently only `hyphy` is supported).
- `tool`: The specific analysis method to run (e.g., `absrel`, `bgm`, `busted`, `fade`, `fel`, `fubar`, `gard`, `meme`, `relax`, or `slac`).

Example `samplesheet.csv`:
```csv
gene_name,alignment,tree,suite,tool
KSR2,/path/to/ksr2.fna,/path/to/ksr2.tree,hyphy,absrel
TRIM5,/path/to/trim5.fna,/path/to/trim5.tree,hyphy,meme
MX1,/path/to/mx1.fna,/path/to/mx1_labeled.tree,hyphy,relax
```

## How to run
The pipeline is executed using Nextflow. It is recommended to test the setup with the provided test profile before running on actual data.

```bash
nextflow run nf-core/genephylomodeler \
   -profile <docker/singularity/conda/institute> \
   --input samplesheet.csv \
   --outdir <OUTDIR>
```

Key parameters:
- `-profile`: Specifies the software container or environment (e.g., `docker`, `singularity`).
- `--input`: Path to the CSV samplesheet.
- `--outdir`: The directory where results will be saved.
- `-resume`: Use this flag to restart a pipeline from the last successful step if it was interrupted.
- `-r`: Pin a specific version of the pipeline (e.g., `-r 1.0.0`).

Note that pipeline-specific parameters must use double dashes (e.g., `--input`), while core Nextflow options use a single dash (e.g., `-profile`).

## Outputs
All results are saved to the directory specified by the `--outdir` parameter. The primary deliverables include:
- **Tool-specific results**: Analysis outputs in JSON and text formats for each gene and tool combination defined in the samplesheet.
- **Pipeline reports**: Summary reports such as MultiQC (if applicable) and Nextflow execution logs.

For detailed information on interpreting specific tool outputs, refer to the [official output documentation](https://nf-co.re/genephylomodeler/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)