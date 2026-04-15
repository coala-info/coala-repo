---
name: ucsc-bamtopsl
description: The ucsc-bamtopsl utility converts BAM alignment files into the PSL format used by the UCSC Genome Browser. Use when user asks to convert BAM to PSL, translate binary alignments to a human-readable format, or extract read sequences into FASTA files during conversion.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-bamtopsl:482--h0b57e2e_0"
---

# ucsc-bamtopsl

## Overview
The `bamToPsl` utility is a specialized converter within the UCSC Kent Toolkit. It translates the compressed, binary BAM format into the human-readable PSL format, which is the native alignment format for the UCSC Genome Browser. This is particularly useful for researchers who need to visualize alignments in the browser or perform downstream analysis using tools that require PSL input. Unlike many other converters, it can also reconstruct the read sequences into a FASTA file during the conversion process.

## Usage Instructions

### Basic Conversion
The most common use case is a direct conversion from BAM to PSL.
```bash
bamToPsl input.bam output.psl
```

### Extracting FASTA Sequences
To generate a FASTA file containing the reads alongside the PSL alignment:
```bash
bamToPsl -fasta=output.fa input.bam output.psl
```

### Handling Multiple Alignments
If your BAM file contains multiple alignments for the same read (e.g., chimeric reads or multi-mapping), `bamToPsl` will create a PSL record for each alignment.

### Expert Tips and Best Practices
- **Input Sorting**: While `bamToPsl` does not strictly require the BAM to be coordinate-sorted, having an indexed BAM is standard practice in bioinformatics pipelines to ensure compatibility with other tools in the workflow.
- **PSL vs. SAM/BAM**: Remember that PSL files do not store the reference sequence; they store the coordinates and match/mismatch counts. If you need to visualize the results in the UCSC Genome Browser, ensure the chromosome names in your BAM match the UCSC naming convention (e.g., "chr1" instead of "1").
- **Pipe Integration**: Like most UCSC utilities, `bamToPsl` can often be used in command-line pipes, though it typically expects file paths for its primary arguments.
- **Permissions**: If you have downloaded the binary directly from the UCSC servers, ensure it is executable: `chmod +x bamToPsl`.

## Reference documentation
- [ucsc-bamtopsl - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-bamtopsl_overview.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)