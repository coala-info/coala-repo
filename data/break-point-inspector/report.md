# break-point-inspector CWL Generation Report

## break-point-inspector

### Tool Description
A second layer of filtering on top of Manta

### Metadata
- **Docker Image**: quay.io/biocontainers/break-point-inspector:1.5--0
- **Homepage**: https://github.com/hartwigmedical/hmftools/tree/master/break-point-inspector
- **Package**: https://anaconda.org/channels/bioconda/packages/break-point-inspector/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/break-point-inspector/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hartwigmedical/hmftools
- **Stars**: N/A
### Original Help Text
```text
usage: Break-Point-Inspector [-contamination_fraction <arg>] [-output_vcf
       <arg>] [-proximity <arg>] -ref <arg> [-ref_slice <arg>] -tumor
       <arg> [-tumor_slice <arg>] -vcf <arg>
A second layer of filtering on top of Manta
 -contamination_fraction <arg>   fraction of allowable normal support per
                                 tumor support read
 -output_vcf <arg>               VCF output file (optional)
 -proximity <arg>                distance to scan around breakpoint
                                 (optional, default=500)
 -ref <arg>                      the Reference BAM (required)
 -ref_slice <arg>                the sliced Reference BAM to output
                                 (optional)
 -tumor <arg>                    the Tumor BAM (required)
 -tumor_slice <arg>              the sliced Tumor BAM to output (optional)
 -vcf <arg>                      Manta VCF file to batch inspect
                                 (required)
```


## Metadata
- **Skill**: not generated
