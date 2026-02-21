---
name: taranis
description: Taranis is a bioinformatics pipeline designed for high-resolution bacterial typing using genomic data.
homepage: https://github.com/BU-ISCIII/taranis
---

# taranis

## Overview

Taranis is a bioinformatics pipeline designed for high-resolution bacterial typing using genomic data. It transforms raw bacterial assemblies into interpretable allelic profiles by matching sequences against established schemas. The tool is essential for outbreak investigations where distinguishing between closely related strains requires the precision of wgMLST or cgMLST. It provides a complete workflow from cleaning and validating genomic schemas to the final identification of alleles in sample data.

## Core Workflow and CLI Patterns

### 1. Schema Quality Assessment
Before performing allele calling, validate the integrity of the MLST schema to remove redundant or non-functional sequences.

*   **Basic validation**: Run `analyze-schema` to generate statistics on start/stop codons and sequence lengths.
    ```bash
    taranys analyze-schema -i ./schema_dir -o ./output_analysis
    ```
*   **Schema cleaning**: Use flags to automatically remove problematic alleles (subsequences, duplicates, or non-coding regions).
    ```bash
    taranys analyze-schema -i ./schema_dir -o ./cleaned_schema \
        --remove-subset \
        --remove-duplicated \
        --remove-no-cds \
        --genus "Staphylococcus" \
        --species "aureus" \
        --cpus 8
    ```

### 2. Reference Allele Identification
Identify representative alleles for each locus to streamline the search process during the main analysis.

*   **Generate references**: Use the Leiden algorithm to cluster similar sequences and pick representatives.
    ```bash
    taranys reference-alleles --schema ./cleaned_schema --output ./ref_alleles --eval-cluster --cpus 8
    ```
*   **Fine-tuning clustering**: Adjust the resolution and identity thresholds if the schema is highly diverse.
    ```bash
    taranys reference-alleles --schema ./cleaned_schema --output ./ref_alleles \
        --cluster-resolution 0.85 \
        --eval-identity 90 \
        --kmer-size 31
    ```

### 3. Allele Calling
Execute the primary typing analysis on your sample assemblies.

*   **Standard execution**: Provide the reference alleles generated in the previous step and the directory containing your bacterial assemblies.
    ```bash
    taranys allele-calling --query ./ref_alleles --samples ./assemblies_dir --output ./results
    ```

## Expert Tips and Best Practices

*   **Resource Management**: Always specify the `--cpus` parameter. Taranis relies on BLASTn and Prokka, which are computationally intensive; matching the CPU count to your environment significantly reduces runtime.
*   **Schema Integrity**: Never skip the `analyze-schema` step when using a new or community-contributed schema. "Bad" quality alleles (missing start/stop codons) can lead to false negatives or ambiguous calls.
*   **Annotation Context**: When running `analyze-schema`, provide the `--genus` and `--species` flags. This allows the tool to use Prokka for better functional annotation of the alleles in your schema.
*   **Clustering Sensitivity**: If `reference-alleles` produces too many clusters per locus, increase the `--cluster-resolution` (default 0.75). If it produces too few, decrease it.
*   **Input Requirements**: Ensure input genomes are de novo assemblies (FASTA format). Taranis is optimized for contigs/scaffolds rather than raw reads.

## Reference documentation
- [Taranys GitHub Repository](./references/github_com_BU-ISCIII_taranys.md)
- [Taranis Wiki](./references/github_com_BU-ISCIII_taranys_wiki.md)