# wepp CWL Generation Report

## wepp_detectpeaks

### Tool Description
Detects Peaks from the MAT

### Metadata
- **Docker Image**: quay.io/biocontainers/wepp:0.1.5.2--h9f2696a_0
- **Homepage**: https://github.com/TurakhiaLab/WEPP
- **Package**: https://anaconda.org/channels/bioconda/packages/wepp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wepp/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2026-02-05
- **GitHub**: https://github.com/TurakhiaLab/WEPP
- **Stars**: N/A
### Original Help Text
```text
Invalid command. Help follows:

COMMAND        	DESCRIPTION

detectPeaks    	Detects Peaks from the MAT

sam2PB         	Applies QC before running WEPP


Arguments:
  -w [ --working-directory ] arg (=./) WEPP's working directory.
  -i [ --input-mat ] arg               Input mutation-annotated tree.
  -d [ --dataset ] arg                 Data folder containing reads.
  -m [ --max-reads ] arg (=1000000000) Maximum number of reads.
  -p [ --file-prefix ] arg             Prefix for intermediate files.
  -f [ --ref-fasta ] arg               Reference sequence.
  -a [ --min-af ] arg (=0.005)         Allele Frequency threshold for masking 
                                       errorneous alleles.
  -c [ --min-depth ] arg (=10)         Depth threshold for masking low coverage
                                       sites.
  -q [ --min-phred ] arg (=20)         Phred score threshold for masking low 
                                       quality alleles.
  -r [ --min-prop ] arg (=0.005)       Minimum haplotype abundance.
  -n [ --clade-idx ] arg (=1)          Index used for inferring lineage 
                                       proportions from haplotypes.
  -T [ --threads ] arg (=20)           Number of threads to use when possible 
                                       [DEFAULT uses all available cores, 20 
                                       detected on this machine]
  -h [ --help ]                        Print help messages
```


## wepp_sam2pb

### Tool Description
Applies QC before running WEPP

### Metadata
- **Docker Image**: quay.io/biocontainers/wepp:0.1.5.2--h9f2696a_0
- **Homepage**: https://github.com/TurakhiaLab/WEPP
- **Package**: https://anaconda.org/channels/bioconda/packages/wepp/overview
- **Validation**: PASS

### Original Help Text
```text
Invalid command. Help follows:

COMMAND        	DESCRIPTION

detectPeaks    	Detects Peaks from the MAT

sam2PB         	Applies QC before running WEPP


Arguments:
  -w [ --working-directory ] arg (=./) WEPP's working directory.
  -i [ --input-mat ] arg               Input mutation-annotated tree.
  -d [ --dataset ] arg                 Data folder containing reads.
  -m [ --max-reads ] arg (=1000000000) Maximum number of reads.
  -p [ --file-prefix ] arg             Prefix for intermediate files.
  -f [ --ref-fasta ] arg               Reference sequence.
  -a [ --min-af ] arg (=0.005)         Allele Frequency threshold for masking 
                                       errorneous alleles.
  -c [ --min-depth ] arg (=10)         Depth threshold for masking low coverage
                                       sites.
  -q [ --min-phred ] arg (=20)         Phred score threshold for masking low 
                                       quality alleles.
  -r [ --min-prop ] arg (=0.005)       Minimum haplotype abundance.
  -n [ --clade-idx ] arg (=1)          Index used for inferring lineage 
                                       proportions from haplotypes.
  -T [ --threads ] arg (=20)           Number of threads to use when possible 
                                       [DEFAULT uses all available cores, 20 
                                       detected on this machine]
  -h [ --help ]                        Print help messages
```


## Metadata
- **Skill**: generated
