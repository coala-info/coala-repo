---
name: insurveyor
description: INSurVeyor is a specialized discovery tool designed to identify genomic insertions with high speed and precision in Illumina paired-end data. Use when user asks to identify genomic insertions, resolve novel insertion sequences, or detect structural variants from BAM or CRAM files.
homepage: https://github.com/kensung-lab/INSurVeyor
metadata:
  docker_image: "quay.io/biocontainers/insurveyor:1.1.3--h077b44d_2"
---

# insurveyor

## Overview

INSurVeyor is a specialized discovery tool designed to identify genomic insertions with high speed and precision. Unlike general structural variant callers that handle multiple types of mutations, INSurVeyor is optimized specifically for insertions in Illumina paired-end data. It utilizes a combination of split-read analysis and local assembly to resolve insertion sequences, making it particularly effective for detecting novel sequences that are not present in the reference genome.

## Prerequisites and Data Preparation

Before running INSurVeyor, ensure your input data meets the following technical requirements:

*   **Alignment Format**: Input must be a coordinate-sorted and indexed BAM or CRAM file.
*   **Mandatory Tags**: Primary alignments must contain the `MC` (Mate CIGAR) and `MQ` (Mate Mapping Quality) tags.
    *   Recent versions of BWA MEM (0.7.17+) typically add the `MC` tag automatically.
    *   If tags are missing, use Picard's `FixMateInformation` to add them:
        `java -jar picard.jar FixMateInformation I=input.bam O=fixed.bam`
*   **Reference**: A reference genome in FASTA format (indexed).

## Command Line Usage

### Basic Execution
If installed via Conda, use the following syntax:
`insurveyor.py --threads <N> <BAM_FILE> <WORKDIR> <REFERENCE_FASTA>`

### Parameters
*   `--threads`: Number of CPU cores to utilize.
*   `<BAM_FILE>`: Path to the sorted/indexed alignment file.
*   `<WORKDIR>`: Path to a directory where results and intermediate files will be stored.
*   `<REFERENCE_FASTA>`: Path to the reference genome file.

## Interpreting Results

The tool generates two primary VCF files in the specified `WORKDIR`:

1.  **`out.pass.vcf.gz`**: Contains high-confidence insertions that passed all internal filters. This is the recommended file for most downstream analyses.
2.  **`out.vcf.gz`**: Contains all candidate insertions, including those flagged as low-confidence. These are often false positives and should only be used for manual curation of specific regions.

### Long Insertions
For insertions significantly longer than the library's insert size, INSurVeyor may fail to assemble the full sequence.
*   **Flag**: Look for `INFO/INCOMPLETE_ASSEMBLY` in the VCF.
*   **Sequence**: The `SVINSSEQ` field will provide a prefix and suffix of the insertion joined by a dash (`-`).

## Expert Tips and Best Practices

### Creating a Complete SV Callset
Since INSurVeyor only calls insertions, it is common practice to combine its output with a general caller like Manta. To merge them using `bcftools`:

1.  Filter out insertions from the Manta VCF:
    `bcftools view manta.vcf.gz -i "SVTYPE!='INS'" -Oz -o manta.noINS.vcf.gz`
2.  Index both files:
    `tabix -p vcf manta.noINS.vcf.gz`
    `tabix -p vcf out.pass.vcf.gz`
3.  Concatenate the results:
    `bcftools concat -a manta.noINS.vcf.gz out.pass.vcf.gz -Oz -o combined_svs.vcf.gz`

### Performance Note
While INSurVeyor is highly effective, the developers have released a successor called **SurVeyor** which handles deletions, duplications, and inversions in addition to insertions, and provides genotyping. Consider using SurVeyor if you require a unified caller for all SV types.

## Reference documentation
- [GitHub Repository - INSurVeyor](./references/github_com_kensung-lab_INSurVeyor.md)
- [Bioconda - INSurVeyor Overview](./references/anaconda_org_channels_bioconda_packages_insurveyor_overview.md)