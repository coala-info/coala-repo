# cosap CWL Generation Report

## cosap

### Tool Description
cosap

### Metadata
- **Docker Image**: quay.io/biocontainers/cosap:0.1.0--pyh026a95a_0
- **Homepage**: https://github.com/MBaysanLab/cosap
- **Package**: https://anaconda.org/channels/bioconda/packages/cosap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cosap/overview
- **Total Downloads**: 898
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MBaysanLab/cosap
- **Stars**: N/A
### Original Help Text
```text
Usage: cosap [OPTIONS]

Options:
  --analysis_type TEXT       Type of the analysis, can be somatic or germline
                             [required]
  --workdir TEXT             Directory that outputs will be saved  [required]
  --normal_sample TEXT       Path to normal sample
  --tumor_sample TEXT        Path to tumor sample. This option can be used
                             multiple times.
  --bed_file TEXT            Path to BED file
  --mapper TEXT              Mapper algorithm to use while aligning reads.
                             This option can be used multiple times. Options =
                             ['bwa', 'bwa2', 'bowtie2']
  --variant_caller TEXT      Variant caller algorithm to use for variant
                             detection.     This option can be used multiple
                             times, Options = ['mutect2','varscan2','haplotype
                             caller','octopus','strelka','somaticsniper','vard
                             ict', 'deepvariant']
  --normal_sample_name TEXT  Sample name of germline to write in bam. Default
                             is 'normal'
  --tumor_sample_name TEXT   Sample name of tumor to write in bam. Default is
                             'tumor'
  --bam_qc TEXT              Qaulity control algorithm for .bam quality check.
                             Options = ['qualimap', 'mosdepth']
  --annotators TEXT          Annotation tool to annotate variants in vcf
                             files.
  --gvcf BOOLEAN             Generate gvcf files
  --msi                      Run microsatellite instability analysis
  --gene_fusion              Run gene fusion analysis
  --device TEXT              Device to run the pipeline on. Options = ['cpu',
                             'gpu']
  --help                     Show this message and exit.
```


## Metadata
- **Skill**: generated
