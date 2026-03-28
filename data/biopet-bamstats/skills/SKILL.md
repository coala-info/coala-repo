---
name: biopet-bamstats
description: "Biopet BamStats generates and manages detailed quality control metrics for BAM files organized by sample, library, and readgroup. Use when user asks to generate sequencing statistics from BAM files, merge multiple stats files for cohort analysis, or validate the integrity of existing stats files."
homepage: https://github.com/biopet/bamstats
---


# biopet-bamstats

## Overview
Biopet BamStats is a specialized tool for high-throughput sequencing quality control. It processes BAM files to produce detailed metrics organized by a hierarchical sample-library-readgroup structure. This allows for granular QC analysis across different levels of a sequencing project. The tool operates in three primary modes: generating new statistics, merging existing stats files for cohort-level analysis, and validating the integrity of stats files to ensure data consistency.

## Command Line Usage

### Generate Mode
Use this mode to process a BAM file and produce a statistics report.

```bash
# Basic generation (outputs JSON by default)
biopet-bamstats generate -b input.bam -o output.json

# Generate both JSON and TSV formats
biopet-bamstats generate -b input.bam -o output.json --tsvOutputs
```

**Requirements:**
*   The input BAM file must have readgroups annotated with **SM** (Sample) and **LB** (Library) tags.
*   If these tags are missing, use `samtools addreplacerg` or Picard `AddOrReplaceReadGroups` before running BamStats.

### Merge Mode
Use this mode to combine multiple BamStats JSON files into a single aggregate file. This is useful for project-level reporting.

```bash
# Merge multiple stats files
biopet-bamstats merge -i sample1.json -i sample2.json -o combined_stats.json
```

### Validate Mode
Use this mode to verify that a BamStats file is not corrupt. It attempts to regenerate aggregation values to ensure the file hasn't been improperly edited.

```bash
biopet-bamstats validate -i stats.json
```

## Expert Tips and Best Practices

*   **Metadata Integrity**: BamStats will throw an error if it encounters readgroups without sample or library metadata. Always validate your BAM headers (`samtools view -H`) before starting a large-scale run.
*   **Output Formats**: While JSON is the primary format for programmatic use and merging, the `--tsvOutputs` flag is highly recommended for manual inspection or for use with spreadsheet software.
*   **Resource Management**: When running via Java directly (if not using the Bioconda wrapper), ensure you allocate sufficient memory for large BAM files using JVM flags (e.g., `java -Xmx4G -jar BamStats.jar ...`).
*   **Validation Workflow**: Always run the `validate` mode after manually editing a JSON stats file or if a transfer process was interrupted, as the tool relies on internal consistency for accurate merging.



## Subcommands

| Command | Description |
|---------|-------------|
| generate | Generate statistics for a BAM file, including information about mapping quality, clipping, and region-specific stats. |
| merge | Merge bamstats files into a single file. |
| validate | Validate a BamStats file schema. |

## Reference documentation
- [BamStats GitHub Repository](./references/github_com_biopet_bamstats.md)
- [BamStats README](./references/github_com_biopet_bamstats_blob_develop_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_biopet-bamstats_overview.md)