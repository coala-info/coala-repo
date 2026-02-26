# amrfior CWL Generation Report

## amrfior

### Tool Description
AMRfíor v0.5.1 - The Multi-Tool AMR Gene Detection Toolkit.

### Metadata
- **Docker Image**: quay.io/biocontainers/amrfior:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/NickJD/AMRfior
- **Package**: https://anaconda.org/channels/bioconda/packages/amrfior/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amrfior/overview
- **Total Downloads**: 334
- **Last updated**: 2026-02-22
- **GitHub**: https://github.com/NickJD/AMRfior
- **Stars**: N/A
### Original Help Text
```text
usage: amrfior [-h] -i INPUT -st {Single-FASTA,Paired-FASTQ} -o OUTPUT
               [--report-fasta {None,all,detected,detected-all}]
               [--tools {blastn,blastx,diamond,bowtie2,bwa,minimap2,all} [{blastn,blastx,diamond,bowtie2,bwa,minimap2,all} ...]]
               [--databases {resfinder,card,ncbi,user-provided} [{resfinder,card,ncbi,user-provided} ...]]
               [--user-db-path USER_DB_PATH] [--q-min-cov QUERY_MIN_COVERAGE]
               [--d-min-cov DETECTION_MIN_COVERAGE]
               [--d-min-id DETECTION_MIN_IDENTITY]
               [--d-min-base-depth DETECTION_MIN_BASE_DEPTH]
               [--d-min-reads DETECTION_MIN_NUM_READS] [--dna-only]
               [--protein-only]
               [--sensitivity {default,conservative,sensitive,very-sensitive}]
               [--minimap2-preset {sr,map-ont,map-pb,map-hifi}] [-t THREADS]
               [-tmp TEMP_DIRECTORY] [--no_cleanup] [--verbose] [-v]

AMRfíor v0.5.1 - The Multi-Tool AMR Gene Detection Toolkit.

options:
  -h, --help            show this help message and exit

Required selection:
  -i, --input INPUT     Input FASTA/FASTAQ file(s) with sequences to analyse -
                        Separate FASTQ R1 and R2 with a comma for Paired-FASTQ
                        or single file path for Single-FASTA - .gz files
                        accepted
  -st, --sequence-type {Single-FASTA,Paired-FASTQ}
                        Specify the input Sequence Type: Single-FASTA or
                        Paired-FASTQ (R1+R2) - Will convert Paired-FASTQ to
                        single combined FASTA for BLAST and DIAMOND analyses
                        (SLOW)
  -o, --output OUTPUT   Output directory for results

Output selection:
  --report-fasta {None,all,detected,detected-all}
                        Specify whether to output sequences that "mapped" to
                        genes."all" should only be used for deep
                        investigation/debugging."detected" will report the
                        reads that passed detection thresholds for each
                        detected gene."detected-all" will report all reads for
                        each detected gene. (default: None)

Tool selection:
  --tools {blastn,blastx,diamond,bowtie2,bwa,minimap2,all} [{blastn,blastx,diamond,bowtie2,bwa,minimap2,all} ...]
                        Specify which tools to run - "all" will run all tools
                        (default: all except blastx/n as it is very slow!!)

Database selection:
  --databases {resfinder,card,ncbi,user-provided} [{resfinder,card,ncbi,user-provided} ...]
                        Specify which AMR gene databases to use (default:
                        resfinder and card) -If "user-provided" is selected,
                        please ensure the path contains the appropriate
                        databases set up as per the documentation and specify
                        the path with --user-db-path.
  --user-db-path USER_DB_PATH
                        Path to the directory containing user-provided
                        databases (required if --databases includes "user-
                        provided")

Query threshold Parameters:
  --q-min-cov, --query-min-coverage QUERY_MIN_COVERAGE
                        Minimum coverage threshold in percent (default: 40.0)

Gene Detection Parameters:
  --d-min-cov, --detection-min-coverage DETECTION_MIN_COVERAGE
                        Minimum coverage threshold in percent (default: 80.0)
  --d-min-id, --detection-min-identity DETECTION_MIN_IDENTITY
                        Minimum identity threshold in percent (default: 80.0)
  --d-min-base-depth, --detection-min-base-depth DETECTION_MIN_BASE_DEPTH
                        Minimum average base depth for detection - calculated
                        against regions of the detected gene with at least one
                        read hit (default: 1.0)
  --d-min-reads, --detection-min-num-reads DETECTION_MIN_NUM_READS
                        Minimum number of reads required for detection
                        (default: 1)

Mode Selection:
  --dna-only            Run only DNA-based tools
  --protein-only        Run only protein-based tools
  --sensitivity {default,conservative,sensitive,very-sensitive}
                        Preset sensitivity levels - default means each tool
                        uses its own default settings and very-sensitive
                        applies DIAMONDs --ultra-sensitive and Bowtie2s
                        --very-sensitive-local presets

Tool-Specific Parameters:
  --minimap2-preset {sr,map-ont,map-pb,map-hifi}
                        Minimap2 preset: sr=short reads, map-ont=Oxford
                        Nanopore, map-pb=PacBio, map-hifi=PacBio HiFi
                        (default: sr)

Runtime Parameters:
  -t, --threads THREADS
                        Number of threads to use (default: 4)
  -tmp, --temp-directory TEMP_DIRECTORY
                        Path to temporary to place input FASTA/Q file(s) for
                        faster IO during BLAST - Path will also be used for
                        all temporary files (default: system temp directory)
  --no_cleanup
  --verbose

Miscellaneous Parameters:
  -v, --version         Show program version and exit

        WARNING - AMRfíor is now no longer supported and will not receive any further updates. Please use the newer GeneFíor (https://github.com/NickJD/GeneFior) toolkit for your AMR (and non-AMR) gene detection needs!!!

Examples:
  # Basic usage with default tools (runs DNA & protein tools)
  GeneFior -i reads.fasta -st Single-FASTA -o results/

  # Select specific tools and output detected FASTA sequences
  GeneFior -i reads.fasta -st Single-FASTA -o results/     --tools diamond bowtie2     --report_fasta detected

  # Custom thresholds, paired-fastq input, threads and dna-only mode
  GeneFior -i reads_R1.fastq,reads_R2.fastq -st Paired-FASTQ -o results/     -t 16 --d-min-cov 90 --d-min-id 85     --dna-only
```

