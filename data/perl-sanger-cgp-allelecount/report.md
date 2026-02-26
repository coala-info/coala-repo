# perl-sanger-cgp-allelecount CWL Generation Report

## perl-sanger-cgp-allelecount_alleleCounter.pl

### Tool Description
Extract allele counts from BAM/CRAM files at specific loci.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-sanger-cgp-allelecount:4.3.0--pl5321h7b50bb2_2
- **Homepage**: https://github.com/cancerit/alleleCount
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-sanger-cgp-allelecount/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-sanger-cgp-allelecount/overview
- **Total Downloads**: 30.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cancerit/alleleCount
- **Stars**: N/A
### Original Help Text
```text
Usage:
    Where possible use the C version for large data (it's also more
    configurable).

    alleleCounts.pl

      Required:

        -bam      -b      BAM/CRAM file (expects co-located index)
                           - if CRAM see '-ref'
        -output   -o      Output file [STDOUT]
        -loci     -l      Alternate loci file (just needs chr pos)
                           - output is different, counts for each residue

      Optional:
        -ref      -r      genome.fa, required for CRAM (with colocated .fai)
        -minqual  -m      Minimum base quality to include (integer) [30]
        -mapqual  -q      Minimum mapping quality of read (integer) [35]
        -gender   -g      flag, presence indicates loci file to be treated as gender SNPs.
                           - cannot be used with 's'
        -snp6     -s      flag, presence indicates loci file is SNP6 format.
                           - cannot be used with 'g'
                           - changes output format
        -help     -h      This message
        -version  -v      Version number
```


## perl-sanger-cgp-allelecount_alleleCounterToJson.pl

### Tool Description
Converts alleleCounter output to JSON format.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-sanger-cgp-allelecount:4.3.0--pl5321h7b50bb2_2
- **Homepage**: https://github.com/cancerit/alleleCount
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-sanger-cgp-allelecount/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    alleleCounterToJson.pl

      Required:

        -locus-file          -l     File containing SNP positions used for allelecounter
        -allelecount-file    -a     Allelecounter output file

      Optional:
        -output-file         -o      Output file (default: stdout)
        -help                -h      This message
        -version             -v      Version number
```

