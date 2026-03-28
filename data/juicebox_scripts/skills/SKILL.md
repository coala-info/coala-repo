---
name: juicebox_scripts
description: The juicebox_scripts tool converts genomic data formats between FASTA, AGP, and Juicebox-compatible assembly files to facilitate manual genome assembly curation. Use when user asks to convert FASTA or AGP files to assembly format, translate Juicebox edits back into updated genomic files, or remove gap contigs from assembly files.
homepage: https://github.com/phasegenomics/juicebox_scripts
---

# juicebox_scripts

## Overview

The juicebox_scripts skill provides a suite of utilities designed to bridge the gap between standard genomic data formats and the Juicebox visualization tool. It is primarily used during the scaffolding phase of genome assembly, allowing researchers to convert AGP and FASTA files into Juicebox-ready .assembly files, and conversely, to translate manual edits made within Juicebox back into updated FASTA, AGP, and BED files. This ensures that manual refinements to an assembly are accurately captured in downstream bioinformatic outputs.

## Tool Usage and CLI Patterns

### Preparing Files for Juicebox

Before visualizing an assembly in Juicebox, you often need to convert your starting files into the `.assembly` format.

*   **From FASTA to AGP**: If you only have a FASTA file, first generate an AGP representation.
    ```bash
    makeAgpFromFasta.py <input_fasta> <output_agp>
    ```
*   **From AGP to Assembly**: Convert the AGP file to a Juicebox-compatible `.assembly` file.
    ```bash
    agp2assembly.py <input_agp> <output_assembly>
    ```

### Processing Juicebox Outputs

After manually editing an assembly in Juicebox and exporting the `.assembly` file, use these scripts to generate the final assembly products.

*   **Full Scaffold Output**: Generate new FASTA, AGP, and BED files that reflect the scaffolding and orientations defined in Juicebox.
    ```bash
    python juicebox_assembly_converter.py -a <modified_assembly> -f <original_fasta> -p <output_prefix> -v
    ```
*   **Contig-Only Output**: Use this mode if you only want to retrieve the contigs (including any breaks introduced in Juicebox) without the scaffolding information.
    ```bash
    python juicebox_assembly_converter.py -a <modified_assembly> -f <original_fasta> -c
    ```

### Handling Gap Contigs

Juicebox sometimes includes gaps explicitly as contigs in the exported `.assembly` file, which can cause the converter script to fail. Use `degap_assembly.py` to clean these files.

```bash
python degap_assembly.py has_gaps.assembly > no_gaps.assembly
```

## Expert Tips and Best Practices

*   **Consistency is Critical**: Always ensure that the `.hic` file and the `.assembly` file used together in Juicebox were generated from the same underlying data. Mismatches in contig names or lengths between these files will lead to visualization errors and incorrect coordinate mapping.
*   **Break Reports**: The `juicebox_assembly_converter.py` script automatically generates a report describing contig breaks. Review this report to validate that the breaks introduced during manual curation align with your biological expectations or Hi-C signal evidence.
*   **Environment Requirements**: These scripts are compatible with Python 2.7 and 3.5/3.6. Ensure your environment has these versions available, as newer Python 3.x versions may require minor syntax adjustments for certain scripts.
*   **Integration with 3D-DNA**: For a complete workflow, these scripts are often used alongside the `3d-dna` pipeline and `matlock`. A common pattern for generating a `.hic` file from a BAM file (mapped against starting contigs) is:
    1. Convert BAM to links: `matlock bam2 juicer in.bam out.links.txt`
    2. Sort links: `sort -k2,2 -k6,6 out.links.txt > out.sorted.links.txt`
    3. Visualize: `bash 3d-dna/visualize/run-assembly-visualizer.sh -p false in.assembly out.sorted.links.txt`



## Subcommands

| Command | Description |
|---------|-------------|
| agp2assembly.py | (No description) |
| juicebox_assembly_converter.py | Converts a Juicebox assembly file to other formats. |
| juicebox_scripts_degap_assembly.py | Removes gaps from an assembly file. |
| makeAgpFromFasta.py | Converts a FASTA file to an AGP file. |

## Reference documentation

- [Juicebox Scripts README](./references/github_com_phasegenomics_juicebox_scripts_blob_master_README.md)
- [Juicebox Scripts Overview](./references/anaconda_org_channels_bioconda_packages_juicebox_scripts_overview.md)