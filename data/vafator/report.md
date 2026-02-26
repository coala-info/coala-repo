# vafator CWL Generation Report

## vafator

### Tool Description
vafator v2.2.2

### Metadata
- **Docker Image**: quay.io/biocontainers/vafator:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/tron-bioinformatics/vafator
- **Package**: https://anaconda.org/channels/bioconda/packages/vafator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vafator/overview
- **Total Downloads**: 35.0K
- **Last updated**: 2025-06-02
- **GitHub**: https://github.com/tron-bioinformatics/vafator
- **Stars**: N/A
### Original Help Text
```text
usage: vafator [-h] --input-vcf INPUT_VCF --output-vcf OUTPUT_VCF
               [--bam sample_name bam_file]
               [--mapping-quality MAPPING_QUALITY]
               [--base-call-quality BASE_CALL_QUALITY]
               [--purity sample_name purity]
               [--tumor-ploidy sample_name tumor_ploidy]
               [--normal-ploidy NORMAL_PLOIDY] [--fpr FPR]
               [--error-rate ERROR_RATE] [--include-ambiguous-bases]

vafator v2.2.2

optional arguments:
  -h, --help            show this help message and exit
  --input-vcf INPUT_VCF
                        The VCF to annotate (default: None)
  --output-vcf OUTPUT_VCF
                        The annotated VCF (default: None)
  --bam sample_name bam_file
                        A sample name and a BAM file. Can be used multiple
                        times to input multiple samples and multiple BAM
                        files. The same sample name can be used multiple times
                        with different BAMs, this will treated as replicates.
                        (default: [])
  --mapping-quality MAPPING_QUALITY
                        All reads with a mapping quality below this threshold
                        will be filtered out (default: 1)
  --base-call-quality BASE_CALL_QUALITY
                        All bases with a base call quality below this
                        threshold will be filtered out (default: 30)
  --purity sample_name purity
                        A sample name and a tumor purity value. Can be used
                        multiple times to input multiple samples in
                        combination with --bam. If no purity is provided for a
                        given sample the default value is 1.0 (default: [])
  --tumor-ploidy sample_name tumor_ploidy
                        A sample name and a tumor ploidy. Can be used multiple
                        times to input multiple samples in combination with
                        --bam. The tumor ploidy can be provided as a genome-
                        wide value (eg: --tumor-ploidy primary 2) or as local
                        copy numbers in a BED file (eg: --tumor-ploidy primary
                        /path/to/copy_numbers.bed), see the documentation for
                        expected BED format (default: 2) (default: [])
  --normal-ploidy NORMAL_PLOIDY
                        Normal ploidy for the power calculation (default: 2)
                        (default: 2)
  --fpr FPR             False Positive Rate (FPR) to use in the power
                        calculation (default: 5e-07)
  --error-rate ERROR_RATE
                        Error rate to use in the power calculation (default:
                        0.001)
  --include-ambiguous-bases
                        Flag indicating to include ambiguous bases from the DP
                        calculation (default: False)

Copyright (c) 2019-2021 TRON gGmbH (See LICENSE for licensing details)
```

