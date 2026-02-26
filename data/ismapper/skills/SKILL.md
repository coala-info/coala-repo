---
name: ismapper
description: ISMapper identifies the locations and orientations of insertion sequences within bacterial genomes using paired-end Illumina reads and a reference genome. Use when user asks to map insertion sequences, identify IS element coordinates, or track mobile genetic elements in bacterial populations.
homepage: https://github.com/jhawkey/IS_mapper/
---


# ismapper

## Overview
ISMapper is a specialized mapping-based tool designed to pinpoint where specific insertion sequences are located within a bacterial genome. By utilizing paired-end Illumina reads and a reference GenBank file, it identifies the flanking regions of IS elements to determine their exact coordinates and orientation. This tool is essential for researchers tracking mobile genetic elements, investigating outbreaks, or analyzing genomic plasticity in bacterial populations.

## Usage Patterns

### Basic Command
The core command for ISMapper is `ismap`. You must provide paired-end reads, at least one IS query sequence, and a reference genome.

```bash
ismap --reads isolate_R1.fastq.gz isolate_R2.fastq.gz \
      --queries IS_element.fasta \
      --reference reference_genome.gbk \
      --output_dir ./output_results
```

### Processing Multiple Isolates
ISMapper can handle multiple read sets in a single command. It automatically pairs files belonging to the same isolate based on naming conventions.

```bash
ismap --reads /path/to/reads/*.fastq.gz \
      --queries IS_collection.fasta \
      --reference ref.gbk \
      --output_dir ./batch_results
```

### Advanced Mapping Parameters
Fine-tune hit detection based on your data quality:
- `--cutoff`: Minimum depth for a mapped region to be considered (default: 6). Increase this for high-coverage data to reduce noise.
- `--novel_gap_size`: Distance (bp) between left and right flanks to call a novel hit (default: 15).
- `--min_range` / `--max_range`: Percent size of the gap to be called a known hit (default: 0.9 to 1.1).

## Expert Tips and Best Practices

### Reference Requirements
- **Locus Tags**: Every CDS, tRNA, or rRNA feature in your reference GenBank file **must** have a `locus_tag`. ISMapper uses these for reporting the genomic context of insertions.
- **Multi-entry Files**: You can provide multiple reference genomes as separate files or as a single multi-entry GenBank file.

### Performance Optimization
- **Threading**: Use the `--t` flag to specify the number of threads for BWA mapping.
- **Logging**: Use `--log` to specify a custom prefix for log files to keep track of large batch runs.

### Troubleshooting and Validation
- **Keep Intermediate Files**: If you need to manually validate a hit in a genome browser (like IGV), use the `--bam` flag to prevent ISMapper from deleting the final BAM files.
- **Temporary Files**: Use `--temp` to keep the temporary directory if a run fails and you need to inspect the mapping stages.
- **Gene Information**: If your GenBank uses a qualifier other than `product` for gene descriptions, specify it using `--cds`, `--trna`, or `--rrna`.

### Output Interpretation
ISMapper creates a subdirectory for each isolate, and further subdirectories for each IS query.
- **Table Files**: These contain the coordinates, orientation, and nearby genes for each identified IS site.
- **Compiled Tables**: Use the `compiled_table.py` script (included with the installation) to merge results from multiple isolates into a single summary table.

## Reference documentation
- [ISMapper GitHub Repository](./references/github_com_jhawkey_IS_mapper.md)
- [ISMapper Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ismapper_overview.md)