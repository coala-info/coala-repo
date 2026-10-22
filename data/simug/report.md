# simug CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| simug | PASS | yeast reference from the tool's own test example; counts of simulated SNPs and INDELs match the requested numbers |
| simug_vcf2model | PASS |  |

## simug

### Tool Description
simuG: a general-purpose genome simulator for simulating various types of genomic variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/simug:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/yjx1217/simuG
- **Package**: https://anaconda.org/channels/bioconda/packages/simug/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/simug/overview
- **Total Downloads**: 3.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yjx1217/simuG
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/simug:1.0.1--hdfd78af_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

## simug_vcf2model

### Tool Description
Profile SNP and INDEL variants of a VCF file into model files for simuG.

### Metadata
- **Docker Image**: quay.io/biocontainers/simug:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/yjx1217/simuG
- **Package**: https://anaconda.org/channels/bioconda/packages/simug/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    perl vcf2model.pl [options] [file ...]

Options:
    -help or -h
            Print help message. Example: -h.

    -man or -m
            Print more detailed help message. Example: -m.

    -version or -v
            Print version information. Example: -v.

    -vcf or -i
            Specify the input variant calling file (in vcf or vcf.gz
            format). Example: -vcf input.vcf(.gz).

    -excluded_chr_list or -e
            Specify the chromosome(s) to be excluded for variant profiling.
            Example: -excluded_chr_list excluded_chr_list.txt. Default = "".

    -qual or -q
            Specify the cutoff of the minimal variant quality to be
            considered. Example: -qual 30. Default = 0.

    -prefix or -p
            Specify the file name prefix for the output files. Example:
            -prefix test_prefix. Default = "output_prefix".
```

## Metadata
- **Skill**: generated

