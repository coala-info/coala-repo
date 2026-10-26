# vafator CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| vafator | PASS |  |
| vafator_hatchet2bed | PASS |  |
| vafator_multiallelics-filter | PASS |  |
| vafator_vafator2decifer | PASS |  |

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

## vafator_multiallelics-filter

### Tool Description
Filter multiallelic variants of a VAFator annotated VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/vafator:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/tron-bioinformatics/vafator
- **Package**: https://anaconda.org/channels/bioconda/packages/vafator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: multiallelics-filter [-h] --input-vcf INPUT_VCF --output-vcf OUTPUT_VCF
                            [--tumor-sample-name TUMOR_SAMPLE_NAME]

vafator v2.2.2

optional arguments:
  -h, --help            show this help message and exit
  --input-vcf INPUT_VCF
                        The VCF to annotate (default: None)
  --output-vcf OUTPUT_VCF
                        The annotated VCF (default: None)
  --tumor-sample-name TUMOR_SAMPLE_NAME
                        The tumor sample name (will look for annotation
                        ${SAMPLE_NAME}_af) (default: tumor)

Copyright (c) 2019-2021 TRON gGmbH (See LICENSE for licensing details)
```

## vafator_hatchet2bed

### Tool Description
Generate copy number BED files from a HATCHet best.seg.ucn file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vafator:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/tron-bioinformatics/vafator
- **Package**: https://anaconda.org/channels/bioconda/packages/vafator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hatchet2bed [-h] -i INPUT_FILE -o OUTPUT_PREFIX

Generate input for Decifer using VCF file and HATCHet CNA file

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file INPUT_FILE
                        input *.ucn hatchet file
  -o OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
                        output BED file prefix, one file will be created per
                        sample in the input with the average tumor copy number
                        in each segment
```

## vafator_vafator2decifer

### Tool Description
Generate input for Decifer using VCF file and HATCHet CNA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vafator:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/tron-bioinformatics/vafator
- **Package**: https://anaconda.org/channels/bioconda/packages/vafator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vafator2decifer [-h] -V VCF_FILE -S SAMPLES -C CNA_FILE -O OUT_DIR -M
                       MIN_DEPTH -A MIN_ALT_DEPTH -F MIN_VAF [-N MAX_CN]
                       [-B EXCLUDE_LIST] [-p MIN_PURITY] [--snp_file SNP_FILE]

Generate input for Decifer using VCF file and HATCHet CNA file

optional arguments:
  -h, --help            show this help message and exit
  -V VCF_FILE, --vcf_file VCF_FILE
                        single or multi-sample VCF file
  -S SAMPLES, --samples SAMPLES
                        comma separated list of sample name prefixes to use
                        for VAFator annotations, eg:
                        primary_tumor,metastasis_tumor; the annotations
                        primary_tumor_ac, primary_tumor_dp, etc. will be
                        expected to exist
  -C CNA_FILE, --cna_file CNA_FILE
                        HATCHet CNA file: best.seg.ucn
  -O OUT_DIR, --out_dir OUT_DIR
                        directory for printing files; please make unique for
                        each patient!
  -M MIN_DEPTH, --min_depth MIN_DEPTH
                        minimum depth PER sample
  -A MIN_ALT_DEPTH, --min_alt_depth MIN_ALT_DEPTH
                        minimum depth of ALT allele in at least one sample
  -F MIN_VAF, --min_vaf MIN_VAF
                        minimum VAF of ALT allele in at least one sample
  -N MAX_CN, --max_CN MAX_CN
                        maximum total copy number for each observed clone
  -B EXCLUDE_LIST, --exclude_list EXCLUDE_LIST
                        BED file of genomic regions to exclude
  -p MIN_PURITY, --min_purity MIN_PURITY
                        minimum purity to consider samples
  --snp_file SNP_FILE   HATCHet file containing germline SNP counts in tumor
                        samples, baf/tumor.1bed
```

