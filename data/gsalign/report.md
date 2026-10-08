# gsalign CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gsalign_GSAlign | PASS | synthetic data: query genome with planted SNPs on a real reference; GSAlign found 91312 of the 91314 planted SNPs. |
| gsalign_bwt_index | PASS |  |

## gsalign_GSAlign

### Tool Description
GenAlign v1.0.22

### Metadata
- **Docker Image**: quay.io/biocontainers/gsalign:1.0.22--hcb620b3_8
- **Homepage**: https://github.com/hsinnan75/GSAlign
- **Package**: https://anaconda.org/channels/bioconda/packages/gsalign/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gsalign/overview
- **Total Downloads**: 87.1K
- **Last updated**: 2025-09-05
- **GitHub**: https://github.com/hsinnan75/GSAlign
- **Stars**: N/A
### Original Help Text
```text
Warning! Unknow parameter: --help

GenAlign v1.0.22
Usage: GSAlign [-i IndexFile Prefix / -r Reference file] -q QueryFile[Fasta]

Options: -t     INT     number of threads [8]
         -o     STR     Set the prefix of the output files [output]
         -fmt   INT     Set the output format 1:maf, 2:aln [1]
         -idy   INT     Set the minimal sequence identity (0-100) of a local alignment [70]
         -slen  INT     Set the minimal seed length [15]
         -alen  INT     Set the minimal alignment length [200]
         -ind   INT     Set the maximal indel size [25]
         -clr   INT     Set the minimal cluster size [200]
         -unique        Output unique alignment only [false]
         -sen           Sensitive mode [False]
         -dp            Output Dot-plots
         -one           set one on one aligment mode[false]
         -gp    STR     Specify the path of gnuplot
```

## gsalign_bwt_index

### Tool Description


### Metadata
- **Docker Image**: quay.io/biocontainers/gsalign:1.0.22--hcb620b3_8
- **Homepage**: https://github.com/hsinnan75/GSAlign
- **Package**: https://anaconda.org/channels/bioconda/packages/gsalign/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bwt_index Ref_File[ex. ref.fa] Prefix[ex. MyRef]
```
