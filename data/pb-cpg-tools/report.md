# pb-cpg-tools CWL Generation Report

## pb-cpg-tools

### Tool Description
FAIL to generate CWL: pb-cpg-tools not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pb-cpg-tools:3.0.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pb-CpG-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/pb-cpg-tools/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pb-cpg-tools/overview
- **Total Downloads**: 868
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/pb-CpG-tools
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pb-cpg-tools not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pb-cpg-tools not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pb-cpg-tools_aligned_bam_to_cpg_scores

### Tool Description
A utility to calculate CpG methylation scores from an alignment file with 5mC methylation tags. Outputs results in bed and bigwig format, including haplotype-specific results when available.

### Metadata
- **Docker Image**: quay.io/biocontainers/pb-cpg-tools:3.0.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pb-CpG-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/pb-cpg-tools/overview
- **Validation**: PASS
### Original Help Text
```text
aligned_bam_to_cpg_scores 3.0.0
Chris Saunders <csaunders@pacificbiosciences.com>
A utility to calculate CpG methylation scores from an alignment file with 5mC methylation tags. Outputs results in bed and bigwig format, including haplotype-specific results when available.

Usage: aligned_bam_to_cpg_scores [OPTIONS] --bam <FILE>

Options:
      --bam <FILE>
          Alignment file for input sample in BAM or CRAM format. Alignment file must be mapped and indexed, with MM/ML tags specifying 5mC methylation. If a CRAM file is provided, then `--ref` must also be specified

      --pileup-mode <MODE>
          Method to estimate site methylation from the read pileup
          
          [default: model]

          Possible values:
          - model: Deep learning model-based approach
          - count: Simple count-based approach

      --modsites-mode <MODE>
          Method to pick 5mC scoring sites
          
          [default: denovo]

          Possible values:
          - denovo:    Pick sites where "CG" is present in the majority of the reads
          - reference: Pick sites where "CG" is present in the reference sequence

      --ref <FILE>
          Genome reference in FASTA format. This is required if either (1) 'reference' modsite mode is selected or (2) input alignments are in CRAM format

      --output-prefix <PREFIX>
          Prefix used for all file output. If the prefix includes a directory, the directory must already exist
          
          [default: aligned_bam_to_cpg_scores]

      --threads <THREAD_COUNT>
          Number of threads to use. Defaults to all logical cpus detected

      --min-coverage <MIN_COVERAGE>
          Minimum site coverage. The tensorflow prediction models have their own hard-coded minimum coverage of 4, so any value below this level should have no effect in 'model' pileup mode
          
          [default: 4]

      --min-mapq <MIN_MAPQ>
          Minimum read mapping quality
          
          [default: 1]

      --hap-tag <HAP_TAG>
          The 2-letter SAM aux tag used for per-read haplotype ids in the input bam
          
          [default: HP]

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```

