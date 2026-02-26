# duet CWL Generation Report

## duet

### Tool Description
SNP-Assisted Structural Variant Calling and Phasing Using Oxford Nanopore Sequencing

### Metadata
- **Docker Image**: quay.io/biocontainers/duet:1.0--pyhdfd78af_0
- **Homepage**: https://github.com/yekaizhou/duet
- **Package**: https://anaconda.org/channels/bioconda/packages/duet/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/duet/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yekaizhou/duet
- **Stars**: N/A
### Original Help Text
```text
usage: duet [-h] [-t THREAD] [-m MIN_ALLELE_FREQUENCY]
            [-c CLUSTER_MAX_DISTANCE] [-s SV_MIN_SIZE] [-r MIN_SUPPORT_READ]
            [-a] [-b SV_CALLER]
            BAM REFERENCE OUTPUT

SNP-Assisted Structural Variant Calling and Phasing Using Oxford Nanopore
Sequencing

positional arguments:
  BAM                   sorted alignment file in .bam format (along with .bai
                        file in the same directory)
  REFERENCE             indexed reference genome in .fasta format (along with
                        .fai file in the same directory)
  OUTPUT                working and output directory (existing files in the
                        directory will be overwritten)

optional arguments:
  -h, --help            show this help message and exit
  -t THREAD, --thread THREAD
                        number of threads to use [4]
  -m MIN_ALLELE_FREQUENCY, --min_allele_frequency MIN_ALLELE_FREQUENCY
                        minimum allele frequency required to call a candidate
                        SNP [0.25]
  -c CLUSTER_MAX_DISTANCE, --cluster_max_distance CLUSTER_MAX_DISTANCE
                        maximum span-position distance between SV marks in a
                        cluster to call a SV candidates, when the base SV
                        caller is SVIM [0.9]
  -s SV_MIN_SIZE, --sv_min_size SV_MIN_SIZE
                        minimum SV size to be reported [50]
  -r MIN_SUPPORT_READ, --min_support_read MIN_SUPPORT_READ
                        minimum number of reads that support a SV to be
                        reported [2]
  -a, --include_all_ctgs
                        call variants on all contigs, otherwise call
                        chr{1..22,X,Y} [False]
  -b SV_CALLER, --sv_caller SV_CALLER
                        choose the base SV caller from cuteSV ("cutesv"),
                        Sniffles (sniffles), or SVIM ("svim") [cutesv]
```

