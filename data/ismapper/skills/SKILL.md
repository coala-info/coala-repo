---
name: ismapper
description: ISMapper identifies the locations and genomic contexts of insertion sequences within a genome by mapping short reads to query sequences and a reference. Use when user asks to map insertion sequences, identify novel or known IS positions, or determine the flanking regions of mobile genetic elements.
homepage: https://github.com/jhawkey/IS_mapper/
---

# ismapper

## Overview
ISMapper is a specialized bioinformatics tool designed to pinpoint where specific mobile genetic elements (Insertion Sequences) are located within a genome. By mapping short reads to both an IS query and a reference genome, it identifies "flanking" sequences that indicate the exact coordinates of the IS. This allows for the detection of "known" hits (IS positions already in the reference) and "novel" hits (IS positions present in the isolate but not the reference).

## Basic Usage
The primary command for ISMapper is `ismap`. It requires three core inputs: paired-end reads, a reference genome in GenBank format, and one or more IS query sequences in FASTA format.

```bash
ismap --reads isolate_R1.fastq.gz isolate_R2.fastq.gz \
      --queries IS_element.fasta \
      --reference reference_genome.gbk \
      --output_dir results_folder
```

### Handling Multiple Inputs
*   **Reads**: You can provide multiple read sets using wildcards (e.g., `--reads path/to/*.fastq.gz`). ISMapper automatically pairs files belonging to the same isolate.
*   **Queries**: Multiple IS queries can be provided as separate files or a single multi-FASTA file.
*   **References**: Multiple reference genomes are supported, either as separate files or a multi-entry GenBank file.

## Expert Tips and Best Practices
*   **Locus Tag Requirement**: Every CDS, tRNA, and rRNA feature in your reference GenBank file **must** have a `locus_tag` qualifier. If these are missing, ISMapper will fail to report the genomic context of the hits.
*   **Refining Hit Detection**:
    *   **Depth**: If you have low-coverage data, consider lowering the `--cutoff` (default: 6) to identify potential hits, though this may increase false positives.
    *   **Novel Hits**: The `--novel_gap_size` (default: 15bp) determines the maximum distance between left and right flanks for a hit to be considered a single novel insertion.
    *   **Known Hits**: Use `--min_range` (default: 0.9) and `--max_range` (default: 1.1) to define the expected size of the IS element in the reference genome.
*   **Performance**: Always specify the number of threads for the BWA mapping step using `--t` to speed up processing.
*   **Debugging**: By default, ISMapper deletes intermediate files. Use the `--temp` flag to keep the temporary directory and `--bam` to keep the final BAM files if you need to manually inspect the mappings in a genome browser like IGV.
*   **Annotation Qualifiers**: If your GenBank file uses a qualifier other than `product` to describe genes, specify it using the `--cds`, `--trna`, or `--rrna` flags.

## Common CLI Patterns
**Running a batch of isolates against a single IS query:**
```bash
ismap --reads data/*.fastq.gz --queries IS26.fasta --reference ref.gbk --output_dir is26_mapping --t 8
```

**Summarizing results:**
After running `ismap`, use the `compiled_table.py` script (usually included in the installation) to aggregate results from multiple isolates into a single summary table.

```bash
compiled_table.py --input_dir results_folder --output_file summary_table.csv
```



## Subcommands

| Command | Description |
|---------|-------------|
| compiled_table.py | Create a table of IS hits in all isolates for ISMapper |
| ismap | Basic ISMapper options: |

## Reference documentation
- [ISMapper GitHub Repository](./references/github_com_jhawkey_IS_mapper.md)
- [ISMapper Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ismapper_overview.md)