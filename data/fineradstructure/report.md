# fineradstructure CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fineradstructure_hapsFromVCF | PASS |  |
| fineradstructure_paint | PASS |  |

## fineradstructure_paint

### Tool Description
Generate a co-ancestry matrix from RAD data.

### Metadata
- **Docker Image**: quay.io/biocontainers/fineradstructure:0.3.2r109--h76b9af2_7
- **Homepage**: https://github.com/millanek/fineRADstructure
- **Package**: https://anaconda.org/channels/bioconda/packages/fineradstructure/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RADpainter paint [OPTIONS] INPUT.txt
Generate a co-ancestry matrix from RAD data

       -h, --help                              display this help and exit
       -p, --ploidy=N                          ploidy of the species being analysed (default is 2N, i.e. diploid)
       -c, --chr                               output per-chromosome coancestry matrices
       -n, --run-name                          run-name will be included in the output file name(s)

       -m, --missing2                          (deprecated) output a conancestry matrix with missing data treated
                                               as if any pair of individuals are equally distant



Report bugs to milan.malinsky@unibas.ch
```

## fineradstructure_hapsFromVCF

### Tool Description
(experimental) Get the haplotype format input for RADpainter paint from a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fineradstructure:0.3.2r109--h76b9af2_7
- **Homepage**: https://github.com/millanek/fineRADstructure
- **Package**: https://anaconda.org/channels/bioconda/packages/fineradstructure/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RADpainter hapsFromVCF [OPTIONS] INPUT.vcf
Generate a co-ancestry matrix from RAD data

       -h, --help                              display this help and exit
       -H,   --het-treatment <r|p>             r: assign het bases randomly (default); p: use the phase information in the VCF
       -F MIN_F                                minimum acceptable inbreeding coefficient (default: F >= -0.3)



Report bugs to milan.malinsky@unibas.ch
```

