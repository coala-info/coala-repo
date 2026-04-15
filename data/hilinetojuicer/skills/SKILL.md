---
name: hilinetojuicer
description: This utility transforms SAM alignment files from the HiLine pipeline into the short-format text files required by Juicer. Use when user asks to convert HiLine SAM files to Juicer format, prepare Hi-C data for Juicer tools pre, or bridge HiLine and Juicer workflows.
homepage: https://pypi.org/project/HiLineToJuicer/0.0.1/
metadata:
  docker_image: "quay.io/biocontainers/hilinetojuicer:0.0.2--pyhdfd78af_0"
---

# hilinetojuicer

## Overview
The `hilinetojuicer` utility serves as a specialized bridge in Hi-C data processing workflows. It specifically transforms SAM alignment files produced by the HiLine pipeline into the short-format text files required by the Juicer "tools pre" command. This conversion is essential for researchers who prefer the HiLine alignment strategy but wish to utilize the Juicer ecosystem for matrix generation and normalization.

## Usage Guidelines

### Basic Conversion
The tool is typically invoked via the command line to process SAM files. Ensure your input SAM files are sorted by read name if required by your specific Juicer version.

```bash
hilinetojuicer <input_sam_file> <output_juicer_format>
```

### Integration Workflow
To generate a `.hic` file after using this skill:
1. Run `hilinetojuicer` on your SAM output to create the intermediate text file.
2. Use the Juicer `pre` command with the resulting file:
   ```bash
   java -jar juicer_tools.jar pre <output_juicer_format> out.hic <genome_id>
   ```

### Best Practices
- **Environment**: Install via bioconda (`conda install bioconda::hilinetojuicer`) to ensure all dependencies are correctly managed.
- **Validation**: Verify that the chromosome names in your SAM file match the genome ID/chrom.sizes file used in the subsequent Juicer steps to prevent mapping errors.
- **Pipe Processing**: For large datasets, consider using Unix pipes if the version supports stdin/stdout to save disk space, though standard file-to-file conversion is the most stable approach.

## Reference documentation
- [HiLineToJuicer Project Overview](./references/pypi_org_project_HiLineToJuicer_0.0.1.md)
- [Bioconda Package Metadata](./references/anaconda_org_channels_bioconda_packages_hilinetojuicer_overview.md)