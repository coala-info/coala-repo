---
name: beav
description: beav is a command-line pipeline that orchestrates the functional annotation of bacterial genomes by integrating tools like Bakta, antiSMASH, and DefenseFinder. Use when user asks to annotate bacterial genomes, identify biosynthetic gene clusters, analyze integrative and conjugative elements, or classify Agrobacterium Ti/Ri plasmids.
homepage: https://github.com/weisberglab/beav
metadata:
  docker_image: "quay.io/biocontainers/beav:1.4.0--hdfd78af_1"
---

# beav

## Overview
beav (Bacterial Element Annotation reVamped) is a command-line pipeline designed to streamline the functional annotation of bacterial genomes. It acts as an orchestrator, automatically running and parsing results from various specialized tools like Bakta, antiSMASH, and DefenseFinder. It is particularly effective for researchers focusing on horizontal gene transfer, virulence factors, and plant-associated microbes, providing a unified output for complex features like integrative and conjugative elements (ICEs) and biosynthetic gene clusters.

## Installation and Setup
The pipeline relies on a complex environment of dependencies. Using `mamba` or `pixi` is strongly recommended for environment resolution.

```bash
# Installation via mamba
mamba create -n beav beav
conda activate beav

# Essential: Download prerequisite databases before first run
beav_db
```

## Common CLI Patterns

### Standard Annotation Run
The most common usage involves providing a FASTA nucleotide file.
```bash
beav --input genome.fna --threads 8 --output ./annotation_results
```

### Agrobacterium-Specific Analysis
beav includes a specialized module for Agrobacterium that identifies Ti/Ri plasmids and classifies them according to the Weisberg et al. 2020 scheme.
```bash
beav --input agro_strain.fna --agrobacterium True --threads 8
```

### Handling TIGER2 (ICE Analysis)
If you do not skip TIGER2, you must provide a reference BLAST database.
```bash
beav --input genome.fna --tiger_blast_database /path/to/ref_db --threads 8
```

## Expert Tips and Troubleshooting

### Known Bug Workarounds
*   **DefenseFinder Error**: There is a known bug in DefenseFinder models causing MacSyFinder failures. It is recommended to use the `--skip_defensefinder` flag unless you have manually applied the `registries.py` patch.
*   **ModuleNotFoundError (nrpys)**: If you encounter an error regarding the `nrpys` module, force a reinstall within your environment:
    ```bash
    python -m pip install --upgrade --force-reinstall nrpys
    ```

### Optimization
*   **Skipping Heavy Tools**: If you are only interested in core annotations and want to save time/resources, use skip flags:
    *   `--skip_antismash`: Skips biosynthetic gene cluster detection.
    *   `--skip_tiger`: Skips TIGER2 ICE analysis (removes the need for a reference BLAST DB).
    *   `--skip_gapmind`: Skips metabolic pathway analysis.
*   **Database Management**: Use `beav_db --light` if disk space is limited, which installs a smaller version of the Bakta database.

### Output Visualization
beav automatically generates Circos plots for the genome. If you performed an Agrobacterium-specific run, it will also generate specific plots for Ti/Ri plasmids. You can run the visualization script independently using `beav_circos`.

## Reference documentation
- [beav GitHub Repository](./references/github_com_weisberglab_beav.md)
- [beav Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_beav_overview.md)