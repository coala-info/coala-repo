# phenix CWL Generation Report

## phenix_phenix.py

### Tool Description
A tool for various VCF and reference manipulation tasks.

### Metadata
- **Docker Image**: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
- **Homepage**: https://github.com/phe-bioinformatics/PHEnix
- **Package**: https://anaconda.org/channels/bioconda/packages/phenix/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phenix/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/phe-bioinformatics/PHEnix
- **Stars**: N/A
### Original Help Text
```text
usage: phenix.py [-h] [--debug] [--version]
                 {run_snp_pipeline,filter_vcf,prepare_reference,vcf2fasta,vcf2distancematrix,vcf2json}
                 ...

positional arguments:
  {run_snp_pipeline,filter_vcf,prepare_reference,vcf2fasta,vcf2distancematrix,vcf2json}
    run_snp_pipeline    Run SNP pipeline.
    filter_vcf          Filter a VCF.
    prepare_reference   Create aux files for reference.
    vcf2fasta           Convert VCFs to FASTA.
    vcf2distancematrix  Convert VCFs to a distance matrix.
    vcf2json            Convert VCFs to a JSON file containing variants and
                        ignored positions as arrays of positions relative to
                        reference chromosomes.

optional arguments:
  -h, --help            show this help message and exit
  --debug               More verbose logging (default: turned off).
  --version             show program's version number and exit
```


## phenix_prepare_reference.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
- **Homepage**: https://github.com/phe-bioinformatics/PHEnix
- **Package**: https://anaconda.org/channels/bioconda/packages/phenix/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
exec /usr/local/bin/prepare_reference.py: exec format error
```


## phenix_run_snp_pipeline.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
- **Homepage**: https://github.com/phe-bioinformatics/PHEnix
- **Package**: https://anaconda.org/channels/bioconda/packages/phenix/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
exec /usr/local/bin/run_snp_pipeline.py: exec format error
```

