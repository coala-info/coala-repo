# htsinfer CWL Generation Report

## htsinfer

### Tool Description
Command-line interface client for inferring metadata from High-Throughput Sequencing (HTS) data.

### Metadata
- **Docker Image**: quay.io/biocontainers/htsinfer:1.0.0_rc.1--pyhdfd78af_0
- **Homepage**: https://github.com/zavolanlab/htsinfer
- **Package**: https://anaconda.org/channels/bioconda/packages/htsinfer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/htsinfer/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zavolanlab/htsinfer
- **Stars**: N/A
### Original Help Text
```text
usage: usage: htsinfer [--output-directory PATH] [--temporary-directory PATH]
                [--cleanup-regime {DEFAULT,KEEP_ALL,KEEP_NONE,KEEP_RESULTS}]
                [--records INT] [--threads INT] [--transcripts FASTA]
                [--read-layout-adapters PATH]
                [--read-layout-min-match-percentage FLOAT]
                [--read-layout-min-frequency-ratio FLOAT]
                [--library-source-min-match-percentage FLOAT]
                [--library-source-min-frequency-ratio FLOAT]
                [--library-type-max-distance INT]
                [--library-type-mates-cutoff FLOAT]
                [--read-orientation-min-mapped-reads INT]
                [--read-orientation-min-fraction FLOAT] [--tax-id INT]
                [--verbosity {DEBUG,INFO,WARN,ERROR,CRITICAL}] [-h]
                [--version]
                PATH [PATH]

Command-line interface client.

positional arguments:
  PATH                  either one or two paths to FASTQ files representing
                        the sequencing library to be evaluated, for single- or
                        paired-ended libraries, respectively

options:
  --output-directory PATH
                        path to directory where output is written to (default:
                        /results_htsinfer)
  --temporary-directory PATH
                        path to directory where temporary output is written to
                        (default: /tmp/tmp_htsinfer)
  --cleanup-regime {DEFAULT,KEEP_ALL,KEEP_NONE,KEEP_RESULTS}
                        determine which data to keep after each run; in
                        default mode, both temporary data and results are kept
                        when '--verbosity' is set to 'DEBUG', no data is kept
                        when all metadata could be successfully determined,
                        and only results are kept otherwise (default: DEFAULT)
  --records INT         number of records to process; if set to ``0`` or if
                        the specified value equals or exceeds the number of
                        available records, all records will be processed
                        (default: 1000000)
  --threads INT         number of threads to run STAR with (default: 1)
  --transcripts FASTA   FASTA file containing transcripts to be used for
                        mapping files `--file-1` and `--file-2` for inferring
                        library source and read orientation. Requires that
                        sequence identifier lines are separated by the pipe
                        (`|`) character and that the 4th and 5th columns
                        contain a short source name and taxon identifier,
                        respectively. Example sequence identifier:
                        `rpl-13|ACYPI006272|ACYPI006272-RA|apisum|7029`
                        (default: /usr/local/lib/python3.10/site-
                        packages/data/transcripts.fasta.gz)
  --read-layout-adapters PATH
                        path to text file containing 3' adapter sequences to
                        scan for (one sequence per line) (default:
                        /usr/local/lib/python3.10/site-
                        packages/data/adapter_fragments.txt)
  --read-layout-min-match-percentage FLOAT
                        minimum percentage of reads that contain a given
                        adapter sequence in order for it to be considered as
                        the library's 3'-end adapter (default: 0.1)
  --read-layout-min-frequency-ratio FLOAT
                        minimum frequency ratio between the first and second
                        most frequent adapter in order for the former to be
                        considered as the library's 3'-end adapter (default:
                        2)
  --library-source-min-match-percentage FLOAT
                        minimum percentage of reads that are consistent with a
                        given source in order for it to be considered the
                        library's source (default: 5)
  --library-source-min-frequency-ratio FLOAT
                        minimum frequency ratio between the first and second
                        most frequent source in order for the former to be
                        considered the library's source (default: 2)
  --library-type-max-distance INT
                        upper limit on the difference in the reference
                        sequence coordinates between the two mates to be
                        considered as coming from a single fragment (Used only
                        when sequence identifiers do not match) (default:
                        1000)
  --library-type-mates-cutoff FLOAT
                        minimum fraction of mates that can be mapped to
                        compatible loci and are considered concordant pairs /
                        all mates(Used only when sequence identifiers do not
                        match) (default: 0.85)
  --read-orientation-min-mapped-reads INT
                        minimum number of mapped reads for deeming the read
                        orientation result reliable (default: 20)
  --read-orientation-min-fraction FLOAT
                        minimum fraction of mapped reads required to be
                        consistent with a given read orientation state in
                        order for that orientation to be reported. Must be
                        above 0.5 (default: 0.75)
  --tax-id INT          NCBI taxonomic identifier of source organism of the
                        library; if provided, will not be inferred by the
                        application (default: None)
  --verbosity {DEBUG,INFO,WARN,ERROR,CRITICAL}
                        logging verbosity level (default: INFO)
  -h, --help            show this help message and exit
  --version             show version information and exit

htsinfer v1.0.0-rc.1, (c) 2021 by Zavolab (zavolab-biozentrum@unibas.ch)
```

