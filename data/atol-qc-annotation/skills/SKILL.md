---
name: atol-qc-annotation
description: This tool evaluates the quality of genome annotations by automating coding region extraction and assessment via BUSCO and OMArk. Use when user asks to assess annotation quality, generate a QC report for a predicted proteome, or run BUSCO and OMArk on a GFF file.
homepage: https://github.com/TomHarrop/atol-qc-annotation
metadata:
  docker_image: "quay.io/biocontainers/atol-qc-annotation:0.1.4--pyhdfd78af_0"
---

# atol-qc-annotation

## Overview

The `atol-qc-annotation` tool provides a streamlined pipeline for evaluating the quality of genome annotations. It automates the extraction and translation of coding regions using AGAT, followed by assessment via BUSCO and OMArk. This skill helps you configure the necessary database paths, taxonomy IDs, and resource parameters to generate a comprehensive QC report for a predicted proteome.

## Execution Environment

The primary supported method for running `atol-qc-annotation` is via BioContainers using Apptainer or Singularity.

```bash
apptainer exec \
  docker://quay.io/biocontainers/atol-qc-annotation \
  atol-qc-annotation [options]
```

## Core CLI Pattern

To run a standard QC analysis, you must provide the assembly FASTA, the annotation file, and paths to the required reference databases.

```bash
atol-qc-annotation \
  --threads 12 \
  --mem 32 \
  --fasta assembly.fasta \
  --annot annotation.gff \
  --lineage_dataset eukaryota_odb10 \
  --lineages_path /path/to/busco/lineages \
  --db /path/to/LUCA.h5 \
  --taxid <NCBI_TAX_ID> \
  --ete_ncbi_db /path/to/taxa.sqlite \
  --outdir ./qc_results \
  --logs ./qc_logs
```

## Best Practices and Tips

### Pre-processing Annotations
For the most reliable results, pre-process your annotation files using **AnnoOddities**. This tool generates a standardized GFF file (`*.AnnoOddities.gff`) that is optimized for the `atol-qc-annotation` pipeline.

### Database Preparation
The tool requires three specific reference datasets that must be prepared beforehand:
1.  **OMArk Database**: Download the `LUCA.h5` database from [omabrowser.org](https://omabrowser.org).
2.  **BUSCO Lineages**: Provide the path to the uncompressed directory containing BUSCO datasets.
3.  **ETE NCBI DB**: This is a formatted SQLite version of the NCBI taxonomy. You can generate it using the following Python snippet:
    ```python
    from ete4 import NCBITaxa
    ncbi = NCBITaxa()
    # The file is typically created in ~/.local/share/ete/
    ```

### Resource Management
- **Memory**: Use the `--mem` flag to set the maximum RAM in GB (default is 32).
- **Dry Run**: Use the `-n` flag to validate your command and paths without executing the heavy computation steps.
- **Threads**: Scale `--threads` based on your available CPU cores; BUSCO and OMArk steps are thread-efficient.

### Troubleshooting Input Formats
The tool uses `agat_sp_extract_sequences.pl` internally. If the tool fails during the extraction phase, ensure your GFF/GTF format is valid and contains the necessary parent-child relationships (e.g., mRNA features linked to CDS/Exon features).

## Reference documentation
- [atol-qc-annotation GitHub Repository](./references/github_com_TomHarrop_atol-qc-annotation.md)
- [bioconda atol-qc-annotation Overview](./references/anaconda_org_channels_bioconda_packages_atol-qc-annotation_overview.md)