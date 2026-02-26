---
name: genotypy
description: The genotypy tool detects and reports genomic barcodes integrated into specific loci from sequencing data using a haplotype-based strategy. Use when user asks to identify genomic barcodes, process raw FASTQ reads for strain identification, or extract barcode information from BAM and SAM files.
homepage: https://gitbio.ens-lyon.fr/LBMC/yvertlab/vortex/plasticity_mutation/colony_rnaseq_bioinformatics/genotypy
---


# genotypy

## Overview

The `genotypy` tool is a specialized bioinformatics utility designed to detect and report genomic barcodes integrated into specific loci of interest. It processes sequencing data to identify which barcodes are present, using a haplotype-based strategy that considers combinations of barcodes seen within individual reads. This allows for the identification of specific strains or mutants within a mixed population. Starting from version 0.3.0, the tool can handle the entire workflow from raw reads to results by internally managing the mapping (via Bowtie2) and processing (via Samtools) steps.

## Installation

The recommended way to install `genotypy` is via Bioconda:

```bash
conda install bioconda::genotypy
```

## Core Workflows and CLI Patterns

### Running from Raw Reads (v0.3.0+)
Modern versions of `genotypy` can process FASTQ files directly. This workflow automatically handles the mapping to the reference locus.

```bash
genotypy --reads data.fastq.gz --config locus_config.json --output-dir results/
```

*Note: While the tool supports configuration files for defining loci, ensure your configuration specifies the reference sequence and the coordinates of the barcode region.*

### Processing Existing Alignments
If you have already performed mapping, you can run the tool on BAM or SAM files to extract barcode information.

```bash
genotypy --bam aligned_data.bam --config locus_config.json
```

### Performance Optimization
For large datasets, utilize multithreading during the mapping phase:

```bash
genotypy --reads data.fastq.gz --config locus_config.json --threads 8
```

## Output Interpretation

The tool generates several files in the specified output directory:

1.  **genotypy_results.tsv**: A summary file containing the detected barcodes and their associated locus names.
2.  **LOCUS_detected_barcodes.tsv**: A detailed report for each locus, including the actual strain names if a reference list of expected barcodes was provided.
3.  **_reference_barcodes.tsv**: Reports on the assignment of reads to known reference barcodes.
4.  **JSON Outputs**: Detailed results including read counts and proportions for each detected barcode haplotype.

## Expert Tips and Best Practices

-   **Anchor Sequences**: Ensure your reads have proper "anchors" (conserved sequences) on both sides of the barcode. Version 0.3.3+ specifically favors reads with clear anchors to improve detection accuracy.
-   **Dependency Check**: Ensure `bowtie2` and `samtools` are installed and available in your system PATH, as `genotypy` relies on them for the mapping-integrated workflow.
-   **Low Read Counts**: Version 0.3.4 and later will still produce a `_reference_barcodes.tsv` file even if no reads are detected, indicating a null result rather than failing.
-   **Strain Mapping**: To get direct strain names in your output, include a list of expected genomic barcodes in your configuration. The tool will then automatically match detected sequences against this library.
-   **Mapping Parameters**: The tool uses specific Bowtie2 parameters to handle "N" characters in reference sequences. If you encounter mapping issues, verify that your reference locus sequence is clean and well-defined.

## Reference documentation

- [genotypy - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_genotypy_overview.md)
- [genotypy README.md](./references/gitbio_ens-lyon_fr_LBMC_yvertlab_vortex_plasticity_mutation_colony_rnaseq_bioinformatics_genotypy_-_blob_main_README.md)
- [genotypy Tags and Releases](./references/gitbio_ens-lyon_fr_LBMC_yvertlab_vortex_plasticity_mutation_colony_rnaseq_bioinformatics_genotypy_-_tags.md)