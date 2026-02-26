# vcflatten CWL Generation Report

## vcflatten

### Tool Description
Convert VCF files to TSV format.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcflatten:0.5.2--1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcflatten/overview
- **Total Downloads**: 7.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: vcflatten [options] <filename>

    -i <keys> | --info <keys>
        Specify a semicolon-separated list of INFO IDs to output for each variant from the VCF file.
    
    -g <keys> | --genotype <keys>
        Specify a colon-separated list of FORMAT IDs to output for each sample from the VCF file.
    
    --one-file
        If this flag is set, then only 1 TSV file will be generated for all samples. In addition, this file will have a SAMPLE column which indicates which sample the data belongs to.
    
    --no-header
        If this flag is set, the TSV header won't be written to any of the output files. 
    
    --ignore-errors
        If this flag is set, then any errors in the VCF file will be ignored, and the invalid rows will be skipped.
    
    --prefix <filename prefix>
        A filename prefix that can be used in the output pattern. If this is not set, then the prefix is the same as <filename>.
    
    -o <pattern> | --pattern <pattern>
        The pattern to use when generating output files. The default is "%p-%s-%d". Valid special patterns are:
    
          %p    Include the "prefix" here (either <filename> or given in --prefix <prefix>
          %s    The name of the sample, taken from the header of the VCF file.
          %i    The index of the sample (1-based).
          %%    A single, literal '%'.
    
        If neither %s nor %d is provided, then the VCF file must have only 1 sample.
```


## Metadata
- **Skill**: generated
