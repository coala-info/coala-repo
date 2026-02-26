---
name: hmftools-cider
description: hmftools-cider extracts and identifies Complementary Determining Region 3 (CDR3) sequences from IG and TCR loci in sequencing data. Use when user asks to extract CDR3 sequences, identify immune repertoire diversity, or analyze clonal expansion from RNA or DNA samples.
homepage: https://github.com/hartwigmedical/hmftools/blob/master/cider/README.md
---


# hmftools-cider

## Overview
The `hmftools-cider` skill enables the extraction and identification of Complementary Determining Region 3 (CDR3) sequences from sequencing data. It is a specialized tool within the Hartwig Medical Foundation (HMF) suite designed to characterize the immune repertoire by analyzing IG and TCR loci. This tool is essential for researchers looking to understand clonal expansion, immune diversity, or tumor-immune interactions in both RNA and DNA samples.

## Installation
The tool is primarily distributed via Bioconda.
```bash
conda install bioconda::hmftools-cider
```

## Common CLI Patterns
While specific command-line arguments are often version-dependent, the tool typically follows the standard HMF tool structure.

### Basic Execution
To run CIDER, you generally need to provide input BAM/CRAM files and specify the reference genome.
```bash
java -jar cider.jar \
    -sample <SAMPLE_NAME> \
    -bam <INPUT_BAM> \
    -ref_genome <REFERENCE_FASTA> \
    -output_dir <OUTPUT_DIRECTORY>
```

### Key Parameters
- `-sample`: The identifier for the sample being processed.
- `-bam`: Path to the aligned RNA or DNA sequence data (BAM/CRAM format).
- `-ref_genome`: Path to the reference genome used for alignment (e.g., GRCh37 or GRCh38).
- `-output_dir`: Directory where the resulting CDR3 sequence lists and summary files will be stored.

## Best Practices and Expert Tips
- **Input Quality**: Ensure that the input BAM/CRAM files have high-quality alignments, especially around the IG and TCR loci. CIDER relies on these reads to reconstruct the CDR3 region.
- **Resource Allocation**: As a Java-based tool, ensure sufficient memory is allocated to the JVM using `-Xmx` flags (e.g., `java -Xmx8G -jar cider.jar`) depending on the size of the input BAM.
- **Loci Coverage**: When using DNA-seq, be aware that coverage of the V(D)J regions may be lower than in targeted or RNA-seq data; CIDER is optimized to handle these differences to provide a comprehensive list.
- **Reference Matching**: Always use the same reference genome version for CIDER that was used for the initial alignment of the BAM/CRAM file to avoid coordinate mismatches.

## Reference documentation
- [hmftools-cider Overview](./references/anaconda_org_channels_bioconda_packages_hmftools-cider_overview.md)
- [hmftools GitHub Repository](./references/github_com_hartwigmedical_hmftools_blob_master_cider_README.md)