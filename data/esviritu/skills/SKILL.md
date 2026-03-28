---
name: esviritu
description: EsViritu identifies and quantifies viruses in metagenomic samples by aligning reads to a curated database and providing detailed taxonomic profiling. Use when user asks to identify viral pathogens in metagenomes, quantify viral abundance using RPKMF, or generate interactive viral detection reports.
homepage: https://github.com/cmmr/EsViritu
---


# esviritu

## Overview

EsViritu is a specialized bioinformatics tool designed to identify viruses within complex metagenomic samples. It works by aligning short reads against a curated database of viral genomes, dereplicating candidate references to find the "best" match, and providing detailed quantification metrics like RPKMF (Reads Per Kilobase per Million Filtered reads). It is particularly effective for clinical diagnostics or environmental surveillance where high sensitivity and specificity for viral pathogens are required.

## Core Workflows

### Running the Pipeline

The primary command is `EsViritu`. It requires a sample name, an output directory, and input FASTQ files.

**Single-end/Unpaired reads:**
```bash
EsViritu -r sample.fastq -s SampleID -o output_dir -p unpaired
```

**Paired-end reads:**
```bash
EsViritu -r R1.fastq R2.fastq -s SampleID -o output_dir -p paired
```

**Quality Filtering and Host Removal:**
To remove human/spike-in reads and perform quality trimming (requires `ESVIRITU_FILTER` environment variable to be set), use:
```bash
EsViritu -r reads.fastq -s SampleID -o output_dir -q True -f True -p unpaired
```

### Batch Summarization

After running multiple samples into the same parent output directory, generate a consolidated report and interactive HTML table:
```bash
summarize_esv_runs path/to/output_dir
```

### Custom Database Creation

If the default database (human/animal/plant viruses) is insufficient, follow this sequence:

1.  **Prepare Accession Table**: Create a TSV with `Accession`, `Organism_Name`, and `Length`.
2.  **Generate Metadata**:
    ```bash
    esv_create_taxonomy -i accessions.tsv -o metadata.tsv -a acc2taxid.tsv.gz -t taxdump/
    ```
3.  **Index Sequences**:
    ```bash
    minimap2 -x sr -d custom_db.mmi custom_db.fna
    ```
4.  **Run with Custom DB**:
    ```bash
    EsViritu -r reads.fastq -s SampleID -o output_dir --db /path/to/custom_db_folder
    ```

## Interpreting Results

The pipeline produces several key TSV files in the output directory:

*   **`*.detected_virus.info.tsv`**: The most granular view. Look at `avg_read_identity` and `covered_bases`.
*   **`*.tax_profile.tsv`**: Aggregated taxonomic view.
    *   **Species Level**: Generally requires >90% ANI.
    *   **Subspecies Level**: Generally requires >95% ANI.
*   **`*.reactable.html`**: An interactive report. Use this to visualize coverage breadth across the genome to rule out false positives caused by conserved regions or recombinants.

## Expert Tips

*   **Environment Variables**: Set `ESVIRITU_DB` and `ESVIRITU_FILTER` in your conda environment to avoid passing long paths to every command.
*   **Recombinants**: If a virus is a recombinant not in the database, EsViritu may report both parental strains. Always check the coverage sparklines in the HTML report; a "split" coverage pattern (5' end of one, 3' end of another) confirms a recombinant.
*   **Abundance**: Use RPKMF for cross-sample comparisons as it normalizes for both genome length and sequencing depth.



## Subcommands

| Command | Description |
|---------|-------------|
| EsViritu | EsViritu is a read mapping pipeline for detection and measurement of human, animal, and plat virus pathogens from short read libraries. It is useful for clinical and environmental samples. Version 1.1.6 |
| summarize_esv_runs | Summarize EsViritu run outputs across a directory. |

## Reference documentation

- [Using EsViritu](./references/esviritu_readthedocs_io_en_latest_esviritu-usage.md)
- [Data Directory and Output Reference](./references/esviritu_readthedocs_io_en_latest_data-directory.md)
- [Making Custom Databases](./references/esviritu_readthedocs_io_en_latest_custom-database.md)
- [Interpreting Outputs](./references/esviritu_readthedocs_io_en_latest_interpretting-outputs.md)
- [Pipeline Description](./references/esviritu_readthedocs_io_en_latest_pipeline-description.md)