---
name: checkv
description: "CheckV evaluates the quality of viral contigs by identifying host contamination, estimating genome completeness, and assigning quality tiers. Use when user asks to assess viral genome quality, remove host contamination from proviruses, or estimate the completeness of metagenomic viral sequences."
homepage: https://bitbucket.org/berkeleylab/checkv
---


# checkv

## Overview
CheckV is a comprehensive pipeline designed to evaluate the quality of viral contigs identified from metagenomes. It performs three primary functions: identifying and removing host contamination from proviruses, estimating the completeness of viral genomes based on a large database of reference HMMs and complete genomes, and classifying contigs into quality tiers. This tool is essential for ensuring that viral sequences recovered from environmental samples are high-quality and ready for downstream comparative genomics or ecological analysis.

## Core Workflows

### Standard End-to-End Pipeline
The most common way to run CheckV is using the `end_to_end` command, which executes the full suite of modules (contamination detection, completeness estimation, and quality classification).

```bash
checkv end_to_end input_file.fasta output_directory -t 16 --db /path/to/checkv_db
```

### Modular Execution
If you only need specific information or want to re-run parts of the analysis, you can call individual modules:

- **Contamination Detection**: Identify and remove host regions from viral contigs.
  ```bash
  checkv contamination input.fasta output_dir --db /path/to/checkv_db
  ```
- **Completeness Estimation**: Calculate how much of the viral genome is present.
  ```bash
  checkv completeness input.fasta output_dir --db /path/to/checkv_db
  ```

## Expert Tips and Best Practices

- **Database Setup**: Before first use, ensure the CheckV database is downloaded and the environment variable `CHECKVDB` is set, or provide the path via the `--db` flag.
- **Input Requirements**: Input FASTA files should contain sequences already identified as viral (e.g., by VIBRANT, VirSorter2, or DeepVirFinder). CheckV is designed to assess quality, not to perform initial viral discovery.
- **Provirus Handling**: CheckV is particularly effective at identifying the boundaries of integrated proviruses. Check the `contamination.tsv` output to see the coordinates of the predicted viral region.
- **Interpreting Quality Tiers**:
    - **Complete**: High confidence the full genome is present (e.g., contains DTRs or ITRs).
    - **High-quality**: >90% estimated completeness.
    - **Medium-quality**: 50-90% estimated completeness.
    - **Low-quality**: <50% estimated completeness.
- **Resource Allocation**: Use the `-t` flag to specify threads. Completeness estimation is computationally intensive and benefits significantly from parallelization.

## Key Output Files
- `quality_summary.tsv`: The primary results file containing completeness, contamination, and quality tier for each contig.
- `completeness.tsv`: Detailed breakdown of how completeness was calculated (HMM-based vs. AAI-based).
- `contamination.tsv`: Coordinates of host vs. viral regions for proviruses.
- `proviruses.fna`: FASTA file containing the extracted viral portions of host-contaminated contigs.

## Reference documentation
- [CheckV Bitbucket Repository](./references/bitbucket_org_berkeleylab_checkv.md)