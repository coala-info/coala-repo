# perl-pcap CWL Generation Report

## perl-pcap_bwa_mem.pl

### Tool Description
BWA MEM alignment wrapper for processing BAM, CRAM, or FASTQ files, including support for duplicate marking and CRAM conversion.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Total Downloads**: 20.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Stars**: N/A
### Original Help Text
```text
Usage:
    bwa_mem.pl [options] [file(s)...]

      Required parameters:
        -outdir      -o   Folder to output result to.
        -reference   -r   Path to reference genome file *.fa[.gz]
        -sample      -s   Sample name to be applied to output file.
        -threads     -t   Number of threads to use. [1]

      Optional parameters:
        -fragment    -f   Split input into fragements of X million repairs [10]
        -nomarkdup   -n   Don't mark duplicates
        -cram        -c   Output cram, see '-sc'
        -scramble    -sc  Single quoted string of parameters to pass to Scramble when '-c' used
                          - '-I,-O' are used internally and should not be provided
        -bwa         -b     Single quoted string of additional parameters to pass to BWA
                             - '-t,-p,-R' are used internally and should not be provided
        -map_threads -mt  Number of cores applied to each parallel BWA job when '-t' exceeds this value and '-i' is not in use[6]

      Targeted processing:
        -process     -p   Only process this step then exit, optionally set -index
                            bwamem - only applicable if input is bam
                              mark - Run duplicate marking (-index N/A)
                             stats - Generates the *.bas file for the final BAM.

        -index       -i   Optionally restrict '-p' to single job
                            bwamem - 1..<lane_count>

      Performance variables
        -bwa_pl      -l   BWA runs ~8% quicker when using the tcmalloc library from
                          https://github.com/gperftools/ (assuming number of cores not exceeded)
                          If available specify the path to 'gperftools/lib/libtcmalloc_minimal.so'.

      Other:
        -jobs        -j   For a parallel step report the number of jobs required
        -help        -h   Brief help message.
        -man         -m   Full documentation.

    File list can be full file names or wildcard, e.g.

    mutiple BAM inputs
         bwa_mem.pl -t 16 -r some/genome.fa.gz -o myout -s sample input/*.bam

    multiple paired fastq inputs
         bwa_mem.pl -t 16 -r some/genome.fa.gz -o myout -s sample input/*_[12].fq[.gz]

    multiple interleaved paired fastq inputs
         bwa_mem.pl -t 16 -r some/genome.fa.gz -o myout -s sample input/*.fq[.gz]

    mixture of BAM and CRAM
         bwa_mem.pl -t 16 -r some/genome.fa.gz -o myout -s sample input/*.bam input/*.cram
```


## perl-pcap_gnos_pull.pl

### Tool Description
PCAP GNOS pull tool for retrieving ALIGNMENTS or CALLS metadata and data from GNOS repositories.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
- **Homepage**: https://github.com/ICGC-TCGA-PanCancer/PCAP-core
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pcap/overview
- **Validation**: PASS

### Original Help Text
```text
#################
# PCAP version 3.5.2, Copyright (C) 2014-2017 ICGC/TCGA Pan-Cancer Analysis Project
# PCAP comes with ABSOLUTELY NO WARRANTY
# See LICENSE for full details.
#################
Usage:
    ./gnos_pull.pl [-h] -u http://pancancer.info/gnos_metadata/latest/ -c
    gnos_pull.ini -o local_mirror/

      Required input:

        --analysis  (-a)  ALIGNMENTS or CALLS

        --outdir    (-o)  Where to save jsonl and resulting GNOS downloads

        --config    (-c)  Mapping of GNOS repos to permissions keys

      Other options:

        --symlinks  (-s)  Rebuild symlinks only.

        --threads   (-t)  Number of parallel GNOS retrievals.

        --url       (-u)  The base URL to retrieve jsonl file from
                            [http://pancancer.info/gnos_metadata/latest/]

        --info      (-i)  Just prints how many donor's will be included in pull and some stats.

        --debug     (-d)  prints extra debug information

        --help      (-h)  Brief documentation

        --man       (-m)  More verbose usage info
```

