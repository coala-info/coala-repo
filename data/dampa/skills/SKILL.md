---
name: dampa
description: DAMPA designs and evaluates enrichment probes for targeted metagenomics by utilizing pangenome graphs to capture genetic diversity. Use when user asks to design a new probe panel, evaluate existing probe coverage, or optimize pangenome sensitivity for highly variable pathogens.
homepage: https://github.com/MultipathogenGenomics/dampa
metadata:
  docker_image: "quay.io/biocontainers/dampa:0.2.0--pyhdfd78af_0"
---

# dampa

## Overview

DAMPA (Diversity Aware Metagenomic Panel Assignment) is a specialized bioinformatics pipeline for designing enrichment probes used in targeted metagenomics. Instead of treating genomes as linear sequences, DAMPA constructs a pangenome graph to identify conserved and diverse regions across a dataset. This approach allows for the selection of the minimum number of probes necessary to capture the full genetic breadth of target organisms. It is particularly useful for researchers developing diagnostic panels or genomic surveillance tools for highly variable pathogens.

## Core Workflows

### Designing a New Probe Panel
The `design` module is the primary tool for generating probes from a set of input genomes.

```bash
dampa design -g <input_genomes> -o <output_dir> -p <prefix> [options]
```

**Key Parameters:**
- `-g, --input`: Accepts a single multifasta file or a directory containing individual `.fasta`, `.fa`, or `.fna` files.
- `-l, --probelen`: Sets the probe length (default: 120bp).
- `-s, --probestep`: Sets the tiling interval. For non-overlapping probes, set this equal to the probe length.
- `--pangraphident`: Controls the pangenome identity threshold (allowable values: 5, 10, or 20; default: 20).

### Evaluating Existing Probes
The `eval` module checks how well a specific probeset covers a set of target genomes, providing coverage statistics and visualizations.

```bash
dampa eval -g <genomes.fasta> -q <probes.fasta> -o <output_dir> -p <prefix>
```

## Expert Tips and Best Practices

### Optimizing Pangenome Sensitivity
The underlying pangenome graph determines how probes are distributed. If your target species is highly diverse:
- Adjust `--pangraphalpha` (default: 100) to control graph fragmentation.
- Adjust `--pangraphbeta` (default: 10) to influence how distantly related sequences are merged into blocks.
- Use `--pangraphlen` to set the minimum node length (default: 90bp) to ensure nodes are long enough for valid probe extraction.

### Handling Ambiguous Bases
By default, DAMPA substitutes ambiguous nucleotides (N) with random ATGC bases weighted by the input genome proportions. 
- Use `--skipsubambig` if you prefer to keep ambiguous bases as-is.
- Use `--maxambig` (default: 10) to filter out probes that contain too many non-standard bases after processing.

### Improving Coverage Gaps
DAMPA uses `probetools` as a final step to identify regions in the input genomes not covered by the initial pangenome-derived probes.
- Adjust `--probetoolsidentity` (default: 85) to change the stringency of what constitutes a "binding" match.
- If you only want probes derived strictly from the pangenome graph without gap-filling, use the `--skip_probetoolsfinal` flag.

### Visualizations and Reporting
Unless `--skip_summaries` is toggled, DAMPA generates plots showing probe coverage across genomes.
- Use `--report0covperc` to set the threshold for reporting genomes with insufficient coverage.
- Use `--maxdepth_describe` to define the coverage depth limit for detailed reporting.



## Subcommands

| Command | Description |
|---------|-------------|
| dampa design | Design probes for pangenomes |
| dampa eval | Check probe coverage against genomes or capture files. |
| dampa targets | Generates target sequences based on a dampa design JSON file. |

## Reference documentation
- [Dampa README](./references/github_com_MultipathogenGenomics_dampa_blob_main_README.md)
- [Project Metadata](./references/github_com_MultipathogenGenomics_dampa_blob_main_pyproject.toml.md)