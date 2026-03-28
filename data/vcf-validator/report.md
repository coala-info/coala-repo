# vcf-validator CWL Generation Report

## vcf-validator_vcf_validator

### Tool Description
vcf_validator version 0.10.2

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-validator:0.10.2--h7a61d87_0
- **Homepage**: https://github.com/EBIVariation/vcf-validator
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-validator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcf-validator/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-07-18
- **GitHub**: https://github.com/EBIVariation/vcf-validator
- **Stars**: N/A
### Original Help Text
```text
vcf_validator version 0.10.2

Usage: vcf-validator [OPTIONS] [< input_file]
Allowed options:
  -h [ --help ]                  Display this help
  -v [ --version ]               Display version of the validator
  -i [ --input ] arg (=stdin)    Path to the input VCF file, or stdin
  -l [ --level ] arg (=warning)  Validation level (error, warning, stop)
  -r [ --report ] arg (=summary) Comma separated values for types of reports 
                                 (summary, text)
  -o [ --outdir ] arg            Output directory
  --require-evidence             Flag to check genotypes or allele frequencies 
                                 are present
```


## vcf-validator_vcf_assembly_checker

### Tool Description
vcf-assembly-checker version 0.10.2

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-validator:0.10.2--h7a61d87_0
- **Homepage**: https://github.com/EBIVariation/vcf-validator
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-validator/overview
- **Validation**: PASS

### Original Help Text
```text
vcf-assembly-checker version 0.10.2

Usage: vcf-assembly-checker [OPTIONS] [< input_file]
Allowed options:
  -h [ --help ]                       Display this help
  -v [ --version ]                    Display version of the assembly checker
  -i [ --input ] arg (=stdin)         Path to the input VCF file, or stdin
  -f [ --fasta ] arg                  Path to the input FASTA file; please note
                                      that the index file (from samtools faidx)
                                      must have the same name as the FASTA file
                                      and saved with a .fai extension
  -a [ --assembly ] arg (=no_mapping) Path to the input assembly report used 
                                      for contig synonym mapping
  -r [ --report ] arg (=summary)      Comma separated values for types of 
                                      reports (summary, text, valid)
  -o [ --outdir ] arg                 Output directory
  --require-genbank                   Flag to indicate that VCF should be 
                                      checked for Genbank accessions
```


## Metadata
- **Skill**: generated
